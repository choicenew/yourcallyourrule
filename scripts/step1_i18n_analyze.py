#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
第一步：初步扫描与基准对比
1. 扫描所有业务 Dart 文件，通过正则表达式提取明确调用的翻译键。
2. 读取基准 app_en.arb 文件。
3. 对比得出“候选未使用名单”（在 arb 中存在，但在代码中未被正则命中）。
4. 将初步分析结果写入 i18n_reports/step1_result.json。
"""

import os
import re
import json

# ============ 路径配置 ============
PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
LIB_DIR = os.path.join(PROJECT_ROOT, "lib")
L10N_DIR = os.path.join(PROJECT_ROOT, "lib", "l10n")
REPORT_DIR = os.path.join(PROJECT_ROOT, "i18n_reports")

BASELINE_ARB = "app_en.arb"
METADATA_PREFIX = "@"
SPECIAL_KEYS = {"@@locale"}

# 提取国际化调用的正则表达式
I18N_PATTERNS = [
    re.compile(r"AppLocalizations\s*\.\s*of\s*\([^)]*\)\s*[!?]?\s*\.\s*([a-zA-Z_][a-zA-Z0-9_]*)"),
    re.compile(r"(?<![a-zA-Z0-9_])context\s*\.\s*(?:l10n|loc|localizations|appLocalizations|s|tr|t)\s*[!?]?\s*\.\s*([a-zA-Z_][a-zA-Z0-9_]*)"),
    re.compile(r"(?<![a-zA-Z0-9_])(?:l10n|appLocalizations|localizations|loc|s)\s*[!?]?\s*\.\s*([a-zA-Z_][a-zA-Z0-9_]*)"),
    re.compile(r"(?<![a-zA-Z0-9_])(?:S|I18n)\s*\.\s*(?:of\s*\([^)]*\)|current)\s*[!?]?\s*\.\s*([a-zA-Z_][a-zA-Z0-9_]*)"),
]

def find_all_dart_files(root_dir: str) -> list[str]:
    dart_files = []
    for dirpath, _dirnames, filenames in os.walk(root_dir):
        if "generated" in dirpath.split(os.sep):
            continue
        for filename in filenames:
            if filename.endswith(".dart"):
                if filename.startswith("app_localizations"):
                    continue
                dart_files.append(os.path.join(dirpath, filename))
    return sorted(dart_files)

def extract_used_keys_from_dart(dart_file_path: str) -> set[str]:
    used_keys = set()
    try:
        with open(dart_file_path, "r", encoding="utf-8") as f:
            content = f.read()
    except (UnicodeDecodeError, OSError):
        return used_keys

    for pattern in I18N_PATTERNS:
        for match in pattern.finditer(content):
            key = match.group(1)
            if key:
                used_keys.add(key)
    return used_keys

def extract_keys_from_arb(arb_path: str) -> dict[str, str]:
    result = {}
    try:
        with open(arb_path, "r", encoding="utf-8") as f:
            data = json.load(f)
    except (json.JSONDecodeError, UnicodeDecodeError, OSError):
        return result

    for key, value in data.items():
        if key in SPECIAL_KEYS or key.startswith(METADATA_PREFIX):
            continue
        if isinstance(value, str):
            result[key] = value
    return result

def main():
    print("=" * 60)
    print("      [Step 1] i18n 初始扫描与提取")
    print("=" * 60)

    os.makedirs(REPORT_DIR, exist_ok=True)

    print("1. 扫描 Dart 业务文件，提取被明确正则调用的键...")
    dart_files = find_all_dart_files(LIB_DIR)

    all_used_keys = set()
    for df in dart_files:
        all_used_keys.update(extract_used_keys_from_dart(df))

    print(f"   找到 {len(dart_files)} 个业务 .dart 文件")
    print(f"   正则提取到 {len(all_used_keys)} 个翻译键")

    print(f"2. 读取基准字典 {BASELINE_ARB}...")
    baseline_path = os.path.join(L10N_DIR, BASELINE_ARB)
    baseline_data = extract_keys_from_arb(baseline_path)
    baseline_keys = set(baseline_data.keys())
    print(f"   基准语言翻译键总数: {len(baseline_keys)}")

    candidate_unused = baseline_keys - all_used_keys
    print(f"3. 发现候选未使用键（将在 Step2 进行全文反查）: {len(candidate_unused)} 个")

    # 导出给 Step 2 用的数据
    export_data = {
        "dart_files": dart_files,
        "baseline_keys": list(baseline_keys),
        "regex_used_keys": list(all_used_keys),
        "candidate_unused_keys": list(candidate_unused),
        "baseline_data": baseline_data # 保留原文用于最后生成报告
    }

    out_path = os.path.join(REPORT_DIR, "step1_result.json")
    with open(out_path, "w", encoding="utf-8") as f:
        json.dump(export_data, f, ensure_ascii=False, indent=2)

    print(f"   分析结果已写入: {out_path}")

if __name__ == "__main__":
    main()
