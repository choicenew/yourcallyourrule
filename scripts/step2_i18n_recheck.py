#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
第二步：全文反查与报告生成
1. 读取 step1_result.json 中生成的候选未使用名单（candidate_unused_keys）。
2. 在所有业务 Dart 文件中进行全局整词检索。
3. 剔除在源码中以纯文本/常量等形式确实出现过的键。
4. 确认最终的 100% 未使用废键，并生成 Markdown 报告和最终 JSON 摘要。
"""

import os
import re
import json

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
REPORT_DIR = os.path.join(PROJECT_ROOT, "i18n_reports")
STEP1_FILE = os.path.join(REPORT_DIR, "step1_result.json")

def extract_text_occurred_keys(candidate_keys: set[str], text_file_paths: list[str]) -> set[str]:
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

def main():
    print("=" * 60)
    print("      [Step 2] i18n 二次全文反查与报告生成")
    print("=" * 60)

    if not os.path.exists(STEP1_FILE):
        print(f"[ERROR] 未找到初步分析数据: {STEP1_FILE}")
        return

    with open(STEP1_FILE, "r", encoding="utf-8") as f:
        step1_data = json.load(f)

    dart_files = step1_data["dart_files"]
    candidate_unused_keys = set(step1_data["candidate_unused_keys"])
    baseline_data = step1_data["baseline_data"]
    regex_used_keys = step1_data["regex_used_keys"]
    baseline_keys = step1_data["baseline_keys"]

    print(f"1. 加载 Step1 数据完成：收到 {len(candidate_unused_keys)} 个候选未使用键。")
    print(f"2. 开始在 {len(dart_files)} 个业务文件中进行全局文本反查...")

    text_appeared = extract_text_occurred_keys(candidate_unused_keys, dart_files)

    print(f"   反查结果：有 {len(text_appeared)} 个键以文本形式在源码中被发现（已排除嫌疑）。")

    final_unused_keys = candidate_unused_keys - text_appeared
    print(f"3. 最终确认为废弃无用的键数：{len(final_unused_keys)} 个。")

    # 生成最终 Markdown 报告
    print("4. 生成未使用的翻译键分析报告...")
    report_path = os.path.join(REPORT_DIR, "01_未使用的翻译键.md")
    with open(report_path, "w", encoding="utf-8") as f:
        f.write("# 未使用的翻译键分析报告\n\n")
        f.write(f"- 基准语言: `en`\n")
        f.write(f"- 基准语言翻译键总数: **{len(baseline_keys)}**\n")
        f.write(f"- [Step1] 正则匹配提取键数: **{len(regex_used_keys)}**\n")
        f.write(f"- [Step1] 候选未使用键数: **{len(candidate_unused_keys)}**\n")
        f.write(f"- [Step2] 文本二次反查自证清白键数: **{len(text_appeared)}**\n")
        f.write(f"- 最终 100% 确定未使用的多余键数: **{len(final_unused_keys)}**\n\n")
        f.write("> **说明**：以下翻译键在 `app_en.arb` 中存在，但在项目中既无调用，\n")
        f.write("> 也无任何字符串整词出现。属于完全废弃的翻译，可安全清理。\n\n")

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

    # 生成最终汇总 JSON
    export_data = {
        "summary": {
            "baseline_total_keys": len(baseline_keys),
            "step1_regex_used": len(regex_used_keys),
            "step1_candidate_unused": len(candidate_unused_keys),
            "step2_text_verified_used": len(text_appeared),
            "final_unused_keys_count": len(final_unused_keys),
        },
        "final_unused_keys": sorted(final_unused_keys),
        "text_verified_keys": sorted(text_appeared)
    }

    json_path = os.path.join(REPORT_DIR, "02_综合验证数据摘要.json")
    with open(json_path, "w", encoding="utf-8") as f:
        json.dump(export_data, f, ensure_ascii=False, indent=2)

    # 善后：删除 Step 1 的临时文件（保持 Artifact 清洁）
    if os.path.exists(STEP1_FILE):
        os.remove(STEP1_FILE)

    print("=" * 60)
    print(f"分析彻底完成！报告已生成在 {REPORT_DIR}")
    print("=" * 60)

if __name__ == "__main__":
    main()
