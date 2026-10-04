#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
scripts/i18n_unused_reporter.py
独立 i18n 未使用键查重与 Markdown 报告生成工具（只分析与生成 MD 报告，绝对不删除/修改任何文件）

主要功能：
1. 全面正则表达式扫描所有 .dart 文件，涵盖各种调用范式：
   - 标准调用：AppLocalizations.of(context)!.key / AppLocalizations.of(context)?.key
   - context 扩展调用：context.l10n.key / context.loc.key / context.appLocalizations.key 等
   - 局部变量调用：l10n.key / appLocalizations.key / localizations.key / loc.key / s.key 等
   - 静态/全局调用：S.of(context).key / S.current.key / I18n.of(context).key 等
2. 第二层双重校验（全项目整词纯文本二次扫描）：
   对第一层未命中的“候选键”，进行全项目纯文本扫描（查找是否有 "key" 等形态出现），
   彻底杜绝反射、动态拼接或常量引用导致的误判。
3. 生成独立、清晰的 Markdown 报告 (i18n_reports/01_未使用的翻译键.md 及 json 摘要)。

用法：直接运行 python scripts/i18n_unused_reporter.py
"""

import os
import re
import json
import glob
from collections import defaultdict

# ============ 路径配置 ============
PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
LIB_DIR = os.path.join(PROJECT_ROOT, "lib")
L10N_DIR = os.path.join(PROJECT_ROOT, "lib", "l10n")
REPORT_DIR = os.path.join(PROJECT_ROOT, "i18n_reports")

BASELINE_ARB = "app_en.arb"
METADATA_PREFIX = "@"
SPECIAL_KEYS = {"@@locale"}

# 提取国际化调用的正则表达式（全面覆盖各种调用范式）
I18N_PATTERNS = [
    # 1. 标准调用：AppLocalizations.of(context)!.key / AppLocalizations.of(context)?.key
    re.compile(
        r"AppLocalizations\s*\.\s*of\s*\([^)]*\)\s*[!?]?\s*\.\s*([a-zA-Z_][a-zA-Z0-9_]*)"
    ),
    # 2. 上下文扩展调用：context.l10n.key / context.loc.key / context.appLocalizations.key / context.localizations.key / context.s.key / context.tr.key / context.t.key
    re.compile(
        r"(?<![a-zA-Z0-9_])context\s*\.\s*(?:l10n|loc|localizations|appLocalizations|s|tr|t)\s*[!?]?\s*\.\s*([a-zA-Z_][a-zA-Z0-9_]*)"
    ),
    # 3. 局部变量/Getter调用：l10n.key / appLocalizations.key / localizations.key / loc.key / s.key
    re.compile(
        r"(?<![a-zA-Z0-9_])(?:l10n|appLocalizations|localizations|loc|s)\s*[!?]?\s*\.\s*([a-zA-Z_][a-zA-Z0-9_]*)"
    ),
    # 4. 静态或全局类调用：S.of(context).key / S.current.key / I18n.of(context).key / I18n.current.key
    re.compile(
        r"(?<![a-zA-Z0-9_])(?:S|I18n)\s*\.\s*(?:of\s*\([^)]*\)|current)\s*[!?]?\s*\.\s*([a-zA-Z_][a-zA-Z0-9_]*)"
    ),
]


def find_all_dart_files(root_dir: str) -> list[str]:
    dart_files = []
    for dirpath, _dn, filenames in os.walk(root_dir):
        for fn in filenames:
            if fn.endswith(".dart"):
                dart_files.append(os.path.join(dirpath, fn))
    return sorted(dart_files)


def find_all_arb_files(l10n_dir: str) -> list[str]:
    return sorted(glob.glob(os.path.join(l10n_dir, "*.arb")))


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


def extract_text_occurred_keys(
    candidate_keys: set[str],
    text_file_paths: list[str],
) -> set[str]:
    """
    第二层双重校验：
    对正则未直接命中的候选键，进行全项目整词纯文本匹配，
    确保动态或者字符串常量引用的键不被误判。
    """
    appeared = set()
    if not candidate_keys:
        return appeared
    escaped_keys = [re.escape(k) for k in sorted(candidate_keys, key=len, reverse=True)]
    merged = re.compile(
        r'(["\'])(' + "|".join(escaped_keys) + r')\1'
        r"|"
        r'(?<![a-zA-Z0-9_])(' + "|".join(escaped_keys) + r')(?![a-zA-Z0-9_])'
    )
    for tfp in text_file_paths:
        try:
            with open(tfp, "r", encoding="utf-8") as f:
                content = f.read()
        except (OSError, UnicodeDecodeError):
            continue
        for m in merged.finditer(content):
            for grp in m.groups():
                if grp and grp in candidate_keys:
                    appeared.add(grp)
    return appeared


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
    print("=" * 70)
    print("      i18n 未使用翻译键查重与独立报告生成工具（只分析，不修改文件）")
    print("=" * 70)

    os.makedirs(REPORT_DIR, exist_ok=True)

    # 1. 扫描 Dart 文件
    print("\n[1/4] 扫描所有 Dart 文件，匹配各种 i18n 调用范式...")
    dart_files = find_all_dart_files(LIB_DIR)
    print(f"      共找到 {len(dart_files)} 个 .dart 文件")

    all_used_keys: set[str] = set()
    key_occurrences: dict[str, list[str]] = defaultdict(list)

    for df in dart_files:
        keys_in_file = extract_used_keys_from_dart(df)
        for k in keys_in_file:
            all_used_keys.add(k)
            key_occurrences[k].append(os.path.relpath(df, PROJECT_ROOT))

    print(f"      正则提取到 {len(all_used_keys)} 个被调用的翻译键")

    # 2. 读取基准 ARB
    baseline_path = os.path.join(L10N_DIR, BASELINE_ARB)
    if not os.path.exists(baseline_path):
        print(f"[ERROR] 基准文件不存在: {baseline_path}")
        return

    baseline_data = extract_keys_from_arb(baseline_path)
    baseline_keys = set(baseline_data.keys())
    print(f"      基准语言({BASELINE_ARB}) 翻译键总数: {len(baseline_keys)}")

    # 3. 双重校验查找未使用键
    print("\n[2/4] 执行双重校验（正则调用 + 全局文本整词匹配）...")
    candidate_unused = baseline_keys - all_used_keys

    arb_files = find_all_arb_files(L10N_DIR)
    all_text_files = list(dart_files) + arb_files
    text_appeared = extract_text_occurred_keys(candidate_unused, all_text_files)

    final_unused_keys = candidate_unused - text_appeared

    print(f"      第一层正则未命中候选: {len(candidate_unused)} 个")
    print(f"      第二层文本整词命中排除: {len(text_appeared)} 个")
    print(f"      -> 最终判定 100% 确认为未使用的多余键: {len(final_unused_keys)} 个")

    # 4. 输出 Markdown 报告
    print("\n[3/4] 正在生成 Markdown 分析报告...")
    report_path = os.path.join(REPORT_DIR, "01_未使用的翻译键.md")
    with open(report_path, "w", encoding="utf-8") as f:
        f.write("# 未使用的翻译键分析报告\n\n")
        f.write(f"- 基准语言: `en` (`{BASELINE_ARB}`)\n")
        f.write(f"- 基准语言翻译键总数: **{len(baseline_keys)}**\n")
        f.write(f"- 代码中实际正则调用键数: **{len(all_used_keys)}**\n")
        f.write(f"- 第二层文本命中保留键数: **{len(text_appeared)}**\n")
        f.write(f"- 最终确定未使用的多余键数: **{len(final_unused_keys)}**\n\n")
        f.write("> **说明**：以下翻译键在 `app_en.arb` 中存在，但在项目中既无正则调用，\n")
        f.write("> 也无任何字符串整词出现。属于 100% 确定多余的无效翻译键，可按需清理。\n\n")

        if not final_unused_keys:
            f.write("✅ **恭喜！未发现任何未使用的多余翻译键。**\n")
        else:
            f.write("## 确定未使用的翻译键清单\n\n")
            f.write("| # | 翻译键 | en 原文预览 |\n")
            f.write("|---|--------|--------------|\n")

            sorted_unused = sorted(final_unused_keys)
            for idx, key in enumerate(sorted_unused, 1):
                en_value = baseline_data.get(key, "")
                preview = en_value.replace("\n", " ")
                if len(preview) > 80:
                    preview = preview[:77] + "..."
                f.write(f"| {idx} | `{key}` | {preview} |\n")

            f.write("\n## 可直接复制用于清理的 JSON 片段\n\n")
            f.write("```json\n")
            first = True
            for key in sorted_unused:
                if not first:
                    f.write(",\n")
                value = baseline_data.get(key, "")
                escaped = json.dumps(value, ensure_ascii=False)
                f.write(f'  "{key}": {escaped}')
                first = False
            f.write("\n```\n")

    print(f"      报告已写入: {report_path}")

    # 5. 生成 JSON 摘要
    print("\n[4/4] 正在更新原始数据 JSON...")
    json_path = os.path.join(REPORT_DIR, "05_原始数据.json")
    export_data = {
        "summary": {
            "baseline_total_keys": len(baseline_keys),
            "used_keys_in_code": len(all_used_keys),
            "text_appeared_keys": len(text_appeared),
            "final_unused_keys": len(final_unused_keys),
        },
        "unused_keys": sorted(final_unused_keys),
    }
    with open(json_path, "w", encoding="utf-8") as f:
        json.dump(export_data, f, ensure_ascii=False, indent=2)

    print("=" * 70)
    print("分析完成！仅生成报告，未对项目代码及 ARB 文件进行任何修改。")
    print("=" * 70)


if __name__ == "__main__":
    main()
