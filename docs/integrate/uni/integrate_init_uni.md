# 初始化监听器

在初始化SDK前需要先初始化部分全局监听器，初始化成功后可在合适的时机通过globalEvent对相关回调进行监听。

```js
// 会话监听
this.$openSdk.setConversationListener();
// 消息状态监听
this.$openSdk.addAdvancedMsgListener();
// 群组监听
this.$openSdk.setGroupListener()
// 好友监听
this.$openSdk.setFriendListener();
```

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



# 初始化OpenIMSDK

```js
const config = {
    platform: 1,	//平台类型
    ipApi: "http://1.14.194.38:10000",	//api域名地址
    ipWs: "ws://1.14.194.38:17778",	//websocket地址
    /**
    * ps:上述配置适合于通过ip访问  若通过域名且配置了https证书请使用如下配置方式
    * ipApi: "https://open-im.rentsoft.cn",
    * ipWs: "wss://open-im.rentsoft.cn/wss",
    */
    dbDir,	//SDK数据存放目录
}
//返回值为布尔值告知是否初始化成功
this.flag = this.$openSdk.initSDK(config);
```

- dbDir为SDK初始化目录绝对路径，可通过H5+API获取

  ```js
  plus.io.requestFileSystem(plus.io.PRIVATE_DOC, function(fs) {
  	fs.root.getDirectory(
  		"user", {
  			create: true,
  		},
  		(entry) => {
              //初始化SDK
  			...
  		},
  		(error) => {
  			console.log(error);
  		}
  	);
  });
  ```

#### 初始化SDK成功后会设置一个网络连接状态的回调监听，但回调在调用登录之后才会进行返回。

  - 初始化监听回调事件

| event              | 说明          |
| ------------------ | ------------- |
| initStatus         | 初始化状态    |
| onConnectFailed    | 连接失败      |
| onConnectSuccess   | 连接成功      |
| onConnecting       | 连接中        |
| onKickedOffline    | 被踢下线      |
| onSelfInfoUpdated  | 修改个人信息  |
| onUserTokenExpired | 账号token过期 |

