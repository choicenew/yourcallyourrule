# pyro_device_master_slave_ui

主从设备控制面板 UI 包（UI Layer）。
基于 `package:material_ui/material_ui.dart` 打造，提供全局的主从设备管理控制面板 `DeviceMasterSlaveControlPanel`。

## 📱 界面能力
* 展现集群接入设备节点列表与硬件状态。
* 允许用户像切换“语言”一样，在一个地方一次设置本机为 Master 或 Slave。
* 卡片式动态显示节点初始化权限（Master 允许初始化 vs Slave 管制禁止重复初始化）。
