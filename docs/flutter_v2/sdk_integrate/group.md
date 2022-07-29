#### GroupManager（组/群关系管理）

| 方法                         | 描述                                     |
| ---------------------------- | ---------------------------------------- |
| setGroupListener             | 组关系监听                               |
| inviteUserToGroup            | 邀请进组，直接进组无需同意               |
| kickGroupMember              | 移除组成员                               |
| getGroupMembersInfo          | 查询组成员资料                           |
| getGroupMemberList           | 分页获取组成员列表                       |
| getJoinedGroupList           | 查询已加入的组列表                       |
| isJoinedGroup                | 检查是否已加入组                         |
| createGroup                  | 创建一个组                               |
| setGroupInfo                 | 编辑组资料                               |
| getGroupsInfo                | 查询组信息                               |
| joinGroup                    | 申请加入组，需要通过管理员/群组同意。    |
| quitGroup                    | 退出组                                   |
| transferGroupOwner           | 转移组拥有者权限                         |
| getRecvGroupApplicationList  | 作为群主或者管理员，收到的群成员入群申请 |
| getSendGroupApplicationList  | 获取自己发出的入群申请记录               |
| acceptGroupApplication       | 管理员或者群主同意某人进入某群           |
| refuseGroupApplication       | 管理员或者群主拒绝某人进入某群           |
| dismissGroup                 | 解散群                                   |
| changeGroupMute              | 开启群禁言，所有群成员禁止发言           |
| changeGroupMemberMute        | 禁言群成员                               |
| setGroupMemberNickname       | 设置群成员昵称                           |
| searchGroups                 | 查询群                                   |
| setGroupMemberRoleLevel      | 设置群成员权限                           |
| getGroupMemberListByJoinTime | 根据加入时间分页获取组成员列表           |
| setGroupVerification         | 进群验证设置                             |



#### OnGroupListener（组关系监听）

| 方法                       | 描述                                          |
| -------------------------- | --------------------------------------------- |
| onGroupMemberInfoChanged   | 组成员信息发生变化                            |
| onGroupMemberDeleted       | 组成员退出                                    |
| onGroupMemberAdded         | 组成员进入                                    |
| onGroupApplicationRejected | 发出或收到的组申请被拒绝                      |
| onGroupApplicationDeleted  | 发出或收到的组申请被删除                      |
| onGroupApplicationAdded    | 发出或收到的组申请有新增                      |
| onGroupApplicationAccepted | 发出或收到的组申请被接受                      |
| onJoinedGroupDeleted       | 退出群：退出者收到；踢出群：被踢者收到        |
| onJoinedGroupAdded         | 创建群： 初始成员收到；邀请进群：被邀请者收到 |
| onGroupInfoChanged         | 组资料变更                                    |



#### inviteUserToGroup（邀请进组）

直接进组无需同意。

被邀请者收到OnJoinedGroupAdded

群成员（不包括被邀请者）收到OnGroupMemberAdded 

```
  OpenIM.iMManager.groupManager.inviteUserToGroup(
    groupId: '', // 组ID
    uidList: [], // 成员 userID 列表
    reason: '', // 备注信息
  ).then((list){
    // List<GroupInviteResult>
  });
}
```



#### kickGroupMember（移除组成员）

被踢者收到OnJoinedGroupDeleted

群成员收到OnGroupMemberDeleted 

```
OpenIM.iMManager.groupManager.kickGroupMember(
  groupId: '', // 组ID
  uidList: [], // 成员 userID 列表
  reason: '', // 备注信息
).then((list){
    // List<GroupInviteResult>
 });
```



#### getGroupMembersInfo（查询组成员信息）

```
OpenIM.iMManager.groupManager.getGroupMembersInfo(
  groupId: '', // 组ID
  uidList: [], // 成员 userID 列表
).then((list){
  // List<GroupMembersInfo>
});
```



#### getGroupMemberList（组成员列表）

```
OpenIM.iMManager.groupManager.getGroupMemberList(
  groupId: '', // 组ID
  filter: 0, // 1普通成员, 2群主，3管理员
  offset: 0, // 偏移量，每次开始的index值
  count: 0, // 每次拉取的数量
).then((list){
  // List<GroupMembersInfo>
});
```



#### getJoinedGroupList（获取已加入的群组）

```
OpenIM.iMManager.groupManager.getJoinedGroupList().then((list){
  // List<GroupInfo>
});
```



#### isJoinedGroup（检查是否已入群）

```
OpenIM.iMManager.groupManager.isJoinedGroup(
  gid: '', // 组ID
).then((joned) {
  // true已加入；false未加入
});
```



#### createGroup（创建组）

初始成员收到OnJoinedGroupAdded

```
OpenIM.iMManager.groupManager.createGroup(
  groupName: '', // 组名
  faceUrl: '', // 头像
  notification: '', // 群公告
  introduction: '', // 群简介
  groupType: 0, // 类型
  ex: '', // 扩展信息
  list: [], // 成员角色集合 List<GroupMemberRole>
).then((groupInfo){
  // 返回组信息 GroupInfo
});
```



