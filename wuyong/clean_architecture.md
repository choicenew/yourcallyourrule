lib/
  ├── core/                      # 核心基础设施
  │   ├── di/                    # 依赖注入
  │   ├── exceptions/            # 异常处理
  │   └── utils/                 # 纯工具类
  
  ├── domain/                    # 领域层(核心)
  │   ├── models/                # 领域模型
  │   │   ├── call/              # 通话模型
  │   │   └── rule/              # 规则模型
  │   ├── repositories/         # 仓库接口
  │   └── services/              # 领域服务
  
  ├── data/                      # 数据层
  │   ├── datasources/           # 数据源实现
  │   ├── repositories/          # 仓库实现
  │   └── mappers/               # 数据转换
  
  ├── application/               # 应用层
  │   ├── usecases/              # 用例
  │   └── dto/                   # 数据传输对象
  
  └── presentation/              # 表现层
      ├── state/                 # 状态管理
      ├── views/                 # 页面
      └── widgets/               # 组件