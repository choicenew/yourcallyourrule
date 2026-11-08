# pyro_device_master_slave_protocol

主从设备管理纯抽象协议包（Protocol Layer）。
定义设备节点数据结构 `DeviceNode`、角色 `DeviceRole` (master/slave) 以及 `MasterSlaveAdapter` 抽象契约。

## 🔒 核心管制规则
* **主设备 (Master)**：允许执行数据库初始化与结构建表。
* **从设备 (Slave)**：保留完整云端 Key/密钥，但被物理管制**严禁重复初始化数据库**，直接复制主设备既有快照，免去重复初始化之痛苦。
