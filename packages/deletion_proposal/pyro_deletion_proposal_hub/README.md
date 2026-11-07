# 🛡️ Pyro Deletion Proposal Hub (`pyro_deletion_proposal_hub`)

删除提案评估与中控，使用控制反转 (IoC)，仅持有 `pyro_deletion_proposal_protocol` 抽象 Driver 接口引用。暴露 `importSubscriptionPayload(rawJson)` 回调接口供云端规则订阅自注册。
