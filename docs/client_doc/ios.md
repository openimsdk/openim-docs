## SDK使用步骤

##### 1，初始化

```objc
/* 初始化
 * @param platform 平台
 * @param apiAddr    SDK的api地。如http:xxx:10000
 * @param wsAddr     SDK的web socket地址。如： ws:xxx:17778
 * @param dataDir    数据存储路径，默认documents下
 * @param logLevel   默认6
 * @param oss        默认cos，minio填写'minio'
 */
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths.firstObject stringByAppendingString:@"/"];
    
    BOOL initSuccess = [OIMManager.manager initSDK:iOS
                                           apiAdrr:@"xxxx:10000"
                                            wsAddr:@"xxxx:17778"
                                           dataDir:path
                                          logLevel:6
                                     objectStorage:nil
                                      onConnecting:^{
        NSLog(@"\nconnecting");
    } onConnectFailure:^(NSInteger code, NSString * _Nullable msg) {
        NSLog(@"\n connect failure");
    } onConnectSuccess:^{
        NSLog(@"\nconnect success");
    } onKickedOffline:^{
        NSLog(@"\nkicked offline");
    } onUserTokenExpired:^{
        NSLog(@"\nuser token expired");
    }];
    
    NSLog(@"初始化成功与否：%d", initSuccess);
```

##### 切换到前台

```objc
    [OIMManager.manager wakeUpWithOnSuccess:^(NSString * _Nullable data) {
        
    } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        
    }];
```

##### 2，设置监听器：两种方式，protocol方式如下，addListner以后，移除之前会一直收到回掉；block方式，参照OIMCallbacker+Closure.h。

