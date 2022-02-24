# 获取群组列表

- 调用 getJoinedGroupList 可以获取已加入的群列表。

```js
///
/// @return List<GroupInfo>
OpenIM.iMManager.groupManager.getJoinedGroupList()
```

# 群组管理

## 创建群组

- 您可以在创建群组的同时初始化群的信息，例如群简介、群头像、以及最初的几个群成员等，

```js
///
/// @param groupName 群名
/// @param notification 群公告
/// @param introduction 群简介
/// @param faceUrl 群icon
/// @param list（List<GroupMemberRole>）	被选择的群成员
/// @return Future 
OpenIM.iMManager.groupManager.createGroup(
    groupName: groupName,
    notification: notification,
    introduction: introduction,
    faceUrl: faceUrl,
  list: list,)
```

## 添加群组

- 申请加入某群组，并提供验证信息。

```js
///
/// 添加群组
///
/// @param gid 要加入的群组id
/// @param reason 入群申请信息
///
OpenIM.iMManager.groupManager.joinGroup(gid: gid, reason: reason)
```

## 获取入群申请

- 主动拉取管理群组的所有入群申请列表，在有新的入群申请时我们会通过初始化前设置的群组监听器`setGroupListener`中的onReceiveJoinApplication回调事件更新。

```js
OpenIM.iMManager.groupManager.getGroupApplicationList()
```

## 处理入群申请

- 处理申请后初始化前设置的群组监听器`setGroupListener`中的onApplicationProcessed回调事件会返回处理结果给所有群管理者。

### 同意入群

```js
///
/// 同意入群
///
/// @param info 入群申请对象的GroupApplicationInfo
/// @param reason 同意申请原因
///
OpenIM.iMManager.groupManager.acceptGroupApplication(info: info, reason: reason)
```

### 拒绝入群

```js
///
/// 拒绝入群
///
/// @param info 入群申请对象的GroupApplicationInfo
/// @param reason 同意申请原因
///
OpenIM.iMManager.groupManager.refuseGroupApplication(info: info, reason: reason)
```

## 邀请加入群组

群内成员可批量邀请好友加入用户已加入的群组。

```js
///
/// 邀请加入群组
///
/// @param groupId 邀请进入的群id
/// @param reason 邀请入群信息
/// @param uidList 邀请用户id数组
///
OpenIM.iMManager.groupManager.inviteUserToGroup(groupId: groupId, uidList: uidList, reason: reason)
```

## 踢出群组

群主与管理员可批量踢出群成员。

```js
///
/// 踢出群组
///
/// @param groupId 踢出群id
/// @param reason 踢出原因
/// @param uidList 踢出用户id数组
///
OpenIM.iMManager.groupManager.kickGroupMember(groupId: groupId, uidList: uidList, reason: reason)
```

## 转让群组

- 群主可以调用 transferGroupOwner把群主转让给其他群成员，群主转让后，全员会收到 onGroupInfoChanged 回调。

  ```js
  ///
  /// 转让群组
  ///
  /// @param gid 群id
  /// @param uid 转让目标用户id
  ///
  OpenIM.iMManager.groupManager.transferGroupOwner(gid: gid, uid: uid)
  ```

## 退出群组

```js
///
/// 退出群组
///
/// @param gid 退出群id
///
OpenIM.iMManager.groupManager.quitGroup(gid: gid)
```

# 群资料

## 获取群资料

```js
///
/// 获取群资料
///
/// @param gidList 要获取信息的群组id数组
///
OpenIM.iMManager.groupManager.getGroupsInfo(gidList: gidList)
```

## 修改群资料

- 修改群资料后，全员会收到 onGroupInfoChanged 回调。

```js
///
/// @param groupName 群名
/// @param notification 群公告
/// @param introduction 群简介
/// @param faceUrl 群icon
OpenIM.iMManager.groupManager.setGroupInfo(
  groupName: groupName,
    notification: notification,
    introduction: introduction,
    faceUrl: faceUrl,
)
```

# 群成员管理

## 获取群成员列表

- 可以获取某个群的群成员列表，该列表中包含了各个群成员的资料信息。

  ```js
  ///
  /// 获取群成员列表
  ///
  /// @param groupID 群id
  /// @param filter过滤选项 0：所有成员 1：群主 2：管理员
  /// @param next 分页下标
  ///
  OpenIM.iMManager.groupManager.getGroupMemberList(groupId: groupId,filter:filter,next:next)
  ```

## 获取群员列表

- 根据群成员id批量获取群成员资料。

  ```js
  ///
  /// 获取群成员列表
  ///
  /// @param groupID 群id
  /// @param uidList 群成员id数组
  ///
  OpenIM.iMManager.groupManager.getGroupMembersInfo(groupId: groupId, uidList: uidList)
  ```

# 群组监听回调

## 调用示例

```js
OpenIM.iMManager.groupManager.setGroupListener(OnGroupListener(
        onApplicationProcessed: (groupId, opUser, agreeOrReject, opReason) {},
        onGroupCreated: (groupId) {},
        onGroupInfoChanged: (groupId, info) {},
        onMemberEnter: (groupId, list) {},
        onMemberInvited: (groupId, opUser, list) {},
        onMemberKicked: (groupId, opUser, list) {},
        onMemberLeave: (groupId, info) {},
        onReceiveJoinApplication: (groupId, info, opReason) {},
      ))
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

