lib/
├── common/                         # 通用基础设施
│   ├── error/                      # 错误处理
│   │   ├── exceptions.dart         # 异常类
│   │   └── failures.dart           # 失败类型
│   ├── utils/                      # 工具类
│   │   ├── phone_utils.dart        # 电话号码工具
│   │   ├── file_utils.dart         # 文件操作工具
│   │   └── permission_utils.dart   # 权限工具
│   ├── constants/                  # 常量定义
│   │   ├── app_constants.dart      # 应用常量
│   │   └── rule_constants.dart     # 规则常量
│   └── platform/                   # 平台抽象
│       ├── call_channel_manager.dart # 通话通道管理器
│       ├── android/                # Android平台
│       │   ├── call_channel.dart   # 通话平台通道
│       │   └── sms_channel.dart    # 短信平台通道
│       └── ios/                    # iOS平台
│           ├── call_platform.dart  # 通话平台接口
│           └── sms_platform.dart   # 短信平台接口
│
├── domain/                         # 领域层(核心业务规则)
│   ├── entities/                   # 业务实体
│   │   ├── base/                   # 基础实体
│   │   │   ├── entity.dart         # 实体基类
│   │   │   └── phone_entry.dart    # 电话条目基类
│   │   ├── contact/                # 联系人相关
│   │   │   └── contact.dart        # 联系人实体
│   │   ├── label/                  # 标签相关
│   │   │   └── label_entry.dart    # 标签条目实体
│   │   ├── rule/                   # 规则相关
│   │   │   ├── rule_base.dart      # 规则基类
│   │   │   ├── allowed_rule.dart   # 允许规则
│   │   │   ├── blocked_rule.dart   # 阻止规则
│   │   │   ├── whitelist_rule.dart # 白名单规则
│   │   │   ├── blacklist_rule.dart # 黑名单规则
│   │   │   └── regex_rule.dart     # 正则规则
│   │   ├── call/                   # 通话相关
│   │   │   └── call_log.dart       # 通话记录
│   │   └── sms/                    # 短信相关
│   │       └── sms_message.dart    # 短信消息
│   ├── value_objects/              # 值对象
│   │   ├── phone_number.dart       # 电话号码
│   │   ├── rule_priority.dart      # 规则优先级
│   │   └── rule_action.dart        # 规则动作
│   ├── repositories/               # 仓库接口
│   │   ├── base_repository.dart    # 仓库基类接口
│   │   ├── rule_repository.dart    # 规则仓库接口
│   │   ├── contact_repository.dart # 联系人仓库接口
│   │   ├── call_repository.dart    # 通话仓库接口
│   │   ├── sms_repository.dart     # 短信仓库接口
│   │   └── label_repository.dart   # 标签仓库接口
│   └── services/                   # 领域服务接口
│       ├── rule_matcher_service.dart # 规则匹配服务接口
│       ├── rule_priority_service.dart # 规则优先级服务接口
│       ├── label_service.dart      # 标签服务接口
│       └── notification_service.dart # 通知服务接口
│
├── features/                       # 功能模块
│   ├── rule/                       # 规则功能
│   │   ├── domain/                 # 规则领域
│   │   │   └── usecases/           # 规则用例
│   │   │       ├── add_rule.dart   # 添加规则
│   │   │       ├── delete_rule.dart # 删除规则
│   │   │       ├── update_rule.dart # 更新规则
│   │   │       ├── get_rules.dart  # 获取规则
│   │   │       ├── match_rule.dart # 匹配规则
│   │   │       ├── import_rules.dart # 导入规则
│   │   │       └── export_rules.dart # 导出规则
│   │   ├── data/                   # 规则数据
│   │   │   ├── models/             # 规则模型
│   │   │   │   └── rule_model.dart # 规则模型
│   │   │   ├── datasources/        # 规则数据源
│   │   │   │   ├── rule_local_datasource.dart # 本地数据源
│   │   │   │   └── rule_remote_datasource.dart # 远程数据源
│   │   │   └── repositories/       # 规则仓库实现
│   │   │       └── rule_repository_impl.dart # 规则仓库实现
│   │   ├── presentation/           # 规则表现层
│   │   │   ├── pages/              # 规则页面
│   │   │   │   ├── allowed_page.dart # 允许规则页面
│   │   │   │   ├── blocked_page.dart # 阻止规则页面
│   │   │   │   ├── whitelist_page.dart # 白名单页面
│   │   │   │   ├── blacklist_page.dart # 黑名单页面
│   │   │   │   └── regex_page.dart # 正则规则页面
│   │   │   ├── widgets/            # 规则组件
│   │   │   │   ├── rule_card.dart  # 规则卡片
│   │   │   │   └── rule_form.dart  # 规则表单
│   │   │   └── providers/          # 规则状态管理
│   │   │       └── rule_provider.dart # 规则Provider
│   │   └── services/               # 规则服务实现
│   │       ├── rule_matcher_service_impl.dart # 规则匹配服务实现
│   │       └── rule_priority_service_impl.dart # 规则优先级服务实现
│   │
│   ├── call/                       # 通话功能
│   │   ├── domain/                 # 通话领域
│   │   │   ├── entities/           # 通话实体
│   │   │   │   └── call_details.dart # 通话详情
│   │   │   └── usecases/           # 通话用例
│   │   │       ├── filter_call.dart # 过滤通话
│   │   │       └── log_call.dart   # 记录通话
│   │   ├── data/                   # 通话数据
│   │   │   ├── models/             # 通话模型
│   │   │   │   └── call_model.dart # 通话模型
│   │   │   ├── datasources/        # 通话数据源
│   │   │   │   └── call_local_datasource.dart # 本地数据源
│   │   │   └── repositories/       # 通话仓库实现
│   │   │       └── call_repository_impl.dart # 通话仓库实现
│   │   ├── presentation/           # 通话表现层
│   │   │   ├── pages/              # 通话页面
│   │   │   │   ├── call_history_page.dart # 通话历史页面
│   │   │   │   └── call_detail_page.dart # 通话详情页面
│   │   │   ├── widgets/            # 通话组件
│   │   │   │   └── call_item.dart  # 通话项
│   │   │   └── providers/          # 通话状态管理
│   │   │       └── call_provider.dart # 通话Provider
│   │   └── services/               # 通话服务
│   │       └── call_service_impl.dart # 通话服务实现
│   │
│   ├── sms/                        # 短信功能
│   │   ├── domain/                 # 短信领域
│   │   │   └── usecases/           # 短信用例
│   │   │       ├── filter_sms.dart # 过滤短信
│   │   │       └── log_sms.dart    # 记录短信
│   │   ├── data/                   # 短信数据
│   │   │   ├── models/             # 短信模型
│   │   │   │   └── sms_model.dart  # 短信模型
│   │   │   ├── datasources/        # 短信数据源
│   │   │   │   └── sms_local_datasource.dart # 本地数据源
│   │   │   └── repositories/       # 短信仓库实现
│   │   │       └── sms_repository_impl.dart # 短信仓库实现
│   │   ├── presentation/           # 短信表现层
│   │   │   ├── pages/              # 短信页面
│   │   │   │   ├── sms_history_page.dart # 短信历史页面
│   │   │   │   └── sms_detail_page.dart # 短信详情页面
│   │   │   ├── widgets/            # 短信组件
│   │   │   │   └── sms_item.dart   # 短信项
│   │   │   └── providers/          # 短信状态管理
│   │   │       └── sms_provider.dart # 短信Provider
│   │   └── services/               # 短信服务
│   │       └── sms_service_impl.dart # 短信服务实现
│   │
│   ├── contact/                    # 联系人功能
│   │   ├── domain/                 # 联系人领域
│   │   │   └── usecases/           # 联系人用例
│   │   │       ├── get_contacts.dart # 获取联系人
│   │   │       └── sync_contacts.dart # 同步联系人
│   │   ├── data/                   # 联系人数据
│   │   │   ├── models/             # 联系人模型
│   │   │   │   └── contact_model.dart # 联系人模型
│   │   │   ├── datasources/        # 联系人数据源
│   │   │   │   └── contact_local_datasource.dart # 本地数据源
│   │   │   └── repositories/       # 联系人仓库实现
│   │   │       └── contact_repository_impl.dart # 联系人仓库实现
│   │   └── presentation/           # 联系人表现层
│   │       ├── pages/              # 联系人页面
│   │       │   └── contacts_page.dart # 联系人页面
│   │       └── providers/          # 联系人状态管理
│   │           └── contact_provider.dart # 联系人Provider
│   │
│   ├── label/                      # 标签功能
│   │   ├── domain/                 # 标签领域
│   │   │   └── usecases/           # 标签用例
│   │   │       ├── add_label.dart  # 添加标签
│   │   │       ├── get_labels.dart # 获取标签
│   │   │       ├── update_label.dart # 更新标签
│   │   │       ├── delete_label.dart # 删除标签
│   │   │       ├── import_labels.dart # 导入标签
│   │   │       └── export_labels.dart # 导出标签
│   │   ├── data/                   # 标签数据
│   │   │   ├── models/             # 标签模型
│   │   │   │   └── label_model.dart # 标签模型
│   │   │   ├── datasources/        # 标签数据源
│   │   │   │   └── label_local_datasource.dart # 本地数据源
│   │   │   └── repositories/       # 标签仓库实现
│   │   │       └── label_repository_impl.dart # 标签仓库实现
│   │   ├── presentation/           # 标签表现层
│   │   │   ├── pages/              # 标签页面
│   │   │   │   └── labels_page.dart # 标签页面
│   │   │   └── providers/          # 标签状态管理
│   │   │       └── label_provider.dart # 标签Provider
│   │   └── services/               # 标签服务
│   │       └── label_service_impl.dart # 标签服务实现
│   │
│   └── caller_id/                  # 来电显示功能
│       ├── domain/                 # 来电显示领域
│       │   ├── entities/           # 来电显示实体
│       │   │   ├── caller_id_data.dart # 来电显示数据
│       │   │   ├── stir_info.dart  # STIR验证信息
│       │   │   └── sim_info.dart   # SIM卡信息
│       │   ├── usecases/           # 来电显示用例
│       │   │   └── get_caller_id.dart # 获取来电显示
│       │   └── services/           # 来电显示服务接口
│       │       ├── caller_id_service.dart # 来电显示服务接口
│       │       ├── caller_id_monitor_service.dart # 来电监控服务接口
│       │       └── overlay_service.dart # 悬浮窗服务接口
│       ├── data/                   # 来电显示数据
│       │   ├── models/             # 来电显示模型
│       │   │   └── caller_id_model.dart # 来电显示模型
│       │   ├── datasources/        # 来电显示数据源
│       │   │   └── caller_id_local_datasource.dart # 本地数据源
│       │   └── repositories/       # 来电显示仓库实现
│       │       └── caller_id_repository_impl.dart # 来电显示仓库实现
│       ├── presentation/           # 来电显示表现层
│       │   ├── pages/              # 来电显示页面
│       │   │   ├── caller_id_customization_page.dart # 来电显示定制页面
│       │   │   └── overlay_preview_page.dart # 悬浮窗预览页面
│       │   ├── widgets/            # 来电显示组件
│       │   │   ├── caller_id_overlay.dart # 来电显示悬浮窗
│       │   │   ├── overlay_position_controller.dart # 悬浮窗位置控制器
│       │   │   └── style_editor_panel.dart # 样式编辑面板
│       │   └── providers/          # 来电显示状态管理
│       │       └── caller_id_provider.dart # 来电显示Provider
│       ├── services/               # 来电显示服务实现
│       │   ├── caller_id_service_impl.dart # 来电显示服务实现
│       │   ├── caller_id_monitor_service_impl.dart # 来电监控服务实现
│       │   ├── overlay_service_impl.dart # 悬浮窗服务实现
│       │   ├── time_interceptor_service.dart # 时间拦截器服务
│       │   └── repeated_call_service.dart # 重复来电服务
│       └── config/                 # 来电显示配置
│           ├── caller_id_config.dart # 来电显示配置
│           └── caller_id_style.dart # 来电显示样式
│
├── core/                           # 核心功能
│   ├── database/                   # 数据库
│   │   ├── app_database.dart       # 数据库管理
│   │   └── dao/                    # 数据访问对象
│   │       ├── base_dao.dart       # DAO基类
│   │       ├── rule_dao.dart       # 规则DAO
│   │       ├── contact_dao.dart    # 联系人DAO
│   │       ├── call_dao.dart       # 通话DAO
│   │       ├── sms_dao.dart        # 短信DAO
│   │       └── label_dao.dart      # 标签DAO
│   ├── preferences/                # 本地存储
│   │   └── app_preferences.dart    # 应用偏好
│   ├── services/                   # 核心服务
│   │   ├── permission_service.dart # 权限服务
│   │   ├── notification_service_impl.dart # 通知服务实现
│   │   └── platform_service.dart   # 平台服务
│   └── sync/                       # 同步功能
│       ├── google_drive_service.dart # Google Drive同步服务
│       ├── onedrive_service.dart   # OneDrive同步服务
│       └── webdav_service.dart     # WebDAV同步服务
│
├── presentation/                   # 通用表现层
│   ├── app/                        # 应用
│   │   ├── app.dart                # 应用入口
│   │   └── app_provider.dart       # 应用Provider
│   ├── pages/                      # 通用页面
│   │   ├── home/                   # 首页
│   │   │   └── home_page.dart      # 首页
│   │   └── settings/               # 设置页面
│   │       ├── settings_page.dart  # 设置页面
│   │       ├── call_settings_page.dart # 通话设置页面
│   │       ├── sms_settings_page.dart # 短信设置页面
│   │       ├── sync_page.dart      # 同步页面
│   │       └── about_page.dart     # 关于页面
│   └── widgets/                    # 通用组件
│       ├── search_bar.dart         # 搜索栏
│       └── list_item.dart          # 列表项
│
├── di/                             # 依赖注入
│   └── injection.dart              # 依赖注入容器
│
└── main.dart                       # 应用入口

