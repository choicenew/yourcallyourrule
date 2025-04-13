lib/
  ├── core/                      # 核心功能
  │   ├── platform/             # 平台通道
  │   │   ├── call/            # 通话平台交互
  │   │   ├── sms/             # 短信平台交互
  │   │   └── permission/      # 权限管理
  │   ├── utils/                # 工具类
  │   │   ├── phone_utils.dart  # 电话号码处理
  │   │   └── call_utils.dart   # 通话工具
  │   ├── constants/            # 常量
  │   │   ├── call_constants.dart # 通话常量
  │   │   └── rule_constants.dart # 规则常量
  │   └── managers/             # 全局管理器
  │       ├── ad_manager/       # 广告管理
  │       ├── rule_manager/     # 规则管理(黑/白名单)
  │       └── sync_manager/     # 同步管理
  │
  ├── data/                     # 数据层
  │   ├── datasources/          # 数据源
  │   │   ├── local/           # 本地数据源
  │   │   │   ├── database/    # 数据库
  │   │   │   │   ├── call_dao.dart # 通话数据访问
  │   │   │   │   └── rule_dao.dart # 规则数据访问
  │   │   │   └── preferences/ # 本地存储
  │   │   └── remote/          # 远程数据源
  │   │       ├── api/         # API接口
  │   │       └── cloud/       # 云服务
  │   ├── models/              # 数据模型
  │   │   ├── call/           # 通话相关模型
  │   │   ├── sms/            # 短信相关模型
  │   │   ├── rule/           # 规则模型
  │   │   │   ├── blacklist.dart # 黑名单模型
  │   │   │   └── whitelist.dart # 白名单模型
  │   │   └── user/           # 用户相关模型
  │   └── repositories/        # 仓库实现
  │       ├── call_repository.dart
  │       ├── rule_repository.dart # 规则仓库
  │       └── sms_repository.dart
  │
  ├── domain/                   # 领域层
  │   ├── entities/            # 业务实体
  │   │   ├── call/           # 通话实体
  │   │   ├── sms/            # 短信实体
  │   │   ├── rule/           # 规则实体
  │   │   │   ├── allowed_rule.dart # 允许规则
  │   │   │   └── blocked_rule.dart # 拦截规则
  │   │   └── user/           # 用户实体
  │   └── usecases/            # 用例
  │       ├── call/           # 通话用例
  │       ├── sms/            # 短信用例
  │       └── rule/           # 规则用例
  │           ├── add_to_blacklist.dart
  │           ├── add_to_whitelist.dart
  │           ├── check_blocked.dart
  │           └── check_allowed.dart
  │
  ├── presentation/            # 表现层
  │   ├── providers/          # 状态管理
  │   │   ├── call/          # 通话状态
  │   │   ├── sms/           # 短信状态
  │   │   ├── rule/          # 规则状态
  │   │   │   ├── blacklist_provider.dart
  │   │   │   └── whitelist_provider.dart
  │   │   └── app/           # 应用状态
  │   ├── screens/           # 页面
  │   │   ├── call/          # 通话页面
  │   │   ├── sms/           # 短信页面
  │   │   └── rules/         # 规则管理页面
  │   │       ├── blacklist_screen.dart
  │   │       └── whitelist_screen.dart
  │   └── widgets/           # 可复用组件
  │       ├── common/        # 通用组件
  │       ├── call/          # 通话组件
  │       ├── sms/           # 短信组件
  │       └── rules/         # 规则组件
  │           ├── blocked_item.dart
  │           └── allowed_item.dart
  │
  ├── services/               # 服务层
  │   ├── base/              # 基础服务类
  │   ├── call/              # 通话相关服务
  │   ├── sms/               # 短信相关服务
  │   └── rule/              # 规则服务
  │       ├── rule_filter.dart # 规则过滤
  │       ├── rule_matcher.dart # 规则匹配
  │       └── rule_sync.dart # 规则同步
  │
  ├── features/              # 功能模块
  │   ├── ads/              # 广告功能
  │   ├── auth/             # 认证功能
  │   └── rule_management/  # 规则管理功能
  │       ├── models/      # 规则模型
  │       ├── services/    # 规则服务
  │       └── widgets/     # 规则组件
  │
  └── main.dart             # 应用入口