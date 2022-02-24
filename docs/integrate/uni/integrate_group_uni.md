# 获取群组列表

- 调用 getJoinedGroupList 可以获取已加入的群列表。

```js
this.$openSdk.getJoinedGroupList(data=>{
    const groupList = JSON.parse(data.msg)
    ...
})
```



# 群组管理



## 创建群组

- 您可以在创建群组的同时初始化群的信息，例如群简介、群头像、以及最初的几个群成员等，

```js
const groupInfo = {
    groupName:"xxx",	//群组名称
    introduction:"xxx",	//群组介绍
    notification:"xxx",	//入群邀请信息
    faceUrl:"xxx"	//群头像地址
}
const memberList = [
  {
    uid:"",					//邀请的群成员id
    setRole:0				//设置群成员角色 0:普通成员 2:管理员
  }
]

this.$openSdk.createGroup(groupInfo,memberList,data=>{
    ...
})
```



## 添加群组

- 申请加入某群组，并提供验证信息。

```js
/**
* 添加群组
*
* @param groupID 要加入的群组id
* @param reqMessage 入群申请信息
*/
this.$openSdk.joinGroup(groupID, reqMessage, data => {
    ...
})
```



## 获取入群申请

- 主动拉取管理群组的所有入群申请列表，在有新的入群申请时我们会通过初始化前设置的群组监听器`setGroupListener`中的onReceiveJoinApplication回调事件更新。

```js
this.$openSdk.getGroupApplicationList(data => {
    const groupApplicationInfo = JSON.parse(data.msg)
    ...
})
```



## 处理入群申请

- 处理申请后初始化前设置的群组监听器`setGroupListener`中的onApplicationProcessed回调事件会返回处理结果给所有群管理者。

### 同意入群

```js
/**
* 同意入群
*
* @param applicationJson 入群申请对象的Json字符串
* @param acceptReason 同意申请原因
*/
this.$openSdk.acceptGroupApplication(applicationJson, acceptReason,data=>{
    ...
})
```



### 拒绝入群

```js
/**
* 拒绝入群
*
* @param applicationJson 入群申请对象的Json字符串
* @param refuseReason 同意申请原因
*/
this.$openSdk.refuseGroupApplication(applicationJson, refuseReason,data=>{
    ...
})
```



## 邀请加入群组

群内成员可批量邀请好友加入用户已加入的群组。

```js
/**
* 邀请加入群组
*
* @param groupID 邀请进入的群id
* @param inviteMessage 邀请入群信息
* @param userList 邀请用户id数组
*/
this.$openSdk.inviteUserToGroup(groupID,inviteMessage,userList,data=>{
    ...
})
```



## 踢出群组

群主与管理员可批量踢出群成员。

```js
/**
* 踢出群组
*
* @param groupID 踢出群id
* @param kickMessage 踢出原因
* @param userList 踢出用户id数组
*/
this.$openSdk.kickGroupMember(groupID,kickMessage,userList,data=>{
    ...
})
```



## 转让群组

- 群主可以调用 transferGroupOwner把群主转让给其他群成员，群主转让后，全员会收到 onGroupInfoChanged 回调。

  ```js
  /**
  * 踢出群组
  *
  * @param groupID 踢出群id
  * @param uid 转让目标用户id
  */
  this.$openSdk.transferGroupOwner(groupID,uid,data=>{
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
this.$openSdk.quitGroup(groupID,data=>{
  ...  
})
```



# 群资料



## 获取群资料

```js
/**
* 获取群资料
*
* @param groupIdList 要获取信息的群组id数组
*/
this.$openSdk.getGroupsInfo(groupIdList,data=>{
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
const groupInfo = {
  groupID:"",	//群ID
	groupName:"",	//群名称
  introduction:"",	//群介绍
  notification:"",	//群公告
  faceUrl:""	//群头像
}
this.$openSdk.setGroupInfo(groupInfo,data=>{
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
  * @param groupID 群id
  * @param filter过滤选项 0：所有成员 1：群主 2：管理员
  * @param next 分页下标
  */
  this.$openSdk.getGroupMemberList(groupID,filter,next,data=>{
    ...  
  })
  ```



## 获取群员列表

- 根据群成员id批量获取群成员资料。

  ```js
  /**
  * 获取群成员列表
  *
  * @param groupID 群id
  * @param uidList 群成员id数组
  */
  this.$openSdk.getGroupMembersInfo(groupID,uidList,data=>{
    ...  
  })
  ```

  

# 群组监听回调



## 调用示例

```js
this.$globalEvent.addEventListener("OnGroupInfoChanged", data=>{
    ...
})
```



## 群组监听回调列表

| 回调事件名称             | 说明                 |
| ------------------------ | -------------------- |
| onApplicationProcessed   | 入群申请被处理       |
| onGroupCreated           | 群组创建             |
| onGroupInfoChanged       | 群组信息改变         |
| onMemberEnter            | 有新成员加入群组     |
| onMemberInvited          | 邀请新成员加入了群组 |
| onMemberKicked           | 有群成员被踢出       |
| onMemberLeave            | 有群成员退群         |
| onReceiveJoinApplication | 收到新入群申请       |

