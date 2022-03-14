# 用户资料管理

## 获取用户资料

可通过ID批量获取用户资料，在登录成功后可调用该接口获取当前登录用户资料。

```objc
        [OIMManager.manager getUsersInfo:@[] // 用户ID数组
                               onSuccess:^(NSArray<OIMUserInfo *> * _Nullable userInfos) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

## 修改当前登录用户资料

可修改当前登录用户资料，只需要传入要修改的资料字段即可。

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

# 用户关系链

当前SDK逻辑在发送单聊消息的时候，默认不检查好友关系，即非好友也可以进行收发消息，如果用户需要先加客服为好友才能进行沟通非常不方便，因此该默认设置常用于在线客服等场景。

## 获取好友列表

获取当前登录用户好友列表。

```objc
        [OIMManager.manager getFriendListWithOnSuccess:^(NSArray<OIMFullUserInfo *> * _Nullable userInfos) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

## 设置好友备注

给某个好友添加备注，在好友界面或会话界面可通过判断comment是否为空来决定展示好友昵称还是备注。

```objc
        [OIMManager.manager setFriendRemark:@"" // 好友userID
                                     remark:@"" // 备注名
                                  onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

## 添加好友

向某个用户发送添加好友的申请，同时可向对方传达验证信息。

```objc
        [OIMManager.manager addFriend:@""   // 用户id
                           reqMessage:@""    // 发起好友申请的描述信息
                            onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

## 获取好友申请

获取所有好友请求列表。

```objc
        [OIMManager.manager getFriendApplicationListWithOnSuccess:^(NSArray<OIMFriendApplication *> * _Nullable friendApplications) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

## 处理好友申请

### 同意好友请求

```objc
        [OIMManager.manager acceptFriendApplication:@"" // userID
                                          handleMsg:@"" // 信息
                                          onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

### 拒绝好友申请

```objc
        [OIMManager.manager refuseFriendApplication:@"" // userID
                                          handleMsg:@"" // 信息
                                          onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

## 拉入黑名单

```objc
        [OIMManager.manager addToBlackList:@"" // 用户userID
                                 onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

## 获取黑名单列表

获取所有黑名单列表。

```objc
        [OIMManager.manager getBlackListWithOnSuccess:^(NSArray<OIMFullUserInfo *> * _Nullable userInfos) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

## 移除黑名单

将某个用户移除黑名单列表。

```objc
        [OIMManager.manager removeFromBlackList:@"" // userID
                                      onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

## 删除好友

删除某个好友会将其从好友列表中删除，并将与该好友直接的聊天消息清空，但会在会话列表中保留会话，是否删除可根据自身业务决定，若需要删除可调用`deleteConversation`进行删除。并且该删除操作为单向好友删除。

```objc
        [OIMManager.manager deleteFriend:@""    // userID
                                  onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

## 好友监听回调

### 调用示例

```objc
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
```
