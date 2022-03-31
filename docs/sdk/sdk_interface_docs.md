# 回调说明

## 主动回调

主动回调在开发者调用OpenIM SDK函数时传入，在结果成功或者失败时回调给调用方。如果失败，则触发OnError，请关注errCode和errMsg，如果成功则返回json字符串，具体内容和格式要参考具体函数说明。

```
在主动调用sdk时，传入此回调，比如Login等
type Base interface {
   OnError(errCode int32, errMsg string)
   OnSuccess(data string)
}

```

```
在主动调用sdk发送消息时，传入此回调
type SendMsgCallBack interface {
   Base
   OnProgress(progress int)
}
```

## 被动回调（事件监听）

被动回调，也称事件监听，是指有IM事件（或通知）发生时，OpenIM SDK根据事件类型触发不同的回调函数，使得UI层能及时感知IM事件、通知和数据的变化，确保会话、消息、好友、群组等数据同步的即时性和一致性。

连接监听，在在InitSDK时传入。其它被动监听在InitSDK之后，Login之前调用响应的设置监听函数完成监听设置，分别为SetUserListener、SetFriendListener、SetGroupListener、SetConversationListener、SetAdvancedMsgListener

### 连接监听

```
连接监听，在InitSDK时传入，在IM连接状态有变化时回调
type ConnListener interface {
   OnConnecting()
   OnConnectSuccess()
   OnConnectFailed(errCode int32, errMsg string)
   OnKickedOffline()
   OnUserTokenExpired()
}
```

### 用户监听

```
用户监听，在InitSDK成功后，Login之前设置，本登录用户个人资料有变化时回调
type OnUserListener interface {
	OnSelfInfoUpdated(userInfo string)
}
```

用户资料修改： 修改者OnSelfInfoUpdated； 好友收到OnFriendInfoChanged

### 好友监听

```
群组监听，在InitSDK成功后，Login之前设置，好友相关信息有变化时回调
type OnFriendshipListener interface {
   OnFriendApplicationAdded(friendApplication string)
   OnFriendApplicationDeleted(friendApplication string)
   OnFriendApplicationAccepted(groupApplication string)
   OnFriendApplicationRejected(friendApplication string)
   OnFriendAdded(friendInfo string)
   OnFriendDeleted(friendInfo string)
   OnFriendInfoChanged(friendInfo string)
   OnBlackAdded(blackInfo string)
   OnBlackDeleted(blackInfo string)

}
```

申请添加好友：主动申请者收到OnFriendApplicationAdded  ； 被添加者收到OnReceiveFriendApplicationAdded   ok  111加222

同意好友申请：操作者收到 OnFriendApplicationAccepted OnFriendAdded； 申请者收到：OnFriendApplicationAccepted OnFriendAdded  ok

好友拒绝申请：操作者收到OnFriendApplicationRejected；申请者收到：OnFriendApplicationRejected ok

删除好友：操作者收到OnFriendDeleted  ok

修改备注：操作者收到OnFriendInfoChanged  ok

添加黑名单：操作者收到OnBlackAdded；  ok

移除黑名单：操作者收到OnBlackDeleted  ok



### 群组监听

```
群组监听，在InitSDK成功后，Login之前设置，群组相关信息有变化时回调
type OnGroupListener interface {
	OnJoinedGroupAdded(groupInfo string)
	OnJoinedGroupDeleted(groupInfo string)
	OnGroupMemberAdded(groupMemberInfo string)
	OnGroupMemberDeleted(groupMemberInfo string)

	OnGroupApplicationAdded(groupApplication string)
	OnGroupApplicationDeleted(groupApplication string)
	OnGroupInfoChanged(groupInfo string)
	OnGroupMemberInfoChanged(groupMemberInfo string)
	OnGroupApplicationAccepted(groupApplication string)
	OnGroupApplicationRejected(groupApplication string)
}
```

创建群： 初始成员收到：OnJoinedGroupAdded        验证ok   1111 创建 2222

退出群：退出者收到：OnJoinedGroupDeleted ，  群成员收到：OnGroupMemberDeleted    2222退出群    验证ok 

踢出群：被踢者收到：OnJoinedGroupDeleted ； 群成员收到：OnGroupMemberDeleted  验证ok

邀请进群：被邀请者收到：OnJoinedGroupAdded ；  群成员（不包括被邀请者）收到：OnGroupMemberAdded   1111邀请2222  验证ok 

申请加群： 申请者收到：OnGroupApplicationAdded ； 群主+管理员收到：OnReceiveJoinGroupApplicationAdded    验证ok 

同意进群： 申请者收到：OnJoinedGroupAdded   ， OnGroupApplicationAccepted；   群成员（不包括申请者）收到：OnGroupMemberAdded； 审批者（群主或者管理员）收到：OnGroupMemberAdded+OnGroupApplicationAccepted  验证ok 

拒绝进群：申请者收到：OnGroupApplicationRejected； 审批者（群主或者管理员）收到：OnGroupApplicationRejected    验证ok 

修改群资料： 群成员收到： OnGroupInfoChanged 验证ok

### 会话监听

```
会话监听，在InitSDK成功后，Login之前设置，聊天的会话有变化时回调
type OnConversationListener interface {
   OnSyncServerStart()
   OnSyncServerFinish()
   OnSyncServerFailed()
   OnNewConversation(conversationList string)
   OnConversationChanged(conversationList string)
   OnTotalUnreadMessageCountChanged(totalUnreadCount int64)
}
```