#### setGroupInfo（修改组信息）

群成员收到OnGroupInfoChanged

```
OpenIM.iMManager.groupManager.setGroupInfo(
  groupID: '',
  groupName: '', // 组名
  faceUrl: '', // 头像
  notification: '', // 群公告
  introduction: '', // 群简介
  ex: '', // 扩展信息
  needVerification: '',// 进群验证设置
);
```



#### getGroupsInfo（根据id查询组信息）

```
OpenIM.iMManager.groupManager.getGroupsInfo(
  gidList: [], // 组id集合
).then((list){
  // List<GroupInfo>
});
```



#### joinGroup（申请入群组）

需要通过管理员同意。

申请者收到OnGroupApplicationAdded

群主+管理员收到OnGroupApplicationAdded 

```
OpenIM.iMManager.groupManager.joinGroup(
  gid: '', // 组id
  reason: '', // 入群备注信息
);
```



#### quitGroup（退出组）

退出者收到OnJoinedGroupDeleted

群成员收到OnGroupMemberDeleted

```
OpenIM.iMManager.groupManager.quitGroup(
  gid: '', // 组id
).then((_) {
    // 成功
 }).catchError((_){
 		// 失败
 });
```



#### transferGroupOwner（群转让）

```
OpenIM.iMManager.groupManager.transferGroupOwner(
  gid: '', // 组ID
  uid: '', // 新 owner userID
).then((_) {
    // 成功
 }).catchError((_){
 		// 失败
 });
```



#### getRecvGroupApplicationList（收到的入群申请）

作为群主或者管理员，获取收到的群成员申请进群列表。

```
OpenIM.iMManager.groupManager.getRecvGroupApplicationList().then((list){
  // List<GroupApplicationInfo>
});
```



#### getSendGroupApplicationList（发出的入群申请）

```
OpenIM.iMManager.groupManager.getSendGroupApplicationList().then((list){
  // List<GroupApplicationInfo>
});
```



#### acceptGroupApplication（接受入群申请）

申请者收到OnJoinedGroupAdded  OnGroupApplicationAccepted

群成员（不包括申请者）收到OnGroupMemberAdded

审批者（群主或者管理员）收到OnGroupMemberAdded OnGroupApplicationAccepted

```
OpenIM.iMManager.groupManager.acceptGroupApplication(
  gid: '', // 组ID
  uid: '', // 申请人userID
  handleMsg: '', // 备注信息
);
```



#### refuseGroupApplication（拒绝入群申请）

申请者收到OnGroupApplicationRejected

审批者（群主或者管理员）收到OnGroupApplicationRejected 

```
OpenIM.iMManager.groupManager.refuseGroupApplication(
  gid: '', // 组ID
  uid: '', // 申请人userID
  handleMsg: '', // 备注信息
);
```



#### dismissGroup（解散群）

```
OpenIM.iMManager.groupManager.dismissGroup(
  groupID: '', // 组ID
);
```



#### changeGroupMute（开启群禁言）

```
OpenIM.iMManager.groupManager.changeGroupMute(
  groupID: '', // 组ID
  mute:true, // 禁言
);
```



#### changeGroupMemberMute（对群成员禁言)

```
OpenIM.iMManager.groupManager.changeGroupMemberMute(
  groupID: '', // 组ID
  userID:'', // 群成员userID
  seconds:0, // 禁言时长s
);
```



#### setGroupMemberNickname（修改成员组昵称）

```
OpenIM.iMManager.groupManager.setGroupMemberNickname(
  groupID: '', // 组ID
  userID:'', // 群成员userID
  groupNickname:'', // 群昵称
);
```



#### searchGroups（搜索群）

```
List<GroupInfo> list = await OpenIM.iMManager.groupManager.searchGroups(
  keywordList: [], // 关键词
  isSearchGroupID: true, // 以id搜索
  isSearchGroupName: false, // 以群名搜索
);
```



#### setGroupMemberRoleLevel（设置群成员角色）

```
OpenIM.iMManager.groupManager.setGroupMemberRoleLevel(
  groupID: groupID,
  userID: userID,
  roleLevel: GroupRoleLevel.member,
)
```



#### getGroupMemberListByJoinTime（根据加入时间分页获取组成员列表）

```
// 如：获取消息发送前入群的成员，用于查看消息未读列表
var list = await OpenIM.iMManager.groupManager.getGroupMemberListByJoinTime(
  groupID: message.groupID!,
  joinTimeEnd: message.sendTime! ~/ 1000,
  offset: 0,
  count: 40,
  excludeUserIDList: [...hasReadIDList, OpenIM.iMManager.uid],// 排除的人员
);
```



#### setGroupVerification（进群验证）

```
OpenIM.iMManager.groupManager.setGroupVerification(
  groupID: '', // 组id
  needVerification: 0, // 进群验证选项，参考GroupVerification类
);
```

