# 获取群组列表

> 调用 getJoinedGroupList 可以获取已加入的群列表。

```js
openIM.getJoinedGroupList().then(res=>{
  ...
}).catch(err=>{
  ...
})
```



# 群组管理

## 创建群组

> 您可以在创建群组的同时初始化群的信息，例如群简介、群头像、以及最初的几个群成员等，

```js
const groupBaseInfo:GroupInitInfo = {
  groupType:0,							// 群类型
  groupName: "",						// 群名称
  introduction: "",					// 群介绍
  notification: "",					// 群公告
  faceURL: "",							// 群头像
  ex: ""										// 扩展字段
}
const memberList:member[] = [
  {
    userID:"",							// 用户ID
    roleLevel:1							// 用户角色 1普通 3管理员
  }
]
const options:CreateGroupParams = {
	groupBaseInfo,						// 群基础信息
  memberList								// 邀请入群成员列表
}
openIM.createGroup(options).then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



## 添加群组

> 申请加入某群组，并提供验证信息。

```js
/**
* 添加群组
*
* @param groupID 要加入的群组id
* @param reqMsg 入群申请信息
*/
const options:joinGroupParams = {
  groupID:"",
  reqMsg:""
} 
openIM.joinGroup(options).then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



## 获取发出的入群申请

> 主动拉取管理群组的所有入群申请列表，在有新的入群申请时SDK会通过[群组监听回调]()中的`OnGroupApplicationAdded`回调事件更新。

```js
openIM.getSendGroupApplicationList().then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



## 获取收到的入群申请

> 主动拉取自己发出的入群申请列表，在有新的入群申请时SDK会通过[群组监听回调]()中的`OnGroupApplicationAdded`回调事件更新。

```js
openIM.getRecvGroupApplicationList().then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



## 处理入群申请

> 处理申请后初始化前设置的群组监听器群组监听回调中的`OnGroupApplicationAccepted`或`OnGroupApplicationRejected`回调事件会返回处理结果给所有群管理者。

### 同意入群

```js
/**
* 同意入群
*
* @param groupID 群聊ID
* @param fromUserID 入群申请者ID
* @param handleMsg 同意原因
*/
const options:AccessGroupParams = {
  groupID:"",
  fromUserID:""，
  handleMsg:""
}
openIM.acceptGroupApplication(options).then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



### 拒绝入群

```js
/**
* 拒绝入群
*
* @param groupID 群聊ID
* @param fromUserID 入群申请者ID
* @param handleMsg 拒绝原因
*/
const options:AccessGroupParams = {
  groupID:"",
  fromUserID:""，
  handleMsg:""
}
openIM.refuseGroupApplication(options).then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



## 邀请加入群组

> 群内成员可批量邀请好友加入用户已加入的群组。

```js
/**
* 邀请加入群组
*
* @param groupID 邀请进入的群id
* @param reason 邀请入群信息
* @param userIDList 邀请用户id数组
*/
const options:InviteGroupParams = {
  groupID:"",
  reason:"",
  userIDList:["xxx"]
}
openIM.inviteUserToGroup(options).then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



## 踢出群组

> 群主与管理员可批量踢出群成员。

```js
/**
* 踢出群组
*
* @param groupID 踢出群id
* @param reason 踢出原因
* @param userIDList 踢出用户id数组
*/
const options:InviteGroupParams = {
  groupID:"",
  reason:"",
  userIDList:["xxx"]
}
openIM.kickGroupMember(options).then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



## 转让群组

> 群主可以调用 transferGroupOwner把群主转让给其他群成员，群主转让后，全员会收到 onGroupInfoChanged 回调。

```js
/**
* 踢出群组
*
* @param groupID 踢出群id
* @param newOwnerUserID 新群主用户id
*/
const options:TransferGroupParams = {
	groupID:"",
  newOwnerUserID:""
}
openIM.transferGroupOwner(options).then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



## 退出群组

```js
/**
* 退出群组
*
* @param groupID 退出群id
*/
openIM.quitGroup(groupID).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



# 群资料

## 获取群资料

```js
/**
* 获取群资料
*
* @param groupIDList 要获取信息的群组id数组
*/
const groupIDList = ["xxx"]
openIM.getGroupsInfo(groupIDList).then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



## 修改群资料

> 修改群资料后，全员会收到 onGroupInfoChanged 回调。

```js
/**
* 修改群资料
*
* @param groupInfo 群基本信息对象
*/
const groupInfo:GroupBaseInfo = {
  groupName: "",			// 群名称
  introduction: "",		// 群介绍
  notification: "",		// 群公告
  faceURL: "",				// 群头像
  ex: ""							// 群扩展字段
}
const options:GroupInfo = {
  groupID:"xxx",			//群ID
  groupInfo
}
openIM.setGroupInfo(options).then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



# 群成员管理

## 获取群成员列表

> 可以获取某个群的群成员列表，该列表中包含了各个群成员的资料信息。

```js
/**
* 获取群成员列表
*
* @param groupID 群id
* @param filter过滤选项 0：所有成员 1：普通 2：群主 3：管理员
* @param offset 分页下标
* @param count 一页拉取的数量
*/
const options:GetGroupMemberParams = {
  groupID:"",
  filter:0,
  offset:0,
  count:20
}
openIM.getGroupMemberList(options).then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



## 获取群员列表

> 根据群成员id批量获取群成员资料。

```js
/**
* 获取群成员列表
*
* @param groupID 群id
* @param userIDList 群成员id数组
*/
const options:Omit<InviteGroupParams, "reason"> = {
  groupID:"",
  userIDList:["xxx"]
}
openIM.getGroupMembersInfo(options).then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



# 群组监听回调

## 调用示例

```js
openIM.on(CbEvents.ONGROUPINFOCHANGED,(data:WsResponse)=>{
  ...
})
```



## 群组监听回调列表

| Event                      | Callback Parameters | Description      |
| -------------------------- | ------------------- | ---------------- |
| OnGroupApplicationAccepted | 被同意的群申请      | 入群申请被同意   |
| OnGroupApplicationRejected | 被拒绝的群申请      | 入群申请被拒绝   |
| OnGroupApplicationAdded    | 新增的群申请        | 入群申请有新增   |
| OnGroupApplicationDeleted  | 删除的群申请        | 入群申请被删除   |
| OnGroupInfoChanged         | 更新后的群信息      | 群组信息改变     |
| OnGroupMemberInfoChanged   | 更新后的群成员信息  | 群成员信息改变   |
| OnGroupMemberAdded         | 新入群的群成员      | 有新成员加入群组 |
| OnGroupMemberDeleted       | 退出去的群成员      | 有群成员退出群组 |
| OnJoinedGroupAdded         | 新加入的群 群信息   | 加入的群增加     |
| OnJoinedGroupDeleted       | 退出的群 群信息     | 加入的群减少     |