```
/// IMSDK 主核心回调
@protocol OIMSDKListener <NSObject>
@optional
/*
 *  SDK 正在连接到服务器
 */
- (void)onConnecting;

/*
 * SDK 已经成功连接到服务器
 */
- (void)onConnectSuccess;

/*
 * SDK 连接服务器失败
 */
- (void)onConnectFailed:(NSInteger)code err:(NSString*)err;

/*
 * 当前用户被踢下线，此时可以 UI 提示用户
 */
- (void)onKickedOffline;

/*
 * 在线时票据过期：此时您需要生成新的 UserToken 并再次重新登录。
 */
- (void)onUserTokenExpired;

@end

/// 资料关系链回调
@protocol OIMFriendshipListener <NSObject>
@optional

/*
 *  好友申请新增通知
 */
- (void)onFriendApplicationAdded:(OIMFriendApplication *)application;

/*
 *  好友申请被拒绝
 */
- (void)onFriendApplicationRejected:(OIMFriendApplication *)application;

/*
 *  好友申请被接受
 */
- (void)onFriendApplicationAccepted:(OIMFriendApplication *)application;

/*
 *  好友申请被删除
 */
- (void)onFriendApplicationDeleted:(OIMFriendApplication *)application;

/*
 *  好友新增通知
 */
- (void)onFriendAdded:(OIMFriendInfo *)info;

/*
 *  好友删除通知
 */
- (void)onFriendDeleted:(OIMFriendInfo *)info;

/*
 *  好友资料变更通知
 */
- (void)onFriendInfoChanged:(OIMFriendInfo *)info;

/*
 *  黑名单新增通知
 */
- (void)onBlackAdded:(OIMBlackInfo *)info;

/*
 *  黑名单删除通知
 */
- (void)onBlackDeleted:(OIMBlackInfo *)info;

@end

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

@protocol OIMConversationListener <NSObject>
@optional

/*
 * 同步服务器会话开始
 */
- (void)onSyncServerStart;

/*
 * 同步服务器会话完成
 */
- (void)onSyncServerFinish;

/*
 * 同步服务器会话失败
 */
- (void)onSyncServerFailed;

/*
 * 有新的会话
 */
- (void)onNewConversation:(NSArray <OIMConversationInfo *> *) conversations;

/*
 * 某些会话的关键信息发生变化（
 */
- (void)onConversationChanged:(NSArray <OIMConversationInfo *> *)conversations;

/*
 * 会话未读总数变更通知
 */
- (void)onTotalUnreadMessageCountChanged:(NSInteger) totalUnreadCount;

@end

/// 高级消息监听器
@protocol OIMAdvancedMsgListener <NSObject>
@optional

/*
 *  收到新消息
 */
- (void)onRecvNewMessage:(OIMMessageInfo *)msg;

/*
 *  群聊消息已读回执
 */
- (void)onRecvGroupReadReceipt:(NSArray<OIMReceiptInfo *> *)groupMsgReceiptList;

/*
 *  单聊消息已读回执
 */
- (void)onRecvC2CReadReceipt:(NSArray<OIMReceiptInfo *> *)receiptList;

/*
 *  收到消息撤回
 */
- (void)onRecvMessageRevoked:(NSString *)msgID;


/// 音视频监听器
@protocol OIMSignalingListener <NSObject>
@optional

/*
 *  被邀请者收到：音视频通话邀请
 */
- (void)onReceiveNewInvitation:(OIMSignalingInfo *)invitaion;

/*
 *  邀请者收到：被邀请者同意音视频通话
 */
- (void)onInviteeAccepted:(OIMSignalingInfo *)invitaion;

/*
 *  邀请者收到：被邀请者拒绝音视频通话
 */
- (void)onInviteeRejected:(OIMSignalingInfo *)invitaion;

/*
 *  被邀请者收到：邀请者取消音视频通话
 */
- (void)onInvitationCancelled:(OIMSignalingInfo *)invitaion;

/*
 *  邀请者收到：被邀请者超时未接通
 */
- (void)onInvitationTimeout:(OIMSignalingInfo *)invitaion;

/*
 *  被邀请者（其他端）收到：比如被邀请者在手机拒接，在pc上会收到此回调
 */
- (void)onInviteeRejectedByOtherDevice:(OIMSignalingInfo *)invitaion;

/*
 *  被邀请者（其他端）收到：比如被邀请者在手机拒接，在pc上会收到此回调
 */
- (void)onInviteeAcceptedByOtherDevice:(OIMSignalingInfo *)invitaion;

@end

```
###### block方式
```
    [OIMManager.callbacker setSelfUserInfoUpdateListener:^(OIMUserInfo * _Nullable userInfo) {
        
    }];
    
    [OIMManager.callbacker setConversationListenerWithOnSyncServerStart:^{
        
    } onSyncServerFinish:^{
        
    } onSyncServerFailed:^{
        
    } onConversationChanged:^(NSArray<OIMConversationInfo *> * _Nullable conversations) {
        
    } onNewConversation:^(NSArray<OIMConversationInfo *> * _Nullable conversations) {
        
    } onTotalUnreadMessageCountChanged:^(NSInteger number) {
        
    }];
    
    [OIMManager.callbacker setFriendListenerWithOnBlackAdded:^(OIMBlackInfo * _Nullable blackInfo) {
        
    } onBlackDeleted:^(OIMBlackInfo * _Nullable blackInfo) {
        
    } onFriendApplicationAccepted:^(OIMFriendApplication * _Nullable friendApplication) {
        
    } onFriendApplicationAdded:^(OIMFriendApplication * _Nullable friendApplication) {
        
    } onFriendApplicationDeleted:^(OIMFriendApplication * _Nullable friendApplication) {
        
    } onFriendApplicationRejected:^(OIMFriendApplication * _Nullable friendApplication) {
        
    } onFriendInfoChanged:^(OIMFriendInfo * _Nullable friendInfo) {
        
    } onFriendAdded:^(OIMFriendInfo * _Nullable friendInfo) {
        
    } onFriendDeleted:^(OIMFriendInfo * _Nullable friendInfo) {
        
    }];
    
    [OIMManager.callbacker setGroupListenerWithOnGroupInfoChanged:^(OIMGroupInfo * _Nullable groupInfo) {
        
    } onJoinedGroupAdded:^(OIMGroupInfo * _Nullable groupInfo) {
        
    } onJoinedGroupDeleted:^(OIMGroupInfo * _Nullable groupInfo) {
        
    } onGroupMemberAdded:^(OIMGroupMemberInfo * _Nullable groupMemberInfo) {
        
    } onGroupMemberDeleted:^(OIMGroupMemberInfo * _Nullable groupMemberInfo) {
        
    } onGroupMemberInfoChanged:^(OIMGroupMemberInfo * _Nullable groupMemberInfo) {
        
    } onGroupApplicationAdded:^(OIMGroupApplicationInfo * _Nullable groupApplication) {
        
    } onGroupApplicationDeleted:^(OIMGroupApplicationInfo * _Nullable groupApplication) {
        
    } onGroupApplicationAccepted:^(OIMGroupApplicationInfo * _Nullable groupApplication) {
        
    } onGroupApplicationRejected:^(OIMGroupApplicationInfo * _Nullable groupApplication) {
        
    }];
    
    [OIMManager.callbacker setAdvancedMsgListenerWithOnRecvMessageRevoked:^(NSString * _Nullable item) {
        
    } onRecvC2CReadReceipt:^(NSArray<OIMReceiptInfo *> * _Nullable msgReceiptList) {
        
    } onRecvNewMessage:^(OIMMessageInfo * _Nullable message) {
    }];
```

