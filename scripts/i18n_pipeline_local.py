#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
scripts/i18n_pipeline_local.py
云端全自动 腾讯混元 Hy-MT2-1.8B 本地模型无 API 依赖增量翻译管道

核心特征：
1. 100% 运行于 GitHub Actions 本地 CPU (127.0.0.1:8080)
2. 零外部云端 API 依赖、零 403 封锁、零 429 限流、零费用
3. 专针对腾讯 Hy-MT2-1.8B 极低比特 (1.25-bit/2-bit) 翻译模型优化
"""

import json
import os
import re
import sys
import time
import urllib.request
import urllib.error

# ============ 路径配置 ============
PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
L10N_DIR = os.path.join(PROJECT_ROOT, "lib", "l10n")
LANG_DATA_FILE = os.path.join(PROJECT_ROOT, "lib", "features", "language", "language_data.dart")
BASELINE_ARB = os.path.join(L10N_DIR, "app_en.arb")

# 本地 llama.cpp / llama-server API 地址
LOCAL_API_URL = os.environ.get("LOCAL_API_URL", "http://127.0.0.1:8080/v1/chat/completions")
CHUNK_SIZE = 15  # 本地模型推理 Batch 大小


def log(msg: str):
    print(f"[i18n-Local-HyMT2] {msg}", flush=True)


def load_arb(path: str) -> dict:
    if not os.path.exists(path):
        return {}
    try:
        with open(path, "r", encoding="utf-8") as f:
            return json.load(f)
    except Exception:
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


def call_local_hymt2_api(prompt: str) -> str:
    """调用本地运行的 腾讯 Hy-MT2-1.8B llama-server 接口"""
    headers = {"Content-Type": "application/json"}
    payload = {
        "messages": [{"role": "user", "content": prompt}],
        "temperature": 0.1,
        "top_p": 0.9,
    }
    data_bytes = json.dumps(payload).encode("utf-8")

    try:
        req = urllib.request.Request(LOCAL_API_URL, data=data_bytes, headers=headers, method="POST")
        with urllib.request.urlopen(req, timeout=120) as resp:
            res_body = resp.read().decode("utf-8")
            res_json = json.loads(res_body)
            choices = res_json.get("choices", [])
            if not choices:
                raise ValueError("本地模型响应未包含 choices")
            return choices[0]["message"]["content"]
    except urllib.error.URLError as e:
        log(f"❌ 无法连接本地 Hy-MT2 推理服务器 ({LOCAL_API_URL}): {e}")
        raise e


def translate_chunk_local(chunk: dict, target_locale: str) -> dict:
    prompt = f"""You are a professional Flutter ARB translator powered by Tencent Hy-MT2.
Translate the following JSON string values from English to target locale '{target_locale}'.

Requirements:
1. Return strictly a raw valid JSON object starting with {{ and ending with }}.
2. Do NOT alter key names.
3. Keep untranslated placeholders like {{userName}}, {{count}}, {{hours}}.
4. Do NOT wrap output in markdown syntax.

Input JSON:
{json.dumps(chunk, ensure_ascii=False)}"""

    raw_response = call_local_hymt2_api(prompt)
    clean_json = raw_response.replace("```json", "").replace("```", "").strip()

    # 清理非 JSON 的附加输出
    start_idx = clean_json.find('{')
    end_idx = clean_json.rfind('}')
    if start_idx != -1 and end_idx != -1:
        clean_json = clean_json[start_idx:end_idx + 1]

    return json.loads(clean_json)


def process_language_task_local(target_locale: str, baseline_data: dict):
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
        log(f"✅ 语言 `{target_locale}` 数据完备。")
        return

    log(f"🌐 [本地 Hy-MT2 推理] 语言 `{target_locale}` 开始处理 {len(need_translation)} 个词条...")

    items = list(need_translation.items())

    for i in range(0, len(items), CHUNK_SIZE):
        chunk = dict(items[i:i + CHUNK_SIZE])
        try:
            chunk_res = translate_chunk_local(chunk, target_locale)
            current_data.update(chunk_res)

            final_data = {"@@locale": target_locale}
            for k in baseline_data.keys():
                if k in current_data:
                    final_data[k] = current_data[k]
                    meta_k = "@" + k
                    if meta_k in baseline_data:
                        final_data[meta_k] = baseline_data[meta_k]

            save_arb(arb_path, final_data)
            log(f"   [本地落盘] `{target_locale}` 进度: {i + len(chunk)}/{len(items)} 条")
        except Exception as e:
            log(f"⚠️ `{target_locale}` 块处理遇到错误: {e}，已有进度已保存。")
            break

    log(f"🎉 语言 `{target_locale}` 处理完毕。")


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
    log("==========================================")
    log(" 腾讯混元 Hy-MT2-1.8B 本地模型翻译管道启动")
    log("==========================================")

    baseline_data = load_arb(BASELINE_ARB)
    if not baseline_data:
        log(f"❌ 错误: 基准文件 {BASELINE_ARB} 不存在！")
        sys.exit(1)

    baseline_data = sanitize_and_deduplicate_arb(baseline_data)
    save_arb(BASELINE_ARB, baseline_data)

    target_locales = parse_target_locales_from_dart(LANG_DATA_FILE)
    if not target_locales:
        log("⚠️ 未解析到语言配置。")
        sys.exit(0)

    log(f"🚀 开始调用本地 Hy-MT2 模型处理 {len(target_locales)} 个语言...")

    for locale in target_locales:
        if locale.startswith("en"):
            continue
        process_language_task_local(locale, baseline_data)

    log("==========================================")
    log("✅ 本地 Hy-MT2 智能增量翻译全套完成！")
    log("==========================================")


if __name__ == "__main__":
    main()
