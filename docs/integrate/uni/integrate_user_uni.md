# 用户资料管理



## 获取用户资料

可通过ID批量获取用户资料，在登录成功后可调用该接口获取当前登录用户资料。

```js
/**
 * 获取用户资料
 *
 * @param uidList 要查询的用户id数组
 */
const userList = ["1f8e0d51d335301d"]
openIM.getLoginUser(userList).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



## 修改当前登录用户资料

可修改当前登录用户资料，只需要传入要修改的资料字段即可。

```js
const info:SelfInfo = {
  name: "blooming",//用户昵称
  icon: "xxx.com",//头像URL
  gender:1,//性别，0未知，1男，2女
  mobile:"123",//用户手机号
  birth:"2020-01-23",//用户生日
  email:"123@qq.com",//用户邮箱
  ex:""//用户扩展信息
}
openIM.setSelfInfo(info).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



# 用户关系链

当前SDK逻辑在发送单聊消息的时候，默认不检查好友关系，即非好友也可以进行收发消息，如果用户需要先加客服为好友才能进行沟通非常不方便，因此该默认设置常用于在线客服等场景。

## 获取好友列表

获取当前登录用户好友列表。

```js
/**
 * 获取好友列表
 *
 * @return 好友列表的json字符串
 */
openIM.getFriendList().then(res=>{
  ...
}).catch(err=>{
  ...
})
```



## 设置好友备注

给某个好友添加备注，在好友界面或会话界面可通过判断comment是否为空来决定展示好友昵称还是备注。

```js
const data:SetFriendParams = {
  uid:"",			//好友id
  comment:""	//好友备注
}
openIM.setFriendInfo(data).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



## 发起添加好友申请

向某个用户发送添加好友的申请，同时可向对方传达验证信息。

```js
const data:AddFriendParams = {
	uid:"",				//用户id
  reqMessage:""	//验证消息
}
openIM.addFriend(data).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



## 获取好友申请

获取所有好友请求列表。

```js
openIM.getFriendApplicationList().then(res=>{
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
* @param uid 请求者id
*/
openIM.acceptFriendApplication(uid).then(res=>{
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
* @param uid 请求者id
*/
openIM.refuseFriendApplication(uid).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



## 拉入黑名单

当前逻辑拉入黑名单后通过`getFriendList`获取的好友列表中依然会返回该用户，但其中isInBlackList属性会标识存在黑名单中，开发者可根据需求决定是否在好友列表中展示。

```js
/**
* 拉入黑名单
*
* @param uid 需要拉入黑名单者id
*/
openIM.addToBlackList(uid).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



## 获取黑名单列表

获取所有黑名单列表。

```js
openIM.getBlackList().then(res=>{
  ...
}).catch(err=>{
  ...
})
```



## 移除黑名单

将某个用户移除黑名单列表。

```js
/**
* 拉入黑名单
*
* @param uid 需要移除黑名单者id
*/
openIM.deleteFromBlackList(uid).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



## 删除好友

删除某个好友会将其从好友列表中删除，并将与该好友直接的聊天消息清空，但会在会话列表中保留会话，是否删除可根据自身业务决定，若需要删除可调用`deleteConversation`进行删除。并且该删除操作为单向好友删除。

```js
/**
* 删除好友
*
* @param uid 要删除的id
*/
openIM.deleteFromFriendList(uid).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



## 好友监听回调



### 调用示例

```js
openIM.on(onFriendListAdded,(data:WsResponse)=>{
  ...
})
```



### 好友监听回调列表

| 回调事件名称                   | 说明             |
| ------------------------------ | ---------------- |
| OnBlackListAdd                 | 黑名单列表新增   |
| OnBlackListDeleted             | 黑名单列表移除   |
| OnFriendApplicationListAccept  | 接受了好友请求   |
| OnFriendApplicationListAdded   | 收到新的好友请求 |
| OnFriendApplicationListDeleted | 删除了好友请求   |
| OnFriendApplicationListReject  | 拒绝了好友请求   |
| OnFriendInfoChanged            | 好友信息更改     |
| OnFriendListAdded              | 新增了好友       |
| OnFriendListDeleted            | 删除了好友       |

