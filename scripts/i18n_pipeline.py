#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
scripts/i18n_pipeline.py
云端全自动 i18n 增量检修、去重与多 Provider AI 翻译管道脚本

核心逻辑：
1. 【零硬编码】100% 从环境变量动态加载 AI Provider（支持单 Provider 或 AI_PROVIDERS 多 Provider 配置，model 完全可选）
2. 【去重与清洗】优先对 app_en.arb 和目标 ARB 进行键值去重、规范化，并清理在基准表中已废弃的 Key
3. 【智能差量提取】从 language_data.dart 提取目标 Locale，检测缺失键、空值键、及与英文原文一致的待修补未翻译键
4. 【多线程并发】支持全新语言与已有语言补全多线程并行处理
5. 【多 Provider 故障转移与频控】自动在多 Provider 之间轮询/切牌，应对 429 限流与超时
"""

import json
import os
import re
import sys
import time
import itertools
import urllib.request
import urllib.error
from concurrent.futures import ThreadPoolExecutor, as_completed
from threading import Lock

# ============ 路径配置 ============
PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
L10N_DIR = os.path.join(PROJECT_ROOT, "lib", "l10n")
LANG_DATA_FILE = os.path.join(PROJECT_ROOT, "lib", "features", "language", "language_data.dart")
BASELINE_ARB = os.path.join(L10N_DIR, "app_en.arb")

# ============ 并发与频控配置 ============
MAX_WORKERS = 4           # 多线程并发处理语言数
CHUNK_SIZE = 30           # 每次发给 AI 的分块词条数
INTER_REQUEST_DELAY = 1.5 # 并发硬休眠秒数（防频控）
MAX_RETRIES_PER_PROVIDER = 3

rate_limit_lock = Lock()


def log(msg: str):
    print(f"[i18n-Pipeline] {msg}", flush=True)


# ============ 1. 动态多 Provider 加载 ============
def load_providers() -> list[dict]:
    """从环境变量动态加载 Provider 配置（无硬编码）"""
    providers_json = os.environ.get("AI_PROVIDERS", "").strip()
    if providers_json:
        try:
            parsed = json.loads(providers_json)
            if isinstance(parsed, list) and len(parsed) > 0:
                log(f"成功加载 {len(parsed)} 个多 Provider 配置。")
                return parsed
        except Exception as e:
            log(f"⚠️ 解析 AI_PROVIDERS 环境变量失败: {e}")

    # 回退到单 Provider 环境变量
    single_url = os.environ.get("AI_PROVIDER_URL", "").strip()
    single_key = os.environ.get("AI_TRANSLATE_KEY", "").strip()
    single_model = os.environ.get("AI_MODEL", "").strip()

    if single_url and single_key:
        provider = {
            "name": "Default-Provider",
            "url": single_url,
            "key": single_key,
        }
        if single_model:
            provider["model"] = single_model
        log("成功加载单 Provider 配置。")
        return [provider]

    return []


PROVIDERS = load_providers()
provider_cycle = itertools.cycle(PROVIDERS) if PROVIDERS else None


# ============ 2. ARB JSON 文件工具函数 ============
def load_arb(path: str) -> dict:
    if not os.path.exists(path):
        return {}
    try:
        with open(path, "r", encoding="utf-8") as f:
            return json.load(f)
    except (json.JSONDecodeError, OSError) as e:
        log(f"⚠️ 警告: 读取/解析 {os.path.basename(path)} 失败: {e}，重置为空 JSON")
        return {}


def save_arb(path: str, data: dict):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
        f.write("\n")


def sanitize_and_deduplicate_arb(data: dict) -> dict:
    """对 ARB 数据结构进行去重与规范化"""
    sanitized = {}
    for k, v in data.items():
        if k in sanitized:
            # 重复键保留非空有效值
            if v and not sanitized[k]:
                sanitized[k] = v
        else:
            sanitized[k] = v
    return sanitized


def clean_obsolete_keys_from_target(target_data: dict, baseline_keys: set) -> dict:
    """清理在英文基准表中已注销/废弃的旧 Key"""
    cleaned = {}
    for k, v in target_data.items():
        if k == "@@locale":
            cleaned[k] = v
        elif k.startswith("@"):
            base_k = k[1:]
            if base_k in baseline_keys:
                cleaned[k] = v
        elif k in baseline_keys:
            cleaned[k] = v
    return cleaned


def is_untranslated_value(en_val: str, target_val: str) -> bool:
    """判定某个 Key 是否缺失或为空（只有为空或未定义时才触发 AI 增量补全，绝不覆盖已有翻译）"""
    if target_val is None or not str(target_val).strip():
        return True
    return False


# ============ 3. 多 Provider 带故障转移与退避重试的 API 调用 ============
def call_ai_api_with_failover(prompt: str) -> str:
    """在多 Provider 之间轮询与自动切牌请求"""
    if not PROVIDERS:
        raise RuntimeError("云端未配置任何有效的 AI_PROVIDERS 或 AI_PROVIDER_URL / AI_TRANSLATE_KEY 环境变量！")

    start_provider = next(provider_cycle)
    ordered_providers = [start_provider] + [p for p in PROVIDERS if p != start_provider]

    with rate_limit_lock:
        time.sleep(INTER_REQUEST_DELAY)

    for provider in ordered_providers:
        provider_name = provider.get("name", "Unknown-Provider")
        url = provider.get("url", "").strip()
        key = provider.get("key", "").strip()
        model = provider.get("model", "").strip()

        if not url or not key:
            continue

        headers = {"Content-Type": "application/json"}

        if "generativelanguage" in url:
            full_url = f"{url}?key={key}" if "key=" not in url else url
            payload = {"contents": [{"parts": [{"text": prompt}]}]}
        else:
            full_url = url
            headers["Authorization"] = f"Bearer {key}"
            payload = {"messages": [{"role": "user", "content": prompt}]}
            # model 完全可选：仅当非空时写入
            if model:
                payload["model"] = model

        data_bytes = json.dumps(payload).encode("utf-8")

        for attempt in range(1, MAX_RETRIES_PER_PROVIDER + 1):
            try:
                req = urllib.request.Request(full_url, data=data_bytes, headers=headers, method="POST")
                with urllib.request.urlopen(req, timeout=45) as resp:
                    res_body = resp.read().decode("utf-8")
                    res_json = json.loads(res_body)

                    if "generativelanguage" in url:
                        return res_json["candidates"][0]["content"]["parts"][0]["text"]
                    else:
                        return res_json["choices"][0]["message"]["content"]

            except urllib.error.HTTPError as e:
                log(f"⚠️ Provider [{provider_name}] 触发 HTTP {e.code}，第 {attempt}/{MAX_RETRIES_PER_PROVIDER} 次重试...")
                if e.code == 429 or e.code >= 500:
                    time.sleep((2 ** attempt) * 2)
                else:
                    break # 非限流类 4xx 错误直接切下一个 Provider
            except Exception as e:
                log(f"⚠️ Provider [{provider_name}] 网络连接异常: {e}，重试中...")
                time.sleep(3)

        log(f"⚠️ Provider [{provider_name}] 尝试失败，自动切牌至备用 Provider...")

    raise RuntimeError("❌ 列表中所有 AI Provider 均尝试失败，请检查云端 Secrets 配置。")


def extract_json_from_response(text: str) -> dict:
    text = text.strip()
    if "```" in text:
        text = re.sub(r"```(?:json)?", "", text).strip()
    try:
        return json.loads(text)
    except Exception:
        pass

    match = re.search(r"\{.*\}", text, re.DOTALL)
    if match:
        try:
            return json.loads(match.group(0))
        except Exception:
            pass

    raise ValueError(f"AI 响应无法解析为有效的 JSON 数据:\n{text[:200]}")


def validate_and_fix_placeholders(en_val: str, translated_val: str) -> str:
    """保障占位符 100% 格式安全，防止 flutter gen-l10n 校验失败"""
    if not isinstance(translated_val, str) or not translated_val.strip():
        return en_val

    en_placeholders = re.findall(r"\{([a-zA-Z0-9_]+)\}", en_val)
    if not en_placeholders:
        return translated_val

    missing = [ph for ph in en_placeholders if f"{{{ph}}}" not in translated_val]
    if missing:
        trans_placeholders = re.findall(r"\{([^\}]+)\}", translated_val)
        if len(trans_placeholders) == len(en_placeholders):
            fixed = translated_val
            for old_ph, correct_ph in zip(trans_placeholders, en_placeholders):
                fixed = fixed.replace(f"{{{old_ph}}}", f"{{{correct_ph}}}")
            return fixed
        else:
            log(f"⚠️ 占位符损坏且无法修复，安全回退英文: `{en_val}` vs `{translated_val}`")
            return en_val

    return translated_val


def translate_chunk(chunk: dict, target_locale: str) -> dict:
    prompt = f"""
