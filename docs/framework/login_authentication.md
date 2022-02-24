## Open-IM新用户注册

![open-im-server-注册](../images/register.png)

- app注册新用户时，your-app-server完成与自身逻辑相关的验证后，生成uid；
- app-server 会携带 secret， platform， uid 等信息调用/auth/user_register接口完成open-im新用户注册；
- open-im-server检验信息后，给your-app-server返回成功，your-app-server给app返回成功；
- 对于app存量用户，直接批量调用/auth/user_register完成open-im新用户注册；
- 对于/auth/user_register具体请求响应字段，请参考服务端API文档； 



## Open-IM用户登录

![open-im-server-登录](../images/login.png)

- 用户登录app时，your-app-server先验证app账号密码，成功后调用/auth/user_token获取uid+token；
- your-app-server给客户端返回：uid+token+其他app数据；
- 客户端open-im-sdk带上uid+token登录open-im；
- 对于/auth/user_token具体请求响应字段，请参考服务端API文档； 

