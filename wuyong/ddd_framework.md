lib/
  ├── core/                           # 核心层(与业务无关)
  │   ├── error/                      # 错误处理
  │   │   ├── exceptions.dart         # 异常类
  │   │   └── failures.dart           # 失败类型
  │   ├── utils/                      # 工具类
  │   │   ├── phone_utils.dart        # 电话号码工具
  │   │   ├── file_utils.dart         # 文件操作工具
  │   │   └── permission_utils.dart   # 权限工具
  │   └── platform/                   # 平台抽象
  │       ├── call_platform.dart      # 通话平台接口
  │       └── sms_platform.dart       # 短信平台接口
  │
  ├── domain/                         # 领域层(业务规则)
  │   ├── entities/                   # 业务实体
  │   │   ├── base/                   # 基础实体
  │   │   │   ├── entity.dart         # 实体基类
  │   │   │   └── value_object.dart   # 值对象基类
  │   │   ├── contact/                # 联系人相关
  │   │   │   └── contact.dart        # 联系人实体
  │   │   ├── rule/                   # 规则相关
  │   │   │   ├── rule.dart           # 规则基类
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
  │   │   ├── rule_repository.dart    # 规则仓库接口
  │   │   ├── contact_repository.dart # 联系人仓库接口
  │   │   ├── call_repository.dart    # 通话仓库接口
  │   │   └── sms_repository.dart     # 短信仓库接口
  │   └── services/                   # 领域服务
  │       ├── rule_matcher.dart       # 规则匹配服务
  │       └── rule_priority.dart      # 规则优先级服务
  │
  ├── application/                    # 应用层(用例)
  │   ├── dtos/                       # 数据传输对象
  │   │   ├── rule_dto.dart           # 规则DTO
  │   │   ├── contact_dto.dart        # 联系人DTO
  │   │   ├── call_dto.dart           # 通话DTO
  │   │   └── sms_dto.dart            # 短信DTO
  │   └── usecases/                   # 用例
  │       ├── rule/                   # 规则用例
  │       │   ├── add_rule.dart       # 添加规则
  │       │   ├── delete_rule.dart    # 删除规则
  │       │   ├── update_rule.dart    # 更新规则
  │       │   ├── get_rules.dart      # 获取规则
  │       │   ├── import_rules.dart   # 导入规则
  │       │   └── export_rules.dart   # 导出规则
  │       ├── call/                   # 通话用例
  │       │   ├── filter_call.dart    # 过滤通话
  │       │   └── log_call.dart       # 记录通话
  │       ├── sms/                    # 短信用例
  │       │   ├── filter_sms.dart     # 过滤短信
  │       │   └── log_sms.dart        # 记录短信
  │       └── contact/                # 联系人用例
  │           ├── get_contacts.dart   # 获取联系人
  │           └── sync_contacts.dart  # 同步联系人
  │
  ├── infrastructure/                 # 基础设施层(实现)
  │   ├── datasources/                # 数据源
  │   │   ├── local/                  # 本地数据源
  │   │   │   ├── database/           # 数据库
  │   │   │   │   ├── app_database.dart # 数据库管理
  │   │   │   │   └── daos/          # 数据访问对象
  │   │   │   │       ├── rule_dao.dart # 规则DAO
  │   │   │   │       ├── contact_dao.dart # 联系人DAO
  │   │   │   │       ├── call_dao.dart # 通话DAO
  │   │   │   │       └── sms_dao.dart # 短信DAO
  │   │   │   └── preferences/        # 本地存储
  │   │   │       └── app_preferences.dart # 应用偏好
  │   │   └── remote/                 # 远程数据源
  │   │       ├── api/                # API
  │   │       │   └── rule_api.dart   # 规则API
  │   │       └── file/               # 文件数据源
  │   │           └── rule_file_source.dart # 规则文件数据源
  │   ├── models/                     # 数据模型
  │   │   ├── rule_model.dart         # 规则模型
  │   │   ├── contact_model.dart      # 联系人模型
  │   │   ├── call_model.dart         # 通话模型
  │   │   └── sms_model.dart          # 短信模型
  │   ├── repositories/               # 仓库实现
  │   │   ├── rule_repository_impl.dart # 规则仓库实现
  │   │   ├── contact_repository_impl.dart # 联系人仓库实现
  │   │   ├── call_repository_impl.dart # 通话仓库实现
  │   │   └── sms_repository_impl.dart # 短信仓库实现
  │   └── services/                   # 基础设施服务
  │       ├── permission_service_impl.dart # 权限服务实现
  │       ├── notification_service_impl.dart # 通知服务实现
  │       └── platform_service_impl.dart # 平台服务实现
  │
  ├── presentation/                   # 表现层(UI)
  │   ├── blocs/                      # 状态管理
  │   │   ├── rule/                   # 规则状态
  │   │   │   ├── rule_bloc.dart      # 规则Bloc
  │   │   │   ├── rule_event.dart     # 规则事件
  │   │   │   └── rule_state.dart     # 规则状态
  │   │   ├── call/                   # 通话状态
  │   │   │   ├── call_bloc.dart      # 通话Bloc
  │   │   │   ├── call_event.dart     # 通话事件
  │   │   │   └── call_state.dart     # 通话状态
  │   │   ├── sms/                    # 短信状态
  │   │   │   ├── sms_bloc.dart       # 短信Bloc
  │   │   │   ├── sms_event.dart      # 短信事件
  │   │   │   └── sms_state.dart      # 短信状态
  │   │   └── app/                    # 应用状态
  │   │       ├── app_bloc.dart       # 应用Bloc
  │   │       ├── app_event.dart      # 应用事件
  │   │       └── app_state.dart      # 应用状态
  │   ├── pages/                      # 页面
  │   │   ├── home/                   # 首页
  │   │   │   └── home_page.dart      # 首页
  │   │   ├── rule/                   # 规则页面
  │   │   │   ├── allowed_page.dart   # 允许规则页面
  │   │   │   ├── blocked_page.dart   # 阻止规则页面
  │   │   │   ├── whitelist_page.dart # 白名单页面
  │   │   │   ├── blacklist_page.dart # 黑名单页面
  │   │   │   └── regex_page.dart     # 正则规则页面
  │   │   ├── call/                   # 通话页面
  │   │   │   ├── call_history_page.dart # 通话历史页面
  │   │   │   └── call_detail_page.dart # 通话详情页面
  │   │   ├── sms/                    # 短信页面
  │   │   │   ├── sms_history_page.dart # 短信历史页面
  │   │   │   └── sms_detail_page.dart # 短信详情页面
  │   │   └── settings/               # 设置页面
  │   │       ├── settings_page.dart  # 设置页面
  │   │       ├── call_settings_page.dart # 通话设置页面
  │   │       └── sms_settings_page.dart # 短信设置页面
  │   └── widgets/                    # 组件
  │       ├── common/                 # 通用组件
  │       ├── rule/                   # 规则组件
  │       ├── call/                   # 通话组件
  │       └── sms/                    # 短信组件
  │
  ├── di/                             # 依赖注入
  │   └── injection.dart              # 依赖注入容器
  │
  └── main.dart                       # 应用入口