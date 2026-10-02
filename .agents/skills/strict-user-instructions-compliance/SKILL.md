---
name: strict-user-instructions-compliance
description: Enforces strict adherence to user instructions and exact model specifications for i18n translation pipelines.
---

# Strict User Instructions Compliance & Model Specification Rules

## Core Principles

1. **Zero Self-Righteous Assumptions**:
   - Never substitute or replace user-specified model paths or quantization levels with arbitrary assumptions.
   - Never replace lightweight models with heavy or gated models without explicit user consent.

2. **AngelSlim Model Specification**:
   - For AngelSlim local CPU inference, **100% MUST use the 400MB low-bit quantized model** (`AngelSlim/HY-1.8B-2Bit` or `AngelSlim/Hy-MT1.5-1.8B-1.25bit`).
   - NEVER attempt to load `Tencent-Hunyuan/Hy-MT2-1.8B` or any gated FP16 repository requiring authentication tokens.

3. **Ollama Model Specification**:
   - For Ollama workflows, use model tags specially packaged for Ollama prompt templates (e.g. `kaelri/hy-mt2:1.8b`).

4. **Strict Isolation Rule**:
   - Main repository files (`yourcallyourrule`) must remain 100% clean and untouched when running experimental tests.
