# 获取会话列表

- 用户在登录后调用getAllConversationList拉取本地会话列表做 UI 展示

```objc
         [OIMManager.manager getAllConversationListWithOnSuccess:^(NSArray<OIMConversationInfo *> * _Nullable conversations) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];

```

- OpenIM SDK 会在登录成功后、用户上线后、以及断线重连后，自动更新会话列表。更新过程如下：
  - 当有会话更新时，例如新收到一条消息，SDK 会通过初始化前设置的会话监听器 `setConversationListener` 中的 [onConversationChanged] 事件通知您。
  - 当有会话新增时，SDK 会通过初始化前设置的会话监听器 `setConversationListener` 中的 [onNewConversation] 事件通知您。

# 获取会话总未读数

- 调用 getTotalUnreadMsgCount接口可以获取所有会话的未读消息总数。您不用再遍历会话列表，把单个会话的未读数相加，才能得到未读总数。当会话的未读总数发生变更的时候，SDK 会主动向您的 App 回调 [onTotalUnreadMessageCountChanged] ，把最新的未读总数通知给您。

```objc
        [OIMManager.manager getTotalUnreadMsgCountWithOnSuccess:^(NSInteger number) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

# 设置会话已读

- 将某个单聊或群聊会话置为已读状态，同时总未读数减少。

## 设置单聊会话已读

```objc
        [OIMManager.manager markC2CMessageAsRead:@""    // 接收者 userID
                                       msgIDList:@[]    // 已读的消息id列表，传空，可把未读数置为零
                                       onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

## 设置群聊会话已读

```objc
        [OIMManager.manager markGroupMessageHasRead:@"" //  组id
                                          onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

## 设置私聊会话

- 可做阅后即焚。

```objc
        [OIMManager.manager setOneConversationPrivateChat:@""
                                            isPrivate:YES
                                            onSuccess:^(NSString * _Nullable data) {
        
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

# 设置会话置顶

- 会话置顶指的是把特定的好友或者群会话固定在会话列表的最前面，用于主动设置或者取消会话置顶。

```objc
        [OIMManager.manager pinConversation:@""    // 会话id
                                   isPinned:YES     // YES：置顶；NO：取消置顶
                                  onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

# 删除会话

- 调用 [deleteConversation] 接口可以删除某个会话，删除会话时默认删除本地历史消息。

```objc
        [OIMManager.manager deleteConversation:@"" // 会话id
                                     onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];

```

# 会话监听回调

## 调用示例

```objc
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
```

