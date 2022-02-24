# 用户资料管理

## 获取用户资料

可通过ID批量获取用户资料，在登录成功后可调用该接口获取当前登录用户资料。

```js
///
/// 获取用户资料
///
/// @param uidList 要查询的用户id数组
///
OpenIM.iMManager.getUsersInfo(uidList)
```

## 修改当前登录用户资料

可修改当前登录用户资料，只需要传入要修改的资料字段即可。

```js
///只传入需要修改的字段即可

//// @param name  用户昵称
///  @param icon   头像URL
///  @param gender   性别，0未知，1男，2女
///  @param mobile    用户手机号
///  @param birth   用户生日
///  @param email   用户邮箱
///  @param ex    用户扩展信息
}
OpenIM.iMManager.setSelfInfo(  name: name,
          icon: icon,
          gender: gender,
          mobile: mobile,
          birth: birth,
          email: email,
          ex: ex,)
```

# 用户关系链

当前SDK逻辑在发送单聊消息的时候，默认不检查好友关系，即非好友也可以进行收发消息，如果用户需要先加客服为好友才能进行沟通非常不方便，因此该默认设置常用于在线客服等场景。

## 获取好友列表

获取当前登录用户好友列表。

```js
///
/// 获取好友列表
/// @return List<UserInfo>
///
OpenIM.iMManager.friendshipManager.getFriendList()
```

## 设置好友备注

给某个好友添加备注，在好友界面或会话界面可通过判断comment是否为空来决定展示好友昵称还是备注。

```js
/// @param uid    好友id
/// @param comment    好友备注

OpenIM.iMManager.friendshipManager.setFriendInfo(uid: uid, comment: comment)

```

## 添加好友

向某个用户发送添加好友的申请，同时可向对方传达验证信息。

```js
/// @param uid    要添加的用户id
/// @param reason    验证信息

OpenIM.iMManager.friendshipManager.addFriend(uid: uid, reason: reason)
```

## 获取好友申请

获取所有好友请求列表。

```js
/// @return Future<List<UserInfo>>
OpenIM.iMManager.friendshipManager.getFriendApplicationList()
```

## 处理好友申请

### 同意好友请求

```js
///
/// 同意好友请求
///
/// @param uid 请求者id
///
OpenIM.iMManager.friendshipManager.acceptFriendApplication(uid: uid)
```

### 拒绝好友申请

```js
///
/// 拒绝好友请求
///
/// @param uid 请求者id
///
OpenIM.iMManager.friendshipManager.refuseFriendApplication(uid: uid)
```

## 拉入黑名单

当前逻辑拉入黑名单后通过`getFriendList`获取的好友列表中依然会返回该用户，但其中isInBlackList属性会标识存在黑名单中，开发者可根据需求决定是否在好友列表中展示。

```js
///
/// 拉入黑名单
///
/// @param uid 需要拉入黑名单者id
///
OpenIM.iMManager.friendshipManager.addToBlackList(uid: uid)
```

## 获取黑名单列表

获取所有黑名单列表。

```js
/// @return Future<List<UserInfo>>
OpenIM.iMManager.friendshipManager.getBlackList()
```

## 移除黑名单

将某个用户移除黑名单列表。

```js
///
/// 拉入黑名单
///
/// @param uid 需要移除黑名单者id
///
OpenIM.iMManager.friendshipManager.deleteFromBlackList(uid: uid)
```

## 删除好友

删除某个好友会将其从好友列表中删除，并将与该好友直接的聊天消息清空，但会在会话列表中保留会话，是否删除可根据自身业务决定，若需要删除可调用`deleteConversation`进行删除。并且该删除操作为单向好友删除。

```js
///
/// 删除好友
///
/// @param uid 要删除的id
///
OpenIM.iMManager.friendshipManager.deleteFromFriendList(uid: uid)
```

## 好友监听回调

### 调用示例

```js
//调用示例
OpenIM.iMManager.friendshipManager.setFriendshipListener(OnFriendshipListener(
        onBlackListAdd: (u) {},
        onBlackListDeleted: (u) {},
        onFriendApplicationListAccept: (u) {},
        onFriendApplicationListAdded: (u) {},
        onFriendApplicationListDeleted: (u) {},
        onFriendApplicationListReject: (u) {},
        onFriendInfoChanged: (u) {},
        onFriendListAdded: (u) {},
        onFriendListDeleted: (u) {},
      ))
```

### 好友监听回调列表

| 回调事件名称                   | 说明             |
| ------------------------------ | ---------------- |
| onBlackListAdd                 | 黑名单列表新增   |
| onBlackListDeleted             | 黑名单列表移除   |
| onFriendApplicationListAccept  | 接受了好友请求   |
| onFriendApplicationListAdded   | 收到新的好友请求 |
| onFriendApplicationListDeleted | 删除了好友请求   |
| onFriendApplicationListReject  | 拒绝了好友请求   |
| onFriendInfoChanged            | 好友信息更改     |
| onFriendListAdded              | 新增了好友       |
| onFriendListDeleted            | 删除了好友       |
