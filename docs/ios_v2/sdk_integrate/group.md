#### GroupManager（组/群关系管理）

| 方法                         | 描述                                     |
| ---------------------------- | ---------------------------------------- |
| setGroupListener             |
| addGroupListener             | 组关系监听                               |
| inviteUserToGroup            | 邀请进组，直接进组无需同意               |
| kickGroupMember              | 移除组成员                               |
| getGroupMembersInfo          | 查询组成员资料                           |
| getGroupMemberList           | 分页获取组成员列表                       |
| getJoinedGroupList           | 查询已加入的组列表                       |
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
| setGroupVerification         | 进群验证设置选项           |




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
        [OIMManager.manager inviteUserToGroup:@"" // group id
                                       reason:@""
                                         uids:@[@""] // [user id]
                                    onSuccess:^(NSArray<OIMSimpleResultInfo *> * _Nullable results) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### kickGroupMember（移除组成员）

被踢者收到OnJoinedGroupDeleted

群成员收到OnGroupMemberDeleted 

```
        [OIMManager.manager kickGroupMember:@"" // group id 
                                     reason:@""
                                       uids:@[@""] // user id
                                  onSuccess:^(NSArray<OIMSimpleResultInfo *> * _Nullable results) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### getGroupMembersInfo（查询组成员信息）

```
        [OIMManager.manager getGroupMembersInfo:@"" // group id 
                                           uids:@[@""] // user id
                                      onSuccess:^(NSArray<OIMGroupMemberInfo *> * _Nullable groupMembersInfo) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### getGroupMemberList（组成员列表）

```
        [OIMManager.manager getGroupMemberList:@"" // group id
                                        filter:0   // 1普通成员, 2群主，3管理员
                                        offset:0   // 偏移量，每次开始的index值
                                         count:20  // 每次拉取的数量
                                     onSuccess:^(NSArray<OIMGroupMemberInfo *> * _Nullable groupMembersInfo) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### getJoinedGroupList（获取已加入的群组）

```
        [OIMManager.manager getJoinedGroupListWithOnSuccess:^(NSArray<OIMGroupInfo *> * _Nullable groupsInfo) {

        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### createGroup（创建组）

初始成员收到OnJoinedGroupAdded

```
        OIMGroupCreateInfo *t = [OIMGroupCreateInfo new]; // 相关属性，去看下头文件
        t.groupName = @"x的群";
        t.introduction = @"群的简介";
        
        OIMGroupMemberBaseInfo *m1 = [OIMGroupMemberBaseInfo new];
        m1.userID = @"" // 邀请的群成员;
        m1.roleLevel = OIMGroupMemberRoleMember;
        
        [OIMManager.manager createGroup:t
                             memberList:@[m1]
                              onSuccess:^(OIMGroupInfo * _Nullable groupInfo) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];

```



#### setGroupInfo（修改组信息）

群成员收到OnGroupInfoChanged

```
        OIMGroupBaseInfo *t = [OIMGroupBaseInfo new]; // 相关属性，去看下头文件
        t.introduction = @"这是一个大群";
        
        [OIMManager.manager setGroupInfo:@"" // group id
                               groupInfo:t
                               onSuccess:^(NSString * _Nullable data) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### getGroupsInfo（根据id查询组信息）

```
        [OIMManager.manager getGroupsInfo:@[@""] // group id
                                onSuccess:^(NSArray<OIMGroupInfo *> * _Nullable groupsInfo) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### joinGroup（申请入群组）

需要通过管理员同意。

申请者收到OnGroupApplicationAdded

群主+管理员收到OnGroupApplicationAdded 

```
        [OIMManager.manager joinGroup:@"" // group id
                               reqMsg:@""
                            onSuccess:^(NSString * _Nullable data) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### quitGroup（退出组）

退出者收到OnJoinedGroupDeleted

群成员收到OnGroupMemberDeleted

```
        [OIMManager.manager quitGroup:@"" // group id
                            onSuccess:^(NSString * _Nullable data) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### transferGroupOwner（群转让）

```
        [OIMManager.manager transferGroupOwner:@"" // group id 
                                      newOwner:@"" // user id
                                     onSuccess:^(NSString * _Nullable data) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### getRecvGroupApplicationList（收到的入群申请）

作为群主或者管理员，获取收到的群成员申请进群列表。

```
        [OIMManager.manager getGroupApplicationListWithOnSuccess:^(NSArray<OIMGroupApplicationInfo *> * _Nullable groupsInfo) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### getSendGroupApplicationList（发出的入群申请）

```
        [OIMManager.manager getSendGroupApplicationListWithOnSuccess:^(NSArray<OIMGroupApplicationInfo *> * _Nullable groupsInfo) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### acceptGroupApplication（接受入群申请）

申请者收到OnJoinedGroupAdded  OnGroupApplicationAccepted

群成员（不包括申请者）收到OnGroupMemberAdded

审批者（群主或者管理员）收到OnGroupMemberAdded OnGroupApplicationAccepted

```
        [OIMManager.manager acceptGroupApplication:@""    // group id
                                        fromUserId:@""    // 申请人 user id
                                         handleMsg:@"ok"  // 备注
                                         onSuccess:^(NSString * _Nullable data) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### refuseGroupApplication（拒绝入群申请）

申请者收到OnGroupApplicationRejected

审批者（群主或者管理员）收到OnGroupApplicationRejected 

```
        [OIMManager.manager refuseGroupApplication:@""    // group id
                                        fromUserId:@""    // 申请人 user id
                                         handleMsg:@"ok"  // 备注
                                         onSuccess:^(NSString * _Nullable data) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### dismissGroup（解散群）

```
        [OIMManager.manager dismissGroup:@"" // group id
                               onSuccess:^(NSString * _Nullable data) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
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
        [OIMManager.manager changeGroupMemberMute:@"" // 组ID
                                           userID:@"" // 群成员userID
                                     mutedSeconds:1   // 禁言时长s
                                        onSuccess:^(NSString * _Nullable data) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### setGroupMemberNickname（修改成员组昵称）

```
        [OIMManager.manager setGroupMemberNickname:@"" // 组ID
                                            userID:@"" // 群成员userID
                                     groupNickname:@"群昵称"
                                         onSuccess:^(NSString * _Nullable data) {

        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];

```



#### searchGroups（搜索群）

```
        OIMSearchGroupParam *param = [OIMSearchGroupParam new]; // 更多搜索条件，看头文件
        param.isSearchGroupName = YES;
        param.keywordList = @[@"test"];
        
        [OIMManager.manager searchGroups:param
                               onSuccess:^(NSArray<OIMGroupInfo *> * _Nullable groupsInfo) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### setGroupMemberRoleLevel（设置群成员角色）

```
        [OIMManager.manager setGroupMemberRoleLevel:@"GROUP_ID"
                                             userID:@"OTHER_USER_ID"
                                          roleLevel:OIMGroupMemberRoleAdmin
                                          onSuccess:^(NSString * _Nullable data) {

        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### getGroupMemberListByJoinTime（根据加入时间分页获取组成员列表）
```
        [OIMManager.manager getGroupMemberListByJoinTimeFilter:@"GROUP_ID"
                                                        offset:0
                                                         count:100
                                                 joinTimeBegin:[NSDate new].timeIntervalSince1970
                                                   joinTimeEnd:[NSDate new].timeIntervalSince1970
                                              filterUserIDList:@[] // 排除的人员id
                                                     onSuccess:^(NSArray<OIMGroupMemberInfo *> * _Nullable groupMembersInfo) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

}];
```


#### setGroupVerification（进群验证设置选项）
```
        [OIMManager.manager setGroupVerification:@"GROUP_ID"
                                needVerification:OIMGroupVerificationTypeDirectly
                                       onSuccess:^(NSString * _Nullable data) {

        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```
