#### UserInfo（用户信息）

```
/// 用户id
String userID;

/// 用户昵称
String nickname;

/// 头像
String faceURL;

/// 性别
int gender;

/// 手机号
String phoneNumber;

/// 出生时间
int birth;

/// 邮箱
String email;

/// 扩展字段
String ex;

/// 创建时间
int createTime;

/// 备注
String remark;

/// 用户公开的资料
PublicUserInfo publicInfo;

/// 好友才能查看的资料
FriendInfo friendInfo;

/// 黑名单资料
BlacklistInfo blackInfo;

/// 是否好友关系
boolean isFriendship;

/// 是否黑名单
boolean isBlacklist;

/// 全局免打扰 0：正常；1：不接受消息；2：接受在线消息不接受离线消息；
int globalRecvMsgOpt;
```



#### ConversationInfo（会话信息）

```
/// 会话ID
String conversationID;

/// 会话类型[ConversationType]
int conversationType;

/// 参与会话的userID
String userID;

/// 参与会话的groupID
String groupID;

/// 昵称
String showName;

/// 头像
String faceURL;

/// 免打扰 0：正常；1：不接受消息；2：接受在线消息不接受离线消息；
int recvMsgOpt;

/// 未读消息数
int unreadCount;

/// 强制提示，[GroupAtType]包含@所有人，@个人以及公告提示
int groupAtType;

/// 会话最新消息内容
Message latestMsg;

/// 最新消息发送时间
int latestMsgSendTime;

/// 草稿
String draftText;

/// 草稿生成时间
int draftTextTime;

/// 是否置顶
boolean isPinned;

/// 是否开启了私聊（阅后即焚）
boolean isPrivateChat;

/// 附加内容
String ext;

/// 是否还在组内，如果退群返回true
boolean isNotInGroup;
```



#### GroupInfo（组信息）

```
/// 群ID
String groupID;

/// 群名
String groupName;

/// 群公告
String notification;

/// 群简介
String introduction;

/// 群头像
String faceURL;

/// 拥有者ID
String ownerUserID;

/// 创建时间
int createTime;

/// 群成员数
int memberCount;

/// 群状态：0正常，1被封，2解散，3禁言
int status;

/// 创建者ID
String creatorUserID;

/// 群类型
int groupType;

/// 扩展字段
String ex;

/// 进群验证方式[GroupVerification]
int needVerification;
```



#### Message（消息）

```
/// 消息id，唯一标识
String clientMsgID;

/// 服务端生成的id
String serverMsgID;

/// 创建时间
int createTime;

/// 发送时间
int sendTime;

/// 会话类型[ConversationType]
int sessionType;

/// 发送者id
String sendID;

/// 接收者id
String recvID;

/// 来源
int msgFrom;

/// 消息类型[MessageType]
int contentType;

/// 平台[Platform]
int platformID;

/// 发送者昵称
String senderNickname;

/// 发送者头像
String senderFaceUrl;

/// 群ID
String groupID;

/// 消息内容
String content;

/// 消息的seq
int seq;

/// 是否已读
boolean isRead;

/// 已读时间
int hasReadTime;

/// 消息发送状态[MessageStatus]
int status;

/// 离线显示内容
OfflinePushInfo offlinePush;

/// 附加信息
String attachedInfo;

/// 扩展信息
String ex;

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



#### 其他请参照SDK内有详细注释