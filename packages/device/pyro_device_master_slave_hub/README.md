# pyro_device_master_slave_hub

主从设备运行时注册与调度中枢包（Hub Layer）。
维护单例 `DeviceMasterSlaveHub.instance`，负责设备拓扑适配器的注册、调度与角色变更通知。
遵循 Protocol-Hub-Driver 拓扑，底层 Driver 与 Driver 不横向交叉依赖。
