# 用户资料管理

## 获取用户资料

> 可通过ID批量获取用户资料，在登录成功后可调用该接口获取当前登录用户资料。

```js
/**
 * 获取用户资料
 *
 * @param userIDList 要查询的用户id数组
 */
const userIDList = ["1f8e0d51d335301d"]
openIM.getUsersInfo(userIDList).then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



## 获取当前登录用户资料

> 可修改当前登录用户资料，只需要传入要修改的资料字段即可。

```js
openIM.getSelfUserInfo().then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



## 修改当前登录用户资料

> 可修改当前登录用户资料，只需要传入要修改的资料字段即可。

```js
//只传入需要修改的字段即可
const selfInfo:PartialUserItem = {
  userID:"1234",
  nickname: "blooming",//用户昵称
  faceURL: "xxx.com",//头像URL
  gender:1,//性别，0未知，1男，2女
  phoneNumber:"123",//用户手机号
  birth:1642584426,//用户生日
  email:"123@qq.com",//用户邮箱
  ex:"ex"//用户扩展信息
}
openIM.setSelfInfo(selfInfo).then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



# 用户关系链

> 当前SDK逻辑在发送单聊消息的时候，默认不检查好友关系，即非好友也可以进行收发消息，如果用户需要先加客服为好友才能进行沟通非常不方便，因此该默认设置常用于在线客服等场景。

## 获取好友列表

> 获取当前登录用户好友列表。

```js
openIM.getFriendList().then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



## 设置好友备注

> 给某个好友添加备注，在好友界面或会话界面可通过判断remark是否为空来决定展示好友昵称还是备注。

```js
/**
* 设置好友备注
*
* @param toUserID 好友ID
* @param remark 好友备注
*/
const options:RemarkFriendParams = {
  toUserID:"",
  remark:""
}
openIM.setFriendRemark(options).then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



## 添加好友

> 向某个用户发送添加好友的申请，同时可向对方传达验证信息。

```js
/**
* 添加好友
*
* @param toUserID 用户ID
* @param reqMsg 请求信息
*/
const options:AddFriendParams = {
	toUserID:"",
  reqMsg:""
}
openIM.addFriend(options).then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



## 获取发出的好友申请

> 获取自己发出的所有好友请求列表。

```js
openIM.getSendFriendApplicationList().then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



## 获取收到的好友申请

> 获取自己收到的所有好友请求列表。

```js
openIM.getRecvFriendApplicationList().then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



## 处理好友申请

### 同意好友请求

```js
/**
* 同意好友请求
*
* @param toUserID 请求者id
* @param handleMsg 同意原因
*/
const options:AccessFriendParams = {
  toUserID:"",
  handleMsg:""
}
openIM.acceptFriendApplication(options).then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



### 拒绝好友申请

```js
/**
* 拒绝好友请求
*
* @param toUserID 请求者id
* @param handleMsg 拒绝原因
*/
const options:AccessFriendParams = {
  toUserID:"",
  handleMsg:""
}
openIM.refuseFriendApplication(options).then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



## 拉入黑名单

> 当前逻辑拉入黑名单后通过`getFriendList`获取的好友列表中依然会返回该用户，但其中isInBlackList属性会标识存在黑名单中，开发者可根据需求决定是否在好友列表中展示。

```js
/**
* 拉入黑名单
*
* @param userID 需要拉入黑名单者id
*/
openIM.addBlack(userID).then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



## 获取黑名单列表

> 获取所有黑名单列表。

```js
openIM.getBlackList().then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



## 移除黑名单

> 将某个用户移除黑名单列表。

```js
/**
* 拉入黑名单
*
* @param userID 需要移除黑名单者id
*/
openIM.removeBlack(userID).then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



## 删除好友

> 删除某个好友会将其从好友列表中删除，并将与该好友直接的聊天消息清空，但会在会话列表中保留会话，是否删除可根据自身业务决定，若需要删除可调用`deleteConversation`进行删除。并且该删除操作为单向好友删除。

```js
/**
* 删除好友
*
* @param userID要删除的用户ID
*/
openIM.deleteFriend(userID).then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



# 好友监听回调

## 调用示例

```js
openIM.on(CbEvents.ONFRIENDADDED,(data:WsResponse)=>{
  ...
})
```



## 好友监听回调列表

| Event                       | Callback Parameters | Description              |
| --------------------------- | ------------------- | ------------------------ |
| OnBlackAdded                | 新增的黑名单信息    | 添加用户到黑名单         |
| OnBlackDeleted              | 移除的黑名单信息    | 从黑名单中移除了某个用户 |
| OnFriendApplicationAccepted | 被接受的好友申请    | 好友请求被接受           |
| OnFriendApplicationRejected | 被拒绝的好友申请    | 好友请求被拒绝           |
| OnFriendApplicationAdded    | 新增的好友申请      | 好友请求列表增加         |
| OnFriendApplicationDeleted  | 被移除的好友申请    | 好友请求列表减少         |
| OnFriendInfoChanged         | 更新后的好友信息    | 好友信息更新             |
| OnFriendAdded               | 新增的好友信息      | 好友列表增加             |
| OnFriendDeleted             | 减少的好友信息      | 好友列表减少             |

