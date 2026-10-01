#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
scripts/i18n_pipeline.py
云端全自动 i18n 增量检修、去重与多 Provider + 多 Flash/Mini 低消耗 Model 自动重试与降级 AI 翻译管道脚本

优化要点：
1. 【小参数/低消耗优先】默认挑选极速、极低 Token 消耗的 Flash / Nano / Mini / Instant 轻量模型，节省 API 免费额度并秒级响应。
2. 【ChatAnywhere 配额优化】针对 ChatAnywhere 优先匹配 gpt-4.1-nano (0.4 CA)、gpt-4o-mini (0.75 CA)、deepseek-v4.1-flash (1 CA) 等低消耗模型。
3. 【Groq 极速优化】针对 Groq 优先匹配 llama-3.1-8b-instant (每秒上千 Token，0 延迟)。
4. 【OpenRouter 免费池】针对 OpenRouter 优先匹配 gemini-2.0-flash-exp:free、llama-3.2-3b-instruct:free。
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
MAX_WORKERS = 3           # 多线程并发处理语言数
CHUNK_SIZE = 25           # 每次发给 AI 的分块词条数
INTER_REQUEST_DELAY = 1.2 # 并发硬休眠秒数（防频控）
MAX_RETRIES_PER_MODEL = 2

rate_limit_lock = Lock()


def log(msg: str):
    print(f"[i18n-Pipeline] {msg}", flush=True)


# 极速、极低配额消耗的 Flash / Nano / Mini 默认模型池
DEFAULT_MODELS = {
    "openrouter": [
        "google/gemini-2.0-flash-exp:free",
        "meta-llama/llama-3.2-3b-instruct:free",
        "qwen/qwen-2.5-7b-instruct:free",
        "cognitivecomputations/dolphin-mistral-24b-venice-edition:free",
    ],
    "groq": [
        "llama-3.1-8b-instant",   # 极速 8B 模型，秒级响应
        "llama-3.3-70b-versatile",
        "mixtral-8x7b-32768",
    ],
    "modelscope": [
        "qwen/Qwen2.5-7B-Instruct",
        "deepseek-ai/DeepSeek-V3",
    ],
    "chatanywhere": [
        "gpt-4.1-nano",           # 消耗极低：仅 0.4 CA / M tokens
        "gpt-4o-mini",            # 消耗极低：仅 0.75 CA / M tokens
        "deepseek-v4.1-flash",     # 消耗极低：仅 1 CA / M tokens
        "deepseek-chat",
    ],
}


# ============ 1. 动态多 Provider & 多 Model 加载 ============
def load_providers() -> list[dict]:
    """从环境变量动态加载 Provider 配置，并补全轻量候选 Model 列表"""
    providers_json = os.environ.get("AI_PROVIDERS", "").strip()
    raw_providers = []

    if providers_json:
        try:
            parsed = json.loads(providers_json)
            if isinstance(parsed, list) and len(parsed) > 0:
                raw_providers = parsed
        except Exception as e:
            log(f"⚠️ 解析 AI_PROVIDERS 环境变量失败: {e}")

    if not raw_providers:
        single_url = os.environ.get("AI_PROVIDER_URL", "").strip()
        single_key = os.environ.get("AI_TRANSLATE_KEY", "").strip()
        single_model = os.environ.get("AI_MODEL", "").strip()
        if single_url and single_key:
            p = {"name": "Default-Provider", "url": single_url, "key": single_key}
            if single_model:
                p["model"] = single_model
            raw_providers = [p]

    processed_providers = []
    for p in raw_providers:
        name = p.get("name", "Unknown")
        url = p.get("url", "").strip()
        key = p.get("key", "").strip()

        if not url or not key:
            continue

        candidate_models = []
        if "models" in p and isinstance(p["models"], list):
            candidate_models.extend([m for m in p["models"] if m])
        if "model" in p and p["model"]:
            if p["model"] not in candidate_models:
                candidate_models.append(p["model"])

        # 未指定 model 时，根据 URL 匹配超小/超低消耗默认模型
        if not candidate_models:
            url_lower = url.lower()
            for kw, defaults in DEFAULT_MODELS.items():
                if kw in url_lower:
                    candidate_models.extend(defaults)
                    break

        processed_providers.append({
            "name": name,
            "url": url,
            "key": key,
            "models": candidate_models if candidate_models else [""]
        })

    log(f"成功加载 {len(processed_providers)} 个 AI Provider 配置。")
    for p in processed_providers:
        log(f"  - [{p['name']}] URL: {p['url']} | 候选模型: {p['models']}")

    return processed_providers


