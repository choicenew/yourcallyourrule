# ⏱️ Pyro Time Interceptor Connector (`pyro_time_interceptor_connector`)

时间拦截外观装配线，通过静态方法 `PyroTimeInterceptorConnector.registerAll` 将 Driver 注入到 Hub 实例中，并向 `call_filter_hub` 自注册 `TimeWindowFilterDriver` 算子。
