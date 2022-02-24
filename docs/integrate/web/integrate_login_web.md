# 登录

初始化并登录OpenIM SDK Server，使用用户ID(uid)和token登录，uid来自于自身业务服务器，token需要业务服务器根据secret向OpenIM服务端交换获取。url为OpenIM Server部署服务器的web server websocket地址。

- Example:

  ```js
  const config: InitConfig = {
    uid: "xxx",
    token: "xxx",
    url: "ws://1.14.194.38:30000",
    platformID: 5,
  };
  openIM.login(config).then(res => {
    console.log("login suc...");
  }).catch(err => {
    console.log("login failed...");
  })
  ```

- Parameters:


| Name       | Type   | Description                                                  |
| ---------- | ------ | ------------------------------------------------------------ |
| uid        | int    | 用户ID                                                       |
| token      | string | 用户tokn                                                     |
| url        | string | websocket地址                                                |
| platformID | String | 平台类型 1:ios 2:android 3:windows 4:osx 5:web&mini 7:linux 8:管理员 |

- Return:


| Type                                                         | Description      |
| ------------------------------------------------------------ | ---------------- |
| [WsResponse](https://doc.rentsoft.cn/client_doc/web_doc.html#promise-%E8%BF%94%E5%9B%9E%E5%8F%82%E6%95%B0) | 返回登录是否成功 |



# 退出登录

登出OpenIM，通常在切换账号的时候调用，清除登录态以及内存中的所有数据。

- Example:

  ```js
  openIM.logout().then(res=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Return:

| Type           | Description      |
| -------------- | ---------------- |
| [WsResponse]() | 返回登出是否成功 |



# 获取当前登录状态

获取当前用户登录状态。

- Example:

  ```js
  openIM.getLoginStatus().then(res=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- CallBack:


| Name | Type   | Description                                   |
| ---- | ------ | --------------------------------------------- |
| data | string | 101:登录成功 102:登陆中 103:登录失败 201:登出 |

  


## 获取当前登录用户ID

获取当前登录用户ID。

- Example:

  ```js
  openIM.getLoginUser().then(res=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- CallBack:


| Name | Type   | Description |
| ---- | ------ | ----------- |
| data | string | 用户ID      |
