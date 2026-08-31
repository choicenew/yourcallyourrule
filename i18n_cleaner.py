#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Internationalization (i18n) Cleaner Script
精准剔除未使用的翻译键。

策略（100% 确定才删）：
  1. 扫描 .dart 文件，通过调用正则（AppLocalizations...xxx / l10n.xxx）提取"确认使用"集合 A
  2. 再次全量扫描所有 .dart / .arb 文本，用纯字符串匹配（"xxx"作为整词）提取"疑似出现"集合 B
  3. 最终"安全可删"集合 S = (en_keys - (A ∪ B))，即 en 中定义、且代码和任何地方都完全没出现过该标识符的键
  4. 从所有语言的 ARB 中删除 S 中的键以及对应的 @元数据键
  5. 删除前备份 l10n 目录

用法：
  python i18n_cleaner.py                    # 默认 dry-run，只打印将删除的内容
  python i18n_cleaner.py --apply            # 真正执行删除（会先备份）
  python i18n_cleaner.py --apply --nobackup # 执行删除，不备份
  python i18n_cleaner.py --report-dir xxx   # 指定报告目录，复用已生成的分析结果
"""

import argparse
import json
import os
import re
import shutil
import sys
from datetime import datetime
from typing import Optional

# ============ 配置 ============
PROJECT_ROOT = os.path.abspath(os.path.dirname(__file__))
LIB_DIR = os.path.join(PROJECT_ROOT, "lib")
L10N_DIR = os.path.join(PROJECT_ROOT, "lib", "l10n")
REPORT_DIR = os.path.join(PROJECT_ROOT, "i18n_reports")
BACKUP_ROOT = os.path.join(PROJECT_ROOT, "_l10n_backups")

BASELINE_ARB = "app_en.arb"
SPECIAL_KEYS = {"@@locale"}
METADATA_PREFIX = "@"

I18N_PATTERNS = [
    re.compile(
        r"AppLocalizations\s*\.\s*of\s*\([^)]*\)\s*[!?]?\s*\.\s*([a-zA-Z_][a-zA-Z0-9_]*)"
    ),
    re.compile(
        r"(?<![a-zA-Z0-9_])l10n\s*\?\.?\s*([a-zA-Z_][a-zA-Z0-9_]*)"
    ),
]


# ============ 工具函数 ============
def find_all_dart_files(root_dir: str) -> list[str]:
    dart_files = []
    for dirpath, _dn, filenames in os.walk(root_dir):
        for fn in filenames:
            if fn.endswith(".dart"):
                dart_files.append(os.path.join(dirpath, fn))
    return sorted(dart_files)


def find_all_arb_files(l10n_dir: str) -> list[str]:
    import glob
    return sorted(glob.glob(os.path.join(l10n_dir, "*.arb")))


def extract_confirmed_used_keys(dart_files: list[str]) -> set[str]:
    """通过调用正则提取 100% 确认使用过的键"""
    used = set()
    for df in dart_files:
        try:
            with open(df, "r", encoding="utf-8") as f:
                content = f.read()
        except (OSError, UnicodeDecodeError):
            continue
        for pat in I18N_PATTERNS:
            for m in pat.finditer(content):
                k = m.group(1)
                if k:
                    used.add(k)
    return used


def extract_text_occurred_keys(
    candidate_keys: set[str],
    text_file_paths: list[str],
) -> set[str]:
    """
    第二层保险：
    对于候选键集合 candidate_keys，在所有文本文件中做整词字符串匹配，
    只要出现过 "xxx"（双引号包起来，符合 ARB / Dart 字符串形态）就保留。
    这样即使正则漏了（比如间接拼接、反射、动态生成），也不会误删。
    """
    # 预编译每个候选键的整词匹配：前后是双引号，中间是完整标识符
    appeared = set()
    # 为了性能，把所有候选键按长度排序并合并成一个大正则
    if not candidate_keys:
        return appeared
    # 构造一个整词匹配模式：前后必须是引号（单双都算）或边界
    # 这里使用 "xxx" 或 'xxx' 或标识符作为独立 token 出现（前后非字母数字下划线）
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


def load_arb_dict(arb_path: str) -> dict:
    with open(arb_path, "r", encoding="utf-8") as f:
        return json.load(f)


def dump_arb_dict(arb_path: str, data: dict):
    """按 Flutter 标准写回：2 空格缩进，ASCII 不转义"""
    with open(arb_path, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
        f.write("\n")


def remove_keys_from_arb(arb_dict: dict, keys_to_remove: set[str]) -> tuple[dict, int]:
    """
    返回 (新字典, 删除的条目数)
    除了 keys_to_remove 中的翻译键，还要删除对应的 @key 元数据。
    """
    removed_count = 0
    new_dict = {}
    expanded_remove = set()
    for k in keys_to_remove:
        expanded_remove.add(k)
        expanded_remove.add(METADATA_PREFIX + k)

    for k, v in arb_dict.items():
        if k in expanded_remove:
            removed_count += 1
            continue
        new_dict[k] = v
    return new_dict, removed_count


def backup_l10n() -> Optional[str]:
    """把 lib/l10n 整个目录备份到 _l10n_backups/<时间戳>/l10n"""
    if not os.path.isdir(L10N_DIR):
        return None
    ts = datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_dir = os.path.join(BACKUP_ROOT, ts)
    dst = os.path.join(backup_dir, "l10n")
    os.makedirs(backup_dir, exist_ok=True)
    # 只备份文件，不递归（l10n 下本来就是文件）
    shutil.copytree(L10N_DIR, dst)
    return backup_dir


# ============ 主流程 ============
def compute_safe_keys_to_remove() -> tuple[set[str], set[str], set[str]]:
    """
    返回 (safe_remove_set, confirmed_used, text_appeared)
    safe_remove_set = en_keys - (confirmed_used ∪ text_appeared)
    """
    print("[1/5] 扫描 Dart 文件，提取已确认使用的翻译键（调用级）...")
    dart_files = find_all_dart_files(LIB_DIR)
    confirmed_used = extract_confirmed_used_keys(dart_files)
    print(f"      确认调用: {len(confirmed_used)} 个键")

    baseline_path = os.path.join(L10N_DIR, BASELINE_ARB)
    if not os.path.exists(baseline_path):
        print(f"[ERROR] 基准文件不存在: {baseline_path}")
        sys.exit(1)
    baseline_data = load_arb_dict(baseline_path)
    en_keys = set()
    for k in baseline_data.keys():
        if k in SPECIAL_KEYS or k.startswith(METADATA_PREFIX):
            continue
        en_keys.add(k)
    print(f"      en 翻译键总数: {len(en_keys)}")

    # 候选待删 = en 中定义但确认未调用
    candidate_to_remove = en_keys - confirmed_used
    print(f"      调用级未命中候选: {len(candidate_to_remove)} 个")

    print("[2/5] 第二层保险：全项目文本扫描整词出现情况...")
    # 扫描所有 .dart 和 .arb，防止间接引用
    all_text_files = list(dart_files) + find_all_arb_files(L10N_DIR)
    text_appeared = extract_text_occurred_keys(candidate_to_remove, all_text_files)
    print(f"      文本级命中（排除）: {len(text_appeared)} 个")

    # 100% 安全可删
    safe_remove_set = candidate_to_remove - text_appeared
    print(f"      -> 判定安全可删: {len(safe_remove_set)} 个")

    return safe_remove_set, confirmed_used, text_appeared


def apply_cleanup(
    safe_remove_set: set[str],
    do_backup: bool,
) -> tuple[dict[str, int], str | None]:
    """
    对所有 ARB 执行删除。
    第一步：如果 do_backup 为 True，先把整个 lib/l10n 文件夹原样备份。
    第二步：逐个 ARB 执行删除。
    返回：
      - stats: 每个 ARB 文件名删除条目数
      - backup_dir_path: 实际备份目录绝对路径（没备份时为 None）
    """
    stats: dict[str, int] = {}
    backup_dir_path: str | None = None

    if do_backup:
        print("[3/5] 先把整个 l10n 文件夹原样备份...")
        bp = backup_l10n()
        backup_dir_path = bp
        if bp:
            nested = os.path.join(bp, "l10n")
            arb_count_backup = len([f for f in os.listdir(nested) if f.endswith(".arb")]) if os.path.isdir(nested) else 0
            print(f"      备份目录: {bp}")
            print(f"      备份验证: 目录存在={os.path.isdir(nested)}，内含 .arb 数={arb_count_backup}")
        else:
            print("      [WARN] l10n 目录不存在，跳过目录备份。")

    print("[4/5] 从每个语言 ARB 中剔除未使用键...")
    arb_files = find_all_arb_files(L10N_DIR)
    for af in arb_files:
        base = os.path.basename(af)
        data = load_arb_dict(af)
        new_data, removed = remove_keys_from_arb(data, safe_remove_set)
        if removed > 0:
            dump_arb_dict(af, new_data)
        stats[base] = removed
        mark = "*" if removed > 0 else " "
        print(f"      [{mark}] {base:20s}: 删除 {removed:4d} 条")

    return stats, backup_dir_path


def main():
    parser = argparse.ArgumentParser(
        description="精准剔除 ARB 中未使用的翻译键（100% 确认才删，含双重扫描 + 自动备份）"
    )
    parser.add_argument(
        "--apply",
        action="store_true",
        help="真正执行删除。默认不传为 dry-run，仅打印",
    )
    parser.add_argument(
        "--nobackup",
        action="store_true",
        help="执行删除前不做备份（仅在 --apply 下生效，不推荐）",
    )
    args = parser.parse_args()

    print("=" * 70)
    print("  i18n 翻译清理工具（100% 确认才删）")
    print("=" * 70)

    mode = "DRY-RUN（预览，不修改文件）"
    if args.apply:
        mode = "APPLY（真正修改 ARB 文件）"
    print(f"  模式: {mode}")
    if args.apply:
        print(f"  备份: {'OFF' if args.nobackup else 'ON（自动）'}")
    print()

    safe_remove_set, confirmed_used, text_appeared = compute_safe_keys_to_remove()

    # 打印清单
    if safe_remove_set:
        print()
        print("[清单] 以下翻译键将被删除（基准 en 中存在 + 全局扫描未出现）：")
        baseline_path = os.path.join(L10N_DIR, BASELINE_ARB)
        baseline_data = load_arb_dict(baseline_path)
        for i, k in enumerate(sorted(safe_remove_set), 1):
            v = baseline_data.get(k, "")
            preview = str(v).replace("\n", " ")
            if len(preview) > 64:
                preview = preview[:61] + "..."
            print(f"  {i:4d}. {k:50s}  ->  {preview}")
    else:
        print("\n✅ 没有可安全删除的翻译键。")

    if not args.apply:
        print()
        print("=" * 70)
        print("  预览结束。若确认删除，请运行:")
        print("    python i18n_cleaner.py --apply")
        print("  （执行前会自动备份 lib/l10n 目录）")
        print("=" * 70)
        return

    stats, backup_dir_path = apply_cleanup(
        safe_remove_set, do_backup=not args.nobackup
    )

    print()
    print("[5/5] 写入清理执行记录...")
    os.makedirs(REPORT_DIR, exist_ok=True)
    report_path = os.path.join(REPORT_DIR, "06_清理执行记录.md")
    with open(report_path, "w", encoding="utf-8") as f:
        f.write("# i18n 清理执行记录\n\n")
        f.write(f"- 执行时间: {datetime.now().isoformat(timespec='seconds')}\n")
        f.write(f"- 模式: {'APPLY（真正修改文件）' if args.apply else 'DRY-RUN（仅预览）'}\n")
        f.write(f"- 清理前是否整文件夹备份 l10n: {'否（--nobackup）' if args.nobackup else '是'}\n")
        if backup_dir_path:
            nested = os.path.join(backup_dir_path, "l10n")
            f.write(f"- 清理前整文件夹备份路径: `{nested}`\n")
            f.write(f"- 备份目录直接覆盖还原命令 (PowerShell):\n")
            l10n_unix = os.path.join(PROJECT_ROOT, "lib", "l10n").replace("\\", "/")
            backup_unix = nested.replace("\\", "/")
            f.write(f"  ```powershell\n")
            f.write(f"  Remove-Item -Recurse -Force '{l10n_unix}'\n")
            f.write(f"  Copy-Item -Recurse -Force '{backup_unix}' '{l10n_unix}'\n")
            f.write(f"  ```\n")
            f.write(f"- 备份目录直接覆盖还原命令 (bash/macOS/Linux):\n")
            f.write(f"  ```bash\n")
            f.write(f"  rm -rf   '{l10n_unix}'\n")
            f.write(f"  cp -a    '{backup_unix}' '{l10n_unix}'\n")
            f.write(f"  ```\n\n")
        f.write(f"- 第一层(调用级)确认使用的键数: {len(confirmed_used)}\n")
        f.write(f"- 第二层(文本级整词)额外命中的键数: {len(text_appeared)}\n")
        f.write(f"- 最终判定安全可删除的键数: {len(safe_remove_set)}\n\n")

        if safe_remove_set:
            f.write("## 本次删除的翻译键清单（en 原文对照）\n\n")
            f.write("| # | 键 | en 原文（前120字符） |\n|---|----|--------------------|\n")
            baseline_path = os.path.join(L10N_DIR, BASELINE_ARB)
            baseline_data = load_arb_dict(baseline_path)
            for i, k in enumerate(sorted(safe_remove_set), 1):
                v = baseline_data.get(k, "")
                s = str(v).replace("\n", " ")
                if len(s) > 120:
                    s = s[:117] + "..."
                f.write(f"| {i} | `{k}` | {s} |\n")
            f.write("\n")

        f.write("## 各 ARB 文件删除条目数\n\n")
        f.write("| ARB 文件 | 删除条目 |\n|----------|----------|\n")
        for name, cnt in sorted(stats.items()):
            f.write(f"| {name} | {cnt} |\n")

    print(f"      清理记录: {report_path}")

    print()
    print("=" * 70)
    print("  清理完成！")
    if backup_dir_path:
        print(f"  ✅ 清理前已把整个 l10n 文件夹备份: {os.path.join(backup_dir_path, 'l10n')}")
        print("     一旦删错，直接用这个文件夹覆盖 lib/l10n/ 即可还原")
    elif args.nobackup:
        print("  ⚠️  你指定了 --nobackup，没有整文件夹备份，自行承担风险")
    print("=" * 70)


if __name__ == "__main__":
    main()
