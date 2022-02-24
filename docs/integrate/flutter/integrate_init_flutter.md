# 初始化

初始化SDK的listener（OnInitSDKListener）回调是在调用login方法后才开始进行。

```
  // Initialize SDK
    OpenIM.iMManager
      ..initSDK(
        platform: Platform.isAndroid ? IMPlatform.android : IMPlatform.ios,
        ipApi: '',
        ipWs: '',
        dbPath: '',
        listener: OnInitSDKListener(
          onConnecting: () {},
          onConnectFailed: (code, error) {},
          onConnectSuccess: () {},
          onKickedOffline: () {},
          onUserSigExpired: () {},
          onSelfInfoUpdated: (user) {},
        ),
      )

      // Add message listener (remove when not in use)
      ..messageManager.addAdvancedMsgListener(OnAdvancedMsgListener(
        onRecvMessageRevoked: (msgId) {},
        onRecvC2CReadReceipt: (list) {},
        onRecvNewMessage: (msg) {},
      ))

      // Set up message sending progress listener
      ..messageManager.setMsgSendProgressListener(OnMsgSendProgressListener(
        onProgress: (msgId, progress) {},
      ))

      // Set up friend relationship listener
      ..friendshipManager.setFriendshipListener(OnFriendshipListener(
        onBlackListAdd: (u) {},
        onBlackListDeleted: (u) {},
        onFriendApplicationListAccept: (u) {},
        onFriendApplicationListAdded: (u) {},
        onFriendApplicationListDeleted: (u) {},
        onFriendApplicationListReject: (u) {},
        onFriendInfoChanged: (u) {},
        onFriendListAdded: (u) {},
        onFriendListDeleted: (u) {},
      ))

      // Set up conversation listener
      ..conversationManager.setConversationListener(OnConversationListener(
        onConversationChanged: (list) {},
        onNewConversation: (list) {},
        onTotalUnreadMessageCountChanged: (count) {},
        onSyncServerFailed: () {},
        onSyncServerFinish: () {},
        onSyncServerStart: () {},
      ))

      // Set up group listener
      ..groupManager.setGroupListener(OnGroupListener(
        onApplicationProcessed: (groupId, opUser, agreeOrReject, opReason) {},
        onGroupCreated: (groupId) {},
        onGroupInfoChanged: (groupId, info) {},
        onMemberEnter: (groupId, list) {},
        onMemberInvited: (groupId, opUser, list) {},
        onMemberKicked: (groupId, opUser, list) {},
        onMemberLeave: (groupId, info) {},
        onReceiveJoinApplication: (groupId, info, opReason) {},
      ));
```

- 初始化监听回调事件

| event              | 说明          |
| ------------------ | ------------- |
| onConnectFailed    | 连接失败      |
| onConnectSuccess   | 连接成功      |
| onConnecting       | 连接中        |
| onKickedOffline    | 被踢下线      |
| onSelfInfoUpdated  | 修改个人信息  |
| onUserTokenExpired | 账号token过期 |

- 会话监听回调列表

| event                            | 说明             |
| -------------------------------- | ---------------- |
| onConversationChanged            | 会话列表改变     |
| onNewConversation                | 新会话           |
| onSyncServerFailed               | -                |
| onSyncServerFinish               | -                |
| onSyncServerStart                | -                |
| onTotalUnreadMessageCountChanged | 消息未读总数改变 |

- 消息状态监听回调列表

| event                | 说明             |
| -------------------- | ---------------- |
| onRecvNewMessage     | 接收到新消息     |
| onRecvMessageRevoked | 其他用户撤回通知 |
| onRecvC2CReadReceipt | 对方实时已读通知 |

- 群组监听回调列表

| event                    | 说明           |
| ------------------------ | -------------- |
| onApplicationProcessed   | 入群申请被处理 |
| onGroupCreated           | 群组创建       |
| onGroupInfoChanged       | 群组信息改变   |
| onMemberEnter            | 新成员加入群组 |
| onMemberInvited          | 邀请成员加入   |
| onMemberKicked           | 踢出成员       |
| onMemberLeave            | 成员退群       |
| onReceiveJoinApplication | 收到入群申请   |

- 好友监听回调列表

| event                          | 说明             |
| ------------------------------ | ---------------- |
| onBlackListAdd                 | 添加黑名单       |
| onBlackListDeleted             | 移除黑名单       |
| onFriendApplicationListAccept  | 接受好友请求     |
| onFriendApplicationListAdded   | 好友请求列表增加 |
| onFriendApplicationListDeleted | 好友请求列表减少 |
| onFriendApplicationListReject  | 拒绝好友请求     |
| onFriendInfoChanged            | 好友信息更新     |
| onFriendListAdded              | 好友列表增加     |
| onFriendListDeleted            | 好友列表减少     |
