#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
scripts/i18n_pipeline_local.py
遵循 AngelSlim 官方规范，通过 Engine 装载 AngelSlim 内核模型，并自动保证 Flutter 本地化 base-locale 兜底文件
"""

import json
import os
import re
import sys
import torch
from angelslim.engine import Engine
from transformers import AutoTokenizer

# ============ 路径与模型配置 ============
PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
L10N_DIR = os.path.join(PROJECT_ROOT, "lib", "l10n")
LANG_DATA_FILE = os.path.join(PROJECT_ROOT, "lib", "features", "language", "language_data.dart")
BASELINE_ARB = os.path.join(L10N_DIR, "app_en.arb")

MODEL_PATH = "AngelSlim/HY-1.8B-2Bit"

slim_engine = None
model = None
tokenizer = None


def log(msg: str):
    print(f"[i18n-Local-AngelSlim] {msg}", flush=True)


def init_hymt2_model():
    """按 AngelSlim 规范初始化 prepare_model，并提取 AngelSlim 内核修饰后的 model 与 tokenizer"""
    global slim_engine, model, tokenizer
    log(f"通过 AngelSlim Engine 加载模型: {MODEL_PATH}")

    slim_engine = Engine()
    slim_engine.prepare_model(model_name="HunyuanDense", model_path=MODEL_PATH)

    # 从 AngelSlim SlimModel 中提取已经过量化算子修饰的底层 PyTorch 模型与分词器
    if hasattr(slim_engine, "slim_model") and slim_engine.slim_model:
        model = getattr(slim_engine.slim_model, "model", slim_engine.slim_model)
        tokenizer = getattr(slim_engine.slim_model, "tokenizer", None)

    if not tokenizer:
        tokenizer = AutoTokenizer.from_pretrained(MODEL_PATH)

    log("✅ 腾讯混元 2Bit 模型与分词器已成功通过 AngelSlim 框架初始化就绪！")


def translate_text_with_hymt2(text: str, target_lang: str) -> str:
    """使用 AngelSlim 算子修饰后的模型进行标准 generate 推理"""
    prompt = f"Translate to {target_lang}: {text}"
    inputs = tokenizer(prompt, return_tensors="pt").to(model.device)

    with torch.no_grad():
        outputs = model.generate(**inputs, max_new_tokens=256, do_sample=False)

    translated = tokenizer.decode(outputs[0], skip_special_tokens=True)
    if prompt in translated:
        translated = translated.replace(prompt, "").strip()
    return translated.strip()


def load_arb(path: str) -> dict:
    if not os.path.exists(path):
        return {}
    try:
        with open(path, "r", encoding="utf-8") as f:
            return json.load(f)
    except Exception:
        return {}


def save_arb_with_fallback(path: str, data: dict, target_locale: str):
    """写回 ARB 文件，并自动处理 Flutter 要求的 base-locale 基础兜底文件 (如 app_hu_HU.arb -> app_hu.arb)"""
    os.makedirs(os.path.dirname(path), exist_ok=True)

    # 1. 写入目标 ARB 文件
    with open(path, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
        f.write("\n")

    # 2. 如果包含下划线 (如 hu_HU, zh_CN)，自动确保基础文件 app_hu.arb 存在，规避 Flutter gen-l10n 报错
    if "_" in target_locale:
        base_lang = target_locale.split("_")[0]
        base_arb_path = os.path.join(L10N_DIR, f"app_{base_lang}.arb")
        if not os.path.exists(base_arb_path):
            base_data = dict(data)
            base_data["@@locale"] = base_lang
            with open(base_arb_path, "w", encoding="utf-8") as f:
                json.dump(base_data, f, ensure_ascii=False, indent=2)
                f.write("\n")
            log(f"💡 自动生成 Flutter gen-l10n 所需的 Base Fallback 文件: app_{base_lang}.arb")


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
        save_arb_with_fallback(arb_path, current_data, target_locale)
        log(f"✅ 语言 `{target_locale}` 数据完备。")
        return

    log(f"🌐 [AngelSlim 框架推理] 语言 `{target_locale}` 开始翻译 {len(need_translation)} 个词条...")

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
                save_arb_with_fallback(arb_path, final_data, target_locale)
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
    save_arb_with_fallback(arb_path, final_data, target_locale)
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
    log("  腾讯混元 2Bit 官方 AngelSlim 框架推理管道启动")
    log("==========================================")

    init_hymt2_model()

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

    log(f"🚀 开始调用本地 AngelSlim 2Bit 模型处理 {len(target_locales)} 个语言...")

    for locale in target_locales:
        if locale.startswith("en"):
            continue
        process_language_task_local(locale, baseline_data)

    log("==========================================")
    log("✅ 本地 AngelSlim 智能增量翻译全套完成！")
    log("==========================================")


if __name__ == "__main__":
    main()
