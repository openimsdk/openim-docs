# 获取群组列表

- 调用 getJoinedGroupList 可以获取已加入的群列表。

```objc
        [OIMManager.manager getJoinedGroupListWithOnSuccess:^(NSArray<OIMGroupInfo *> * _Nullable groupsInfo) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];

```

# 群组管理

## 创建群组

- 您可以在创建群组的同时初始化群的信息，例如群简介、群头像、以及最初的几个群成员等，

```objc
        OIMGroupCreateInfo *t = [OIMGroupCreateInfo new];
        t.groupName = @"";
        t.introduction = @"";
        
        OIMGroupMemberBaseInfo *m1 = [OIMGroupMemberBaseInfo new];
        m1.userID = @"";
        m1.roleLevel = OIMGroupMemberRoleMember;
        
        [OIMManager.manager createGroup:t
                             memberList:@[m1]
                              onSuccess:^(OIMGroupInfo * _Nullable groupInfo) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];

```

## 添加群组

- 申请加入某群组，并提供验证信息。

```objc
        [OIMManager.manager joinGroup:@""   // 组id
                               reqMsg:@""   // 入群备注信息
                            onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

## 获取入群申请

- 主动拉取管理群组的所有入群申请列表，在有新的入群申请时我们会通过初始化前设置的群组监听器`setGroupListener`中的onReceiveJoinApplication回调事件更新。

```objc
        [OIMManager.manager getGroupApplicationListWithOnSuccess:^(NSArray<OIMGroupApplicationInfo *> * _Nullable groupsInfo) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

## 处理入群申请

- 处理申请后初始化前设置的群组监听器`setGroupListener`中的onApplicationProcessed回调事件会返回处理结果给所有群管理者。

### 同意入群

```objc
        [OIMManager.manager acceptGroupApplication:@""  // 组ID
                                        fromUserId:@""  // 申请人userID
                                         handleMsg:@""  // 备注信息
                                         onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

### 拒绝入群

```objc
        [OIMManager.manager refuseGroupApplication:@""  // 组ID
                                        fromUserId:@""  // 申请人userID
                                         handleMsg:@""  // 备注信息
                                         onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

## 邀请加入群组

群内成员可批量邀请好友加入用户已加入的群组。

```objc
        [OIMManager.manager inviteUserToGroup:@""   // 组ID
                                       reason:@""   // 备注信息
                                         uids:@[]   // 成员 userID 列表
                                    onSuccess:^(NSArray<OIMSimpleResultInfo *> * _Nullable results) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

## 踢出群组

群主与管理员可批量踢出群成员。

```objc
        [OIMManager.manager getGroupMembersInfo:@"" // 组ID
                                           uids:@[] // 成员 userID 列
                                      onSuccess:^(NSArray<OIMGroupMemberInfo *> * _Nullable groupMembersInfo) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

## 转让群组

- 群主可以调用 transferGroupOwner把群主转让给其他群成员，群主转让后，全员会收到 onGroupInfoChanged 回调。

  ```objc
        [OIMManager.manager transferGroupOwner:@""  // 组ID
                                      newOwner:@""  // 新 owner userID
                                     onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
  ```

## 退出群组

```objc
        [OIMManager.manager quitGroup:@""   // 组id
                            onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

## 解散群

```objc
        [OIMManager.manager dismissGroup:@""  // 群ID
                               onSuccess:^(NSString * _Nullable data) {

        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

# 群资料

## 获取群资料

```objc
        [OIMManager.manager getGroupsInfo:@[]   // 组id集合
                                onSuccess:^(NSArray<OIMGroupInfo *> * _Nullable groupsInfo) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

## 修改群资料

- 修改群资料后，全员会收到 onGroupInfoChanged 回调。

```objc
        OIMGroupBaseInfo *t = [OIMGroupBaseInfo new];
        t.introduction = @"";
        
        [OIMManager.manager setGroupInfo:@""
                               groupInfo:t
                               onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

## 群禁言

```objc
        [OIMManager.manager changeGroupMemberMute:@""  //群ID
                                           userID:@""  //userID
                                     mutedSeconds:1
                                        onSuccess:^(NSString * _Nullable data) {

        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];

        [OIMManager.manager changeGroupMute:@"" 
                                     isMute:YES
                                  onSuccess:^(NSString * _Nullable data) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

# 群成员管理

## 获取群成员列表

- 可以获取某个群的群成员列表，该列表中包含了各个群成员的资料信息。

  ```objc
        [OIMManager.manager getGroupMemberList:@""  // 组ID
                                        filter:0    // 0不过滤 1普通成员, 2群主，3管理员
                                        offset:0    // 偏移量，每次开始的index值
                                         count:200  // 每次拉取的数量
                                     onSuccess:^(NSArray<OIMGroupMemberInfo *> * _Nullable groupMembersInfo) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
  ```

## 获取群员列表

- 根据群成员id批量获取群成员资料。

  ```objc
        [OIMManager.manager getGroupMemberList:@""  // 组ID
                                        filter:0    // 0不过滤 1普通成员, 2群主，3管理员
                                        offset:0    // 偏移量，每次开始的index值
                                         count:200  // 每次拉取的数量
                                     onSuccess:^(NSArray<OIMGroupMemberInfo *> * _Nullable groupMembersInfo) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
  ```

# 群组监听回调

## 调用示例

```objc
/// IMSDK 群组事件回调
@protocol OIMGroupListener <NSObject>
@optional

/*
 *  有新成员加入群
 */
- (void)onGroupMemberAdded:(OIMGroupMemberInfo *)memberInfo;

/*
 *  有成员离开群
 */
- (void)onGroupMemberDeleted:(OIMGroupMemberInfo *)memberInfo;

/*
 *  某成员信息发生变更
 */
- (void)onGroupMemberInfoChanged:(OIMGroupMemberInfo *)changeInfo;

/*
 *  例如有邀请进群， UI列表会展示新的item
 */
- (void)onJoinedGroupAdded:(OIMGroupInfo *)groupInfo;

/*
 *  例如群里被踢， UI列表会删除这个的item
 */
- (void)onJoinedGroupDeleted:(OIMGroupInfo *)groupInfo;

/*
 *  某个已加入的群的信息被修改了
 */
- (void)onGroupInfoChanged:(OIMGroupInfo *)changeInfo;

/*
 *  群申请被接受
 */
- (void)onGroupApplicationAccepted:(OIMGroupApplicationInfo *)groupApplication;

/*
 *  有人申请加群
 */
- (void)onGroupApplicationAdded:(OIMGroupApplicationInfo *)groupApplication;

/*
 *  群申请有删除
 */
- (void)onGroupApplicationDeleted:(OIMGroupApplicationInfo *)groupApplication;

/*
 *  群申请有拒绝
 */
- (void)onGroupApplicationRejected:(OIMGroupApplicationInfo *)groupApplication;

@end
```

