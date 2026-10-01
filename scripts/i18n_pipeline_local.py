#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
scripts/i18n_pipeline_local.py
遵循 AngelSlim / Hy-MT2 官方与 Transformers GGUF 规范进行本地增量翻译

技术解答：
为什么报 `ValueError: Unrecognized model in ... Should have a model_type key in its config.json`:
`AngelSlim/Hy-MT2-1.8B-2Bit-GGUF` 是纯 GGUF 权重仓库，不包含常规 PyTorch 的 `config.json`。
Transformers 4.40+ 规定，从 GGUF 仓库加载 AutoModelForCausalLM 时，必须显式指定 `gguf_file` 参数！
"""

import json
import os
import re
import sys
import torch
from huggingface_hub import list_repo_files
from transformers import AutoModelForCausalLM, AutoTokenizer

# ============ 路径与模型配置 ============
PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
L10N_DIR = os.path.join(PROJECT_ROOT, "lib", "l10n")
LANG_DATA_FILE = os.path.join(PROJECT_ROOT, "lib", "features", "language", "language_data.dart")
BASELINE_ARB = os.path.join(L10N_DIR, "app_en.arb")

MODEL_PATH = os.environ.get("HY_MT2_MODEL_PATH", "AngelSlim/Hy-MT2-1.8B-2Bit-GGUF")

model = None
tokenizer = None


def log(msg: str):
    print(f"[i18n-Local-AngelSlim] {msg}", flush=True)


def init_hymt2_model():
    """使用 Transformers GGUF 加载规范加载 AngelSlim/Hy-MT2-1.8B-2Bit-GGUF"""
    global model, tokenizer
    log(f"开始加载 GGUF 镜像模型: {MODEL_PATH}")

    # 动态查询仓库内部的 GGUF 文件
    try:
        repo_files = list_repo_files(MODEL_PATH)
        gguf_files = [f for f in repo_files if f.endswith(".gguf")]
    except Exception as e:
        log(f"⚠️ 查询仓库文件失败: {e}")
        gguf_files = []

    target_gguf = gguf_files[0] if gguf_files else None

    if target_gguf:
        log(f"锁定 GGUF 权重目标文件: `{target_gguf}`，通过 Transformers 核心载入...")
        model = AutoModelForCausalLM.from_pretrained(
            MODEL_PATH,
            gguf_file=target_gguf,
            device_map="auto",
            trust_remote_code=True,
            low_cpu_mem_usage=True,
        )
    else:
        model = AutoModelForCausalLM.from_pretrained(
            MODEL_PATH,
            device_map="auto",
            trust_remote_code=True,
            torch_dtype='auto',
            low_cpu_mem_usage=True,
        )

    tokenizer = AutoTokenizer.from_pretrained(MODEL_PATH, gguf_file=target_gguf) if target_gguf else AutoTokenizer.from_pretrained(MODEL_PATH)
    log("✅ 模型与分词器通过 Transformers GGUF 规范成功加载！")


def translate_text_with_hymt2(text: str, target_lang: str) -> str:
    """按官方规范进行 generate 推理"""
    prompt = f"Translate to {target_lang}: {text}"
    inputs = tokenizer(prompt, return_tensors="pt").to(model.device)
    outputs = model.generate(**inputs, max_new_tokens=256)
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

    log(f"🌐 [AngelSlim 官方推理] 语言 `{target_locale}` 开始翻译 {len(need_translation)} 个词条...")

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
    log("  腾讯混元 Hy-MT2 GGUF 本地模型管道启动")
    log("==========================================")

    init_hymt2_model()

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

    log(f"🚀 开始处理 {len(target_locales)} 个语言...")

    for locale in target_locales:
        if locale.startswith("en"):
            continue
        process_language_task_local(locale, baseline_data)

    log("==========================================")
    log("✅ 本地 AngelSlim 智能增量翻译全套完成！")
    log("==========================================")


if __name__ == "__main__":
    main()
