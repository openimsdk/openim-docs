#### 1，添加依赖到yaml

       flutter_openim_sdk: latest

SDK版本号参考：https://pub.flutter-io.cn/packages/flutter_openim_sdk

#### 2，导入包

      import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';

#### 3，初始化

```
OpenIM.iMManager.initSDK(
    platform: 0, // 平台，参照IMPlatform类,
    apiAddr: "", // SDK的API接口地址。如：http://xxx:10000
    wsAddr: "",  // SDK的web socket地址。如： ws://xxx:17778
    dataDir: "", // 数据存储路径。如：var apath =(await getApplicationDocumentsDirectory()).path
    objectStorage: 'cos', // 图片服务器默认'cos'
    logLevel: 6, // 日志等级，默认值6
    listener: OnConnectListener(
      onConnectSuccess: () {
        // 已经成功连接到服务器
      },
      onConnecting: () {
        // 正在连接到服务器，适合在 UI 上展示“正在连接”状态。
      },
      onConnectFailed: (code, errorMsg) {
        // 连接服务器失败，可以提示用户当前网络连接不可用
      },
      onUserSigExpired: () {
        // 登录票据已经过期，请使用新签发的 UserSig 进行登录。
      },
      onKickedOffline: () {
        // 当前用户被踢下线，此时可以 UI 提示用户“您已经在其他端登录了当前账号，是否重新登录？”
      },
    ),
  ).then((value){
      if(value == true){
        // 初始化成功
      }
  });
```

#### 4，设置监听器

```
OpenIM.iMManager
      ..userManager.setUserListener(OnUserListener(
        onSelfInfoUpdated: (userInfo) {
          // 当前登录用户资料变更回调
        },
      ))
      ..messageManager.setAdvancedMsgListener(OnAdvancedMsgListener(
        onRecvNewMessage: (message) {
          // 收到新消息，界面添加新消息
        },
        onRecvMessageRevoked: (messageID) {
          // 消息成功撤回，从界面移除消息
        },
        onRecvC2CReadReceipt: (list) {
          // 消息被阅读回执，将消息标记为已读
        },
      ))
      ..messageManager.setMsgSendProgressListener(OnMsgSendProgressListener(
        onProgress: (messageID, progress) {
          // 消息发送进度回调
        },
      ))
      ..friendshipManager.setFriendshipListener(OnFriendshipListener(
        onFriendApplicationRejected: (applicationInfo) {
          // 发出或收到的好友申请被拒绝
        },
        onFriendApplicationDeleted: (applicationInfo) {
          // 发出或收到的好友申请被删除
        },
        onFriendApplicationAdded: (applicationInfo) {
          // 发出或收到的好友申请被添加
        },
        onFriendApplicationAccepted: (applicationInfo) {
          // 发出或收到的好友申请已同意
        },
        onFriendAdded: (frinedInfo) {
          // 好友被添加
        },
        onFriendDeleted: (frinedInfo) {
          // 好友被删除
        },
        onFriendInfoChanged: (frinedInfo) {
          // 朋友的资料发生变化
        },
        onBlacklistDeleted: (blackInfo) {
          // 从黑名单删除
        },
        onBlacklistAdded: (blackInfo) {
          // 拉入黑名单
        },
      ))
      ..conversationManager.setConversationListener(OnConversationListener(
        onNewConversation: (list) {
          // 新增会话
        },
        onConversationChanged: (list) {
          // 已添加的会话发送改变
        },
        onTotalUnreadMessageCountChanged: (count) {
          // 未读消息数发送变化
        },
      ))
      ..groupManager.setGroupListener(OnGroupListener(
        onGroupMemberInfoChanged: (memberInfo) {
          // 组成员信息发生变化
        },
        onGroupMemberDeleted: (memberInfo) {
          // 组成员退出
        },
        onGroupMemberAdded: (memberInfo) {
          // 组成员进入
        },
        onGroupApplicationRejected: (applicationInfo) {
          // 发出或收到的组申请被拒绝
        },
        onGroupApplicationDeleted: (applicationInfo) {
          // 发出或收到的组申请被删除
        },
        onGroupApplicationAdded: (applicationInfo) {
          // 发出或收到的组申请有新增
        },
        onGroupApplicationAccepted: (applicationInfo) {
          // 发出或收到的组申请被接受
        },
        onJoinedGroupDeleted: (groupInfo) {
          // 退出群：退出者收到；踢出群：被踢者收到
        },
        onJoinedGroupAdded: (groupInfo) {
          // 创建群： 初始成员收到；邀请进群：被邀请者收到
        },
        onGroupInfoChanged: (groupInfo) {
          // 组资料变更
        },
      ))
      ..signalingManager.setSignalingListener(OnSignalingListener(
        onReceiveNewInvitation: (info) {
          // 被邀请者收到：音视频通话邀请
        },
        onInviteeRejected: (info) {
          // 邀请者收到：被邀请者拒绝音视频通话
        },
        onInviteeAccepted: (info) {
          // 邀请者收到：被邀请者同意音视频通话
        },
        onInvitationTimeout: (info) {
          // 邀请者收到：被邀请者超时未接通
        },
        onInvitationCancelled: (info) {
          // 被邀请者收到：邀请者取消音视频通话
        },
      ));
```

#### 5，登录

```
OpenIM.iMManager.login(
      uid: "", // uid来自于自身业务服务器
      token: "", // token需要业务服务器根据secret向OpenIM服务端交换获取
    ).then((userInfo) {
      // 返回当前登录用户的资料
    });
```



#### 注：

1，SDK只能初始化一次。

2，在登录前必须设置各监听器， 如：好友监听，组监听，会话监听，消息监听等。

3，其他api调用必须保证登录回调成功后操作。
