lib/
  ├── core/                           # 核心基础设施
  │   ├── platform/                   # 平台通道
  │   │   ├── call_channel.dart       # 通话平台通道
  │   │   └── sms_channel.dart        # 短信平台通道
  │   ├── utils/                      # 工具类
  │   │   ├── file_utils.dart         # 文件操作工具
  │   │   ├── permission_utils.dart   # 权限工具
  │   │   └── format_utils.dart       # 格式化工具
  │   ├── constants/                  # 常量
  │   │   ├── app_constants.dart      # 应用常量
  │   │   └── rule_constants.dart     # 规则常量
  │   └── exceptions/                 # 异常处理
  │       └── app_exceptions.dart     # 应用异常
  │
  ├── domain/                         # 领域层(核心业务逻辑)
  │   ├── entities/                   # 领域实体
  │   │   ├── common/                 # 共享实体
  │   │   │   ├── phone_entry.dart    # 电话条目基类
  │   │   │   └── contact.dart        # 联系人实体
  │   │   ├── call/                   # 通话实体
  │   │   │   ├── call_log.dart       # 通话记录
  │   │   │   └── call_rule.dart      # 通话规则
  │   │   └── sms/                    # 短信实体
  │   │       ├── sms_message.dart    # 短信消息
  │   │       └── sms_rule.dart       # 短信规则
  │   ├── value_objects/              # 值对象
  │   │   ├── phone_number.dart       # 电话号码
  │   │   ├── rule_priority.dart      # 规则优先级
  │   │   └── rule_action.dart        # 规则动作
  │   ├── repositories/               # 仓库接口
  │   │   ├── call_repository.dart    # 通话仓库接口
  │   │   ├── sms_repository.dart     # 短信仓库接口
  │   │   ├── rule_repository.dart    # 规则仓库接口
  │   │   └── contact_repository.dart # 联系人仓库接口
  │   └── services/                   # 领域服务
  │       ├── rule_matcher_service.dart # 规则匹配服务
  │       └── rule_priority_service.dart # 规则优先级服务
  │
  ├── application/                    # 应用层(用例)
  │   ├── usecases/                   # 用例
  │   │   ├── call/                   # 通话用例
  │   │   │   ├── filter_call.dart    # 过滤通话
  │   │   │   └── log_call.dart       # 记录通话
  │   │   ├── sms/                    # 短信用例
  │   │   │   ├── filter_sms.dart     # 过滤短信
  │   │   │   └── log_sms.dart        # 记录短信
  │   │   └── rule/                   # 规则用例
  │   │       ├── add_rule.dart       # 添加规则
  │   │       ├── remove_rule.dart    # 删除规则
  │   │       ├── update_rule.dart    # 更新规则
  │   │       ├── import_rules.dart   # 导入规则
  │   │       └── export_rules.dart   # 导出规则
  │   └── dto/                        # 数据传输对象
  │       ├── call_dto.dart           # 通话DTO
  │       ├── sms_dto.dart            # 短信DTO
  │       └── rule_dto.dart           # 规则DTO
  │
  ├── infrastructure/                 # 基础设施层(实现)
  │   ├── datasources/                # 数据源
  │   │   ├── local/                  # 本地数据源
  │   │   │   ├── database/           # 数据库
  │   │   │   │   ├── app_database.dart # 数据库管理
  │   │   │   │   └── dao/           # 数据访问对象
  │   │   │   │       ├── allowed_dao.dart  # 允许DAO
  │   │   │   │       ├── blocked_dao.dart  # 阻止DAO
  │   │   │   │       ├── blacklist_dao.dart # 黑名单DAO
  │   │   │   │       └── whitelist_dao.dart # 白名单DAO
  │   │   │   └── preferences/        # 本地存储
  │   │   │       └── app_preferences.dart # 应用偏好
  │   │   └── remote/                 # 远程数据源
  │   │       ├── api/                # API
  │   │       │   ├── label_api.dart  # 标签API
  │   │       │   └── subscription_api.dart # 订阅API
  │   │       └── file/               # 文件数据源
  │   │           ├── csv_source.dart # CSV数据源
  │   │           ├── json_source.dart # JSON数据源
  │   │           └── yaml_source.dart # YAML数据源
  │   ├── repositories/               # 仓库实现
  │   │   ├── call_repository_impl.dart # 通话仓库实现
  │   │   ├── sms_repository_impl.dart  # 短信仓库实现
  │   │   ├── rule_repository_impl.dart # 规则仓库实现
  │   │   └── contact_repository_impl.dart # 联系人仓库实现
  │   └── services/                   # 基础设施服务
  │       ├── permission_service.dart # 权限服务
  │       ├── notification_service.dart # 通知服务
  │       └── plugin_service.dart     # 插件服务
  │
  ├── presentation/                   # 表现层(UI)
  │   ├── state/                      # 状态管理
  │   │   ├── providers/              # Provider状态
  │   │   │   ├── call_provider.dart  # 通话Provider
  │   │   │   ├── sms_provider.dart   # 短信Provider
  │   │   │   ├── rule_provider.dart  # 规则Provider
  │   │   │   └── app_provider.dart   # 应用Provider
  │   │   └── blocs/                  # Bloc状态(可选)
  │   ├── views/                      # 页面
  │   │   ├── call/                   # 通话页面
  │   │   │   ├── call_history_page.dart # 通话历史
  │   │   │   └── call_settings_page.dart # 通话设置
  │   │   ├── sms/                    # 短信页面
  │   │   │   ├── sms_history_page.dart # 短信历史
  │   │   │   └── sms_settings_page.dart # 短信设置
  │   │   ├── rules/                  # 规则页面
  │   │   │   ├── allowed_page.dart   # 允许页面
  │   │   │   ├── blocked_page.dart   # 阻止页面
  │   │   │   ├── blacklist_page.dart # 黑名单页面
  │   │   │   ├── whitelist_page.dart # 白名单页面
  │   │   │   └── regex_page.dart     # 正则页面
  │   │       └── plugin_page.dart    # 插件页面  
  │   │   └── settings/               # 设置页面
  │   │       ├── general_settings_page.dart # 通用设置
  │   │       ├── sync_page.dart      # 同步页面
  │   └── widgets/                    # 组件
  │       ├── common/                 # 通用组件
  │       │   ├── search_bar.dart     # 搜索栏
  │       │   └── list_item.dart      # 列表项
  │       ├── call/                   # 通话组件
  │       │   └── call_overlay.dart   # 通话覆盖
  │       ├── sms/                    # 短信组件
  │       │   └── sms_preview.dart    # 短信预览
  │       └── rule/                   # 规则组件
  │           ├── rule_card.dart      # 规则卡片
  │           └── rule_form.dart      # 规则表单
  │
  ├── features/                       # 功能模块(横切关注点)
  │   ├── ads/                        # 广告功能
  │   │   ├── ad_manager.dart         # 广告管理
  │   │   └── ad_widgets.dart         # 广告组件
  │   ├── localization/               # 本地化
  │   │   └── app_localizations.dart  # 应用本地化
  │   └── analytics/                  # 分析
  │       └── app_analytics.dart      # 应用分析
  │
  └── main.dart                       # 应用入口

  规则优先级(从高到低):
1. 允许规则(Allowed) - 用户手动添加的允许规则
2. 阻止规则(Blocked) - 用户手动添加的阻止规则
3. 白名单规则(Whitelist) - 订阅的白名单规则
4. 黑名单规则(Blacklist) - 订阅的黑名单规则
5. 正则表达式规则(Regex) - 基于模式的规则
6. 默认规则 - 如果没有匹配到任何规则