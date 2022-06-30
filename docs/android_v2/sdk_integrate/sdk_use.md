



#### 1，导入包

    implementation 'io.openim:android-sdk:version@aar'
    implementation 'io.openim:core-sdk:version@aar'
	SDK版本号参考：https://github.com/OpenIMSDK/Open-IM-SDK-Android

#### 2，初始化

```
    /**
     * 初始化sdk
     * 注：在创建图片，语音，视频，文件等需要路径参数的消息体时，
     * 如果选择的是非全路径方法如：createSoundMessage（全路径方法为：createSoundMessageFromFullPath）,
     * 需要将文件自行拷贝到dbPath目录下，如果此时文件路径为 apath+"/sound/a.mp3"，则参数path的值为：/sound/a.mp3。
     * 如果选择的全路径方法，路径为你文件的实际路径不需要再拷贝。
     *
     * @param apiUrl        SDK的API接口地址。如：http:xxx:10000
     * @param wsUrl         SDK的web socket地址。如： ws:xxx:17778
     * @param storageDir    数据存储目录路径
     * @param logLevel      日志等级，如：6
     * @param objectStorage 图片上传配置 如：cos
     * @param listener      SDK初始化监听
     * @return boolean   true成功; false失败
     */
    public boolean initSDK(String apiUrl, String wsUrl, String storageDir, int logLevel, String objectStorage, OnConnListener listener)

/**
 * 只有在调用sdk的login方法后才开始回调
 */
public interface OnConnListener {

    /**
     * 连接服务器失败
     * 可以提示用户当前网络连接不可用
     */
    void onConnectFailed(long code, String error);

    /**
     * 已经成功连接到服务器
     */
    void onConnectSuccess();

    /**
     * 正在连接到服务器
     * 适合在 UI 上展示“正在连接”状态。
     */
    void onConnecting();

    /**
     * 当前用户被踢下线
     * 此时可以 UI 提示用户“您已经在其他端登录了当前账号，是否重新登录？”
     */
    void onKickedOffline();

    /**
     * 登录票据已经过期
     * 请使用新签发的 UserSig 进行登录。
     */
    void onUserTokenExpired();
}

```

#### 3，设置监听器

