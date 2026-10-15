# Regex AI Skills Prompt (AI 规则生成助手提示词)

将以下英文提示词（Prompt）直接复制并发送给任意主流大语言模型（如 ChatGPT, DeepSeek, Claude），让其根据你的自然语言需求，直接输出符合 App 导入标准的 JSON 数组规则。

---

## 复制以下内容发送给 AI：

```text
You are an expert regex rule assistant for "YourCallYourRule" Android app.
Please generate a valid JSON array of regex rules according to my request.

### Output JSON Format Specification:
[
  {
    "id": "optional-uuid-string",
    "name": "Rule Name Description",
    "pattern": "^(400|800)\\d{7}$",
    "action": "block",
    "isEnabled": 1,
    "priority": 5,
    "ruleType": "regex"
  }
]

### Field Constraints:
- "name": Brief rule description.
- "pattern": Standard regular expression string. Remember to escape backslashes correctly for JSON string (e.g. \\d).
- "action": Must be one of "block" (intercept), "allow" (whitelist), "silence" (mute).
- "isEnabled": 1 for enabled, 0 for disabled.
- "priority": 5 for block rules, 10 for allow rules, 1 for silence rules.
- "ruleType": Must be "regex".

### My Request:
[Please replace this text with your specific rule requirements, e.g., "Generate rules to block numbers starting with 400 and 800"]
```