#### FullUserInfo（用户信息）

```
/// 用户id
NSString *userID;

/// 用户昵称
NSString *nickname;

/// 头像
NSString *faceURL;

/// 性别
NSInteger gender;

/// 手机号
NSString *phoneNumber;

/// 出生时间
NSInteger birth;

/// 邮箱
NSString *email;

/// 扩展字段
NSString *ex;

/// 创建时间
NSInteger createTime;

/// 备注
NSString *remark;

/// 用户公开的资料
PublicUserInfo? publicInfo;

/// 好友才能查看的资料
FriendInfo? friendInfo;

/// 黑名单资料
BlacklistInfo? blackInfo;

/// 全局免打扰 0：正常；1：不接受消息；2：接受在线消息不接受离线消息；
OIMReceiveMessageOpt globalRecvMsgOpt;
```



#### ConversationInfo（会话信息）

```
/// 会话ID
String conversationID;

/// 会话类型[ConversationType]
NSInteger conversationType;

/// 参与会话的userID
NSString *userID;

/// 参与会话的groupID
NSString *groupID;

/// 昵称
NSString *showName;

/// 头像
NSString *faceURL;

/// 免打扰 0：正常；1：不接受消息；2：接受在线消息不接受离线消息；
OIMReceiveMessageOpt recvMsgOpt;

/// 未读消息数
NSInteger unreadCount;

/// 强制提示，[GroupAtType]包含@所有人，@个人以及公告提示
OIMGroupAtType groupAtType;

/// 会话最新消息内容
OIMMessageInfo latestMsg;

/// 最新消息发送时间
NSInteger latestMsgSendTime;

/// 草稿
NSString *draftText;

/// 草稿生成时间
NSInteger draftTextTime;

/// 是否置顶
Bool  isPinned;

/// 是否开启了私聊（阅后即焚）
bool isPrivateChat;

/// 附加内容
NSString *ext;

/// 是否还在组内，如果退群返回true
Bool  isNotInGroup;
```



#### GroupInfo（组信息）

```
/// 群ID
NSString *groupID;

/// 群名
NSString *groupName;

/// 群公告
NSString *notification;

/// 群简介
NSString *introduction;

/// 群头像
NSString *faceURL;

/// 拥有者ID
NSString *ownerUserID;

/// 创建时间
NSInteger createTime;

/// 群成员数
NSInteger memberCount;

/// 群状态：0正常，1被封，2解散，3禁言
NSInteger status;

/// 创建者ID
NSString *creatorUserID;

/// 群类型
NSInteger groupType;

/// 扩展字段
NSString *ex;

/// 进群验证方式[GroupVerification]
NSInteger needVerification;
```



#### Message（消息）

```
/// 消息id，唯一标识
NSString *clientMsgID;

/// 服务端生成的id
NSString *serverMsgID;

/// 创建时间
NSInteger createTime;

/// 发送时间
NSInteger sendTime;

/// 会话类型
OIMConversationType sessionType;

/// 发送者id
NSString *sendID;

/// 接收者id
NSString *recvID;

/// 来源
NSInteger msgFrom;

/// 消息类型
OIMMessageContentType contentType;

/// 平台[Platform]
NSInteger platformID;

/// 发送者昵称
NSString *senderNickname;

/// 发送者头像
NSString *senderFaceUrl;

/// 群ID
NSString *groupID;

/// 消息内容
NSString *content;

/// 消息的seq
NSInteger seq;

/// 是否已读
Bool  isRead;

/// 已读时间
NSInteger hasReadTime;

/// 消息发送状态
OIMMessageStatus status;

/// 离线显示内容
OfflinePushInfo offlinePush;

/// 附加信息
NSString *attachedInfo;

/// 扩展信息
NSString *ex;

/// 自定义扩展信息，目前用于客服端处理消息时间分段
dynamic ext;

/// 图片
PictureElem pictureElem;

/// 语音
SoundElem soundElem;

/// 视频
VideoElem videoElem;

/// 文件
FileElem fileElem;

/// @信息
AtElem atElem;

/// 位置
LocationElem locationElem;

/// 自定义
CustomElem customElem;

/// 引用
QuoteElem quoteElem;

/// 合并
MergeElem mergeElem;

/// 通知
NotificationElem notificationElem;

/// 自定义表情
FaceElem faceElem;

/// 附加信息
AttachedInfoElem attachedInfoElem;
```



#### 其他请参照SDK