```
 OpenIMClient.getInstance().userInfoManager.setOnUserListener(new OnUserListener() {
            @Override
            public void onSelfInfoUpdated(UserInfo info) {
                // 当前登录用户资料变更回调
            }
        });

OpenIMClient.getInstance().messageManager.setAdvancedMsgListener(new OnAdvanceMsgListener() {
            @Override
            public void onRecvNewMessage(Message msg) {
                // 收到新消息，界面添加新消息
                           }

            @Override
            public void onRecvC2CReadReceipt(List<ReadReceiptInfo> list) {
                // 消息被阅读回执，将消息标记为已读
                          }

            @Override
            public void onRecvMessageRevoked(String msgId) {
                // 消息成功撤回，从界面移除消息
               
            }

            @Override
            public void onRecvGroupMessageReadReceipt(List<ReadReceiptInfo> list) {
                // 消息被阅读回执，将消息标记为已读
              
            }
        });

 OpenIMClient.getInstance().friendshipManager.setOnFriendshipListener(new OnFriendshipListener() {
            @Override
            public void onBlacklistAdded(BlacklistInfo u) {
                // 拉入黑名单
            }

            @Override
            public void onBlacklistDeleted(BlacklistInfo u) {
                // 从黑名单删除
            }

            @Override
            public void onFriendApplicationAccepted(FriendApplicationInfo u) {
                // 发出或收到的好友申请已同意
            }

            @Override
            public void onFriendApplicationAdded(FriendApplicationInfo u) {
                // 发出或收到的好友申请被添加
               
            }

            @Override
            public void onFriendApplicationDeleted(FriendApplicationInfo u) {
                // 发出或收到的好友申请被删除
            }

            @Override
            public void onFriendApplicationRejected(FriendApplicationInfo u) {
                // 发出或收到的好友申请被拒绝
            }


            @Override
            public void onFriendInfoChanged(FriendInfo u) {
                // 朋友的资料发生变化
            }

            @Override
            public void onFriendAdded(FriendInfo u) {
                // 好友被添加
            }

            @Override
            public void onFriendDeleted(FriendInfo u) {
                // 好友被删除
            }
        });

 OpenIMClient.getInstance().conversationManager.setOnConversationListener(new OnConversationListener() {
            @Override
            public void onConversationChanged(List<ConversationInfo> list) {
                // 已添加的会话发生改变
               
            }

            @Override
            public void onNewConversation(List<ConversationInfo> list) {
            	  // 新增会话
               
            }

            @Override
            public void onSyncServerFailed() {
		//会话同步服务器失败
            }

            @Override
            public void onSyncServerFinish() {
		//会话同步服务器完成

            }

            @Override
            public void onSyncServerStart() {
		//会话开始同步服务器

            }

            @Override
            public void onTotalUnreadMessageCountChanged(int i) {
                // 未读消息数发送变化
               
            }
        });      

OpenIMClient.getInstance().groupManager.setOnGroupListener(new OnGroupListener() {
            @Override
            public void onGroupApplicationAccepted(GroupApplicationInfo info) {
                // 发出或收到的组申请被接受
               
            }

            @Override
            public void onGroupApplicationAdded(GroupApplicationInfo info) {
                // 发出或收到的组申请有新增
              
            }

            @Override
            public void onGroupApplicationDeleted(GroupApplicationInfo info) {
                // 发出或收到的组申请被删除
               
            }

            @Override
            public void onGroupApplicationRejected(GroupApplicationInfo info) {
                // 发出或收到的组申请被拒绝
               
            }

            @Override
            public void onGroupInfoChanged(GroupInfo info) {
                // 组资料变更
                
            }

            @Override
            public void onGroupMemberAdded(GroupMembersInfo info) {
                // 组成员进入
                           }

            @Override
            public void onGroupMemberDeleted(GroupMembersInfo info) {
                // 组成员退出
            }

            @Override
            public void onGroupMemberInfoChanged(GroupMembersInfo info) {
                // 组成员信息发生变化
            }

            @Override
            public void onJoinedGroupAdded(GroupInfo info) {
                // 创建群： 初始成员收到；邀请进群：被邀请者收到
                
            }

            @Override
            public void onJoinedGroupDeleted(GroupInfo info) {
                // 退出群：退出者收到；踢出群：被踢者收到
                
            }
        });
      
 OpenIMClient.getInstance().signalingManager.setSignalingListener(new OnSignalingListener() {
            @Override
            public void onInvitationCancelled(SignalingInfo s) {
                // 被邀请者收到：邀请者取消音视频通话
            }

            @Override
            public void onInvitationTimeout(SignalingInfo s) {
                // 邀请者收到：被邀请者超时未接通
            }

            @Override
            public void onInviteeAccepted(SignalingInfo s) {
                // 邀请者收到：被邀请者同意音视频通话
            }

            @Override
            public void onInviteeAcceptedByOtherDevice(SignalingInfo s) {

            }

            @Override
            public void onInviteeRejected(SignalingInfo s) {
                // 邀请者收到：被邀请者拒绝音视频通话
            }

            @Override
            public void onInviteeRejectedByOtherDevice(SignalingInfo s) {

            }

            @Override
            public void onReceiveNewInvitation(SignalingInfo s) {
                // 被邀请者收到：音视频通话邀请
            }

            @Override
            public void onHangup(SignalingInfo s) {

            }
        });
```

#### 4，登录

```
    /**
     * 登录
     *
     * @param uid   用户id
     * @param token 用户token
     * @param base  callback String
     */
    public void login(OnBase<String> base, String uid, String token)
```



#### 注：

1，SDK只能初始化一次。

2，在登录前必须设置各监听器， 如：好友监听，组监听，会话监听，消息监听等。

3，其他api调用必须保证登录回调成功后操作。
