# 初始化及登录相关API

| 方法           | 描述               |
| -------------- | ------------------ |
| login          | 登录IM             |
| logout         | 登出               |
| getLoginStatus | 获取登录状态       |
| getLoginUser   | 获取当前登录用户ID |

## login

> 初始化并登录IM，使用用户ID(userID)和token登录，userID来自于自身业务服务器，token需要业务服务器根据secret向OpenIM服务端交换获取。url为OpenIM Server部署服务器的web server websocket地址。<br/>**注意1：**JSSDK ws连接端口为10003端口，与其他端SDK不同，请勿混淆。<br/>**注意2：**必须确保登录成功回调到达后才能调用其他API。

```typescript
const config: InitConfig = {
  userID: "userID",								// 用户ID
  token: "token",									// 用户token
  url: "ws://121.37.25.71:10003",	// jssdk server ws地址
  platformID: 5,									// 平台号
};
openIM.login(config).then(res => {
  console.log("login suc...");
}).catch(err => {
  console.log("login failed...");
})
```

## logout

> 退出登录，并关闭当前ws

```typescript
openIM.logout().then(res => {
  console.log("logout suc...");
}).catch(err => {
  console.log("logout failed...");
})
```



#### getLoginStatus

> 获取当前登录状态

```typescript
openIM.getLoginStatus().then(res => {
  // 101:登录成功 102:登陆中 103:登录失败 201:登出
}).catch(err => {

})
```



#### getLoginUser

> 获取当前登录用户的ID

```typescript
openIM.getLoginUser().then(res => {
  // 当前登录用户ID
}).catch(err => {

})
```



# 初始化及登录相关监听

> 所有事件相关常量均封装在SDK的`CbEvents`中，可直接进行引入使用。

| 事件               | 描述             |
| ------------------ | ---------------- |
| OnConnectFailed    | 连接IM服务器失败 |
| OnConnectSuccess   | 连接成功         |
| OnConnecting       | 连接中           |
| OnKickedOffline    | 被其它端踢下线   |
| OnUserTokenExpired | 用户token过期    |