##### 3，登录

```objc
        [OIMManager.manager login:@"" // uid来自于自身业务服务器
                            token:@""  // token需要业务服务器根据secret向OpenIM服务端交换获取
                        onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```



## 方法名、参数、返回值说明

- ##### logout（ 登出）

```objc
        [OIMManager.manager logoutWithOnSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### getLoginUserInfo（获取当前登录用户的资料）

```objc
        [OIMManager.manager getSelfInfoWithOnSuccess:^(OIMUserInfo * _Nullable userInfo) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### getLoginUserID（获取当前登录用户的ID）

```objc
     [OIMManager.manager getLoginUid]
```

- ##### getUsersInfo（根据用户ID批量获取用户信息）

```objc
        [OIMManager.manager getUsersInfo:@[] // 用户ID数组
                               onSuccess:^(NSArray<OIMUserInfo *> * _Nullable userInfos) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### setSelfInfo（修改当前用登录户资料）

会触发当用户的onSelfInfoUpdated回调，以及好友的onFriendInfoChanged、onConversationChanged回调。

```objc
        OIMUserInfo *info = [OIMUserInfo new];
        info.nickname = @"nickname";
        info.email = @"xx@xx.com";
        info.faceURL = @"xxxx";
        
        [OIMManager.manager setSelfInfo:info
                              onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### getAllConversationList（获取所有会话）

```objc
         [OIMManager.manager getAllConversationListWithOnSuccess:^(NSArray<OIMConversationInfo *> * _Nullable conversations) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### getConversationListSplit（分页获取会话）

```objc
        [OIMManager.manager getConversationListSplitWithOffset:0 // 偏移量，如：第1页，offet：0，count：20；第2页：offset：20； 
                                                         count:20   // 每页数量
                                                     onSuccess:^(NSArray<OIMConversationInfo *> * _Nullable conversations) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### getOneConversation（获取一个会话，如果不存在会自动创建）

```objc
        [OIMManager.manager getOneConversationWithSessionType:OIMConversationTypeC2C // OIMConversationType
                                                     sourceID:@"" // 如果是单聊值传userID，如果是群聊groupID
                                                    onSuccess:^(OIMConversationInfo * _Nullable conversation) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### getMultipleConversation（根据会话id查询会话）

```objc
        [OIMManager.manager getMultipleConversation:@[]
                                          onSuccess:^(NSArray<OIMConversationInfo *> * _Nullable conversations) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### deleteConversation（根据会话id删除指定会话)

会触onTotalUnreadMessageCountChanged回调

```objc
        [OIMManager.manager deleteConversation:@"" // 会话id
                                     onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### setConversationDraft（设置会话草稿）

会触onConversationChanged回调

```objc
        [OIMManager.manager setConversationDraft:@""    // 会话id
                                       draftText:@""  // 草稿
                                       onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### pinConversation（置顶会话）

会触onConversationChanged回调

```objc
        [OIMManager.manager pinConversation:@""    // 会话id
                                   isPinned:YES     // YES：置顶；NO：取消置顶
                                  onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### markGroupMessageHasRead（标记群会话已读，清除未读数）

会触onConversationChanged、onTotalUnreadMessageCountChanged回调

```objc
        [OIMManager.manager markGroupMessageHasRead:@"" //  组id
                                          onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### getTotalUnreadMsgCount（获取未读消息总数）

```objc
        [OIMManager.manager getTotalUnreadMsgCountWithOnSuccess:^(NSInteger number) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### getConversationIDBySessionType（查询会话id）

```objc
        [OIMManager.manager getConversationIDBySessionType:OIMConversationTypeGroup // OIMConversationType
                                              sourceID:@""]; // 如果是单聊值传userID，如果是群聊groupID
```

- ##### setConversationRecvMessageOpt（设置免打扰模式）

```objc
        [OIMManager.manager setConversationRecvMessageOpt:@[]   // 会话id列表
                                                   status:OIMReceiveMessageOptReceive    // 1：不接受消息；2：接受在线消息不接受离线消息；0：正常
                                                onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### getConversationRecvMessageOpt（查询免打扰状态）

```objc
        [OIMManager.manager getConversationRecvMessageOpt:@[]   // 会话id列表
                                                onSuccess:^(NSArray<OIMConversationNotDisturbInfo *> * _Nullable conversations) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### （设置私聊会话，可做阅后即焚）

```objc
        [OIMManager.manager setOneConversationPrivateChat:@""
                                            isPrivate:YES
                                            onSuccess:^(NSString * _Nullable data) {
        
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```


- ##### addFriend（发起好友申请）

主动申请者收到OnFriendApplicationAdded

被添加者收到OnFriendApplicationAdded 

```objc
        [OIMManager.manager addFriend:@""   // 用户id
                           reqMessage:@""    // 发起好友申请的描述信息
                            onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### checkFriend（检查是否是好友）

```objc
        [OIMManager.manager checkFriend:@[] // userID 列表
                              onSuccess:^(NSArray<OIMSimpleResultInfo *> * _Nullable results) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### deleteFriend（删除好友）

操作者收到OnFriendDeleted

```objc
        [OIMManager.manager deleteFriend:@""    // userID
                                  onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### setFriendRemark（好友备注设置）

操作者收到OnFriendInfoChanged

```objc
        [OIMManager.manager setFriendRemark:@"" // 好友userID
                                     remark:@"" // 备注名
                                  onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### getFriendList（好友列表）

返回的数据里包含已拉入黑名单的好友，可以根据isBlacklist字段筛选。

```objc
        [OIMManager.manager getFriendListWithOnSuccess:^(NSArray<OIMFullUserInfo *> * _Nullable userInfos) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### getRecvFriendApplicationList（收到的好友申请）

```objc
        [OIMManager.manager getFriendApplicationListWithOnSuccess:^(NSArray<OIMFriendApplication *> * _Nullable friendApplications) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### getSendFriendApplicationList（发出的好友申请）

```objc
        [OIMManager.manager getSendFriendApplicationListWithOnSuccess:^(NSArray<OIMFriendApplication *> * _Nullable friendApplications) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### addBlacklist（拉黑好友）

操作者收到OnBlackAdded

```objc
        [OIMManager.manager addToBlackList:@"" // 用户userID
                                 onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### getBlacklist（黑名单）

```objc
        [OIMManager.manager getBlackListWithOnSuccess:^(NSArray<OIMFullUserInfo *> * _Nullable userInfos) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### removeBlacklist（移除黑名单）

操作者收到OnBlackDeleted

```objc
        [OIMManager.manager removeFromBlackList:@"" // userID
                                      onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### acceptFriendApplication（接受好友申请）

操作者收到OnFriendApplicationAccepted、OnFriendAdded

申请者收到OnFriendApplicationAccepted、OnFriendAdded

```objc
        [OIMManager.manager acceptFriendApplication:@"" // userID
                                          handleMsg:@"" // 信息
                                          onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### refuseFriendApplication（拒绝好友申请）

操作者收到OnFriendApplicationRejected

申请者收到OnFriendApplicationRejected 

```objc
        [OIMManager.manager refuseFriendApplication:@"" // userID
                                          handleMsg:@"" // 信息
                                          onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### inviteUserToGroup（邀请进组）

直接进组无需同意。

被邀请者收到OnJoinedGroupAdded

群成员（不包括被邀请者）收到OnGroupMemberAdded 

```objc
        [OIMManager.manager inviteUserToGroup:@""   // 组ID
                                       reason:@""   // 备注信息
                                         uids:@[]   // 成员 userID 列表
                                    onSuccess:^(NSArray<OIMSimpleResultInfo *> * _Nullable results) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### kickGroupMember（移除组成员）

被踢者收到OnJoinedGroupDeleted

群成员收到OnGroupMemberDeleted 

```objc
        [OIMManager.manager kickGroupMember:@"" // 组ID
                                     reason:@"" // 备注信息
                                       uids:@[] // 成员 userID 列表
                                  onSuccess:^(NSArray<OIMSimpleResultInfo *> * _Nullable results) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### getGroupMembersInfo（查询组成员信息）

```objc
        [OIMManager.manager getGroupMembersInfo:@"" // 组ID
                                           uids:@[] // 成员 userID 列
                                      onSuccess:^(NSArray<OIMGroupMemberInfo *> * _Nullable groupMembersInfo) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### getGroupMemberList（组成员列表）

```objc
        [OIMManager.manager getGroupMemberList:@""  // 组ID
                                        filter:0    // 0不过滤 1普通成员, 2群主，3管理员
                                        offset:0    // 偏移量，每次开始的index值
                                         count:200  // 每次拉取的数量
                                     onSuccess:^(NSArray<OIMGroupMemberInfo *> * _Nullable groupMembersInfo) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### getJoinedGroupList（获取已加入的群组）

```objc
        [OIMManager.manager getJoinedGroupListWithOnSuccess:^(NSArray<OIMGroupInfo *> * _Nullable groupsInfo) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### createGroup（创建组）

初始成员收到OnJoinedGroupAdded

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

- ##### setGroupInfo（修改组信息）

群成员收到OnGroupInfoChanged

```objc
        OIMGroupBaseInfo *t = [OIMGroupBaseInfo new];
        t.introduction = @"";
        
        [OIMManager.manager setGroupInfo:@""
                               groupInfo:t
                               onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### getGroupsInfo（根据id查询组信息）

```objc
        [OIMManager.manager getGroupsInfo:@[]   // 组id集合
                                onSuccess:^(NSArray<OIMGroupInfo *> * _Nullable groupsInfo) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### joinGroup（申请入群组）

需要通过管理员同意。

申请者收到OnGroupApplicationAdded

群主+管理员收到OnGroupApplicationAdded 

```objc
        [OIMManager.manager joinGroup:@""   // 组id
                               reqMsg:@""   // 入群备注信息
                            onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### quitGroup（退出组）

退出者收到OnJoinedGroupDeleted

群成员收到OnGroupMemberDeleted

```objc
        [OIMManager.manager quitGroup:@""   // 组id
                            onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### transferGroupOwner（群转让）

```objc 
        [OIMManager.manager transferGroupOwner:@""  // 群ID
                                      newOwner:@""  // 新 owner userID
                                     onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### getRecvGroupApplicationList（收到的入群申请）

作为群主或者管理员，获取收到的群成员申请进群列表。

```objc
        [OIMManager.manager getGroupApplicationListWithOnSuccess:^(NSArray<OIMGroupApplicationInfo *> * _Nullable groupsInfo) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### getSendGroupApplicationList（发出的入群申请）

```objc
        [OIMManager.manager getSendGroupApplicationListWithOnSuccess:^(NSArray<OIMGroupApplicationInfo *> * _Nullable groupsInfo) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### (解散群)

```objc
        [OIMManager.manager dismissGroup:@""  // 群ID
                               onSuccess:^(NSString * _Nullable data) {

        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### (群禁言)

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


- ##### acceptGroupApplication（接受入群申请）

申请者收到OnJoinedGroupAdded  OnGroupApplicationAccepted

群成员（不包括申请者）收到OnGroupMemberAdded

审批者（群主或者管理员）收到OnGroupMemberAdded OnGroupApplicationAccepted

```objc
        [OIMManager.manager acceptGroupApplication:@""  // 组ID
                                        fromUserId:@""  // 申请人userID
                                         handleMsg:@""  // 备注信息
                                         onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### refuseGroupApplication（拒绝入群申请）

申请者收到OnGroupApplicationRejected

审批者（群主或者管理员）收到OnGroupApplicationRejected 

```objc
        [OIMManager.manager refuseGroupApplication:@""  // 组ID
                                        fromUserId:@""  // 申请人userID
                                         handleMsg:@""  // 备注信息
                                         onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### sendMessage（发送消息）

```objc
        OIMMessageInfo testMessage = [OIMMessageInfo createTextMessage:[@"TEST" stringByAppendingFormat:@"%d", arc4random() % 1000]];
        [OIMManager.manager sendMessage:testMessage // 消息体
                                 recvID:@"" // 接受消息的userID
                                groupID:@"" // 接受消息的群ID
                        offlinePushInfo:nil // 离线推送的消息备
                              onSuccess:^(NSString * _Nullable data) {
            //  这里特别注意下，返回的这个message 需要替换创建的消息体。做撤回等动作需要这个新的消息体
            //  自行将data转换成OIMMessageInfo对象，切记
            testMessage = [OIMMessageInfo objectFromJson:data];
        } onProgress:^(NSInteger number) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### getHistoryMessageList（获取聊天记录）

```objc
        [OIMManager.manager getHistoryMessageListWithUserId:@"" // 单聊对象的userID
                                                    groupID:@"" // 群聊的组id
                                           startClientMsgID:nil
                                                      count:200 // 每次拉取的数量
                                                  onSuccess:^(NSArray<OIMMessageInfo *> * _Nullable messages) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

注：消息列表list，index == list.length - 1 是最新的一条消息。 index == 0 是从最新的这条记录后的第199条。所以startMsg首次传null，

- ##### revokeMessage（撤回消息）

撤回成功需要当前用户从列表里移除Message然后更新ui，而另外一方通过撤回监听（onRecvMessageRevoked）移除。

```objc
        [OIMManager.manager revokeMessage:nil   // 消息体
                                onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- #####（删除消息）

```objc
        [OIMManager.manager deleteMessageFromLocalStorage:nil   // 消息体
                                                onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];

        [OIMManager.manager deleteAllMsgFromLocalAndSvrWithOnSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];

        [OIMManager.manager deleteAllMsgFromLocalWithOnSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### insertSingleMessageToLocalStorage（向本地插入一条消息）

```objc
        [OIMManager.manager insertSingleMessageToLocalStorage:nil   // 消息体
                                                       recvID:@""   // 接收者userID
                                                       sendID:@""   // 发送者userID
                                                    onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### markC2CMessageAsRead（标记c2c消息已读）

当调用此方法后，已读的消息会通过已读回执（onRecvC2CReadReceipt）告诉对方。

```objc
        [OIMManager.manager markC2CMessageAsRead:@""    // 接收者 userID
                                       msgIDList:@[]    // 已读的消息id列表，传空，可把未读数置为零
                                       onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### typingStatusUpdate（正在输入提示）

会通过onRecvNewMessage回调

```objc
        [OIMManager.manager typingStatusUpdate:@""  // 接收者 userID
                                        msgTip:@""  // 自定义提示内容
                                     onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### clearC2CHistoryMessage（清空c2c聊天记录）

```objc
        [OIMManager.manager clearC2CHistoryMessage:@""  // userID
                                         onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];

        [OIMManager.manager clearC2CHistoryMessageFromLocalAndSvr:@""  // userID
                                                          onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### clearGroupHistoryMessage（清空群聊天记录）

```objc
        [OIMManager.manager clearGroupHistoryMessage:@""    // 群ID
                                           onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];

        [OIMManager.manager clearGroupHistoryMessageFromLocalAndSvr:@""    // 群ID
                                                          onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### searchLocalMessages（搜索本地消息）

```objc
        OIMSearchParam *t = [OIMSearchParam new];
        t.sourceID = "";
        t.sessionType = 1;
        t.keywordList = @[];
        
        [OIMManager.manager searchLocalMessages:t
                                      onSuccess:^(OIMSearchResultInfo * _Nullable result) {

        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

- ##### (音视频信令消息)

```objc
        
/*
 * 邀请个人加入音视频
 *
 * @param invitation
 * 邀请个人加入：
    {
        "inviteeUserIDList": ["userID"],  //只有一个元素
        "roomID": "roomID",
        "timeout": 1000,
        "mediaType": "video",
        "sessionType": x,
    }
 * 邀请群里某些人加入音视频
    {
        "inviteeUserIDList": ["useID1", "userID2"],
        "groupID": "groupID",
        "roomID": "roomID",
        "timeout": 1000,
        "mediaType": "video",
        "sessionType": x
    }
 * @param offlinePushInfo 离线push消息
 */
- (void)signalingInvite:(OIMInvitationInfo *)invitation
        offlinePushInfo:(OIMOfflinePushInfo * _Nullable)offlinePushInfo
              onSuccess:(nullable OIMSignalingResultCallback)onSuccess
              onFailure:(nullable OIMFailureCallback)onFailure;


- (void)signalingInviteInGroup:(OIMInvitationInfo *)invitation
                     onSuccess:(nullable OIMSignalingResultCallback)onSuccess
                     onFailure:(nullable OIMFailureCallback)onFailure;
```

```objc
/*
 *  同意某人音视频邀请
 *  opUserID 操作人的ID
 *  invitation
    {
         "inviterUserID": "userID",
         "inviteeUserIDList": [
             "userID"
         ],
         "groupID": "groupID",
         "roomID": "roomID",
         "timeout": 1000,
         "mediaType": "video",
         "sessionType": x
     }
 */
- (void)signalingAccept:(OIMSignalingInfo *)invitation
              onSuccess:(nullable OIMSignalingResultCallback)onSuccess
              onFailure:(nullable OIMFailureCallback)onFailure;
```

```objc

/*
 *  拒绝某人音视频邀请
 *  opUserID 操作人的ID
 *  invitation
    {
         "inviterUserID": "userID",
         "inviteeUserIDList": [
             "userID"
         ],
         "groupID": "groupID",
         "roomID": "roomID",
         "timeout": 1000,
         "mediaType": "video",
         "sessionType": x
     }
 */
- (void)signalingReject:(OIMSignalingInfo *)invitation
              onSuccess:(nullable OIMSuccessCallback)onSuccess
              onFailure:(nullable OIMFailureCallback)onFailure;
```

```objc

/*
 *  取消某人音视频邀请
 *  opUserID 操作人的ID
 *  invitation
    {
         "inviterUserID": "userID",
         "inviteeUserIDList": [
             "userID"
         ],
         "groupID": "groupID",
         "roomID": "roomID",
         "timeout": 1000,
         "mediaType": "video",
         "sessionType": x
     }
 */
- (void)signalingCancel:(OIMSignalingInfo *)invitation
              onSuccess:(nullable OIMSuccessCallback)onSuccess
              onFailure:(nullable OIMFailureCallback)onFailure;
```


```objc
- (void)signalingHungUp:(OIMSignalingInfo *)invitation
              onSuccess:(nullable OIMSuccessCallback)onSuccess
              onFailure:(nullable OIMFailureCallback)onFailure;
```

- ##### createTextMessage

```objc
参看[Example](https://github.com/OpenIMSDK/Open-IM-SDK-iOS.git) 更佳
```
