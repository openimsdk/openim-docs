# 群聊相关API

| 方法                         | 描述                                     |
| ---------------------------- | ---------------------------------------- |
| inviteUserToGroup            | 邀请用户进群                             |
| kickGroupMember              | 移除群成员                               |
| getGroupMembersInfo          | 根据用户ID获取指定群成员资料             |
| getGroupMemberList           | 分页获取群成员列表                       |
| getGroupMemberListByJoinTime | 根据加入时间分页获取群成员列表           |
| getJoinedGroupList           | 查询已加入的群列表                       |
| createGroup                  | 创建群聊                                 |
| setGroupInfo                 | 编辑群资料                               |
| getGroupsInfo                | 获取群信息                               |
| joinGroup                    | 申请加入群                               |
| quitGroup                    | 退出群                                   |
| transferGroupOwner           | 转让群主                                 |
| getRecvGroupApplicationList  | 作为群主或者管理员，收到的群成员入群申请 |
| getSendGroupApplicationList  | 获取自己发出的入群申请记录               |
| acceptGroupApplication       | 管理员或者群主同意某人进入某群           |
| refuseGroupApplication       | 管理员或者群主拒绝某人进入某群           |
| dismissGroup                 | 解散群                                   |
| changeGroupMute              | 开启群禁言，所有普通群成员禁止发言       |
| changeGroupMemberMute        | 禁言指定群成员                           |
| setGroupMemberNickname       | 设置群成员昵称                           |
| searchGroups                 | 在已加入的群聊中搜索                     |
| setGroupMemberRoleLevel      | 设置群成员权限                           |
| setGroupVerification         | 设置进群验证规则                         |



## inviteUserToGroup

> 邀请用户加入群组(可批量)。

- Example:

  ```js
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

- Parameters:


| Name       | Type     | Required | Description  |
| ---------- | -------- | -------- | ------------ |
| groupID    | string   | true     | 群聊ID       |
| reason     | string   | true     | 请求验证信息 |
| userIDList | string[] | true     | 邀请用户列表 |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 邀请成功或失败描述 |

  

## kickGroupMember

> 踢出群聊(可批量)。

- Example:

  ```js
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

- Parameters:


| Name       | Type     | Required | Description  |
| ---------- | -------- | -------- | ------------ |
| groupID    | string   | true     | 群聊ID       |
| reason     | string   | true     | 踢出原因     |
| userIDList | string[] | true     | 邀请用户列表 |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 踢出成功或失败描述 |

## getGroupMembersInfo

> 批量获取群成员信息。

- Example:

  ```js
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

- Parameters:


| Name       | Type     | Required | Description  |
| ---------- | -------- | -------- | ------------ |
| groupID    | string   | true     | 群聊ID       |
| userIDList | string[] | true     | 群成员ID数组 |

- CallBack:


| Name | Type   | Description                  |
| ---- | ------ | ---------------------------- |
| data | string | 群成员信息对象列表json字符串 |

  

## getGroupMemberList

> 获取群成员列表。

- Example:

  ```js
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

- Parameters:


| Name    | Type   | Required | Description                                    |
| ------- | ------ | -------- | ---------------------------------------------- |
| groupID | string | true     | 群聊ID                                         |
| filter  | number | true     | 过滤标识 0:所有成员 1:普通成员 2:群主 3:管理员 |
| offset  | number | true     | 分页拉取起点                                   |
| count   | number | true     | 分页拉取总数                                   |

- CallBack:


| Name | Type   | Description                  |
| ---- | ------ | ---------------------------- |
| data | string | 群成员信息对象列表json字符串 |

  

## getGroupMemberListByJoinTime

> 获取群成员列表。

