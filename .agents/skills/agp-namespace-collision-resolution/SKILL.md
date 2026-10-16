---
name: agp-namespace-collision-resolution
description: 深度解析 Android Gradle Plugin (AGP 8.3/9.0+) 严格命名空间校验机制、第三方库（特别是 Chromium Cronet 模块 cronet-api 与 cronet-shared）多 AAR 相同 namespace 冲突成因，及无硬编码版本的标准工程解决方案。
---

# AGP 命名空间冲突处理指南：以 Cronet 多模块冲突为例 (AGP Namespace Collision Resolution)

在现代化 Android 构建体系（尤其是 AGP 8.3+ 及 AGP 9.0+）中，构建系统全面启用了强制性的**命名空间唯一性校验（Namespace Uniqueness Verification）**。当三方依赖库或内部子模块在打包或拆分构件时未遵守命名空间隔离规范，将直接导致 Manifest Merger 失败并阻断 CI/本地编译。

本 Skill 详细规范了此类问题的底层成因、处理边界、禁用反模式及**零硬编码版本的标准工程解决方案**。

---

## 一、 核心背景与报错现场

### 典型报错特征
```text
[org.chromium.net:cronet-api:141.7340.3] /path/to/transformed/jetified-cronet-api-141.7340.3/AndroidManifest.xml Error:
Namespace 'org.chromium.net' is used in multiple modules and/or libraries: org.chromium.net:cronet-api:141.7340.3, org.chromium.net:cronet-shared:141.7340.3. Please ensure that all modules and libraries have a unique namespace. For more information, See https://developer.android.com/studio/build/configure-app-module#set-namespace
/path/to/app/src/main/AndroidManifest.xml Error:
Validation failed, exiting
FAILURE: Build failed with an exception.
```

### 报错底层机理
1. **AGP 规范演进**：
   - 旧版 AGP（AGP 7.x 以前）允许不同模块的 Manifest 声明相同或重叠的 `package`，在 Merger 阶段可能引发资源覆盖或 R 文件符号冲突。
   - 现代 AGP 引入了 `namespace` DSL，并在 AGP 8.3+ 默认开启了包名唯一性检验（`android.uniquePackageNames=true`），在 AGP 9.0+ 中更是作为核心硬性规则执行。
2. **Chromium Cronet 特殊拆分历史**：
   - 官方在拆分 Cronet 构件（如 `141.x`）时，将功能划分为 `cronet-api`、`cronet-shared`、`cronet-common` 等独立 AAR。
   - 但是，上游打包元数据中这些独立 AAR 却**共同声明了完全相同的根命名空间**：`org.chromium.net`。
   - 当应用本身或三方网络库（如 `cronet_http`、`play-services-cronet` 或广告/分析类 SDK）通过传递依赖同时引入了上述多个构件时，直接触发 AGP 的致命校验阻断。

---

## 二、 严格禁用的反模式 (Anti-Patterns)

在解决此类命名空间冲突时，**绝对禁止**以下两种不规范做法：

1. ❌ **禁用命名空间一致性检查（关闭开关）**：
   - **错误做法**：在 `gradle.properties` 中配置 `android.uniquePackageNames=false`。
   - **危害**：该属性是已被标记弃用的逃生阀门（Escape Hatch），不仅会在未来 AGP 版本被彻底移除，还会屏蔽项目中可能存在的真实包名/资源冲突风险，违背现代 Android 构建标准。

2. ❌ **强行硬编码依赖版本号（Pinning Version）**：
   - **错误做法**：在 `configurations.all` 中写死 `force 'org.chromium.net:cronet-api:143.7445.0'`。
   - **危害**：硬编码具体版本会破坏依赖树的语义化版本自适应，当上游 SDK（如 Google Mobile Ads、Firebase、Flutter 网络插件）升级时，被锁死的依赖版本极易导致 ABI 接口缺失、运行时 `NoSuchMethodError` 或 `ClassNotFoundException`。

---

## 三、 标准解决方案：模块依赖排除法 (Exclude Strategy)

### 方案原理
- 在 Chromium Cronet 体系中，`cronet-shared` 在官方 Maven 仓库中实际被定义为内部过渡性（transitional/internal）占位 AAR，其核心实现与对外公开 API 已经完整包含在 `cronet-api` 及主实现引擎中。
- 利用 Gradle 的依赖排除能力（`exclude`），**在不触及任何版本号的前提下**，将多余且引发冲突的构件从依赖解析图中全局剃除，既满足了 AGP 命名空间 100% 唯一的严苛标准，又保留了版本动态协商能力。

### 标准实施代码

在项目根级构建脚本（`android/build.gradle`）的全局配置块中加入排他规则：

```groovy
allprojects {
    repositories {
        google()
        mavenCentral()
    }

    // 解决 AGP 9.0+ 下 Chromium Cronet 模块间命名空间重复定义的问题
    // 排除掉冲突的过渡性模块 cronet-shared，无任何硬编码版本，完全随项目依赖树自然解析
    configurations.all {
        exclude group: 'org.chromium.net', module: 'cronet-shared'
    }
}
```

---

## 四、 常见变种场景审计清单

当在其它依赖或多模块项目中遭遇 `Namespace 'xxx' is used in multiple modules and/or libraries` 时，按以下顺序排查与处置：

1. **确定冲突的双方构件**：
   - 阅读报错日志中的全限定坐标，如 `GroupA:ArtifactA:Version` 与 `GroupA:ArtifactB:Version`。
2. **分析构件定位**：
   - **主备包装关系**：若其中一个属于 transitional / legacy / shared 包装层（类似 `cronet-shared`），采用本 Skill 的全局 `exclude` 策略。
   - **全量包与精简包混用**：若项目同时引入了 fat-jar/fat-aar 与 thin-aar（如 `cronet-bundled` 与 `cronet-api`），应 exclude 掉 thin-aar，或移除主动声明的冗余依赖。
   - **三方插件自建本地模块**：若两个 Flutter 插件在 `android/build.gradle` 中给自家模块硬编码了相同的 `namespace`（如抄袭模板未改名），应在根目录 `subprojects` 块中通过 `androidComponents.finalizeDsl` 按 `project.name` 动态重写覆盖 `namespace`。