```plaintext

## 规则优先级(从高到低)

1. 允许规则(Allowed) - 用户手动添加的允许规则
2. 阻止规则(Blocked) - 用户手动添加的阻止规则
3. 白名单规则(Whitelist) - 订阅的白名单规则
4. 黑名单规则(Blacklist) - 订阅的黑名单规则
5. 正则表达式规则(Regex) - 基于模式的规则
6. 默认规则 - 如果没有匹配到任何规则

## 基础实体定义

### PhoneEntry (基类)
- phoneNumber: 电话号码
- label: 标签
- name: 名称
- avatar: 头像
- source: 来源(用户添加/订阅)

## 架构说明

### 1. 特性驱动的目录结构

新的架构采用了特性驱动的目录结构，将相关功能组织在一起，使得代码更加内聚。每个功能模块都包含自己的领域、数据和表现层，使得功能之间的边界更加清晰。

### 2. 来电显示功能的组织

来电显示功能被组织在 `features/caller_id` 目录下，包含以下部分：

- **领域层**：定义了来电显示的核心实体和服务接口
- **数据层**：实现了数据存储和获取
- **表现层**：实现了UI界面
- **服务层**：实现了来电显示、监控和悬浮窗等服务
- **配置**：管理来电显示的样式和配置

### 3. 服务的清晰分离

- `caller_id_service.dart`：负责获取和处理来电显示数据
- `caller_id_monitor_service.dart`：负责监控来电事件
- `overlay_service.dart`：负责管理悬浮窗
- `time_interceptor_service.dart`：负责时间段拦截
- `repeated_call_service.dart`：负责处理重复来电

### 4. 核心功能与特性功能的分离

- `core/` 目录包含了应用的核心功能，如数据库、权限和通知等
- `features/` 目录包含了应用的特性功能，每个特性都是相对独立的模块

### 5. 通用表现层

`presentation/` 目录包含了应用的通用表现层，如首页和设置页面等，这些页面不属于特定的功能模块。
 ```
```