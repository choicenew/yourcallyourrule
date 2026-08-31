#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Internationalization (i18n) Analysis Script
功能：
1. 扫描所有 .dart 文件，提取实际使用的国际化翻译键
2. 解析所有 .arb 翻译文件
3. 对比 app_en.arb 与实际使用情况，找出未使用的翻译键
4. 对比其他语言与 app_en.arb，找出缺失的翻译键
5. 生成分析报告

使用方式：直接运行 python i18n_analyzer.py
"""

import os
import re
import json
import glob
from collections import defaultdict

# ============ 配置 ============
PROJECT_ROOT = r"c:\Users\Ngokel\Desktop\en\test\github\yourcallyourrulemixhistory"
LIB_DIR = os.path.join(PROJECT_ROOT, "lib")
L10N_DIR = os.path.join(PROJECT_ROOT, "lib", "l10n")
REPORT_DIR = os.path.join(PROJECT_ROOT, "i18n_reports")

# 基准语言文件
BASELINE_ARB = "app_en.arb"

# 提取国际化调用的正则表达式
# 匹配模式：
#   AppLocalizations.of(context)!.xxx  或  AppLocalizations.of(context)?.xxx
#   AppLocalizations.of(context)!.xxx(  或  AppLocalizations.of(context)?.xxx(
#   l10n.xxx  或  l10n?.xxx
#   l10n.xxx(  或  l10n?.xxx(
#
# 说明：只提取 .后面第一个标识符（属性/方法名），不提取参数
I18N_PATTERNS = [
    # AppLocalizations.of(context)!?
    re.compile(
        r"AppLocalizations\s*\.\s*of\s*\([^)]*\)\s*[!?]?\s*\.\s*([a-zA-Z_][a-zA-Z0-9_]*)"
    ),
    # l10n 后面直接跟 .或?.
    re.compile(
        r"(?<![a-zA-Z0-9_])l10n\s*\?\.?\s*([a-zA-Z_][a-zA-Z0-9_]*)"
    ),
]

# 需要忽略的键（ARB 文件中的元数据）
METADATA_PREFIX = "@"
SPECIAL_KEYS = {"@@locale"}


# ============ 工具函数 ============
def find_all_dart_files(root_dir: str) -> list[str]:
    """递归查找所有 .dart 文件"""
    dart_files = []
    for dirpath, _dirnames, filenames in os.walk(root_dir):
        for filename in filenames:
            if filename.endswith(".dart"):
                dart_files.append(os.path.join(dirpath, filename))
    return sorted(dart_files)


def find_all_arb_files(l10n_dir: str) -> list[str]:
    """查找 l10n 目录下所有 .arb 文件"""
    return sorted(glob.glob(os.path.join(l10n_dir, "*.arb")))


def extract_used_keys_from_dart(dart_file_path: str) -> set[str]:
    """从单个 .dart 文件中提取所有使用过的 i18n 键"""
    used_keys = set()
    try:
        with open(dart_file_path, "r", encoding="utf-8") as f:
            content = f.read()
    except (UnicodeDecodeError, OSError) as e:
        print(f"  [WARN] 读取文件失败: {dart_file_path} -> {e}")
        return used_keys

    for pattern in I18N_PATTERNS:
        for match in pattern.finditer(content):
            key = match.group(1)
            if key:
                used_keys.add(key)

    return used_keys


def extract_keys_from_arb(arb_path: str) -> dict[str, str]:
    """
    解析 ARB 文件，返回 {翻译键: 翻译值}
    过滤掉以 @ 开头的元数据和 @@locale 等特殊键
    """
    result = {}
    try:
        with open(arb_path, "r", encoding="utf-8") as f:
            data = json.load(f)
    except (json.JSONDecodeError, UnicodeDecodeError, OSError) as e:
        print(f"  [WARN] 解析 ARB 失败: {arb_path} -> {e}")
        return result

    for key, value in data.items():
        if key in SPECIAL_KEYS:
            continue
        if key.startswith(METADATA_PREFIX):
            continue
        if isinstance(value, str):
            result[key] = value
    return result


def get_language_code_from_filename(filename: str) -> str:
    """从 app_zh_CN.arb 这样的文件名提取语言代码 zh_CN"""
    base = os.path.basename(filename)
    # 去掉前缀 app_ 和后缀 .arb
    if base.startswith("app_"):
        base = base[4:]
    elif base.startswith("intl_"):
        base = base[5:]
    if base.endswith(".arb"):
        base = base[:-4]
    return base


def safe_make_dir(path: str):
    """确保目录存在"""
    if not os.path.exists(path):
        os.makedirs(path, exist_ok=True)


# ============ 主分析逻辑 ============
def main():
    print("=" * 70)
    print("         i18n 国际化翻译分析工具")
    print("=" * 70)

    safe_make_dir(REPORT_DIR)

    # 1. 扫描所有 dart 文件，提取使用过的翻译键
    print("\n[1/5] 扫描 Dart 文件，提取使用过的翻译键...")
    dart_files = find_all_dart_files(LIB_DIR)
    print(f"      找到 {len(dart_files)} 个 .dart 文件")

    all_used_keys: set[str] = set()
    key_occurrences: dict[str, list[str]] = defaultdict(list)

    for df in dart_files:
        keys_in_file = extract_used_keys_from_dart(df)
        for k in keys_in_file:
            all_used_keys.add(k)
            key_occurrences[k].append(os.path.relpath(df, PROJECT_ROOT))

    print(f"      共提取到 {len(all_used_keys)} 个不同的翻译键")

    # 2. 加载所有 ARB 文件
    print("\n[2/5] 加载 ARB 翻译文件...")
    arb_files = find_all_arb_files(L10N_DIR)
    print(f"      找到 {len(arb_files)} 个 .arb 文件")

    arb_data: dict[str, dict[str, str]] = {}
    for af in arb_files:
        lang_code = get_language_code_from_filename(af)
        arb_data[lang_code] = extract_keys_from_arb(af)
        print(f"      - {lang_code:12s}: {len(arb_data[lang_code])} 个翻译键 ({os.path.basename(af)})")

    baseline_lang_code = get_language_code_from_filename(BASELINE_ARB)
    if baseline_lang_code not in arb_data:
        print(f"\n[ERROR] 未找到基准语言文件: {BASELINE_ARB}，脚本终止。")
        return

    baseline_keys: set[str] = set(arb_data[baseline_lang_code].keys())
    print(f"\n      基准语言(en)翻译键总数: {len(baseline_keys)}")

    # 3. 找出基准语言中未使用的键
    print("\n[3/5] 分析未使用的翻译键（en 中定义但代码中未使用）...")
    unused_in_baseline: set[str] = baseline_keys - all_used_keys
    used_not_in_baseline: set[str] = all_used_keys - baseline_keys

    print(f"      en 中未被使用的键: {len(unused_in_baseline)} 个")
    print(f"      代码中使用但 en 中缺失的键: {len(used_not_in_baseline)} 个")

    # 4. 对比其他语言与基准，找出缺失翻译
    print("\n[4/5] 对比其他语言，分析缺失的翻译...")
    missing_per_lang: dict[str, set[str]] = {}
    untranslated_per_lang: dict[str, set[str]] = {}
    unused_per_lang: dict[str, set[str]] = {}

    baseline_values = arb_data[baseline_lang_code]

    for lang_code, translations in arb_data.items():
        if lang_code == baseline_lang_code:
            continue
        # 当前语言拥有的键
        lang_keys = set(translations.keys())
        # 基准有但当前语言没有 -> 缺失
        missing = baseline_keys - lang_keys
        missing_per_lang[lang_code] = missing

        # 基准和当前都有，但值完全一致 -> 疑似未翻译
        untranslated = set()
        for k in baseline_keys & lang_keys:
            en_val = baseline_values.get(k, "")
            lang_val = translations.get(k, "")
            # 仅当有占位符且完全相同时才判定（简单字符串常见不翻译，如 "All", "123"）
            if en_val and lang_val and en_val == lang_val and len(en_val) > 3:
                # 跳过纯数字、短单词，保守一点：长度 > 3 且有至少一个字母
                if re.search(r"[a-zA-Z]", en_val):
                    # 如果含有占位符 {xxx}，则更可能是未翻译
                    has_placeholder = bool(re.search(r"\{[a-zA-Z_][a-zA-Z0-9_]*\}", en_val))
                    if has_placeholder or len(en_val) > 8:
                        untranslated.add(k)
        untranslated_per_lang[lang_code] = untranslated

        # 当前语言中未被使用的键（相对于代码使用情况）
        unused = (set(translations.keys()) & baseline_keys) - all_used_keys
        unused_per_lang[lang_code] = unused

    # 5. 生成报告
    print("\n[5/5] 生成报告文档...")
    generate_reports(
        report_dir=REPORT_DIR,
        baseline_lang=baseline_lang_code,
        baseline_keys=baseline_keys,
        baseline_values=baseline_values,
        all_used_keys=all_used_keys,
        unused_in_baseline=unused_in_baseline,
        used_not_in_baseline=used_not_in_baseline,
        key_occurrences=key_occurrences,
        missing_per_lang=missing_per_lang,
        untranslated_per_lang=untranslated_per_lang,
        unused_per_lang=unused_per_lang,
        arb_data=arb_data,
    )

    print("\n" + "=" * 70)
    print(f"分析完成！报告已生成到: {REPORT_DIR}")
    print("=" * 70)


def generate_reports(
    report_dir: str,
    baseline_lang: str,
    baseline_keys: set[str],
    baseline_values: dict[str, str],
    all_used_keys: set[str],
    unused_in_baseline: set[str],
    used_not_in_baseline: set[str],
    key_occurrences: dict[str, list[str]],
    missing_per_lang: dict[str, set[str]],
    untranslated_per_lang: dict[str, set[str]],
    unused_per_lang: dict[str, set[str]],
    arb_data: dict[str, dict[str, str]],
):
    """生成多个报告文档"""

    # ============ 报告1: 未使用的翻译键（en 为准，附带其他语言对应条目） ============
    report1_path = os.path.join(report_dir, "01_未使用的翻译键.md")
    with open(report1_path, "w", encoding="utf-8") as f:
        f.write("# 未使用的翻译键分析报告\n\n")
        f.write(f"- 基准语言: `{baseline_lang}`\n")
        f.write(f"- 基准语言翻译键总数: **{len(baseline_keys)}**\n")
        f.write(f"- 代码中实际使用的翻译键数: **{len(all_used_keys)}**\n")
        f.write(f"- 未被使用的翻译键数: **{len(unused_in_baseline)}**\n\n")
        f.write("> 说明：以下键在 `app_en.arb` 中定义，但在项目 .dart 代码中未通过\n")
        f.write("> `AppLocalizations.of(context)!?.xxx` 或 `l10n!?.xxx` 形式调用。\n")
        f.write("> 可能是遗留项，可以考虑移除。\n\n")

        if not unused_in_baseline:
            f.write("✅ **未发现未使用的翻译键！**\n")
        else:
            f.write("## 未使用翻译键清单\n\n")
            f.write("| # | 翻译键 | en 原文（前60字符） | 在哪些语言中同样存在 |\n")
            f.write("|---|--------|---------------------|---------------------|\n")

            sorted_unused = sorted(unused_in_baseline)
            for idx, key in enumerate(sorted_unused, 1):
                en_value = baseline_values.get(key, "")
                preview = en_value.replace("\n", " ")
                if len(preview) > 60:
                    preview = preview[:57] + "..."
                # 统计哪些语言也有这个键
                langs_with_key = []
                for lc, vals in arb_data.items():
                    if lc == baseline_lang:
                        continue
                    if key in vals:
                        langs_with_key.append(lc)
                langs_str = ", ".join(sorted(langs_with_key)) if langs_with_key else "（仅 en）"
                f.write(f"| {idx} | `{key}` | {preview} | {langs_str} |\n")

            f.write(f"\n## 可直接删除的 JSON 片段（app_en.arb）\n\n")
            f.write("```json\n")
            first = True
            for key in sorted_unused:
                # 顺便把 @元数据 也带上（如果有）
                meta_key = "@" + key
                if not first:
                    f.write(",\n")
                # 写键值对
                value = baseline_values.get(key, "")
                escaped = json.dumps(value, ensure_ascii=False)
                f.write(f'  "{key}": {escaped}')
                # 写元数据（如果在原始arb中存在）
                # 这里我们只从 baseline_values 拿实际翻译值，不处理元数据
                first = False
            f.write("\n```\n")

    # ============ 报告2: 各语言缺失翻译键清单 ============
    report2_path = os.path.join(report_dir, "02_各语言缺失的翻译键.md")
    with open(report2_path, "w", encoding="utf-8") as f:
        f.write("# 各语言缺失翻译键报告\n\n")
        f.write(f"- 基准语言: `{baseline_lang}` (共 {len(baseline_keys)} 个键)\n\n")
        f.write("> 说明：基准语言有但其他语言文件中没有的键。已过滤掉基准语言中未被代码使用的键。\n\n")

        # 只关心"基准语言中被实际使用"的那些键的缺失情况
        used_baseline_keys = baseline_keys & all_used_keys

        # 概览表
        f.write("## 概览\n\n")
        f.write("| 语言 | 总键数 | 拥有数 | 缺失数 | 疑似未翻译数 | 未使用键数 |\n")
        f.write("|------|--------|--------|--------|--------------|------------|\n")
        sorted_langs = sorted(arb_data.keys())
        for lc in sorted_langs:
            if lc == baseline_lang:
                continue
            own_keys = set(arb_data[lc].keys())
            own_count = len(own_keys & baseline_keys)
            miss_count = len(baseline_keys - own_keys)
            untrans_count = len(untranslated_per_lang.get(lc, set()))
            unused_count = len(unused_per_lang.get(lc, set()))
            f.write(
                f"| `{lc:12s}` | {len(baseline_keys)} | {own_count} | "
                f"**{miss_count}** | {untrans_count} | {unused_count} |\n"
            )
        f.write("\n")

        # 每种语言的详细清单
        for lc in sorted_langs:
            if lc == baseline_lang:
                continue
            own_keys = set(arb_data[lc].keys())
            # 过滤：只展示那些基准语言中被实际使用的缺失键
            missing_set = (baseline_keys - own_keys) & used_baseline_keys
            untranslated_set = untranslated_per_lang.get(lc, set()) & used_baseline_keys

            if not missing_set and not untranslated_set:
                continue

            f.write(f"\n---\n\n## 语言: `{lc}`\n\n")

            if missing_set:
                f.write(f"### 缺失的翻译键（{len(missing_set)} 个，已使用）\n\n")
                f.write("| # | 翻译键 | en 原文 |\n|---|--------|--------|\n")
                for idx, key in enumerate(sorted(missing_set), 1):
                    en_val = baseline_values.get(key, "")
                    # 转义 markdown 表格中的管道符
                    safe_val = en_val.replace("|", "\\|").replace("\n", " ")
                    f.write(f"| {idx} | `{key}` | {safe_val} |\n")
                f.write("\n")

                # 生成可直接粘贴到 ARB 的 JSON 片段
                f.write("#### 可粘贴到 `app_" + lc + ".arb` 的骨架\n\n")
                f.write("```json\n")
                first = True
                for key in sorted(missing_set):
                    if not first:
                        f.write(",\n")
                    value = baseline_values.get(key, "")
                    escaped = json.dumps(value, ensure_ascii=False)
                    f.write(f'  "{key}": {escaped}')
                    first = False
                f.write("\n```\n\n")

            if untranslated_set:
                f.write(f"### 疑似未翻译（与 en 相同，{len(untranslated_set)} 个）\n\n")
                f.write("| # | 翻译键 | 值（与 en 相同） |\n|---|--------|------------------|\n")
                for idx, key in enumerate(sorted(untranslated_set), 1):
                    val = arb_data[lc].get(key, "")
                    safe_val = val.replace("|", "\\|").replace("\n", " ")
                    if len(safe_val) > 80:
                        safe_val = safe_val[:77] + "..."
                    f.write(f"| {idx} | `{key}` | {safe_val} |\n")
                f.write("\n")

    # ============ 报告3: 代码中使用但 en 中缺失的键 ============
    report3_path = os.path.join(report_dir, "03_代码使用但EN缺失的键.md")
    with open(report3_path, "w", encoding="utf-8") as f:
        f.write("# 代码中使用但 en 中缺失的翻译键\n\n")
        f.write(f"- 代码中使用了 {len(all_used_keys)} 个不同翻译键\n")
        f.write(f"- 其中 **{len(used_not_in_baseline)}** 个在 `app_en.arb` 中找不到定义\n\n")
        f.write("> 注意：这些键可能来自 intl_*.arb 或生成代码中的其他属性，\n")
        f.write("> 或者是拼写错误、使用了非标准命名。请逐一核实。\n\n")

        if not used_not_in_baseline:
            f.write("✅ **全部匹配！代码中使用的键在 en 中均有定义。**\n")
        else:
            f.write("| # | 翻译键 | 出现位置（部分） |\n|---|--------|------------------|\n")
            for idx, key in enumerate(sorted(used_not_in_baseline), 1):
                occs = key_occurrences.get(key, [])
                preview = "; ".join(occs[:5])
                if len(occs) > 5:
                    preview += f" (+{len(occs) - 5} 处)"
                f.write(f"| {idx} | `{key}` | {preview} |\n")

    # ============ 报告4: 所有语言综合对比 CSV ============
    report4_path = os.path.join(report_dir, "04_所有语言翻译对比.csv")
    sorted_langs = sorted(arb_data.keys())
    with open(report4_path, "w", encoding="utf-8-sig") as f:
        # BOM 保证 Excel 正确识别 UTF-8
        header = ["key", "是否被使用"] + sorted_langs
        f.write(",".join(f'"{h}"' for h in header) + "\n")

        for key in sorted(baseline_keys):
            used_mark = "YES" if key in all_used_keys else "UNUSED"
            row = [key, used_mark]
            for lc in sorted_langs:
                val = arb_data[lc].get(key, "")
                # CSV 转义：双引号转义为两个双引号
                escaped = val.replace('"', '""')
                row.append(escaped)
            f.write(",".join(f'"{c}"' for c in row) + "\n")

    # ============ 报告5: 纯 JSON 导出，便于程序进一步处理 ============
    report5_path = os.path.join(report_dir, "05_原始数据.json")
    with open(report5_path, "w", encoding="utf-8") as f:
        export = {
            "summary": {
                "baseline_language": baseline_lang,
                "baseline_total_keys": len(baseline_keys),
                "used_keys_in_code": len(all_used_keys),
                "unused_keys_in_baseline": len(unused_in_baseline),
                "code_used_but_baseline_missing": len(used_not_in_baseline),
                "languages_count": len(arb_data),
            },
            "unused_keys_baseline": sorted(unused_in_baseline),
            "code_used_but_baseline_missing": sorted(used_not_in_baseline),
            "missing_keys_per_language": {
                lc: sorted(s) for lc, s in missing_per_lang.items()
            },
            "untranslated_keys_per_language": {
                lc: sorted(s) for lc, s in untranslated_per_lang.items()
            },
            "key_occurrences": {
                k: sorted(v) for k, v in key_occurrences.items()
            },
            "arb": {
                lc: v for lc, v in arb_data.items()
            },
        }
        json.dump(export, f, ensure_ascii=False, indent=2)


if __name__ == "__main__":
    main()
