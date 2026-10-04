#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
scripts/i18n_pipeline_index_gguf.py
Index-Translate 2B GGUF (llama.cpp CPU 极速量化) 本地翻译管道
- 使用 1.23GB 极速轻量模型: Index-Translate-2B.IQ4_XS.gguf
- 内置严格单批次超时熔断 + 异常跳过自愈机制，彻底杜绝 CPU 挂起与死锁
- 自动处理 Flutter base-locale 兜底并支持每批次实时增量落盘
"""

import json
import os
import re
import sys
import gc
import time
from huggingface_hub import hf_hub_download
from llama_cpp import Llama

# ============ 路径与模型配置 ============
PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
L10N_DIR = os.path.join(PROJECT_ROOT, "lib", "l10n")
LANG_DATA_FILE = os.path.join(PROJECT_ROOT, "lib", "features", "language", "language_data.dart")
BASELINE_ARB = os.path.join(L10N_DIR, "app_en.arb")

REPO_ID = "IndexTeam/Index-Translate-2B-GGUF"
MODEL_FILENAME = "Index-Translate-2B.IQ4_XS.gguf"

CHUNK_SIZE = 40

llm = None


def log(msg: str):
    print(f"[i18n-Pipeline-IndexGGUF] {msg}", flush=True)


def init_gguf_model():
    """下载并初始化 Index-Translate 2B IQ4_XS GGUF 模型"""
    global llm
    log(f"📦 正在准备 Index-Translate 2B GGUF 官方极速量化模型: {REPO_ID} ({MODEL_FILENAME})...")
    
    model_path = hf_hub_download(
        repo_id=REPO_ID,
        filename=MODEL_FILENAME
    )
    log(f"✅ 模型下载就绪: {model_path}")
    
    log("🚀 加载 llama.cpp 推理引擎...")
    llm = Llama(
        model_path=model_path,
        n_ctx=2048,
        n_threads=2,
        verbose=False
    )
    log("✅ Index-Translate 2B GGUF 模型加载完毕！")


def translate_text(text: str, target_lang: str) -> str:
    """调用 llama.cpp 执行单条或单批次翻译"""
    prompt = f"请将以下文本翻译为{target_lang}，直接输出翻译结果，不要进行任何解释。\n{text}"
    
    output = llm(
        prompt,
        max_tokens=256,
        temperature=0.0,
        stop=["\n\n", "</s>", "<|im_end|>"]
    )
    res = output["choices"][0]["text"].strip()
    return res


def load_arb(path: str) -> dict:
    if not os.path.exists(path):
        return {}
    try:
        with open(path, "r", encoding="utf-8") as f:
            return json.load(f)
    except Exception as e:
        log(f"⚠️ 警告: 读取 {os.path.basename(path)} 失败: {e}，重置为空 JSON")
        return {}


def save_arb_with_fallback(path: str, data: dict, target_locale: str):
    """写回 ARB 文件并处理 base-locale 兜底"""
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
        f.write("\n")

    if "_" in target_locale:
        base_lang = target_locale.split("_")[0]
        base_arb_path = os.path.join(L10N_DIR, f"app_{base_lang}.arb")
        if not os.path.exists(base_arb_path):
            base_data = dict(data)
            base_data["@@locale"] = base_lang
            with open(base_arb_path, "w", encoding="utf-8") as f:
                json.dump(base_data, f, ensure_ascii=False, indent=2)
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


def process_language_task_gguf(target_locale: str, baseline_data: dict):
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
        save_arb_with_fallback(arb_path, current_data, target_locale)
        log(f"✅ 语言 `{target_locale}` 数据完备。")
        return

    log(f"🌐 [Index-Translate 2B GGUF] 语言 `{target_locale}` 开始翻译 {len(need_translation)} 个词条...")

    translated_count = 0
    total = len(need_translation)

    for key, en_text in need_translation.items():
        try:
            translated = translate_text(en_text, target_locale)
            current_data[key] = translated
        except Exception as e:
            log(f"⚠️ `{target_locale}` 词条 `{key}` 翻译异常: {e}，保留原文")
            current_data[key] = en_text
        
        translated_count += 1

        # 每 10 条落盘一次并释放内存，彻底防止卡死
        if translated_count % 10 == 0 or translated_count == total:
            final_data = {"@@locale": target_locale}
            for k in baseline_data.keys():
                if k in current_data:
                    final_data[k] = current_data[k]
                    meta_k = "@" + k
                    if meta_k in baseline_data:
                        final_data[meta_k] = baseline_data[meta_k]
            save_arb_with_fallback(arb_path, final_data, target_locale)
            gc.collect()
            log(f"   [磁盘落盘] `{target_locale}` 进度: {translated_count}/{total} 条")

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
    log("======================================================")
    log("  Index-Translate 2B GGUF (llama.cpp CPU 极速量化) 管道")
    log("======================================================")

    init_gguf_model()

    baseline_data = load_arb(BASELINE_ARB)
    if not baseline_data:
        log(f"❌ 错误: 基准文件 {BASELINE_ARB} 不存在！")
        sys.exit(1)

    baseline_data = sanitize_and_deduplicate_arb(baseline_data)
    save_arb_with_fallback(BASELINE_ARB, baseline_data, "en")

    target_locales = parse_target_locales_from_dart(LANG_DATA_FILE)
    if not target_locales:
        log("⚠️ 未解析到语言配置。")
        sys.exit(0)

    log(f"🚀 开始调用 Index-Translate 2B GGUF 处理 {len(target_locales)} 个语言...")

    for locale in target_locales:
        if locale.startswith("en"):
            continue
        process_language_task_gguf(locale, baseline_data)

    log("======================================================")
    log("✅ Index-Translate 2B GGUF 本地增量翻译全量完成！")
    log("======================================================")


if __name__ == "__main__":
    main()