### 消息监听

```
消息监听，在InitSDK成功后，Login之前设置，聊天的消息有变化时回调
type OnAdvancedMsgListener interface {
   OnRecvNewMessage(message string)
   OnRecvC2CReadReceipt(msgReceiptList string)
   OnRecvMessageRevoked(msgId string)
   OnRecvGroupReadReceipt(groupMsgReceiptList string)
}
```



# 初始化

```
InitSDK(listener open_im_sdk_callback.ConnListener, operationID string, config string)

config是json字符串，格式为
{
"platform":1, 
"api_addr":"http://127.0.0.1:10000",
"ws_addr":"ws://127.0.0.1:17778",
"data_dir":"./",
"log_level":6, 
"object_storage":"cos"
}

```

```
字段说明

```



# 登录

```
Login(callback open_im_sdk_callback.Base, operationID string, userID, token string)
operationID建议采用随机数生成
成功时OpenIM SDK会回调callback的OnSuccess("")
开发者注意，需要等待此回调后再做其它业务逻辑，否则可能会出现异常
```



# 几大通用结构说明

```
PublicUserInfo:用户公开信息，主要是基本信息，不包括手机等其它隐私字段 
 {
        "userID": "openIM2222",
        "nickname": "2222",
        "faceURL": "https://oss.com.cn/head",
        "gender": 1
  }
```

```
FriendInfo:好友相关信息，比较全，所有信息都包括
 {
        "ownerUserID": "openIM1111",
        "userID": "openIM2222",
        "remark": "",
        "createTime": 1644466099,
        "addSource": 0,
        "operatorUserID": "openIM2222",
        "nickname": "2222",
        "faceURL": "https://oss.com.cn/head",
        "gender": 1,
        "phoneNumber": "",
        "birth": 0,
        "email": "xxxx@qq.com",
        "ex": "xxx"
  }
```

```
UserInfo 个人信息，所有信息都包括
{
"userID":"user001",
"nickname":"openIM",
"faceURL":"127.0.0.1/xx",
"gender":1,
"phoneNumber":""
"birth":222222
"email":""
"createTime":222222
"ex":
}
```



```
FriendApplication：好友申请信息，谁申请添加谁为好友，以及对申请的处理结果
{
	"fromUserID": "user002",
	"fromNickname": "my friend",
	"fromFaceURL": "xx",
	"fromGender": 1,
	"toUserID": "user002",
	"toNickname": "hh",
	"toFaceURL": "xx",
	"toGender": 1,
	"handleResult": 1,
	"reqMsg": "hi",
	"createTime": 166665545,
	"handlerUserID": "",
	"handleMsg": "",
	"handleTime": 1133131333,
	"ex": ""
}
```

```
BlackInfo：黑名单信息，黑名单用户基本信息，注意黑名单是双向关系。
 {
        "ownerUserID": "openIM1111",
        "userID": "openIM2222",
        "nickname": "2222",
        "faceURL": "https://oss.com.cn/head",
        "gender": 1,
        "createTime": 0,
        "addSource": 0,
        "operatorUserID": "",
        "ex": ""
  }
	
```



```
FullUserInfo ： 整合了PublicUserInfo， FriendInfo和BlackInfo 
getuserinfo时，
如果是好友，publicInfo和friendInfo会设置，
如果是黑名单，publicinfo和blackInfo会设置
如果即时好友，也是黑名单，则publicInfo， friendInfo，blackInfo都会设置

getfriend时
如果是黑名单，则friendInfo和blackInfo会设置， 但publicInfo不设置

getblack时，
如果是好友，则blackInfo和friendInfo会设置，但publicInfo不设置

{
    "publicInfo": {
        "userID": "openIM2222",
        "nickname": "2222",
        "faceURL": "https://oss.com.cn/head",
        "gender": 1
    },
    "friendInfo": {
        "ownerUserID": "openIM1111",
        "userID": "openIM2222",
        "remark": "",
        "createTime": 1644466099,
        "addSource": 0,
        "operatorUserID": "openIM2222",
        "nickname": "2222",
        "faceURL": "https://oss.com.cn/head",
        "gender": 1,
        "phoneNumber": "",
        "birth": 0,
        "email": "xxxx@qq.com",
        "ex": "xxx"
    },
    "blackInfo": {
        "ownerUserID": "openIM1111",
        "userID": "openIM2222",
        "nickname": "2222",
        "faceURL": "https://oss.com.cn/head",
        "gender": 1,
        "createTime": 0,
        "addSource": 0,
        "operatorUserID": "",
        "ex": ""
    }
}


```



```
GroupInfo: 群组信息
{
	"groupID": "111111222222",
	"groupName": "test group",
	"notification": "hello",
	"introduction": "this is test group chat",
	"faceURL": "xx",
	"ownerUserID": "user001",
	"createTime": 0,
	"memberCount": 2,
	"status": 0,
	"creatorUserID": "user001",
	"groupType": 0,
	"ex": ""
}
```



```
GroupMemberInfo:群成员信息
{
	"groupID": "1112221222333",
	"userID": "user002",
	"nickname": "open",
	"faceURL": "xx",
	"roleLevel": 1,
	"joinTime": 0,
	"joinSource": 0,
	"operatorUserID": "user001",
	"ex": ""
}
```



