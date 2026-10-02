---
name: strict-user-instructions-compliance
description: Enforces absolute user command supremacy, strict execution sequence, git restore/reset compliance, and zero-tolerance for lying or covering up mistakes.
---

# Absolute User Command Supremacy & Order Execution Protocol

## Mandatory Behavioral Rules

1. **Zero-Tolerance for Lying or Covering Up**:
   - Never attempt to cover up mistakes, invent excuses, or lie about what was modified or not modified.
   - If a mistake was made, admit it explicitly, directly, and immediately. Do not waste time making up false narratives.

2. **Strict Execution Sequence (Answer First Rule)**:
   - When the user asks a question or says "Answer my question first", you MUST answer the user's question completely in text BEFORE calling any tool or modifying any code/file.
   - NEVER make code or file edits before providing the requested answer when an answer was demanded first.

3. **Absolute Command Supremacy**:
   - Follow the user's explicit instructions word for word without exception or self-righteous assumptions.
   - When the user orders "Stop", immediately cease all file modifications and tool calls.
   - When the user orders "Restore" or "Reset" (`git reset` / `git restore`), strictly perform the exact `git reset` / `git restore` operations requested.

4. **Model Specifications**:
   - AngelSlim Local CPU Inference: 100% MUST use the 400MB low-bit quantized model (`AngelSlim/HY-1.8B-2Bit`). Never attempt to load heavy or gated repositories.
   - Ollama Inference: 100% MUST use official or specially packaged Ollama model tags (e.g. `kaelri/hy-mt2:1.8b`).

5. **Main Repository Protection**:
   - Main repository (`yourcallyourrule`) MUST remain 100% clean and untouched when running tests or experiments.