PROVIDERS = load_providers()
provider_cycle = itertools.cycle(PROVIDERS) if PROVIDERS else None


# ============ 2. ARB 工具函数 ============
def load_arb(path: str) -> dict:
    if not os.path.exists(path):
        return {}
    try:
        with open(path, "r", encoding="utf-8") as f:
            return json.load(f)
    except Exception as e:
        log(f"⚠️ 警告: 读取 {os.path.basename(path)} 失败: {e}，重置为空 JSON")
        return {}


def save_arb(path: str, data: dict):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
        f.write("\n")


def sanitize_and_deduplicate_arb(data: dict) -> dict:
    sanitized = {}
    for k, v in data.items():
        if k in sanitized:
            if v and not sanitized[k]:
                sanitized[k] = v
        else:
            sanitized[k] = v
    return sanitized


def clean_obsolete_keys_from_target(target_data: dict, baseline_keys: set) -> dict:
    cleaned = {}
    if "@@locale" in target_data:
        cleaned["@@locale"] = target_data["@@locale"]
    for k, v in target_data.items():
        if k in baseline_keys or k.startswith("@"):
            cleaned[k] = v
    return cleaned


def is_untranslated_value(en_val: str, target_val: str) -> bool:
    if not target_val or not str(target_val).strip():
        return True
    if en_val == target_val and len(en_val) > 3:
        if re.search(r"[a-zA-Z]", en_val):
            return True
    return False


# ============ 3. API 请求处理 ============
def call_ai_api_with_failover(prompt: str) -> str:
    if not PROVIDERS:
        raise RuntimeError("云端未配置任何有效的 AI Provider！")

    start_provider = next(provider_cycle)
    ordered_providers = [start_provider] + [p for p in PROVIDERS if p != start_provider]

    with rate_limit_lock:
        time.sleep(INTER_REQUEST_DELAY)

    for provider in ordered_providers:
        provider_name = provider["name"]
        url = provider["url"]
        key = provider["key"]
        models = provider["models"]

        for model in models:
            headers = {"Content-Type": "application/json"}

            if "generativelanguage" in url:
                full_url = f"{url}?key={key}" if "key=" not in url else url
                payload = {"contents": [{"parts": [{"text": prompt}]}]}
            else:
                full_url = url
                headers["Authorization"] = f"Bearer {key}"
                if "openrouter.ai" in url:
                    headers["HTTP-Referer"] = "https://github.com/yourcallyourrule"
                    headers["X-Title"] = "Flutter i18n Auto Translator"

                payload = {"messages": [{"role": "user", "content": prompt}]}
                if model:
                    payload["model"] = model

            data_bytes = json.dumps(payload).encode("utf-8")

            for attempt in range(1, MAX_RETRIES_PER_MODEL + 1):
                try:
                    req = urllib.request.Request(full_url, data=data_bytes, headers=headers, method="POST")
                    with urllib.request.urlopen(req, timeout=45) as resp:
                        res_body = resp.read().decode("utf-8")
                        res_json = json.loads(res_body)

                        if "generativelanguage" in url:
                            return res_json["candidates"][0]["content"]["parts"][0]["text"]
                        else:
                            choices = res_json.get("choices", [])
                            if not choices:
                                raise ValueError(f"API 响应未包含 valid choices: {res_body[:200]}")
                            return choices[0]["message"]["content"]

                except urllib.error.HTTPError as e:
                    err_msg = e.read().decode("utf-8", errors="ignore")[:300]
                    log(f"⚠️ Provider [{provider_name}] (Model: {model or 'default'}) 触发 HTTP {e.code}: {err_msg}")
                    if e.code == 429 or e.code >= 500:
                        time.sleep((2 ** attempt) * 2)
                    else:
                        break
                except Exception as e:
                    log(f"⚠️ Provider [{provider_name}] (Model: {model or 'default'}) 网络异常: {e}")
                    time.sleep(2)

    raise RuntimeError("❌ 所有 Provider 及候选模型均尝试失败，请检查云端 Key 及模型配置！")


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
    clean_json = raw_response.replace("```json", "").replace("```", "").strip()
    return json.loads(clean_json)