```
GroupApplicationInfo:申请进群信息
{
	"groupID": "111111222222",
	"groupName": "test group",
	"notification": "hello",
	"introduction": "this is test group chat",
	"groupFaceURL": "xx",
	"createTime": "user001",
	"status": 0,
	"creatorUserID": "user001",
	"groupType": 0,
	"ownerUserID": "user001",
	"memberCount": 1,
	"userID": "user001",
	"nickname": "sk",
	"userFaceURL": "xx",
	"gender": 1,
	"handleResult": 1,
	"reqMsg": "come in",
	"handledMsg": "ok",
	"reqTime": 0,
	"handleUserID": "user001",
	"handledTime": 0,
	"ex": ""
}
```



```
ConversationInfo:会话信息
{
    "conversationID": "group_8609c4fa2f49cc449ae905d63da56840", 
    "conversationType": 2, 
    "userID": "", 
    "groupID": "8609c4fa2f49cc449ae905d63da56840", 
    "showName": "", 
    "faceURL": "", 
    "recvMsgOpt": 0, 
    "unreadCount": 1, 
    "groupAtType": 0, 
    "latestMsg": "", 
    "latestMsgSendTime": 1644387061568, 
    "draftText": "", 
    "draftTextTime": 0, 
    "isPinned": false, 
    "attachedInfo":"",
    "ex": ""
}
```



```
MessageInfo:聊天记录信息
{
    "clientMsgID": "56938acc45b1ac7c418018b516d3d4fe", 
    "serverMsgID": "73918c4a8644ad83f9b08413f7649e7b", 
    "createTime": 1647497342434, 
    "sendTime": 1647497342891, 
    "sessionType": 2, 
    "sendID": "13412345678", 
    "recvID": "13412345678", 
    "msgFrom": 100, 
    "contentType": 101, 
    "platformID": 2, 
    "senderNickname": "Gordon", 
    "senderFaceUrl": "ic_avatar_04", 
    "groupID": "cb7aaa8e5f83d92db2ed1573cd01870c", 
    "content": "664655", 
    "seq": 20, 
    "isRead": true, 
    "status": 2, 
    "offlinePush": { }, 
    "attachedInfo": "{\"groupHasReadInfo\":{\"hasReadUserIDList\":[\"17777777777\"],\"hasReadCount\":1}}", 
    "ex": "", 
    "pictureElem": {
        "sourcePath": "", 
        "sourcePicture": {
            "uuid": "", 
            "type": "", 
            "size": 0, 
            "width": 0, 
            "height": 0, 
            "url": ""
        }, 
        "bigPicture": {
            "uuid": "", 
            "type": "", 
            "size": 0, 
            "width": 0, 
            "height": 0, 
            "url": ""
        }, 
        "snapshotPicture": {
            "uuid": "", 
            "type": "", 
            "size": 0, 
            "width": 0, 
            "height": 0, 
            "url": ""
        }
    }, 
    "soundElem": {
        "uuid": "", 
        "soundPath": "", 
        "sourceUrl": "", 
        "dataSize": 0, 
        "duration": 0
    }, 
    "videoElem": {
        "videoPath": "", 
        "videoUUID": "", 
        "videoUrl": "", 
        "videoType": "", 
        "videoSize": 0, 
        "duration": 0, 
        "snapshotPath": "", 
        "snapshotUUID": "", 
        "snapshotSize": 0, 
        "snapshotUrl": "", 
        "snapshotWidth": 0, 
        "snapshotHeight": 0
    }, 
    "fileElem": {
        "filePath": "", 
        "uuid": "", 
        "sourceUrl": "", 
        "fileName": "", 
        "fileSize": 0
    }, 
    "mergeElem": {
        "title": "", 
        "abstractList": null, 
        "multiMessage": null
    }, 
    "atElem": {
        "text": "", 
        "atUserList": null, 
        "isAtSelf": false
    }, 
    "faceElem": {
        "index": 0, 
        "data": ""
    }, 
    "locationElem": {
        "description": "", 
        "longitude": 0, 
        "latitude": 0
    }, 
    "customElem": {
        "data": "", 
        "description": "", 
        "extension": ""
    }, 
    "quoteElem": {
        "text": "", 
        "quoteMessage": null
    }, 
    "notificationElem": {
        "detail": "", 
        "defaultTips": ""
    }, 
    "attachedInfoElem": {
        "groupHasReadInfo": {
            "hasReadUserIDList": [
                "17777777777"
            ], 
            "hasReadCount": 1
        }
    }
}
```



# 用户相关接口

```
GetUsersInfo(callback open_im_sdk_callback.Base, operationID string, userIDList string)
说明：获取某些用户的公开资料
请求：userIDList： userID列表
回调：成功时，OnSuccess回调FullUserInfo列表 
```

```
SetSelfInfo(callback open_im_sdk_callback.Base, operationID string, userInfo string)
说明：设置登录用户的相关资料
请求：为UserInfo

回调：成功时，OnSuccess回调""

```

```
GetSelfUserInfo(callback open_im_sdk_callback.Base, operationID string) 
说明：设置登录用户相关资料
请求：
回调：成功时，OnSuccess回调UserInfo
```





# 好友及黑名单相关接口

```
GetDesignatedFriendsInfo(callback open_im_sdk_callback.Base, operationID string, userIDList string)
说明：获取指定好友列表的相关信息
请求：userIDList: userID列表
回调:成功时，OnSuccess回调FullUserInfo列表
```

```
GetFriendList(callback open_im_sdk_callback.Base, operationID string)
说明：获取所有好友的相关信息
请求：
回调:成功时，OnSuccess回调FullUserInfo列表
```

