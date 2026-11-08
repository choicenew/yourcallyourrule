# pyro_device_master_slave

主从设备物理驱动包（Driver Layer）。
实现 `MasterSlaveAdapter`，负责集群设备节点的拓扑状态维护、手动与自动 Master/Slave 角色指定，以及管制 Slave 节点绝对不重复初始化数据库。
底层直接调度 `packages/device/pyro_device_master_slave_protocol` 契约。