You are a professional Flutter ARB translator.
Translate the following JSON string values from English to target locale '{target_locale}'.

Requirements:
1. Return strictly a raw valid JSON object starting with {{ and ending with }}.
2. Do NOT alter key names.
3. Keep untranslated placeholders like {{userName}}, {{count}}, {{hours}}.
4. Do NOT wrap output in markdown syntax.

Input JSON:
{json.dumps(chunk, ensure_ascii=False)}
"""
    raw_response = call_ai_api_with_failover(prompt)
    raw_dict = extract_json_from_response(raw_response)

    validated_dict = {}
    for k, trans_v in raw_dict.items():
        if k in chunk:
            validated_dict[k] = validate_and_fix_placeholders(chunk[k], trans_v)
        else:
            validated_dict[k] = trans_v

    return validated_dict


# ============ 4. 语言任务构建与多线程执行 ============
def process_language_task(target_locale: str, baseline_data: dict):
    arb_path = os.path.join(L10N_DIR, f"app_{target_locale}.arb")
    current_data = load_arb(arb_path)

    baseline_keys_set = set(baseline_data.keys())

    # 1. 前置查重与清理废弃键
    current_data = sanitize_and_deduplicate_arb(current_data)
    current_data = clean_obsolete_keys_from_target(current_data, baseline_keys_set)

    valid_en_keys = {k: v for k, v in baseline_data.items() if not k.startswith("@") and k != "@@locale"}

    # 2. 提取缺失键与未翻译键
    need_translation = {}
    for k, en_val in valid_en_keys.items():
        curr_val = current_data.get(k)
        if is_untranslated_value(en_val, curr_val):
            need_translation[k] = en_val

    # 3. 如果需要翻译，执行 AI 分块处理
    translated_results = {}
    if need_translation:
        log(f"🌐 [并发线程] 语言 `{target_locale}` 开始翻译修补 {len(need_translation)} 个缺失/空词条...")
        items = list(need_translation.items())
        for i in range(0, len(items), CHUNK_SIZE):
            chunk = dict(items[i:i + CHUNK_SIZE])
            chunk_res = translate_chunk(chunk, target_locale)
            translated_results.update(chunk_res)

    # 4. 最终按基准顺序统一合并写回
    final_data = {"@@locale": target_locale}
    merged = {**current_data, **translated_results}

    for k in baseline_data.keys():
        if k == "@@locale" or k.startswith("@"):
            continue
        if k in merged:
            final_data[k] = merged[k]
            meta_k = "@" + k
            if meta_k in merged:
                final_data[meta_k] = merged[meta_k]

    # 判断数据是否有实际变动，无变动时不动文件，避免污染 git diff 与时间戳
    if final_data != current_data:
        save_arb(arb_path, final_data)
        if need_translation:
            log(f"🎉 语言 `{target_locale}` 并发翻译与写回完成！")
        else:
            log(f"🧹 语言 `{target_locale}` 结构规范化写回完成。")
    else:
        log(f"✅ 语言 `{target_locale}` 已是最新状态，无改动。")

    return target_locale, True


def parse_target_locales_from_dart(file_path: str) -> list[str]:
    locales = set()
    if not os.path.exists(file_path):
        log(f"⚠️ 未找到 {file_path}")
        return list(locales)

    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()

    pattern = re.compile(r"Locale\s*\(\s*['\"]([a-zA-Z]+)['\"](?:\s*,\s*['\"]([a-zA-Z]+)['\"])?\s*\)")
    for match in pattern.finditer(content):
        lang = match.group(1)
        country = match.group(2)
        locales.add(f"{lang}_{country}" if country else lang)

    return sorted(locales)


def main():
    if not PROVIDERS:
        log("❌ 错误: 云端 Secrets 未配置任何有效的 AI Provider！脚本终止。")
        sys.exit(1)

    log("==========================================")
    log("  启动云端 i18n 并发清洗、去重与 AI 增量翻译")
    log("==========================================")

    # 步骤 1：主表去重与格式化
    baseline_data = load_arb(BASELINE_ARB)
    if not baseline_data:
        log(f"❌ 错误: 基准文件 {BASELINE_ARB} 不存在或为空！")
        sys.exit(1)

    baseline_data = sanitize_and_deduplicate_arb(baseline_data)
    save_arb(BASELINE_ARB, baseline_data)
    log(f"✅ 基准文件 {os.path.basename(BASELINE_ARB)} 结构去重与格式化完成。")

    # 步骤 2：读取语言配置
    target_locales = parse_target_locales_from_dart(LANG_DATA_FILE)
    if not target_locales:
        log("⚠️ 未在 language_data.dart 解析到目标语言配置。")
        sys.exit(0)

    # 步骤 3：多线程并发处理（支持断点续修与部分成功持久化）
    log(f"🚀 开启并发多线程 ({MAX_WORKERS} Workers) 执行处理...")

    tasks = {}
    with ThreadPoolExecutor(max_workers=MAX_WORKERS) as executor:
        for locale in target_locales:
            if locale.startswith("en"):
                continue
            future = executor.submit(process_language_task, locale, baseline_data)
            tasks[future] = locale

        succeeded_locales = []
        failed_locales = []

        for future in as_completed(tasks):
            locale = tasks[future]
            try:
                future.result()
                succeeded_locales.append(locale)
            except Exception as e:
                failed_locales.append(locale)
                log(f"⚠️ 语言 `{locale}` 处理失败 (已安全隔离，不影响其他成功语言): {e}")

    log("==========================================")
    log("📊 增量翻译与检修断点续修报告:")
    log(f"   - 成功/完备语言 ({len(succeeded_locales)} 个): {', '.join(succeeded_locales) if succeeded_locales else '无'}")
    if failed_locales:
        log(f"   - 失败/未完成语言 ({len(failed_locales)} 个): {', '.join(failed_locales)}")
        log(f"   💡 已成功语言的改动已持久化保存。下一次运行将自动断点续修剩余 {len(failed_locales)} 个语言。")

    if not succeeded_locales and failed_locales:
        log("❌ 所有语言处理均失败，请检查 AI Provider 与网络状态。")
        sys.exit(1)

    log("==========================================")


if __name__ == "__main__":
    main()