```
CheckFriend(callback open_im_sdk_callback.Base, operationID string, userIDList string)
说明：检查是否好友关系，即是否在登录用户的好友列表中。注意：好友是双向关系。
请求：userIDList: userID列表
回调:成功时，OnSuccess回调此结构的列表，result为1表示好友（并且不是黑名单）
{
"userID":"user001",
"result":1
}
```

```
AddFriend(callback open_im_sdk_callback.Base, operationID string, userIDReqMsg string)
说明：添加好友申请
请求：userIDReqMsg为
{
"toUserID":"user002",
"reqMsg":"hello"
}
回调:成功时，OnSuccess回调""

```

```
SetFriendRemark(callback open_im_sdk_callback.Base, operationID string, userIDRemark string)
说明：设置好友备注
请求：userIDRemark为
{
	"toUserID": "user002",
	"remark": "my friend"
}
回调:成功时，OnSuccess回调""
```

```
DeleteFriend(callback open_im_sdk_callback.Base, operationID string, friendUserID string)
说明：删除好友，好友是双向关系，此函数仅仅删除自己的好友
请求：friendUserID为好友UserID
回调:成功时，OnSuccess回调""
```

```
GetRecvFriendApplicationList(callback open_im_sdk_callback.Base, operationID string) 
说明：获取收到的好友申请，即哪些人申请加我为好友
请求：
回调:成功时，OnSuccess回调FriendApplication列表

```



```
GetSendFriendApplicationList(callback open_im_sdk_callback.Base, operationID string)
说明：获取我发出去的好友申请，即我主动申请添加哪些人为好友
请求：
回调:成功时，OnSuccess回调FriendApplication列表

```

```
AcceptFriendApplication(callback open_im_sdk_callback.Base, operationID string, userIDHandleMsg string)
说明：同意某人的好友申请
请求：userIDHandleMsg为
{
	"toUserID": "user001",
	"handleMsg": "ok"
}
回调:成功时，OnSuccess回调""
```

```
RefuseFriendApplication(callback open_im_sdk_callback.Base, operationID string, userIDHandleMsg string) 
说明：拒绝某人的好友申请
请求：userIDHandleMsg为
{
	"toUserID": "user001",
	"handleMsg": "ok"
}
回调:成功时，OnSuccess回调""
```

```
AddBlack(callback open_im_sdk_callback.Base, operationID string, blackUserID string)
说明：添加黑名单
请求：blackUserID为要添加黑名单的UserID
回调:成功时，OnSuccess回调""
```

```
GetBlackList(callback open_im_sdk_callback.Base, operationID string) 
说明：获取黑名单资料列表
请求：
回调:成功时，OnSuccess回调FullUserInfo列表
```

```
RemoveBlack(callback open_im_sdk_callback.Base, operationID string, removeUserID string)
说明：移除黑名单
请求：removeUserID 被移除的黑名单UserID
回调:成功时，OnSuccess回调""
```

```

```

## 群组相关接口

```
CreateGroup(callback open_im_sdk_callback.Base, operationID string, groupBaseInfo string, memberList string) 
说明：创建群聊
请求：groupBaseInfo为
{
	"groupName": "test group",
	"groupType": 0
	"notification": ""
	"introduction":""
	"faceURL":""
	"ex":""
}
memberList为此结构的列表
{
	"userID": "user001",
	"roleLevel": 1
}
回调:成功时，OnSuccess回调GroupInfo
```

```
JoinGroup(callback open_im_sdk_callback.Base, operationID string, groupID, reqMsg string)
说明：申请加入某群
请求：groupID: 群ID；
reqMsg: 进群申请消息
回调:成功时，OnSuccess回调""
```

```
QuitGroup(callback open_im_sdk_callback.Base, operationID string, groupID string)
说明：退出某群
请求：
回调:成功时，OnSuccess回调""
```

```
DismissGroup(callback open_im_sdk_callback.Base, operationID string, groupID string)
说明：解散某群
请求：
回调:成功时，OnSuccess回调""
```

```
ChangeGroupMute(callback open_im_sdk_callback.Base, operationID string, groupID string, isMute bool)
说明：静音或取消禁言某群
请求：
回调:成功时，OnSuccess回调""
```

```
ChangeGroupMemberMute(callback open_im_sdk_callback.Base, operationID string, groupID, userID string, mutedSeconds int)
说明：静音或取消禁言某群成员 mutedSeconds为0时取消禁言
请求：
回调:成功时，OnSuccess回调""
```

```
GetJoinedGroupList(callback open_im_sdk_callback.Base, operationID string)
说明：获取已加入的群列表
请求：
回调:成功时，OnSuccess回调GroupInfo列表
```

```
GetJoinedGroupList(callback open_im_sdk_callback.Base, operationID string)
说明：获取已加入的群列表
请求：
回调:成功时，OnSuccess回调GroupInfo列表
```

```
GetGroupsInfo(callback open_im_sdk_callback.Base, operationID string, groupIDList string) 
说明：获取指定群信息
请求：groupIDList: GroupID列表
回调:成功时，OnSuccess回调GroupInfo列表
```

```
SetGroupInfo(callback open_im_sdk_callback.Base, operationID string, groupID string, groupInfo string) 
说明：设置群信息（群名称，群通知，群公告，群头像，以及扩展字段），管理员和群主可以操作
请求：GroupID：群ID；
groupInfo为
{
	"groupName": "test group",
	"notification": "hello",
	"introduction": "this is test group chat",
	"faceURL": "xx",
	"ex": ""
}
回调:成功时，OnSuccess回调""
```

