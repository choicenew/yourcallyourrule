#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
scripts/i18n_pipeline_local.py
遵循 AngelSlim / Hy-MT2 官方 SGLang 规范调用本地模型服务进行增量翻译

技术解答：
之前的报错 `RuntimeError: Failed to infer device type` 是因为 vLLM 默认强制需要 Nvidia GPU 才能启动。
在 GitHub Actions 的无显卡 CPU 虚拟机中，vLLM 检测不到 CUDA 设备直接崩溃。
根据 AngelSlim 官方部署规范（Section 2 - 启动服务 SGLang），SGLang 对硬件架构的兼容性更好，我们将使用 SGLang 启动 OpenAI 兼容服务。
"""

import json
import os
import re
import sys
import urllib.request
import urllib.error

# ============ 路径与模型配置 ============
PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
L10N_DIR = os.path.join(PROJECT_ROOT, "lib", "l10n")
LANG_DATA_FILE = os.path.join(PROJECT_ROOT, "lib", "features", "language", "language_data.dart")
BASELINE_ARB = os.path.join(L10N_DIR, "app_en.arb")

# 本地 SGLang 部署接口地址 (AngelSlim 官方部署规范 Section 2)
LOCAL_API_URL = os.environ.get("LOCAL_API_URL", "http://127.0.0.1:8080/v1/chat/completions")
MODEL_NAME = os.environ.get("HY_MT2_MODEL_NAME", "Tencent-Hunyuan/Hy-MT2-1.8B")


def log(msg: str):
    print(f"[i18n-Local-SGLang] {msg}", flush=True)


def translate_text_with_hymt2(text: str, target_lang: str) -> str:
    """按 AngelSlim 官方 SGLang OpenAI API 规范调用本地推理服务"""
    headers = {"Content-Type": "application/json"}
    payload = {
        "model": MODEL_NAME,
        "messages": [
            {"role": "user", "content": f"Translate the following text into {target_lang}:\n{text}"}
        ],
        "temperature": 0.1,
        "max_tokens": 256
    }
    data_bytes = json.dumps(payload).encode("utf-8")

    try:
        req = urllib.request.Request(LOCAL_API_URL, data=data_bytes, headers=headers, method="POST")
        with urllib.request.urlopen(req, timeout=60) as resp:
            res_body = resp.read().decode("utf-8")
            res_json = json.loads(res_body)
            choices = res_json.get("choices", [])
            if not choices:
                raise ValueError("API 响应未包含 choices")
            return choices[0]["message"]["content"].strip()
    except Exception as e:
        log(f"❌ 调用本地 SGLang API 服务失败 ({LOCAL_API_URL}): {e}")
        raise e


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

    log(f"🌐 [SGLang 官方 API] 语言 `{target_locale}` 开始翻译 {len(need_translation)} 个词条...")

    translated_count = 0
    for key, en_text in need_translation.items():
        try:
            translated_text = translate_text_with_hymt2(en_text, target_locale)
            current_data[key] = translated_text
            translated_count += 1

            if translated_count % 10 == 0:
                final_data = {"@@locale": target_locale}
                for k in baseline_data.keys():
                    if k in current_data:
                        final_data[k] = current_data[k]
                        meta_k = "@" + k
                        if meta_k in baseline_data:
                            final_data[meta_k] = baseline_data[meta_k]
                save_arb(arb_path, final_data)
                log(f"   [磁盘落盘] `{target_locale}` 进度: {translated_count}/{len(need_translation)} 条")

        except Exception as e:
            log(f"⚠️ `{target_locale}` 词条 `{key}` 翻译异常: {e}")

    final_data = {"@@locale": target_locale}
    for k in baseline_data.keys():
        if k in current_data:
            final_data[k] = current_data[k]
            meta_k = "@" + k
            if meta_k in baseline_data:
                final_data[meta_k] = baseline_data[meta_k]
    save_arb(arb_path, final_data)
    log(f"🎉 语言 `{target_locale}` 处理完毕！")


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
    log("  腾讯混元 Hy-MT2 官方 SGLang API 本地管道启动")
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

    log(f"🚀 开始调用本地 SGLang API 处理 {len(target_locales)} 个语言...")

    for locale in target_locales:
        if locale.startswith("en"):
            continue
        process_language_task_local(locale, baseline_data)

    log("==========================================")
    log("✅ 本地 SGLang Hy-MT2 智能增量翻译全套完成！")
    log("==========================================")


if __name__ == "__main__":
    main()