- Example:

  ```js
  const options:GetGroupMemberByTimeParams = {
    groupID:"",
    offset:0,
    count:20,
    filterUserIDList:[],
    joinTimeBegin:0,
    joinTimeEnd:0
  }
  openIM.getGroupMemberListByJoinTime(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name             | Type     | Required | Description                             |
| ---------------- | -------- | -------- | --------------------------------------- |
| groupID          | string   | true     | 群聊ID                                  |
| offset           | number   | true     | 分页拉取起点                            |
| count            | number   | true     | 分页拉取总数                            |
| filterUserIDList | string[] | true     | 需要排除的群成员ID                      |
| joinTimeBegin    | number   | true     | 拉取该时间点之后进群的用户，为0时不限制 |
| joinTimeEnd      | number   | true     | 拉取该时间点之前进群的用户，为0时不限制 |

- CallBack:


| Name | Type   | Description                  |
| ---- | ------ | ---------------------------- |
| data | string | 群成员信息对象列表json字符串 |

  



## getJoinedGroupList

> 获取已加入的群列表。

- Example:

  ```js
  openIM.getJoinedGroupList().then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- CallBack:


| Name | Type   | Description                                                  |
| ---- | ------ | ------------------------------------------------------------ |
| data | string | [群信息对象](https://doc.rentsoft.cn/client_doc/web_doc.html#%E7%BE%A4%E7%BB%84%E4%BF%A1%E6%81%AF%E5%AF%B9%E8%B1%A1)列表json字符串 |

  

## createGroup

> 创建一个群聊，并指定群信息以及群成员。

- Example:

  ```js
  const groupBaseInfo:GroupInitInfo = {
    groupType:0,
    groupName: "",
    introduction: "",
    notification: "",
    faceURL: "",
    ex: ""
  }
  const memberList:member[] = [
    {
      userID:"",
      roleLevel:1
    }
  ]
  const options:CreateGroupParams = {
    groupBaseInfo,
    memberList
  }
  openIM.createGroup(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```
  
- Parameters:


| Name                        | Type          | Required | Description                  |
| --------------------------- | ------------- | -------- | ---------------------------- |
| groupBaseInfo               | GroupInitInfo | true     | 群基本信息对象               |
| memberList                  | Member        | true     | 群成员列表 可为空数组        |
| groupBaseInfo->groupName    | string        | true     | 群名称                       |
| groupBaseInfo->groupType    | number        | true     | 群聊类型 当前默认0           |
| groupBaseInfo->introduction | string        | false    | 群介绍                       |
| groupBaseInfo->notification | string        | false    | 群公告                       |
| groupBaseInfo->faceURL      | string        | false    | 群头像                       |
| groupBaseInfo->ex           | string        | false    | 扩展字段                     |
| memberList->userID          | string        | true     | 用户ID                       |
| memberList->roleLevel       | number        | true     | 设置角色 1:普通成员 3:管理员 |

- CallBack:


| Name | Type   | Description      |
| ---- | ------ | ---------------- |
| data | string | 创建成功的群信息 |

  

## setGroupInfo

> 设置、更新群聊信息。

- Example:

  ```js
  const groupInfo:GroupBaseInfo = {
    groupName: "",
    introduction: "",
    notification: "",
    faceURL: "",
    ex: ""
  }
  const options:GroupInfo = {
    groupID:"xxx",
    groupInfo
  }
  openIM.setGroupInfo(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name                    | Type          | Required | Description    |
| ----------------------- | ------------- | -------- | -------------- |
| groupID                 | string        | true     | 群ID           |
| groupInfo               | GroupBaseInfo | true     | 群基本信息     |
| groupInfo->groupName    | string        | false    | 群名称         |
| groupInfo->introduction | string        | false    | 群介绍         |
| groupInfo->notification | string        | false    | 群公告         |
| groupInfo->faceURL      | string        | false    | 群头像         |
| groupInfo->ex           | string        | false    | 群信息扩展字段 |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 设置成功或失败描述 |

  

## getGroupsInfo

> 批量获取群组信息。

- Example:

  ```js
  const groupIDList = ["xxx"]
  openIM.getGroupsInfo(groupIDList).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name        | Type     | Required | Description |
| ----------- | -------- | -------- | ----------- |
| groupIDList | string[] | true     | 群组ID列表  |

- CallBack:


| Name | Type   | Description                                                  |
| ---- | ------ | ------------------------------------------------------------ |
| data | string | [群信息对象](https://doc.rentsoft.cn/client_doc/web_doc.html#%E7%BE%A4%E7%BB%84%E4%BF%A1%E6%81%AF%E5%AF%B9%E8%B1%A1)列表json字符串 |

  

## joinGroup

> 申请加入群聊。

- Example:

  ```js
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

- Parameters:


| Name    | Type   | Required | Description  |
| ------- | ------ | -------- | ------------ |
| groupID | string | true     | 群聊ID       |
| reqMsg  | string | true     | 请求验证信息 |

- CallBack:


| Name | Type   | Description  |
| ---- | ------ | ------------ |
| data | string | 发送申请成功 |

  

## quitGroup

> 退出群聊。

- Example:

  ```js
  openIM.quitGroup(groupID).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name    | Type   | Description |
| ------- | ------ | ----------- |
| groupID | string | 群聊ID      |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 退出成功或失败描述 |

  

## transferGroupOwner

> 转让群主。

- Example:

  ```js
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

- Parameters:


| Name           | Type   | Required | Description  |
| -------------- | ------ | -------- | ------------ |
| groupID        | string | true     | 群聊ID       |
| newOwnerUserID | string | true     | 新群主用户ID |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 转让成功或失败描述 |



## getRecvGroupApplicationList

> 获取收到的加入群聊申请列表。

- Example:

  ```js
  openIM.getRecvGroupApplicationList().then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- CallBack:


| Name | Type   | Description                |
| ---- | ------ | -------------------------- |
| data | string | 入群申请对象列表json字符串 |

  

## getSendGroupApplicationList

> 获取发出的加入群聊申请列表。

- Example:

  ```js
  openIM.getSendGroupApplicationList().then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- CallBack:


| Name | Type   | Description                |
| ---- | ------ | -------------------------- |
| data | string | 入群申请对象列表json字符串 |



## acceptGroupApplication

> 同意入群请求。

- Example:

  ```js
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

- Parameters:


| Name       | Type   | Required | Description |
| ---------- | ------ | -------- | ----------- |
| groupID    | string | true     | 群ID        |
| fromUserID | string | true     | 申请者ID    |
| handleMsg  | string | true     | 同意原因    |

- CallBack:


| Name | Type   | Description            |
| ---- | ------ | ---------------------- |
| data | string | 同意入群成功或失败描述 |

  

## refuseGroupApplication

> 拒绝入群请求。

- Example:

  ```js
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

- Parameters:


| Name       | Type   | Required | Description |
| ---------- | ------ | -------- | ----------- |
| groupID    | string | true     | 群ID        |
| fromUserID | string | true     | 申请者ID    |
| handleMsg  | string | true     | 拒绝原因    |

- CallBack:


| Name | Type   | Description            |
| ---- | ------ | ---------------------- |
| data | string | 拒绝入群成功或失败描述 |

  

## dismissGroup

> 拒绝入群请求。

- Example:

  ```js
  openIM.dismissGroup(groupID).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name    | Type   | Required | Description |
| ------- | ------ | -------- | ----------- |
| groupID | string | true     | 群ID        |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 操作成功或失败描述 |



## changeGroupMute

> 修改全体禁言状态。

- Example:

  ```js
  const options:ChangeGroupMuteParams = {
  	groupID:"",
    isMute:true
  }
  openIM.changeGroupMute(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name    | Type    | Required | Description |
| ------- | ------- | -------- | ----------- |
| groupID | string  | true     | 群ID        |
| isMute  | boolean | true     | 是否禁言    |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 操作成功或失败描述 |



## changeGroupMemberMute

> 修改针对某个群员的禁言状态。

- Example:

  ```js
  const options:ChangeGroupMemberMuteParams = {
  	groupID:"",
    userID:"",
    mutedSeconds:0
  }
  openIM.changeGroupMemberMute(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name         | Type   | Required | Description               |
| ------------ | ------ | -------- | ------------------------- |
| groupID      | string | true     | 群ID                      |
| userID       | string | true     | 群成员ID                  |
| mutedSeconds | number | true     | 禁言时长，为0时即解除禁言 |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 操作成功或失败描述 |



## setGroupMemberNickname

> 修改某个群员在群内的昵称。

- Example:

  ```js
  const options:MemberNameParams = {
  	groupID:"",
    userID:"",
    GroupMemberNickname:""
  }
  openIM.setGroupMemberNickname(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name                | Type   | Required | Description |
| ------------------- | ------ | -------- | ----------- |
| groupID             | string | true     | 群ID        |
| userID              | string | true     | 群成员ID    |
| GroupMemberNickname | string | true     | 群昵称      |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 操作成功或失败描述 |



## searchGroups

> 在已加入的群列表中进行搜索。

- Example:

  ```js
  const options:SearchGroupParams = {
  	keywordList: [],
    isSearchGroupID: true,
    isSearchGroupName: true
  }
  openIM.searchGroups(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name              | Type     | Required | Description    |
| ----------------- | -------- | -------- | -------------- |
| keywordList       | string[] | true     | 搜索关键词     |
| isSearchGroupID   | boolean  | true     | 是否搜索群ID   |
| isSearchGroupName | boolean  | true     | 是否搜索群名称 |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 操作成功或失败描述 |



## setGroupMemberRoleLevel

> 修改群成员权限（角色）。

- Example:

  ```js
  const options:SetGroupRoleParams = {
  	groupID:"",
    userID:"",
    roleLevel:1
  }
  openIM.setGroupMemberRoleLevel(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name      | Type      | Required | Description                               |
| --------- | --------- | -------- | ----------------------------------------- |
| groupID   | string    | true     | 群聊ID                                    |
| userID    | string    | true     | 群成员ID                                  |
| roleLevel | GroupRole | true     | 群成员角色类型 1:普通成员 2:群主 3:管理员 |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 操作成功或失败描述 |



## setGroupVerification

> 修改群成员权限（角色）。

- Example:

  ```js
  const options:SetGroupVerificationParams = {
  	groupID:"",
    verification:0,
  }
  openIM.setGroupVerification(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name         | Type                  | Required | Description                                         |
| ------------ | --------------------- | -------- | --------------------------------------------------- |
| groupID      | string                | true     | 群聊ID                                              |
| verification | GroupVerificationType | true     | 验证类型 0:邀请需要验证 1:都需要验证 2:都不需要验证 |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 操作成功或失败描述 |







# 群聊相关回调

> 所有事件相关常量均封装在SDK的`CbEvents`中，可直接进行引入使用。

| 事件                       | 描述                             | 响应                 |
| -------------------------- | -------------------------------- | -------------------- |
| OnJoinedGroupAdded         | 加入了新群组                     | 群信息json字符串     |
| OnJoinedGroupDeleted       | 退出了某个群组                   | 群信息json字符串     |
| OnGroupMemberAdded         | 加入的某个群有新成员加入         | 群成员信息json字符串 |
| OnGroupMemberDeleted       | 加入的某个群有成员退出           | 群成员信息json字符串 |
| OnGroupApplicationAdded    | 收到或发出的群申请有新增         | 群申请信息json字符串 |
| OnGroupApplicationDeleted  | 收到或发出的群申请有减少         | 群申请信息json字符串 |
| OnGroupInfoChanged         | 已加入的某个群信息改变           | 群信息json字符串     |
| OnGroupMemberInfoChanged   | 已加入的某个群中有群成员信息改变 | 群成员信息json字符串 |
| OnGroupApplicationAccepted | 收到或发出的群申请被同意         | 群申请信息json字符串 |
| OnGroupApplicationRejected | 收到或翻出的群申请被拒绝         | 群申请信息json字符串 |