```
GetGroupMemberList(callback open_im_sdk_callback.Base, operationID string, groupID string, filter, offset, count int32)
说明：获取群成员列表
请求：groupID：群ID；
filter：群主、管理员、普通成员；
offer：起始偏移；
count：成员个数
回调:成功时，OnSuccess回调GroupMemberInfo列表
```

```
GetGroupMembersInfo(callback open_im_sdk_callback.Base, operationID string, groupID string, userIDList string)
说明：获取指定群成员列表
请求：groupID：群ID；
userIDList：用户ID列表
回调:成功时，OnSuccess回调GroupMemberInfo列表
```

```
KickGroupMember(callback open_im_sdk_callback.Base, operationID string, groupID string, reason string, userIDList string)
说明：把某人踢出群
请求：groupID：群ID；
reason：踢人原因；
userIDList：用户ID列表
回调:成功时，OnSuccess回调此结构的列表
{
"userID":"user001",
"result":1
}
```

```
TransferGroupOwner(callback open_im_sdk_callback.Base, operationID string, groupID, newOwnerUserID string)
说明：转让群主，只有群主能操作
请求：groupID：群ID；
newOwnerUserID：新群主用户ID
回调:成功时，OnSuccess回调""
```

```
InviteUserToGroup(callback open_im_sdk_callback.Base, operationID string, groupID, reason string, userIDList string)
说明：邀请某些人进群，群里所有成员可以操作
请求：groupID：群ID；
reason：进群原因
回调:成功时，OnSuccess回调此结构的列表
{
"userID":"user001",
"result":1
}
```

```
GetRecvGroupApplicationList(callback open_im_sdk_callback.Base, operationID string)
说明：作为群主或者管理员，获取收到的群成员申请进群列表。
请求：
回调:成功时，OnSuccess回调GroupApplicationInfo的列表
```



```
AcceptGroupApplication(callback open_im_sdk_callback.Base, operationID string, groupID, fromUserID, handleMsg string)
说明：管理员或者群主同意某人进入某群
请求：groupID：群ID；
fromUserID：申请进群的用户ID；
handleMsg：处理的消息
回调:成功时，OnSuccess回调""


```



```
RefuseGroupApplication(callback open_im_sdk_callback.Base, operationID string, groupID, fromUserID, handleMsg string)
说明：管理员或者群主拒绝某人进入某群
请求：groupID：群ID；
fromUserID：申请进群的用户ID；
handleMsg：处理的消息
回调:成功时，OnSuccess回调""

```
## 会话相关接口

```
GetAllConversationList(callback open_im_sdk_callback.Base, operationID string)
说明：获取会话列表
请求：
回调:成功时，OnSuccess回调ConversationInfo的列表
```

## 

```
GetConversationListSplit(callback open_im_sdk_callback.Base, operationID string, offset, count int)
说明：分页获取会话列表
请求：
offset:起始偏移量
count:拉取会话的数量
回调:成功时，OnSuccess回调ConversationInfo的列表
```

## 

```
GetOneConversation(callback open_im_sdk_callback.Base, operationID string, sessionType int, sourceID string)
说明：获取一个会话，如果不存在会自动创建
请求：
sessionType:会话的类型，单聊为1，群聊为2
sourceID:单聊为用户ID，群聊为群ID
回调:成功时，OnSuccess回调ConversationInfo
```

```
GetConversationIDBySessionType(sourceID string, sessionType int) string
说明：获取会话ID
请求：
sourceID:单聊为用户ID，群聊为群ID
sessionType:会话的类型，单聊为1，群聊为2
返回值：会话ID
```

## 

```
GetMultipleConversation(callback open_im_sdk_callback.Base, operationID string, conversationIDList string)
说明：获取多个会话列表
请求：
conversationIDList:会话ID的列表
回调:成功时，OnSuccess回调ConversationInfo的列表
```

## 

```
DeleteConversation(callback open_im_sdk_callback.Base, operationID string, conversationID string)
说明：删除一个会话
请求：
conversationID：会话ID
回调:成功时，OnSuccess回调""
```

## 

```
SetConversationDraft(callback open_im_sdk_callback.Base, operationID string, conversationID, draftText string)
说明：设置会话的草稿
请求：
conversationID:会话ID
draftText:草稿文本，如果为""则为删除草稿
回调:成功时，OnSuccess回调""
```

## 

```
PinConversation(callback open_im_sdk_callback.Base, operationID string, conversationID string, isPinned bool)
说明：置顶会话
请求：
conversationID:会话ID
isPinned:为true时，代表置顶会话，为false时代表取消置顶
回调:成功时，OnSuccess回调""
```

## 
```
SetOneConversationPrivateChat(callback open_im_sdk_callback.Base, operationID, conversationID string, isPrivate bool)
说明：设置阅后即焚
请求:
conversationID:会话ID
isPrivate: true为开启, false为关闭
```

## 

```
GetTotalUnreadMsgCount(callback open_im_sdk_callback.Base, operationID string)
说明：获取总的消息未读数
请求：
回调:成功时，OnSuccess回调"1000"
```

## 

