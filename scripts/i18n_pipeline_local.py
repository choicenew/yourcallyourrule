#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
scripts/i18n_pipeline_local.py
云端全自动 腾讯混元 Hy-MT2-1.8B 本地 GGUF 模型 (via HuggingFace AngelSlim/Hy-MT2-1.8B-2Bit-GGUF + llama_cpp) 翻译管道

核心特征：
1. 精确指向 HuggingFace 官方仓库: AngelSlim/Hy-MT2-1.8B-2Bit-GGUF
2. 使用 hf_hub_download 自动下载 GGUF 权重文件并由 llama_cpp 原生内存加载
3. 无需独立 HTTP Server、无需 401 鉴权 Token、零外部 API 依赖
"""

import json
import os
import re
import sys
from huggingface_hub import hf_hub_download
from llama_cpp import Llama

# ============ 路径与模型配置 ============
PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
L10N_DIR = os.path.join(PROJECT_ROOT, "lib", "l10n")
LANG_DATA_FILE = os.path.join(PROJECT_ROOT, "lib", "features", "language", "language_data.dart")
BASELINE_ARB = os.path.join(L10N_DIR, "app_en.arb")

# 精确对应的 HuggingFace 仓库与 GGUF 文件名
REPO_ID = "AngelSlim/Hy-MT2-1.8B-2Bit-GGUF"
FILENAME = "hy-mt2-1.8b-2bit.gguf"

llm = None


def log(msg: str):
    print(f"[i18n-Local-HyMT2] {msg}", flush=True)


def init_hymt2_model():
    """从 HuggingFace AngelSlim 仓库下载并初始化加载 Hy-MT2 GGUF 模型"""
    global llm
    log(f"正在从 HuggingFace 仓库 `{REPO_ID}` 下载权重文件 `{FILENAME}`...")

    # 从 HuggingFace 自动下载 GGUF 文件并缓存
    model_path = hf_hub_download(
        repo_id=REPO_ID,
        filename=FILENAME,
        repo_type="model"
    )
    log(f"权重已就绪: {model_path}")
    log("正在通过 llama_cpp 原生引擎加载模型...")

    # 内存中直接加载 GGUF 推理引擎
    llm = Llama(
        model_path=model_path,
        n_ctx=2048,
        verbose=False
    )
    log("✅ 腾讯混元 Hy-MT2-1.8B 2Bit-GGUF 本地模型加载成功！")


def translate_text_with_hymt2(text: str, target_lang: str) -> str:
    """使用 Hy-MT2 本地模型进行单文本翻译"""
    prompt = f"Translate the following text into {target_lang}:\n{text}\nTranslation:"

    output = llm(
        prompt,
        max_tokens=256,
        stop=["\n\n", "Input:"],
        echo=False
    )

    translated = output["choices"][0]["text"].strip()
    return translated


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

    log(f"🌐 [Hy-MT2 逐条本地推理] 语言 `{target_locale}` 开始翻译 {len(need_translation)} 个词条...")

    translated_count = 0
    for key, en_text in need_translation.items():
        try:
            translated_text = translate_text_with_hymt2(en_text, target_locale)
            current_data[key] = translated_text
            translated_count += 1

            # 每 10 条进度落盘硬保存
            if translated_count % 10 == 0:
                final_data = {"@@locale": target_locale}
                for k in baseline_data.keys():
                    if k in current_data:
                        final_data[k] = current_data[k]
                        meta_k = "@" + k
                        if meta_k in baseline_data:
                            final_data[meta_k] = baseline_data[meta_k]
                save_arb(arb_path, final_data)
                log(f"   [磁盘硬保存] `{target_locale}` 进度: {translated_count}/{len(need_translation)} 条")

        except Exception as e:
            log(f"⚠️ `{target_locale}` 词条 `{key}` 翻译异常: {e}")

    # 最终完整落盘
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
    log("  腾讯混元 Hy-MT2-1.8B-2Bit 本地模型管道启动")
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

    log(f"🚀 开始调用本地 Hy-MT2 2Bit 模型处理 {len(target_locales)} 个语言...")

    for locale in target_locales:
        if locale.startswith("en"):
            continue
        process_language_task_local(locale, baseline_data)

    log("==========================================")
    log("✅ 本地 Hy-MT2 智能增量翻译全套完成！")
    log("==========================================")


if __name__ == "__main__":
    main()
