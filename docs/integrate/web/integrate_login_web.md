# 登录

> 初始化并登录OpenIM SDK Server，使用用户ID(userID)和token登录，userID来自于自身业务服务器，token需要业务服务器根据secret向OpenIM服务端交换获取。url为OpenIM Server部署服务器的web server websocket地址。<br/>**特别的：**JSSDK ws连接端口为30000端口，与其他端SDK不同，请勿混淆。

```js
/**
* 分页获取会话列表
*
* @param userID 用户ID
* @param token 用户token
* @param url ws url
* @param platformID 平台ID 1:ios 2:android 3:windows 4:osx 5:web&mini 7:linux 8:管理员
*/
const config: InitConfig = {
  userID: "xxx",
  token: "xxx",
  url: "ws://xxx:30000",
  platformID: 5,
};
openIM.login(config).then(res => {
  console.log("login suc...");
}).catch(err => {
  console.log("login failed...");
})
```



# 退出登录

> 登出OpenIM，通常在切换账号的时候调用，清除登录态以及内存中的所有数据。

```js
openIM.logout().then(res=>{
  ...
}).catch(err=>{
  ...
})
```



# 获取当前登录状态

> 获取当前用户登录状态。

```js
openIM.getLoginStatus().then(res=>{
  ...
}).catch(err=>{
  ...
})
```



## 获取当前登录用户ID

> 获取当前登录用户ID。

```js
openIM.getLoginUser().then(res=>{
  ...
}).catch(err=>{
  ...
})
```