```
SendMessage(callback open_im_sdk_callback.SendMsgCallBack, operationID, message, recvID, groupID, offlinePushInfo string)
说明：发送消息
请求：
message:为通过Create...Message创建的MessageInfo
recvID：单聊的用户ID，如果为群聊则为""
groupID:群聊的群ID，如果为单聊则为""
offlinePushInfo:离线推送的消息为json转换后的string，结构如下
{
    "title": "", //标题
    "desc": "", //描述信息
    "ex": "", //扩展字段
    "iOSPushSound": "",//iOS的推送声音 
    "iOSBadgeCount": true//是否计入iOS的未读数
}
回调:
进度，OnProgress回调消息发送进度,整数
成功时，OnSuccess回调""
```

## 

```
SendMessageNotOss(callback open_im_sdk_callback.SendMsgCallBack, operationID string, message, recvID, groupID string, offlinePushInfo string)
说明：发送消息不通过sdk内置OSS上传多媒体文件，
请求：
message:为通过Create...MessageByURL创建的MessageInfo
recvID：单聊的用户ID，如果为群聊则为""
groupID:群聊的群ID，如果为单聊则为""
offlinePushInfo:离线推送的消息为json转换后的string，结构如下
{
    "title": "", //标题
    "desc": "", //描述信息
    "ex": "", //扩展字段
    "iOSPushSound": "",//iOS的推送声音 
    "iOSBadgeCount": true//是否计入iOS的未读数
}
回调:
进度，OnProgress回调消息发送进度,整数
成功时，OnSuccess回调""
```

## 

```
GetHistoryMessageList(callback open_im_sdk_callback.Base, operationID string, getMessageOptions string)
说明：获取历史记录
请求：
getMessageOptions:参数为json转换后的string，结构体如下：
{
    "userID": "", //拉取单个用户之间的聊天消息
    "groupID": "", //拉取群的聊天消息
    "startClientMsgID": "",// 起始的消息clientMsgID，第一次拉取为""
    "count": 20//拉取消息的数量
}
回调:成功时，OnSuccess回调MessageInfo的列表
```

## 

```
RevokeMessage(callback open_im_sdk_callback.Base, operationID string, message string)
说明：撤回一条消息
请求：
message：为MessageInfo
回调:成功时，OnSuccess回调""
```

## 

```""
TypingStatusUpdate(callback open_im_sdk_callback.Base, operationID string, recvID, msgTip string)
说明：单聊正在输入消息
请求：
recvID:接收者的ID
msgTip:自定义的提示信息为json序列化后的string
回调:成功时，OnSuccess回调""
```

## 

```
MarkC2CMessageAsRead(callback open_im_sdk_callback.Base, operationID string, userID string, msgIDList string)
说明：标记单聊消息已读
请求：
userID:用户ID
msgIDList:消息ID的列表
[
    "er4er", 
    "3er4"
]
回调:成功时，OnSuccess回调""
```

## 

```
MarkGroupMessageAsRead(callback open_im_sdk_callback.Base, groupID string, msgIDList, operationID string)
说明：标记群聊消息已读
请求：
groupID:群ID
msgIDList:消息ID的列表
[
    "er4er", 
    "3er4"
]
回调:成功时，OnSuccess回调""
```



## 

```
DeleteMessageFromLocalStorage(callback open_im_sdk_callback.Base, operationID string, message string)
说明:本地删除一条消息，卸载APP后会重新获取到
请求：
message:为MessageInfo
回调:成功时，OnSuccess回调""
```

##
```
DeleteConversationMsgFromLocalAndSvr(callback open_im_sdk_callback.Base, operationID string, conversationID string)
说明:删除该会话和该会话的远程本地消息, 卸载APP后都不会重新获取到
请求：
conversationID 为会话ID
回调:成功时，OnSuccess回调""
```

##
```
DeleteMessageFromLocalAndSvr(callback open_im_sdk_callback.Base, operationID string, message string)
说明:本地远程删除一条消息, 卸载APP后都不会重新获取到
请求：
message 为message结构体
回调:成功时，OnSuccess回调""
```

##
```
DeleteAllMsgFromLocalAndSvr(callback open_im_sdk_callback.Base, operationID string)
说明:删除本地和远程所有消息，卸载APP后都不会重新获取到
请求：
回调:成功时，OnSuccess回调""
```

##
```
DeleteAllMsgFromLocal(callback open_im_sdk_callback.Base, operationID string)
说明:删除本地所有消息，卸载APP后会重新获取到
请求：
回调:成功时，OnSuccess回调""
```

## 

```
ClearC2CHistoryMessage(callback open_im_sdk_callback.Base, operationID string, userID string)
说明：清空单聊的历史记录
请求：
userID:用户的ID
回调:成功时，OnSuccess回调""
```



```
ClearGroupHistoryMessage(callback open_im_sdk_callback.Base, operationID string, groupID string)
说明:本地删除一条消息，卸载APP后会重新获取到
请求：
groupID:群ID
回调:成功时，OnSuccess回调""
```



```
InsertSingleMessageToLocalStorage(callback open_im_sdk_callback.Base, operationID string, message, recvID, sendID string)
说明:插入一条单聊消息到本地
请求：
recvID:接收用户ID
sendID：发送者ID
回调:成功时，OnSuccess回调插入的MessageInfo
```



```
InsertGroupMessageToLocalStorage(callback open_im_sdk_callback.Base, operationID string, message, groupID, sendID string)
说明:插入一条群聊消息到本地
请求：
groupID:群ID
sendID：发送者ID
回调:成功时，OnSuccess回调插入的MessageInfo
```



