# 登录SDK

```js
/// @param uid 用户id
/// @param token 用户token
/// @return Future  执行then分支登录成功，执行catchError分支登录失败
OpenIM.iMManager.login(uid: uid, token: token)
```

- uid为业务服务器返回，token为业务服务器根据uid向OpenIM交换生成的。具体可查看文档架构介绍->APP与OpenIM的关系。
- 调用时机
  - App 启动并初始化完成后首次使用 IM SDK 的能力时。
  - OpenIM SDK 抛出 `onUserTokenExpired` 回调，即登录token已过期时，需要使用新的 UserSig 进行登录。
  - OpenIM SDK 抛出 `onKickedOffline` 回调，即当前用户被踢下线时，可以通过 UI 提示用户“您已经在其他端登录了当前账号，是否重新登录？” 如果用户选择“是”，就可以进行重新登录。
- 以下场景无需调用登录：
  - 用户的网络断开并重新连接后，不需要调用 login 函数，SDK 会自动上线。
  - 当一个登录过程在进行时，不需要进行重复登录。

# 登出SDK

```js
///
/// 登出SDK
///
/// @return Future 执行then分支登录成功，执行catchError分支登录失败
///
OpenIM.iMManager.logout()
```

