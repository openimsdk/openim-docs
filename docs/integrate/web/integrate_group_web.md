# 获取群组列表

- 调用 getJoinedGroupList 可以获取已加入的群列表。

```js
openIM.getJoinedGroupList().then(res=>{
  ...
}).catch(err=>{
  ...
})
```



# 群组管理



## 创建群组

- 您可以在创建群组的同时初始化群的信息，例如群简介、群头像、以及最初的几个群成员等，

```js
const gInfo:GroupInfo = {
	groupName:"",			//群名称
  introduction:"",	//群介绍
  notification:"",	//群公告
  faceUrl:""				//群头像
}
const memberList:member[] = [
  {
    uid:"",					//邀请的群成员id
    setRole:0				//设置群成员角色 0:普通成员 2:管理员
  }
]
const data:CreateGroupParams = {
	gInfo,
  memberList
}
openIM.createGroup(data).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



## 添加群组

- 申请加入某群组，并提供验证信息。

```js
/**
* 添加群组
*
* @param groupId 要加入的群组id
* @param message 入群申请信息
*/
const data:joinGroupParams = {
  groupId:"",
  message:""
} 
openIM.joinGroup(data).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



## 获取入群申请

- 主动拉取管理群组的所有入群申请列表，在有新的入群申请时我们会通过[群组监听回调]()中的`OnReceiveJoinApplication`回调事件更新。

```js
openIM.getGroupApplicationList().then(res=>{
  ...
}).catch(err=>{
  ...
})
```



## 处理入群申请

- 处理申请后初始化前设置的群组监听器群组监听回调中的`OnApplicationProcessed`回调事件会返回处理结果给所有群管理者。

### 同意入群

```js
/**
* 同意入群
*
* @param application 入群申请对象的Json字符串
* @param reason 同意申请原因
*/
const data:AccessGroupParams = {
  application:"",
  reason:""
}
openIM.acceptGroupApplication(data).then(res=>{
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
* @param application 入群申请对象的Json字符串
* @param reason 同意申请原因
*/
const data:AccessGroupParams = {
  application:"",
  reason:""
}
openIM.refuseGroupApplication(data).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



## 邀请加入群组

群内成员可批量邀请好友加入用户已加入的群组。

```js
/**
* 邀请加入群组
*
* @param groupid 邀请进入的群id
* @param reason 邀请入群信息
* @param userList 邀请用户id数组
*/
const data:InviteGroupParams = {
  groupid:"",
  reason:"",
  userList:["xxx"]
}
openIM.inviteUserToGroup(data).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



## 踢出群组

群主与管理员可批量踢出群成员。

```js
/**
* 踢出群组
*
* @param groupid 踢出群id
* @param reason 踢出原因
* @param userList 踢出用户id数组
*/
const data:InviteGroupParams = {
  groupid:"",
  reason:"",
  userList:["xxx"]
}
openIM.kickGroupMember(data).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



## 转让群组

- 群主可以调用 transferGroupOwner把群主转让给其他群成员，群主转让后，全员会收到 onGroupInfoChanged 回调。

  ```js
  /**
  * 踢出群组
  *
  * @param groupId 踢出群id
  * @param userId 转让目标用户id
  */
  const data:TransferGroupParams = {
  	groupId:"",
    userId:""
  }
  openIM.transferGroupOwner(data).then(res=>{
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
* @param data 要获取信息的群组id数组
*/
const data = ["xxx"]
openIM.getGroupsInfo(data).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



## 修改群资料

- 修改群资料后，全员会收到 onGroupInfoChanged 回调。

```js
/**
* 修改群资料
*
* @param groupInfo 群组信息对象，可通过getGroupsInfo获取
*/
const data:GroupInfo = {
  groupId:"",	//群ID
	groupName:"",	//群名称
  introduction:"",	//群介绍
  notification:"",	//群公告
  faceUrl:""	//群头像
}
openIM.setGroupInfo(data).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



# 群成员管理

## 获取群成员列表

- 可以获取某个群的群成员列表，该列表中包含了各个群成员的资料信息。

  ```js
  /**
  * 获取群成员列表
  *
  * @param groupid 群id
  * @param filter过滤选项 0：所有成员 1：群主 2：管理员
  * @param next 分页下标
  */
  const data:GetGroupMemberParams = {
    groupid:"",
    filter:0,
    next:0
  }
  openIM.getGroupMemberList(data).then(res=>{
    ...
  }).catch(err=>{
    ...
  })
  ```



## 获取群员列表

- 根据群成员id批量获取群成员资料。

  ```js
  /**
  * 获取群成员列表
  *
  * @param groupid 群id
  * @param uidList 群成员id数组
  */
  const data:Omit<InviteGroupParams, "reason"> = {
    groupid:"",
    userList:["xxx"]
  }
  openIM.getGroupMembersInfo(data).then(res=>{
    ...
  }).catch(err=>{
    ...
  })
  ```
  
  

# 群组监听回调



## 调用示例

```js
openIM.on(OnGroupInfoChanged,(data:WsResponse)=>{
  ...
})
```



## 群组监听回调列表

| 回调事件名称             | 说明                 |
| ------------------------ | -------------------- |
| OnApplicationProcessed   | 入群申请被处理       |
| OnGroupCreated           | 群组创建             |
| OnGroupInfoChanged       | 群组信息改变         |
| OnMemberEnter            | 有新成员加入群组     |
| OnMemberInvited          | 邀请新成员加入了群组 |
| OnMemberKicked           | 有群成员被踢出       |
| OnMemberLeave            | 有群成员退群         |
| OnReceiveJoinApplication | 收到新入群申请       |