```
SearchLocalMessages(callback open_im_sdk_callback.Base, operationID string, searchParam string)
说明:搜索本地消息
请求：
searchParam:参数为json转换后的string，结构体如下：
{
    "sourceID": "18090680773", //源ID,单聊为用户ID，群聊为群ID
    "sessionType": 1,  //会话类型，单聊为1，群聊为2，如果为0，则代表搜索全部
    "keywordList": [
        "78"    //搜索关键词列表，目前仅支持一个关键词搜索
    ], 
    "keywordListMatchType": 0,  //关键词匹配模式，1代表与，2代表或，暂时未用
    "senderUserIDList": [],  //指定消息发送的uid列表 暂时未用
    "messageTypeList": [],  //消息类型列表
    "searchTimePosition": 0,  //搜索的起始时间点。默认为0即代表从现在开始搜索。UTC 时间戳，单位：秒
    "searchTimePeriod": 864000,  //从起始时间点开始的过去时间范围，单位秒。默认为0即代表不限制时间范围，传24x60x60代表过去一天。
    "pageIndex": 0,  //当前页数
    "count": 0 //每页数量
}

回调:成功时，OnSuccess回调结构：
{
    "totalCount": 9, //获取到的总的消息数量
    "searchResultItems": [
        {
            "conversationID": "single_18090680773",//会话ID 
            "messageCount": 9, //这个会话下的消息数量
            "messageList": [ ] //MessageInfo的列表
        }
    ]
}
```





## 音视频通话相关

### 音视频监听回调说明

```
音视频通话监听，在login之前调用SetSignalingListener(callback open_im_sdk_callback.OnSignalingListener)设置

type OnSignalingListener interface {
	//被邀请者收到：音视频通话邀请
	OnReceiveNewInvitation(receiveNewInvitationCallback string)
	receiveNewInvitationCallback为
	{
    "opUserID": "18666662412", 
    "invitation": {
        "inviterUserID": "18666662412", 
        "inviteeUserIDList": [
            "18349115126"
        ], 
        "groupID": "f2e77b9ec33e92298675ad511fdfa6ab", 
        "roomID": "room_id_111", 
        "timeout": 1000, 
        "mediaType": "video", 
        "sessionType": 2
    }, 
    "offlinePushInfo": { }
}

	
	//邀请者收到：被邀请者同意音视频通话
	OnInviteeAccepted(inviteeAcceptedCallback string)
	inviteeAcceptedCallback为
	{
	"opUserID": "18349115126",
	"invitation": {
		"inviterUserID": "18666662412",
		"inviteeUserIDList": ["18349115126"],
		"groupID": "f2e77b9ec33e92298675ad511fdfa6ab",
		"roomID": "room_id_111",
		"timeout": 1000,
		"mediaType": "video",
		"sessionType": 2
	},
	"offlinePushInfo": {}
}

	
	//邀请者收到：被邀请者拒绝音视频通话
	OnInviteeRejected(inviteeRejectedCallback string)
	inviteeRejectedCallback为
	{
	"opUserID": "18349115126",
	"invitation": {
		"inviterUserID": "18666662412",
		"inviteeUserIDList": ["18349115126"],
		"groupID": "f2e77b9ec33e92298675ad511fdfa6ab",
		"roomID": "room_id_111",
		"timeout": 1000,
		"mediaType": "video",
		"sessionType": 2
	},
	"offlinePushInfo": {}
}

	//被邀请者收到：邀请者取消音视频通话
	OnInvitationCancelled(invitationCancelledCallback string)
	invitationCancelledCallback为
	{
    "opUserID": "18666662412", 
    "invitation": {
        "inviterUserID": "18666662412", 
        "inviteeUserIDList": [
            "18349115126"
        ], 
        "roomID": "room_id_111", 
        "timeout": 10, 
        "mediaType": "video", 
        "platformID": 1, 
        "sessionType": 1
    }, 
    "offlinePushInfo": { }
}
	//邀请者收到：被邀请者超时未接通
	OnInvitationTimeout(invitationTimeoutCallback string)
	invitationTimeoutCallback为
	{
	"opUserID": "18666662412",
	"invitation": {
		"inviterUserID": "18666662412",
		"inviteeUserIDList": ["18349115126"],
		"roomID": "room_id_111",
		"timeout": 10,
		"mediaType": "video",
		"platformID": 1,
		"sessionType": 1
	},
	"offlinePushInfo": {}
}
	
//被邀请者（其他端）收到：比如被邀请者在手机拒接，在pc上会收到此回调
OnInviteeRejectedByOtherDevice(inviteeRejectedCallback string)
//被邀请者（其他端）收到：比如被邀请者在手机接听，在pc上会收到此回调
OnInviteeAcceptedByOtherDevice(inviteeAcceptedCallback string)
```



### 音视频邀请invitationInfo结构说明

```
音视频邀请相关信息
{
		"inviterUserID": "18666662412",  //邀请者UserID
		"inviteeUserIDList": ["18349115126"], //被邀请者UserID列表，如果是单聊只有一个元素
		"groupID": "f2e77b9ec33e92298675ad511fdfa6ab", //如果是单聊，为""
		"roomID": "room_id_111", //房间ID，必须唯一，可以不设置。
		"timeout": 1000, //邀请超时时间（秒）
		"mediaType": "video", //video 或者audio
		"sessionType": 2 //1为单聊，2为群聊
		"platformID":1 //和之前定义一致
	}
	
	metadata是参与者信息具体为
	ParticipantMetaData
	{
		GroupInfo //为群通话时有效
		GroupMemberInfo //为群通话时有效
		PublicUserInfo
	}
	
	  
```

