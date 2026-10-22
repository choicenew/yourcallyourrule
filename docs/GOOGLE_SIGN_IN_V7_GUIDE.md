# Google Sign-In 7.x (Credential Manager) 适配与避坑指南

> **适用版本**：Flutter `google_sign_in: ^7.0.0` 及以上版本  
> **面向平台**：Android (Android 14+ Credential Manager API) & Firebase Auth / Google Drive Sync

---

## 1. 核心现象与背景分析

### 1.1 核心痛点
从 `google_sign_in 6.x` 升级到 `7.x` 后，在 Android 端进行 Google 登录时，经常出现以下报错：
* `Authorization failed, please check Client id and Key`
* `GoogleSignInException(code: clientConfigurationError, message: serverClientId must be provided on Android...)`

### 1.2 为什么旧版本好用，新版本突然报错？
* **旧版（6.x）**：走的是 Legacy Google Play Services Auth。只要在 `android/app` 下放入 `google-services.json`，编译插件会在打包时自动解析 `client_type: 3`（Web Client ID），代码里可以完全盲传。
* **新版（7.x）**：Google 全面强制迁移到了 **Android 14+ Credential Manager API**。在新版的底座架构中，底层要求**必须**在请求建立时明确指定需要获取哪个 Web 后端的 ID Token。静默自动读取在多环境或特定打包机制下会失效，从而引发系统级报错。

---

## 2. 规范化架构配置（环境隔离与统一分发）

为了避免在多个 Service 或页面中硬编码 Client ID，项目采用了统一的环境变量分发模式。

### 2.1 环境配置文件 (`lib/cloud_sync/environment.dart`)
在 `Environment` 类中配置 `googleServerClientId` 的默认值，对应 `google-services.json` 中 `client_type: 3` 的 Client ID：

```dart
class Environment {
  Environment._();

  // Google Drive / Google Auth 配置 (Web Client ID)
  static const googleServerClientId = String.fromEnvironment(
    'GOOGLE_SERVER_CLIENT_ID',
    defaultValue: '213507864895-9di0f0gglameak3d6i9lkimi35cmvi5r.apps.googleusercontent.com',
  );
}
```

> **注意**：必须使用 **Web Client ID**（带有 `.apps.googleusercontent.com` 且在 `google-services.json` 中 `client_type` 为 `3` 的 ID），**绝对不能**误填 Android 客户端 ID。

### 2.2 服务层初始化调用规则

在调用任何登录或静默认证前，初始化必须显式注入 `serverClientId`：

```dart
// 示例：GoogleDriveSyncService 或 AuthInitializer
final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

Future<void> initGoogleAuth() async {
  await _googleSignIn.initialize(
    serverClientId: Environment.googleServerClientId,
  );
}
```

---

## 3. SHA-1 签名证书排查三大盲区

90% 的“Check Client ID and Key”报错除了未传 `serverClientId` 外，都是因为 SHA-1 签名不匹配。请确保以下 **三种环境** 的 SHA-1 均已填入 **Firebase Console -> 项目设置 -> 你的 Android 应用 -> 签名证书指纹** 中：

### 3.1 本地 Debug 开发环境
本地执行 `flutter run` 时，系统默认使用本地电脑的 `debug.keystore`。
* **查看命令**（Windows cmd / PowerShell）：
  ```cmd
  cd android
  gradlew signingReport
  ```
* 提取 `Variant: debug` 对应的 `SHA1:`，加入 Firebase。

### 3.2 本地 Release 打包环境 (`upload_keystore.jks`)
* **查看命令**（使用 JDK keytool）：
  ```cmd
  keytool -list -v -keystore "C:\path\to\your\upload_keystore.jks" -storepass "你的密码"
  ```
* 注意：一个 `.jks` 文件可能包含多个 Alias（别名，如 `yourcallyourrule` 和 `gmail`），**每个 Alias 的 SHA-1 都需要单独加入 Firebase**。

### 3.3 Google Play 商店正式环境 (Google Play App Signing)
当把 AAB 包上传到 Google Play 后，Google 会使用云端存储的 **App Signing Key** 重新对 APK 签名！
* **获取路径**：
  打开 Google Play Console -> 选择应用 -> **设置 (Setup) -> 应用签名 (App Signing)** -> 复制 **“应用签名密钥证书 (App signing key certificate)”** 的 SHA-1 指纹，并**必须同步填入 Firebase Console**。

---

## 4. Google Cloud Console 与 OAuth 同意屏幕误区澄清

### 4.1 纯 Android App 无需做 Web 域名验证
* 原生 Android App 登录依赖的是 **包名 + SHA-1**。
* 如果在 Google Cloud Console -> OAuth 同意屏幕看到 `Missing domain` 红字，是因为在 **Application home page** 框里填写了自定义网址（如 GitHub Pages），触发了 Google 网页表单的无损校验。
* **解法**：保持该框留空，或使用 Firebase 默认赠送的预验证域名 `https://your-project.firebaseapp.com`。

### 4.2 测试账号白名单 (Test Users)
若 OAuth 同意屏幕的发布状态为 **Testing（测试中）**：
* 必须在 Google Cloud Console -> OAuth consent screen -> **Test users** 列表中添加你用于测试登录的 Gmail 邮箱，否则非白名单账号登录时会被系统直接拦截。

---

## 5. 一键排查 CheckList

遇到 Google 登录异常时，按以下顺序列查即可：

1. [ ] `pubspec.yaml` 是否升级到了 `google_sign_in: ^7.x`？
2. [ ] `_googleSignIn.initialize()` 是否传入了 `serverClientId: Environment.googleServerClientId`？
3. [ ] `Environment.googleServerClientId` 的字符串是否与 `google-services.json` 里的 `client_type: 3` 完全一致？
4. [ ] 本地 Debug SHA-1 是否已加入 Firebase Console？
5. [ ] 本地 Release Key (`upload_keystore.jks`) 的所有 Alias SHA-1 是否已加入 Firebase Console？
6. [ ]（若走 Play 商店测试）Google Play Console 的 App Signing SHA-1 是否已加入 Firebase Console？
7. [ ] 当前测试用 Gmail 账号是否已加入 Google Cloud 的 Test Users 白名单？
