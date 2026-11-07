# pyro_cloud_drive_crypto

云端数据 AES-256-CBC 端到端加密与 Worker 多线程加解密引擎包。

## 💡 核心职责

保护云端备份数据的端到端隐私安全：

1. **`CloudDriveCipher` 密码学引擎**:
   - 基于 AES-256-CBC + SHA-256 8字节校验和 + Version 头部，对上传到云盘的文件/字节数据流进行加密组包 `[IV(16B) + Encrypted(Version(1B) + Checksum(8B) + Data)]`。
2. **Worker 线程并发解耦 (`encryptBytesAsync`, `decryptBytesAsync`)**:
   - 配合 `pyro_worker_protocol` 在后台 Isolate 副线程中执行重型加密与哈希计算，100% 避免阻塞 UI 渲染帧。
3. **`CloudDriveSecureStorage`**:
   - 本地密钥派生 (PBKDF2) 与安全凭证加密持久化存储。