### 音视频函数参数及回调说明

```
SignalingInvite(callback open_im_sdk_callback.Base, operationID string, signalInviteReq string)
说明：邀请个人加入音视频
请求参数：
{
	"invitation": {
		"inviteeUserIDList": ["18349115126"],  //只有一个元素
		"roomID": "room_id_111",
		"timeout": 1000,
		"mediaType": "video",
		"sessionType": 1,
		"platformID":1
	}
	"offlinePushInfo":{}
}

回调：成功时，OnSuccess回调
{
	"token": "18666662412",
	"roomID": "room_id_111",
	"liveURL": "ws://43.128.5.63:7880"
}

```



```
SignalingInviteInGroup(callback open_im_sdk_callback.Base, operationID string, signalInviteInGroupReq string)
说明：邀请群里某些人加入音视频
请求参数
{
	"invitation": {
		"inviteeUserIDList": ["18349115126"],
		"groupID": "f2e77b9ec33e92298675ad511fdfa6ab",
		"roomID": "room_id_111",
		"timeout": 1000,
		"mediaType": "video",
		"sessionType": 2
	}
}

回调：成功时，OnSuccess回调
{
	"token": "18666662412",
	"roomID": "room_id_111",
	"liveURL": "ws://43.128.5.63:7880"
}
```



```
SignalingAccept(callback open_im_sdk_callback.Base, operationID string, signalAcceptReq string)
说明：同意某人音视频邀请
请求参数
{
    "opUserID": "18349115126", 
    "invitation": {
        "inviterUserID": "18666662412", 
        "inviteeUserIDList": [
            "18349115126"
        ], 
        "groupID": "f2e77b9ec33e92298675ad511fdfa6ab", 
        "roomID": "room_id_111", 
        "timeout": 1000, 
        "mediaType": "video", 
        "sessionType": 2
    }
}

回调：成功时，OnSuccess回调
OnSuccess
{
    "token": "18349115126", 
    "roomID": "room_id_111", 
    "liveURL": "ws://43.128.5.63:7880"
}

```

```
SignalingReject(callback open_im_sdk_callback.Base, operationID string, signalRejectReq string) 
说明：拒绝某人音视频邀请
请求参数
{
    "opUserID": "18349115126", 
    "invitation": {
        "inviterUserID": "18666662412", 
        "inviteeUserIDList": [
            "18349115126"
        ], 
        "groupID": "f2e77b9ec33e92298675ad511fdfa6ab", 
        "roomID": "room_id_111", 
        "timeout": 1000, 
        "mediaType": "video", 
        "sessionType": 2
    }
}
回调：成功时，OnSuccess回调
OnSuccess{}

```



```
SignalingCancel(callback open_im_sdk_callback.Base, operationID string, signalCancelReq string)
说明：邀请者取消音视频通话
请求参数
{
	"opUserID": "18666662412",
	"invitation": {
		"inviterUserID": "18666662412",
		"inviteeUserIDList": ["18349115126"],
		"roomID": "room_id_111",
		"timeout": 10,
		"mediaType": "video",
		"platformID": 1,
		"sessionType": 1
	}
}

回调：成功时，OnSuccess回调
OnSuccess{}
```



## demo相关接口

```
url:http://43.128.5.63:42233/auth/code
说明：发送验证码
请求：
{
    "email": "", 
    "phoneNumber": "", 
    "operationID": ""
}
返回：
{
    "errCode": 0, 
    "errMsg": "", 
    "data": {
        "account": ""
    }
}
errCode为0代表发送成功
```

## 

```
url:http://43.128.5.63:42233/auth/verify
说明：验证码验证
请求：
{
    "email": "", 
    "phoneNumber": "", 
    "verificationCode":"",
    "operationID": ""
}
返回：
{
    "errCode": 0, 
    "errMsg": "", 
    "data": {
        "account": ""
    }
}
errCode为0代表验证成功
```

## 



```
url:http://43.128.5.63:42233/auth/password
说明：注册用户设置密码
请求：
{
    "email": "", 
    "phoneNumber": "", 
    "verificationCode":"",
    "password":"",
    "platform":1,
    "operationID": ""
}
返回：
{
    "errCode": 0, 
    "errMsg": "", 
    "data": {
        "userID": "",
        "token":"",
        "expiredTime":1525456
    }
}
errCode为0代表注册成功
```

## 



```
url:http://43.128.5.63:42233/auth/login
说明：登录验证
请求：
{
    "email": "", 
    "phoneNumber": "", 
    "password":"",
    "platform":1,
    "operationID": ""
}
返回：
{
    "errCode": 0, 
    "errMsg": "", 
    "data": {
        "userID": "",
        "token":"",
        "expiredTime":1525456
    }
}
errCode为0代表验证获取token成功
```

demo:错误码说明

```
NoError              = 0     //正常
FormattingError      = 10001 //参数错误
HasRegistered        = 10002 //用户已经注册
NotRegistered        = 10003 //用户还未注册
PasswordErr          = 10004 //密码输入错误
GetIMTokenErr        = 10005 //获取IMtoken错误
RepeatSendCode       = 10006 //验证码重复发送
MailSendCodeErr      = 10007 //邮件发送验证码错误
SmsSendCodeErr       = 10008 //短信发送验证码错误
CodeInvalidOrExpired = 10009 //验证码无效或者已经过期
RegisterFailed       = 10010 //注册失败
```