# ============ 4. 语言任务处理 ============
def process_language_task(target_locale: str, baseline_data: dict):
    arb_path = os.path.join(L10N_DIR, f"app_{target_locale}.arb")
    current_data = load_arb(arb_path)

    current_data = sanitize_and_deduplicate_arb(current_data)
    current_data = clean_obsolete_keys_from_target(current_data, set(baseline_data.keys()))

    valid_en_keys = {k: v for k, v in baseline_data.items() if not k.startswith("@") and k != "@@locale"}

    need_translation = {}
    for k, en_val in valid_en_keys.items():
        curr_val = current_data.get(k)
        if is_untranslated_value(en_val, curr_val):
            need_translation[k] = en_val

    if not need_translation:
        save_arb(arb_path, current_data)
        log(f"✅ 语言 `{target_locale}` 已清理且数据完备。")
        return target_locale, True

    log(f"🌐 [并发线程] 语言 `{target_locale}` 开始翻译修补 {len(need_translation)} 个词条...")

    translated_results = {}
    items = list(need_translation.items())

    for i in range(0, len(items), CHUNK_SIZE):
        chunk = dict(items[i:i + CHUNK_SIZE])
        chunk_res = translate_chunk(chunk, target_locale)
        translated_results.update(chunk_res)

    final_data = {"@@locale": target_locale}
    merged = {**current_data, **translated_results}

    for k in baseline_data.keys():
        if k in merged:
            final_data[k] = merged[k]
            meta_k = "@" + k
            if meta_k in baseline_data:
                final_data[meta_k] = baseline_data[meta_k]

    save_arb(arb_path, final_data)
    log(f"🎉 语言 `{target_locale}` 并发翻译与写回完成！")
    return target_locale, True


def parse_target_locales_from_dart(file_path: str) -> list[str]:
    locales = set()
    if not os.path.exists(file_path):
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
    log("  启动云端 i18n 多 Provider + 超小/超低消耗 Model 并发翻译")
    log("==========================================")

    baseline_data = load_arb(BASELINE_ARB)
    if not baseline_data:
        log(f"❌ 错误: 基准文件 {BASELINE_ARB} 不存在或为空！")
        sys.exit(1)

    baseline_data = sanitize_and_deduplicate_arb(baseline_data)
    save_arb(BASELINE_ARB, baseline_data)

    target_locales = parse_target_locales_from_dart(LANG_DATA_FILE)
    if not target_locales:
        log("⚠️ 未在 language_data.dart 解析到目标语言配置。")
        sys.exit(0)

    log(f"🚀 开启并发多线程 ({MAX_WORKERS} Workers) 执行处理...")

    tasks = []
    with ThreadPoolExecutor(max_workers=MAX_WORKERS) as executor:
        for locale in target_locales:
            if locale.startswith("en"):
                continue
            tasks.append(executor.submit(process_language_task, locale, baseline_data))

        for future in as_completed(tasks):
            try:
                future.result()
            except Exception as e:
                log(f"❌ 某个并发任务执行报错: {e}")

    log("==========================================")
    log("✅ 全套并发去重、检修与 AI 增量翻译成功完成！")
    log("==========================================")


if __name__ == "__main__":
    main()
