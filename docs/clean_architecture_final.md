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
  │       ├── android/                # Android平台
  │       │   ├── call_channel.dart   # 通话平台通道
  │       │   ├── sms_channel.dart    # 短信平台通道
  │       │   ├── caller_id_channel.dart # 新增
  │       └── ios/                    # iOS平台
  │           ├── call_platform.dart  # 通话平台接口
  │           ├── sms_platform.dart   # 短信平台接口
  │
  ├── domain/                         # 领域层(核心业务规则)
  │   ├── entities/                   # 业务实体
  │   │   ├── base/                   # 基础实体
  │   │   │   ├── entity.dart         # 实体基类
  │   │   │   └── phone_entry.dart    # 电话条目基类
  │   │   ├── caller/                 # 新增caller实体目录
  │   │   │   ├── caller_id_data.dart 
  │   │   │   ├── 
  │   │   │   ├── stir_info.dart      
  │   │   │   └── sim_info.dart       
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
  │   └── services/                   # 领域服务
  │       ├── rule_matcher_service.dart # 规则匹配服务
  │       ├── rule_priority_service.dart # 规则优先级服务
  │       ├── caller_id_service_impl.dart # 拆分里面的部分函数独立dart
  │       ├── caller_id_monitor_service_impl.dart # 拆分里面的should accept 和handle call 之类的
  │       └── label_service.dart      # 标签服务接口
  │
  ├── application/                    # 应用层(用例)
  │   ├── dto/                        # 数据传输对象
  │   │   ├── base_dto.dart           # DTO基类
  │   │   ├── rule_dto.dart           # 规则DTO
  │   │   ├── contact_dto.dart        # 联系人DTO
  │   │   ├── call_dto.dart           # 通话DTO
  │   │   ├── sms_dto.dart            # 短信DTO
  │   │   └── label_dto.dart          # 标签DTO
  │   └── usecases/                   # 用例
  │       ├── base_usecase.dart       # 用例基类
  │       ├── rule/                   # 规则用例
  │       │   ├── add_rule.dart       # 添加规则
  │       │   ├── delete_rule.dart    # 删除规则
  │       │   ├── update_rule.dart    # 更新规则
  │       │   ├── get_rules.dart      # 获取规则
  │       │   ├── match_rule.dart     # 匹配规则
  │       │   ├── import_rules.dart   # 导入规则
  │       │   └── export_rules.dart   # 导出规则
  │       ├── call/                   # 通话用例
  │       │   ├── filter_call.dart    # 过滤通话
  │       │   └── log_call.dart       # 记录通话
  │       ├── caller_id_style/        # 来电显示样式用例
  │       │   ├── caller_id_style.dart              # 样式实体/值对象
  │       │   ├── position_offset.dart              # 位置坐标值对象
  │       │   ├── caller_id_style_repository.dart    # 样式仓库接口
  │       │   ├── caller_id_style_service.dart      # 样式服务接口
  │       │   ├── manage_caller_id_style_usecase.dart # 样式管理用例
  │       │   ├── caller_id_style_provider.dart      # 样式状态管理
  │       │   ├── caller_id_style_repository_impl.dart # 样式仓库实现
   
  │       ├── sms/                    # 短信用例
  │       │   ├── filter_sms.dart     # 过滤短信
  │       │   └── log_sms.dart        # 记录短信
  │       ├── contact/                # 联系人用例
  │       │   ├── get_contacts.dart   # 获取联系人
  │       │   └── sync_contacts.dart  # 同步联系人
  │       └── label/                  # 标签用例
  │           ├── add_label.dart      # 添加标签
  │           ├── get_labels.dart     # 获取标签
  │           ├── update_label.dart   # 更新标签
  │           ├── delete_label.dart   # 删除标签
  │           ├── import_labels.dart  # 导入标签
  │           └── export_labels.dart  # 导出标签
  │
  ├── infrastructure/                 # 基础设施层(实现)
  │   ├── datasources/                # 数据源
  │   │   ├── base_datasource.dart    # 数据源基类
  │   │   ├── local/                  # 本地数据源
  │   │   │   ├── database/           # 数据库
  │   │   │   │   ├── app_database.dart # 数据库管理
  │   │   │   │   └── dao/           # 数据访问对象
  │   │   │   │       ├── base_dao.dart # DAO基类
  │   │   │   │       ├── rule_dao.dart # 规则DAO
  │   │   │   │       ├── contact_dao.dart # 联系人DAO
  │   │   │   │       ├── call_dao.dart # 通话DAO
  │   │   │   │       ├── sms_dao.dart # 短信DAO
  │   │   │   │       └── label_dao.dart # 标签DAO
  │   │   │   └── preferences/        # 本地存储
  │   │   │       └── app_preferences.dart # 应用偏好
  │   │   └── remote/                 # 远程数据源
  │   │       ├── api/                # API
  │   │       │   ├── api_client.dart # API客户端
  │   │       │   └── rule_api.dart   # 规则API
  │   │       └── file/               # 文件数据源
  │   │           ├── base_file_source.dart # 文件数据源基类
  │   │           └── rule_file_source.dart # 规则文件数据源
  │   ├── models/                     # 数据模型
  │   │   ├── base_model.dart         # 模型基类
  │   │   ├── rule_model.dart         # 规则模型
  │   │   ├── contact_model.dart      # 联系人模型
  │   │   ├── call_model.dart         # 通话模型
  │   │   ├── sms_model.dart          # 短信模型
  │   │   └── label_model.dart        # 标签模型
  │   ├── repositories/               # 仓库实现
  │   │   ├── base_repository_impl.dart # 仓库基类实现
  │   │   ├── rule_repository_impl.dart # 规则仓库实现
  │   │   ├── contact_repository_impl.dart # 联系人仓库实现
  │   │   ├── call_repository_impl.dart # 通话仓库实现
  │   │   ├── sms_repository_impl.dart # 短信仓库实现
  │   │   └── label_repository_impl.dart # 标签仓库实现
  │   └── services/                   # 基础设施服务
  │       ├── base_service_impl.dart  # 服务基类实现
  │       ├── base_list_service.dart  # 列表服务基类实现
  │       ├── permission_service_impl.dart # 权限服务实现
  │       ├── notification_service_impl.dart # 通知服务实现
  │       ├── platform_service_impl.dart # 平台服务实现
  │       ├── caller/                 # 来电识别相关服务
  │       │   ├── caller_id_service_impl.dart # 来电识别服务实现
  │       │   └── caller_id_monitor_service_impl.dart # 来电监控服务实现
  │       ├── label/                  # 标签相关服务
  │       │   └── label_service_impl.dart # 标签服务实现
  │       ├── sync/                   # 同步相关服务
  │       │   ├── google_drive_service_impl.dart # Google Drive同步服务
  │       │   ├── onedrive_service_impl.dart # OneDrive同步服务
  │       │   └── webdav_service_impl.dart # WebDAV同步服务
  │       ├── location/               # 位置相关服务
  │       │   └── location_service_impl.dart # 位置服务实现
  │       └── plugin/                # 插件相关服务
  │           └── plugin_manager_service_impl.dart # 插件管理服务实现
  │
  ├── presentation/                   # 表现层(UI)
  │   ├── state/                      # 状态管理
  │   │   ├── base/                   # 状态管理基类
  │   │   │   ├── base_provider.dart  # Provider基类
  │   │   │   └── base_bloc.dart      # Bloc基类
  │   │   ├── providers/              # Provider状态
  │   │   │   ├── rule_provider.dart  # 规则Provider
  │   │   │   ├── call_provider.dart  # 通话Provider
  │   │   │   ├── sms_provider.dart   # 短信Provider
  │   │   │   └── app_provider.dart   # 应用Provider
  │   │   └── blocs/                  # Bloc状态(可选)
  │   │       ├── rule_bloc.dart      # 规则Bloc
  │   │       ├── call_bloc.dart      # 通话Bloc
  │   │       └── sms_bloc.dart       # 短信Bloc
  │   ├── pages/                      # 页面
  │   │   ├── base_page.dart          # 页面基类
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
  │   │   ├── caller/                 # 新增caller页面
  │   │   │   ├── caller_id_customization_page.dart # 来电显示定制页面
  │   │   │   ├── overlay_preview_page.dart # 悬浮窗预览页面
  │   │   │   └── 
  │   │   └── settings/               # 设置页面
  │   │       ├── settings_page.dart  # 设置页面
  │   │       ├── call_settings_page.dart # 通话设置页面
  │   │       ├── sms_settings_page.dart # 短信设置页面
  │   │       ├── sync_page.dart      # 同步页面
  │   │       └── about_page.dart     # 关于页面  
  │   └── widgets/                    # 组件
  │       ├── base_widget.dart        # 组件基类
  │       ├── common/                 # 通用组件
  │       │   ├── search_bar.dart     # 搜索栏
  │       │   └── list_item.dart      # 列表项
  │       ├── rule/                   # 规则组件
  │       │   ├── rule_card.dart      # 规则卡片
  │       │   └── rule_form.dart      # 规则表单
  │       ├── call/                   # 通话组件
  │       │   └── call_item.dart      # 通话项
  │       ├── sms/                    # 短信组件
  │       │   └── sms_item.dart       # 短信项
  │       └── caller/                 # 来电识别组件
  │           ├── caller_id_overlay.dart # 来电显示悬浮窗所有相关的
  │           ├── overlay_position_controller.dart # 悬浮窗位置控制器
  │           └── style_editor_panel.dart # 样式编辑面板
  │
  ├── di/                             # 依赖注入
  │   └── injection.dart              # 依赖注入容器
  │
  └── main.dart                       # 应用入口

规则优先级(从高到低):
1. 允许规则(Allowed) - 用户手动添加的允许规则
2. 阻止规则(Blocked) - 用户手动添加的阻止规则
3. 白名单规则(Whitelist) - 订阅的白名单规则
4. 黑名单规则(Blacklist) - 订阅的黑名单规则
5. 正则表达式规则(Regex) - 基于模式的规则
6. 默认规则 - 如果没有匹配到任何规则
1. PhoneEntry (基类)

- phoneNumber: 电话号码

- label: 标签

- name: 名称

- avatar: 头像

- source: 来源(用户添加/订阅)


call_handling_rules_page.dart # 通话处理规则页面