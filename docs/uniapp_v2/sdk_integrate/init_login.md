# 初始化及登录相关API

> 所有API中需要用到的`operationID`为随机字符串，通常用于定位问题使用，建议每一次API调用均采用唯一ID，可通过npm包uuid生成。<br/>存在callback的API，callback的回调参数格式为统一格式，errCode为0则代表操作成功，否则为失败。具体参考[此处说明]()。

| 方法           | 描述               |
| -------------- | ------------------ |
| initSDK        | 初始化SDK          |
| login          | 登录IM             |
| logout         | 登出               |
| getLoginStatus | 获取登录状态       |
| getLoginUser   | 获取当前登录用户ID |



## initSDK

> 初始化OpenIM SDK,设置SDK网络连接地址以及本地数据存放目录等。调用其他API之前必须先初始化SDK。

* Example:

```js
const config = {
"platform":1, //平台号 参考通用结构中Platform
"api_addr":"http://121.37.25.71:10002", //IM API地址
"ws_addr":"ws://121.37.25.71:10001", //IM Ws地址
"data_dir":"./", //SDK数据存放目录（绝对路径）
"log_level":6, 	//SDK日志级别
"object_storage":"minio"	// 图片等资源储存方式 目前支持"minio"、"cos"
}
const flag = im.initSDK(operationID,config) //返回值为布尔值告知是否初始化成功
```

* Parameters:

|      Name      |   Type   |                         Description                          |
| :------------: | :------: | :----------------------------------------------------------: |
|    platform    | Platform | 平台类型 1:ios 2:android 3:windows 4:osx 5:web&mini 7:linux 8:管理员 |
|    api_addr    |  string  |                          IM API地址                          |
|  ipWws_addrs   |  string  |                          IM Ws地址                           |
|    data_dir    |  String  |                 SDK数据存放目录（绝对路径）                  |
|   log_level    |  number  |                           日志等级                           |
| object_storage |  string  |          图片等资源储存方式 目前支持"minio"、"cos"           |



## login

> 必须等待登录成功回调之后才能调用其他API（除初始化和设置监听）  如获取好友列表等。

* Example:

```js
im.login(operationID,userID,token,data => {
    ...
})
```

* Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
|   userID    |  string  |    用户ID     |
|    token    |  string  |   用户token   |
|  callback   | callback |    通用回调     |

## logout

> 退出登录后若未杀死应用，需要重新登陆时，无需再初始化和设置监听。

* Example:

```js
im.logout(operationID,data => {
    ...
})
```

* Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
|  callback   | callback |    通用回调     |

## getLoginStatus

> 获取当前用户登录状态。

* Example:

```js
const status = im.getLoginStatus()
// 返回值为 101:登录成功 102:登陆中 103:登录失败 201:登出 -1、-2:未登录
```

## getLoginUser

> 获取当前登录用户ID。

* Example:

```js
const userID = im.getLoginUser()
// 返回值 用户ID
```



# 初始化及登录相关监听

> 相关回调需要通过导入`globalEvent`进行监听，引入步骤参考[SDK引入]()。

| 事件               | 描述             |
| ------------------ | ---------------- |
| onConnectFailed    | 连接IM服务器失败 |
| onConnectSuccess   | 连接成功         |
| onConnecting       | 连接中           |
| onKickedOffline    | 被其它端踢下线   |
| onUserTokenExpired | 用户token过期    |
