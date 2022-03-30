# 引入SDK

```js
const im = uni.requireNativePlugin('Tuoyun-OpenIMSDK')
```

# 通用回调

### CallBack

|  Name   |  Type  |        Description        |
| :-----: | :----: | :-----------------------: |
|  data   | string |           返回值内容           |
| errMsg  | string | 错误信息(成功时返回  "",失败时返回错误信息) |
| errCode |  int   |  错误码(成功时返回  0,失败时返回错误码)   |

# 几大通用结构说明

### PublicUserInfo

```
PublicUserInfo:用户公开信息，主要是基本信息，不包括手机等其它隐私字段 
 {
        "userID": "openIM2222",
        "nickname": "2222",
        "faceURL": "https://oss.com.cn/head",
        "gender": 1
  }
```

Parameters:

|   Name   |  Type  |    Description    |
| :------: | :----: | :---------------: |
|  userID  | string |       用户id        |
| nickname | string |       用户昵称        |
| faceURL  | string |       用户头像        |
|  gender  | number | 用户性别 0:未知 1:女 2:男 |

### FriendInfo

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

Parameters:

|      Name      |  Type  |    Description    |
| :------------: | :----: | :---------------: |
|  ownerUserID   | string |       群主ID        |
|     userID     | string |       用户id        |
|     remark     | string |        备注         |
|   createTime   | number |       创建时间        |
|   addSource    | number |       添加来源        |
| operatorUserID | number |       操作者ID       |
|    nickname    | string |       用户昵称        |
|    faceURL     | string |       用户头像        |
|     gender     | number | 用户性别 0:未知 1:女 2:男 |
|  phoneNumber   | string |       用户手机号       |
|     birth      | string |       用户生日        |
|     email      | string |      用户邮箱地址       |
|       ex       | string | 用户信息扩展字段对象Json字符串 |

### UserInfo

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

Parameters:

|    Name     |  Type  |    Description    |
| :---------: | :----: | :---------------: |
|   userID    | string |       用户ID        |
|  nickname   | string |       用户昵称        |
|   faceURL   | string |       用户头像        |
|   gender    | number | 用户性别 0:未知 1:女 2:男 |
| phoneNumber | string |       用户手机号       |
|    birth    | string |       用户生日        |
|    email    | string |      用户邮箱地址       |
| createTime  | number |       创建时间        |
|     ex      | string | 用户信息扩展字段对象Json字符串 |

### FriendApplication

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

Parameters:

|     Name      |  Type  |    Description     |
| :-----------: | :----: | :----------------: |
|  fromUserID   | string |      申请者用户ID       |
| fromNickname  | string |       申请者昵称        |
|  fromFaceURL  | string |       申请者头像        |
|  fromGender   | number | 申请者性别 0:未知 1:女 2:男 |
|   toUserID    | string |       接收者ID        |
|  toNickname   | string |       接收者昵称        |
|   toFaceURL   | string |       接收者头像        |
|   toGender    | number |       接收者性别        |
| handleResult  | number |        处理状态        |
|    reqMsg     | string |        申请信息        |
|  createTime   | number |        创建时间        |
| handlerUserID | string |       处理者ID        |
|   handleMsg   | string |        回复信息        |
|  handleTime   | number |        处理时间        |
|      ex       | string |        扩展字段        |

### BlackInfo

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

Parameters:

|      Name      |  Type  |    DEscription     |
| :------------: | :----: | :----------------: |
|  ownerUserID   | string |        群主ID        |
|     userID     | string |        用户ID        |
|    nickname    | string |        用户名称        |
|    faceURL     | string |        用户头像        |
|     gender     | number | 用户性别  0:未知 1:女 2:男 |
|   createTime   | number |      移入黑名单时间       |
|   addSource    | number |        添加来源        |
| operatorUserID | number |       操作者ID        |
|       ex       | string |        扩展字段        |

### FullUserInfo

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

Parameters:

|      Name      |  Type  |    Description     |
| :------------: | :----: | :----------------: |
|  ownerUserID   | string |        群主ID        |
|     userID     | string |        用户ID        |
|    nickname    | string |        用户名称        |
|    faceURL     | string |        用户头像        |
|     gender     | number | 用户性别  0:未知 1:女 2:男 |
|  phoneNumber   | string |       用户手机号        |
|     birth      | string |       用户出生日期       |
|     email      | string |       用户邮箱号        |
|   createTime   | number |       成为好友时间       |
|   addSource    | number |        添加来源        |
| operatorUserID | number |       操作者ID        |
|     remark     | string |        好友备注        |
|       ex       | string |      用户信息扩展字段      |

### GroupInfo

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

Parameters:

|     Name      |  Type  | Description |
| :-----------: | :----: | :---------: |
|    groupID    | string |    群组ID     |
|   groupName   | string |    群组名称     |
| notification  | string |     群公告     |
| introduction  | string |     群介绍     |
|    faceURL    | string |     群头像     |
|  ownerUserID  | string |    群主ID     |
|  createTime   | number |   群组创建时间    |
|  memberCount  | number |    群成员总数    |
|    status     | number |     群状态     |
| creatorUserID | string |    创建者ID    |
|   groupType   | number |     群类型     |
|      ex       | string |    扩展字段     |

### GroupMemberInfo

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

Parameters:

|      Name      |  Type  |    Description     |
| :------------: | :----: | :----------------: |
|    groupID     | string |        群组ID        |
|     userID     | string |       群成员ID        |
|    nickname    | string |       群成员昵称        |
|    faceURL     | string |       群成员头像        |
|   roleLevel    | string | 群成员等级 1普通 2群主 3管理员 |
|    joinTime    | number |        加入时间        |
|   joinSource   | number |        加入方式        |
| operatorUserID | number |       操作者ID        |
|       ex       | string |        扩展字段        |

### GroupApplicationInfo

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

Parameters:

|     Name      |  Type  | Description |
| :-----------: | :----: | :---------: |
|    groupID    | string |     群ID     |
|   groupName   | string |     群名      |
| notification  | string |     群公告     |
| introduction  | string |     群介绍     |
| groupFaceURL  | string |     群头像     |
|  createTime   | number |    创建时间     |
|    status     | number |     群状态     |
| creatorUserID | string |    创建者ID    |
|   groupType   | number |     群类型     |
|  ownerUserID  | string |    群主ID     |
|  memberCount  | number |    群成员数     |
|    userID     | string |    申请者ID    |
|   nickname    | string |    申请者昵称    |
|  userFaceURL  | string |    申请者头像    |
|    gender     | number |    申请者性别    |
| handleResult  | number |    处理状态     |
|    reqMsg     | string |   入群申请信息    |
|  handledMsg   | string |    处理原因     |
|    reqTime    | number |    申请时间     |
| handleUserID  | string |    处理者ID    |
|  handledTime  | number |    处理时间     |
|      ex       | string |    扩展字段     |

### ConversationInfo

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

Parameters:

|       Name        |  Type  |               Description                |
| :---------------: | :----: | :--------------------------------------: |
|  conversationID   | string |                   会话ID                   |
| conversationType  | number |              会话类型 1:单聊 2:群聊              |
|      userID       | string |                 会话对象用户ID                 |
|      groupID      | string |                  会话群聊ID                  |
|     showName      | string |              会话对象(用户或群聊)名称               |
|      faceURL      | string |                用户头像或群聊头像                 |
|    recvMsgOpt     | number | 接收消息选项：<br>0:在线正常接收消息，离线时进行推送<br>1:不会接收到消息<br>2:在线正常接收消息，离线不会有推送 |
|    unreadCount    | number |                  未读消息数量                  |
|    groupAtType    |  int   |                  群聊@类型                   |
|     latestMsg     | string | 最后一条消息 [消息对象](https://doc.rentsoft.cn/#/)json字符串 |
| latestMsgSendTime | number |              最后一条消息发送时间(ns)              |
|     draftText     | string |                   会话草稿                   |
|   draftTextTime   | number |                 会话草稿设置时间                 |
|     isPinned      | number |                   是否置顶                   |
|   attachedInfo    | string |                   预留字段                   |
|        ex         | string |                   扩展字段                   |

### MessageInfo

```
MessageInfo:聊天记录信息
{
    "clientMsgID": "09501ab4ce6c6045e6de684512496cad", 
    "serverMsgID": "2022-01-24 14:18:04-openIM100-6906824559772831383", 
    "createTime": 1643005091612, 
    "sendTime": 1643005091612, 
    "sessionType": 1, 
    "sendID": "openIM100", 
    "recvID": "openIM101", 
    "msgFrom": 100, 
    "contentType": 101, 
    "platformID": 1, 
    "senderNickname": "sksksksksk", 
    "senderFaceUrl": "", 
    "groupID": "", 
    "content": "mmmmmmmmtest:Gordon->skopenIM100:openIM101:", 
    "seq": 171880, 
    "isRead": false, 
    "status": 2, 
    "offlinePush": {
        "title": "232", 
        "desc": "er", 
        "ex": "", 
        "iOSPushSound": "", 
        "iOSBadgeCount": true
    }, 
    "attachedInfo": "", 
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
    "NotificationElem": {
        "detail": "", 
        "defaultTips": ""
    }
}
```

#### Message--Parameters

|       Name       |       Type       |               Description                |
| :--------------: | :--------------: | :--------------------------------------: |
|   clientMsgID    |      string      |                  消息唯一ID                  |
|   serverMsgID    |      string      |              消息服务器ID，暂时不使用               |
|    createTime    |      number      |                  消息创建时间                  |
|     sendTime     |      number      |                  消息发送时间                  |
|   sessionType    |      number      |              会话类型 1:单聊 2:群聊              |
|      sendID      |      string      |                  发送者ID                   |
|      recvID      |      string      |                  接收者ID                   |
|     msgFrom      |      number      |      标识消息是用户级别还是系统级别 100:用户 200:系统       |
|   contentType    |      number      | 消息类型：<br>101:文本消息<br>102:图片消息<br>103:语音消息<br>104:视频消息<br>105:文件消息<br>106:@消息<br>107:合并消息<br>108:转发消息<br>109:位置消息<br>110:自定义消息<br>111:撤回消息回执<br>112:C2C已读回执<br>113:正在输入状态 |
|    platformID    |      number      | 平台类型 1:ios 2:android 3:windows 4:osx 5:web 6:mini 7:linux |
|  senderNickname  |      string      |                  发送者昵称                   |
|  senderFaceUrl   |      string      |                  发送者头像                   |
|     groupID      |      string      |                   群聊ID                   |
|     content      |      string      |                   消息内容                   |
|       seq        |      number      |                 消息唯一序列号                  |
|      isRead      |       bool       |                   是否已读                   |
|      status      |      number      |   消息状态 1:发送中 2:发送成功 3:发送失败 4:已删除 5:已撤回   |
|   offlinePush    |   offlinePush    |                  离线推送配置                  |
|   attachedInfo   |      string      |                   预留字段                   |
|        ex        |      string      |                   扩展字段                   |
|   pictureElem    |   PictureElem    |                  图片信息结构                  |
|    soundElem     |    SoundElem     |                  语音信息结构                  |
|    videoElem     |    VideoElem     |                  视频信息结构                  |
|     fileElem     |     FileElem     |                  文件信息结构                  |
|    mergeElem     |    MergeElem     |                  合并信息结构                  |
|      atElem      |      AtElem      |                  @信息结构                   |
|   locationElem   |   LocationElem   |                  位置信息结构                  |
|    customElem    |    CustomElem    |                 自定义信息结构                  |
|    quoteElem     |    QuoteElem     |                  引用消息结构                  |
| notificationElem | NotificationElem |                  通知消息结构                  |

#### offlinePush--Parameters

|     Name      |  Type  | Description |
| :-----------: | :----: | :---------: |
|     title     | string |     标题      |
|     desc      | string |    描述信息     |
|      ex       | string |    扩展字段     |
| iOSPushSound  | string |  iOS的推送声音   |
| iOSBadgeCount |  bool  | 是否计入iOS的未读数 |

#### pictureElem--Parameters

|      Name       |  Type   | Description |
| :-------------: | :-----: | :---------: |
|   sourcePath    | string  |   本地资源地址    |
|  sourcePicture  | Picture |   本地图片详情    |
|   bigPicture    | Picture |    大图详情     |
| snapshotPicture | Picture |    缩略图详情    |

#### Picture--Parameters

|  Name  |  Type  | Description |
| :----: | :----: | :---------: |
|  uuid  | string |    唯一ID     |
|  type  | string |    图片类型     |
|  size  | number |    图片大小     |
| width  | number |    图片宽度     |
| height | number |    图片高度     |
|  url   | String |   图片oss地址   |

#### soundElem--Parameters

|   Name    |  Type  | Description |
| :-------: | :----: | :---------: |
|   uuid    | string |    唯一ID     |
| soundPath | string |   本地资源地址    |
| sourceUrl | string |    oss地址    |
| dataSize  | number |    音频大小     |
| duration  | number |    音频时长     |

#### videoElem--Parameters

|      Name      |  Type  | Description |
| :------------: | :----: | :---------: |
|   videoPath    | string |  视频本地资源地址   |
|   videoUUID    | string |   视频唯一ID    |
|    videoUrl    | string |   视频oss地址   |
|   videoType    | string |    视频类型     |
|   videoSize    | number |    视频大小     |
|    duration    | number |    视频时长     |
|  snapshotPath  | string |  视频快照本地地址   |
|  snapshotUUID  | string |  视频快照唯一ID   |
|  snapshotSize  | number |   视频快照大小    |
|  snapshotUrl   | string |  视频快照oss地址  |
| snapshotWidth  | number |   视频快照宽度    |
| snapshotHeight | number |   视频快照高度    |

#### fileElem--Parameters

|   Name    |  Type  | Description |
| :-------: | :----: | :---------: |
| filePath  | string |  文件本地资源地址   |
|   uuid    | string |    唯一ID     |
| sourceUrl | string |    oss地址    |
| fileName  | string |    文件名称     |
| fileSize  | number |    文件大小     |

#### mergeElem--Parameters

|     Name     |    Type     | Description |
| :----------: | :---------: | :---------: |
|    title     |   string    |   合并消息标题    |
| abstractList | array\|null |    摘要列表     |
| multiMessage | array\|null |   合并消息列表    |

#### atElem--Parameters

|    Name    |    Type     | Description |
| :--------: | :---------: | :---------: |
|    text    |   string    |    文本消息     |
| atUserList | array\|null |   @用户ID列表   |
|  isAtSelf  |    bool     |    是否@自己    |

#### locationElem--Parameters

|    Name     |  Type  | Description |
| :---------: | :----: | :---------: |
| description | String |     描述      |
|  longitude  | number |     经度      |
|  latitude   | number |     纬度      |

#### customElem--Parameters

|    Name     |  Type  |  Description   |
| :---------: | :----: | :------------: |
|    data     | string |  自定义消息json字符串  |
|  extension  | string | 自定义消息扩展json字符串 |
| description | string |       描述       |

#### quoteElem--Parameters

|     Name     |     Type     | Description |
| :----------: | :----------: | :---------: |
| quoteMessage | string\|null |    引用消息     |

#### NotificationElem--Parameters

|    Name     |  Type  | Description |
| :---------: | :----: | :---------: |
|   detail    | string |   通知详细信息    |
| defaultTips | string |   通知默认提示    |

# 初始化与登录

## initSDK

初始化OpenIM SDK,设置SDK网络连接地址以及本地数据存放目录等。

* Example:

```js
const flag = im.initSDK(operationID,config) //返回值为布尔值告知是否初始化成功

config是json字符串，格式为
{
"platform":1, //平台类型
"api_addr":"http://127.0.0.1:10000", //api域名地址
"ws_addr":"ws://127.0.0.1:17778", //websocket地址
"data_dir":"./", //SDK数据存放目录
"log_level":6, 
"object_storage":""
}
```

* Parameters:

|      Name      |  Type  |               Description                |
| :------------: | :----: | :--------------------------------------: |
|    platform    |  int   | 平台类型 1:ios 2:android 3:windows 4:osx 5:web&mini 7:linux 8:管理员 |
|    api_addr    | string |                 api域名地址                  |
|  ipWws_addrs   | string |               websocket地址                |
|    data_dir    | String |             SDK数据存放目录（绝对路径）              |
|   log_level    |  int   |                                          |
| object_storage | string |                                          |

* Monitor:

|        Name        |                   Type                   | Description |
| :----------------: | :--------------------------------------: | :---------: |
|  onConnectFailed   |         err:错误信息<br/>errCode:错误码         |    连接失败     |
|  onConnectSuccess  |           msg:onConnectSuccess           |    连接成功     |
|    onConnecting    |             msg:onConnecting             |     连接中     |
|  onKickedOffline   |           msg:onKickedOffline            |    被踢下线     |
| onSelfInfoUpdated  | msg:[用户信息对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E7%94%A8%E6%88%B7%E4%BF%A1%E6%81%AF%E5%AF%B9%E8%B1%A1)json字符串 |   修改个人信息    |
| onUserTokenExpired |          msg:onUserTokenExpired          |  账号token过期  |

## login

* Example:

```js
im.login(operationID,userID,token,data => {
	...
})
```

* Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
|   userID    |  string  |    用户ID     |
|    token    |  string  |   用户token   |
|  callback   | callback |    通用回调     |

## logout

* Example:

```js
im.logout(operationID,data => {
	...
})
```

* Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
|  callback   | callback |    通用回调     |

## getLoginStatus

获取当前用户登录状态。

* Example:

```js
const res = im.getLoginStatus()
// 返回值为 101:登录成功 102:登陆中 103:登录失败 201:登出
```

## getLoginUid

获取当前登录用户ID。

* Example:

```js
const res = im.getLoginUid()
// 返回值 用户ID
```



# 用户资料

## GetUsersInfo

获取某些用户的公开资料

* Example:

```js
im.getUsersInfo(operationID,userIDList,data => {
	...
})
```

* Parameters:

|    Name     | Description |   Type   |
| :---------: | :---------: | :------: |
| operationID |    UUID     |  string  |
| userIDList  |  string[]   |  用户ID数组  |
|  callback   |    通用回调     | callback |

## SetSelfInfo

设置登录用户的相关资料

* Example:

```js
im.setSelfInfo(operationID,userInfo,data => {
	...
})
```

* Parameters:

|    Name     |   Type   |    Description    |
| :---------: | :------: | :---------------: |
| operationID |  string  |       UUID        |
|  userInfo   | userInfo | 用户个人信息(在通用结构中有解释) |
|  callback   | callback |       通用回调        |

## GetSelfUserInfo

设置登录用户相关资料

* Example:

```js
im.getSelfUserInfo(operationID,data => {
	...
})
```

* Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
|  callback   | callback |    通用回调     |

# 好友及黑名单

## GetDesignatedFriendsInfo

获取指定好友列表的相关信息

* Example:

```js
im.getDesignatedFriendsInfo(operationID,userIDList,data => {
	...
})
// 回调:成功时，OnSuccess回调FullUserInfo列表
```

* Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
| userIDList  | string[] |   好友ID列表    |
|  callback   | callback |    通用回调     |

## GetFriendList

获取所有好友的相关信息

* Example:

```js
im.getFriendList(operationID,data => {
	...
})
// 回调:成功时，OnSuccess回调FullUserInfo列表
```

* Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
|  callback   | callback |    通用回调     |

## CheckFriend

检查是否好友关系，即是否在登录用户的好友列表中。注意：好友是双向关系

* Example:

```js
im.checkFriend(operationID,userIDList,data => {
	...
})
// 回调:成功时，OnSuccess回调此结构的列表，result为1表示好友（并且不是黑名单）
{
"userID":"user001", // 用户ID
"result":1
}
```

* Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
| userIDList  | string[] |   好友ID列表    |
|  callback   | callback |    通用回调     |

## AddFriend

添加好友申请

* Example:

```js
im.addFriend(operationID,userIDReqMsg,data => {
	...
})
// userIDReqMsg为
{
"toUserID":"user002", // 用户ID
"reqMsg":"hello" // 验证消息
}
```

* Parameters:

|     Name     |   Type   | Description |
| :----------: | :------: | :---------: |
| operationID  |  string  |    UUID     |
| userIDReqMsg |  string  |   申请验证信息    |
|   callback   | callback |    通用回调     |

## SetFriendRemark

设置好友备注

* Example:

```js
im.setFriendRemark(operationID,userIDRemark,data => {
	...
})
// userIDRemark为
{
	"toUserID": "user002", // 用户ID
	"remark": "my friend" // 备注
}
```

* Parameters:

|     Name     |   Type   | Description |
| :----------: | :------: | :---------: |
| operationID  |  string  |    UUID     |
| userIDRemark |  string  |    好友备注     |
|   callback   | callback |    通用回调     |

## DeleteFriend

删除好友，好友是双向关系，此函数仅仅删除自己的好友

* Example:

```js
im.deleteFriend(operationID,friendUserID,data => {
	...
})
// friendUserID为好友UserID
```

* Parameters:

|     Name     |   Type   | Description |
| :----------: | :------: | :---------: |
| operationID  |  string  |    UUID     |
| friendUserID |  string  |    好友ID     |
|   callback   | callback |    通用回调     |

## GetRecvFriendApplicationList

获取收到的好友申请，即哪些人申请加我为好友

* Example:

```js
im.getRecvFriendApplicationList(operationID,data => {
	...
})
```

* Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
|  callback   | callback |    通用回调     |

## GetSendFriendApplicationList

获取我发出去的好友申请，即我主动申请添加哪些人为好友

* Example:

```js
im.getSendFriendApplicationList(operationID,data => {
	...
})
```

* Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
|  callback   | callback |    通用回调     |

## AcceptFriendApplication

同意某人的好友申请

* Example:

```js
im.acceptFriendApplication(operationID,userIDHandleMsg,data => {
	...
})
// userIDHandleMsg为
{
	"toUserID": "user001", // 申请者ID
	"handleMsg": "ok" // 回复消息
}
```

* Parameters:

|      Name       |   Type   | Description |
| :-------------: | :------: | :---------: |
|   operationID   |  string  |    UUID     |
| userIDHandleMsg |  string  |    处理消息     |
|    callback     | callback |    通用回调     |

## RefuseFriendApplication

拒绝某人的好友申请

* Example:

```js
im.refuseFriendApplication(operationID,userIDHandleMsg,data => {
	...
})
// userIDHandleMsg为
{
	"toUserID": "user001", // 申请者ID
	"handleMsg": "ok" // 回复消息
}
```

* Parameters:

|      Name       |   Type   | Description |
| :-------------: | :------: | :---------: |
|   operationID   |  string  |    UUID     |
| userIDHandleMsg |  string  |    回复消息     |
|    callback     | callback |    通用回调     |

## AddBlack

添加黑名单

* Example:

```js
im.addBlack(operationID,blackUserID,(data)=>{
	...
})
```

* Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
| blackUserID |  string  |    用户ID     |
|  callback   | callback |    通用回调     |

## GetBlackList

获取黑名单资料列表

* Example:

```js
im.getBlackList(operationID,data => {
	...
})
// 回调:成功时，OnSuccess回调FullUserInfo列表
```

* Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
|  callback   | callback |    通用回调     |

## RemoveBlack

移除黑名单

* Example:

```js
im.removeBlack(operationID,removeUserID,data => {
	...
})
// removeUserID 被移除的黑名单UserID
```

* Parameters:

|     Name     |   Type   | Description |
| :----------: | :------: | :---------: |
| operationID  |  string  |    UUID     |
| removeUserID |  string  |   黑名单用户ID   |
|   callback   | callback |    通用回调     |

# 群组

## CreateGroup

创建群聊

* Example:

```js
im.createGroup(operationID,groupBaseInfo,memberList,data => {
	...
})
// groupBaseInfo为
{
	"groupName": "test group", //群名称
	"groupType": 0 //群类型
	"notification": "" //群公告
	"introduction":"" //群介绍
	"faceURL":"" //群头像
	"ex":"" //扩展字段
}
memberList为此结构的列表
{
	"userID": "user001", //用户ID
	"roleLevel": 1 //设置角色 1:普通成员 3:管理员
}
```

* Parameters:

|     Name      |   Type   | Description |
| :-----------: | :------: | :---------: |
|  operationID  |  string  |    UUID     |
| groupBaseInfo |  string  |     群信息     |
|  memberList   | string[] |     群成员     |
|   callback    | callback |    通用回调     |

## JoinGroup

申请加入某群

* Example:

```js
im.joinGroup(operationID,groupID,reqMsg,data => {
	...
})
```

* Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
|   groupID   |  string  |    群聊ID     |
|   reqMsg    |  string  |   请求验证信息    |
|  callback   | callback |    通用回调     |

## QuitGroup

退出某群

* Example:

```js
im.quitGroup(operationID,groupID,data => {
	...
})
```

* Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
|   groupID   |  string  |    群聊ID     |
|  callback   | callback |    通用回调     |

## GetJoinedGroupList

获取已加入的群列表

* Example:

```js
im.getJoinedGroupList(operationID,data => {
	...
})
// 回调:成功时，OnSuccess回调GroupInfo列表
```

* Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
|  callback   | callback |    通用回调     |

## GetGroupsInfo

获取指定群信息

* Example:

```js
im.getGroupsInfo(operationID,groupIDList,data => {
	...
})
// 回调:成功时，OnSuccess回调GroupInfo列表
```

* Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
| groupIDList | string[] |    群ID列表    |
|  callback   | callback |    通用回调     |



## SetGroupInfo

设置群信息（群名称，群通知，群公告，群头像，以及扩展字段），管理员和群主可以操作

* Example:

```js
im.setGroupInfo(operationID,groupID,groupInfo,data => {
	...
})
//groupInfo为
{
	"groupName": "test group", //	群ID
	"notification": "hello", //群公告
	"introduction": "this is test group chat", //群介绍
	"faceURL": "xx", //群头像
	"ex": "" //群信息扩展字段
}
```

* Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
|   groupID   |  string  |    群聊ID     |
|  groupInfo  |  string  |    群基本信息    |
|  callback   | callback |    通用回调     |

## GetGroupMemberList

获取群成员列表

* Example:

```js
im.getGroupMemberList(operationID,groupID,filter,offset,count,data => {
	...
})
// 回调:成功时，OnSuccess回调GroupMemberInfo列表
```

* Parameters:

|    Name     |   Type   |      Description       |
| :---------: | :------: | :--------------------: |
| operationID |  string  |          UUID          |
|   groupID   |  string  |          群聊ID          |
|   filter    |  number  | 过滤标识 0:所有成员 1:群主 2:管理员 |
|   offset    |  number  |          起始偏移          |
|    count    |  number  |          成员个数          |
|  callback   | callback |          通用回调          |

## GetGroupMembersInfo

获取指定群成员列表

* Example:

```js
im.getGroupMembersInfo(operationID,groupID,userIDList,data => {
	...
})
```

* Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
|   groupID   |  string  |    群聊ID     |
| userIDList  | string[] |   用户ID列表    |
|  callback   | callback |    通用回调     |

## KickGroupMember

把某人踢出群(可批量)

* Example:

```js
im.kickGroupMember(operationID,groupID,reason,userIDList,data => {
	...
})
//回调:成功时，OnSuccess回调此结构的列表
{
"userID":"user001",
"result":1
}
```

* Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
|   groupID   |  string  |    群聊ID     |
|   reason    |  string  |    踢人原因     |
| userIDList  | string[] |   用户ID列表    |
|  callback   | callback |    通用回调     |

## TransferGroupOwner

转让群主，只有群主能操作

* Example:

```js
im.transferGroupOwner(operationID,groupID,newOwnerUserID,data => {
	...
})
```

* Parameters:

|      Name      |   Type   | Description |
| :------------: | :------: | :---------: |
|  operationID   |  string  |    UUID     |
|    groupID     |  string  |    群聊ID     |
| newOwnerUserID |  string  |   新群主用户ID   |
|    callback    | callback |    通用回调     |

## InviteUserToGroup

邀请某些人进群，群里所有成员可以操作(可批量)

* Example:

```js
im.inviteUserToGroup(operationID,groupID,reason,userIDList,data => {
	...
})
//回调:成功时，OnSuccess回调此结构的列表
{
"userID":"user001",
"result":1
}
```

* Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
|   groupID   |  string  |    群聊ID     |
|   reason    |  string  |    进群原因     |
| userIDList  | string[] |   用户ID列表    |
|  callback   | callback |    通用回调     |

## GetRecvGroupApplicationList

作为群主或者管理员，获取收到的群成员申请进群列表

* Example:

```js
im.getRecvGroupApplicationList(operationID,data => {
	...
})
//回调:成功时，OnSuccess回调GroupApplicationInfo的列表
```

* Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
|  callback   | callback |    通用回调     |

## AcceptGroupApplication

管理员或者群主同意某人进入某群

* Example:

```js
im.acceptGroupApplication(operationID,groupID,fromUserID,handleMsg,data => {
	...
})
```

* Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
|   groupID   |  string  |    群聊ID     |
| fromUserID  |  string  |    申请者ID    |
|  handleMsg  |  string  |    处理的消息    |
|  callback   | callback |    通用回调     |

## RefuseGroupApplication

管理员或者群主拒绝某人进入某群

* Example:

```js
im.refuseGroupApplication(operationID,groupID,fromUserID,handleMsg,data => {
	...
})
```

* Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
|   groupID   |  string  |    群聊ID     |
| fromUserID  |  string  |    申请者ID    |
|  handleMsg  |  string  |    处理的消息    |
|  callback   | callback |    通用回调     |

# 会话

## GetAllConversationList

获取会话列表

* Example:

```js
im.getAllConversationList(operationID,data => {
	...
})
//回调:成功时，OnSuccess回调ConversationInfo的列表
```

* Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
|  callback   | callback |    通用回调     |

## GetConversationListSplit

分页获取会话列表

* Example:

```js
im.getConversationListSplit(operationID,offset,count,data => {
	...
})
//回调:成功时，OnSuccess回调ConversationInfo的列表
```

* Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
|   offset    |  number  |    起始偏移量    |
|    count    |  number  |   拉取会话的数量   |
|  callback   | callback |    通用回调     |

## GetOneConversation

获取一个会话，如果不存在会自动创建

* Example:

```js
im.getOneConversation(operationID,sourceID,sessionType,data => {
	...
})
//回调:成功时，OnSuccess回调ConversationInfo
```

* Parameters:

|    Name     |   Type   |   Description   |
| :---------: | :------: | :-------------: |
| operationID |  string  |      UUID       |
|  sourceID   |  string  | 单聊为用户ID，群聊为群ID  |
| sessionType |  number  | 会话的类型，单聊为1，群聊为2 |
|  callback   | callback |      通用回调       |

## GetConversationIDBySessionType

获取会话ID

* Example:

```js
const val = im.getConversationIDBySessionType(operationID,sessionType)
//返回值：会话ID
```

* Parameters:

|    Name     |  Type  |   Description   |
| :---------: | :----: | :-------------: |
| operationID | string |      UUID       |
| sessionType | number | 会话的类型，单聊为1，群聊为2 |

## GetMultipleConversation

获取多个会话列表

* Example:

```js
im.getMultipleConversation(operationID,conversationIDList,data => {
	...
})
//回调:成功时，OnSuccess回调ConversationInfo的列表
```

* Parameters:

|        Name        |   Type   | Description |
| :----------------: | :------: | :---------: |
|    operationID     |  string  |    UUID     |
| conversationIDList | string[] |   会话ID的列表   |
|      callback      | callback |    通用回调     |

## DeleteConversation

删除一个会话

* Example:

```js
im.deleteConversation(operationID,conversationID,data => {
	...
})
```

* Parameters:

|      Name      |   Type   | Description |
| :------------: | :------: | :---------: |
|  operationID   |  string  |    UUID     |
| conversationID |  string  |    会话ID     |
|    callback    | callback |    通用回调     |

## SetConversationDraft

设置会话的草稿

* Example:

```js
im.setConversationDraft(operationID,conversationID,draftText,data => {
	...
})
```

* Parameters:

|      Name      |   Type   |   Description    |
| :------------: | :------: | :--------------: |
|  operationID   |  string  |       UUID       |
| conversationID |  string  |       会话ID       |
|   draftText    |  string  | 草稿文本，如果为""则为删除草稿 |
|    callback    | callback |       通用回调       |

## PinConversation

置顶会话

* Example:

```js
im.pinConversation(operationID,conversationID,isPinned,data => {
	...
})
```

* Parameters:

|      Name      |   Type   |         Description         |
| :------------: | :------: | :-------------------------: |
|  operationID   |  string  |            UUID             |
| conversationID |  string  |            会话ID             |
|    isPinned    |   bool   | 为true时，代表置顶会话，为false时代表取消置顶 |
|    callback    | callback |            通用回调             |

## GetTotalUnreadMsgCount

获取总的消息未读数

- Example:

```js
im.getTotalUnreadMsgCount(operationID,data => {
	...
})
```

- Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
|  callback   | callback |    通用回调     |

# 消息

## CreateTextMessage

创建一条文字消息

* Example:

```js
const meg = im.createTextMessage(operationID,textMsg)
//返回文字信息结构体字符串
```

* Parameters:

|    Name     |  Type  | Description |
| :---------: | :----: | :---------: |
| operationID | string |    UUID     |
|   textMsg   | string |   消息文字内容    |

## CreateTextAtMessage

创建一条@文字消息

* Example:

```js
const meg = im.createTextAtMessage(OperationID, textMsg, atUserIDList)
//返回@文字信息结构体字符串
```

* Parameters:

|     Name     |   Type   | Description |
| :----------: | :------: | :---------: |
| operationID  |  string  |    UUID     |
|   textMsg    |  string  |   消息文字内容    |
| atUserIDList | string[] |   @用户id数组   |

## CreateImageMessage

根据已上传文件的URL及文件信息创建一条图片消息,**注意:通过该API创建的消息需要通过sendMessageNotOss方法发送**

* Example:

```js
const res = im.createImageMessage(OperationID,imagePath)
//返回图片信息结构体字符串
```

* Parameters:

|    Name     |  Type  | Description |
| :---------: | :----: | :---------: |
| operationID | string |    UUID     |
|  imagePath  | string | 图片地址(相对路径)  |

## CreateImageMessageFromFullPath

* Example:

```js
const res = im.createImageMessageFromFullPath(OperationID,imagePath)
//返回图片信息结构体字符串
```

* Parameters:

|    Name     |  Type  | Description |
| :---------: | :----: | :---------: |
| operationID | string |    UUID     |
|  imagePath  | string | 图片地址(绝对路径)  |

## CreateImageMessageByURL

根据自定义文件url创建一条图片消息，用户可将图片上传到任意云空间后，将对应下载地址及文件信息传入即可，但通过该API创建的信息需要调用`sendMessageNotOss`进行发送

* Example:

```js
const res = im.createImageMessageByURL(OperationID,sourceInfo,bigPicInfo,snapshotPicInfo)
//返回图片信息结构体字符串
const sourceInfo = {	//原图片信息
  uuid:"", //图片唯一id
  type:"png", //图片类型
  size:12465, //图片大小
  width:1080, //图片宽度
  height:720, //图片高度
  url:"http://www.ptbird.cn/usr/uploads/2019/07/2213642051.png" //图片地址
}
const bigPicInfo = sourceInfo					//大图信息
const snapshotPicInfo = sourceInfo		//搜略图信息
```

* Parameters:

|      Name       |  Type  | Description |
| :-------------: | :----: | :---------: |
|   operationID   | string |    UUID     |
|   sourceInfo    | string |    原图片信息    |
|   bigPicInfo    | string |    大图信息     |
| snapshotPicInfo | string |    搜略图信息    |

## CreateSoundMessage

根据相对路径创建一条语音消息

* Example:

```js
const res = im.createSoundMessage(OperationID, soundPath, duration)
//返回语音信息结构体字符串
```

* Parameters:

|    Name     |  Type  | Description  |
| :---------: | :----: | :----------: |
| operationID | string |     UUID     |
|  soundPath  | string | 音频文件地址(相对路径) |
|  duration   | number |     语音时长     |

## CreateSoundMessageFromFullPath

根据绝对路径创建一条语音消息

* Example:

```js
const res = createSoundMessageFromFullPath(OperationID, soundPath, duration)
//返回语音信息结构体字符串
```

* Parameters:

|    Name     |  Type  | Description  |
| :---------: | :----: | :----------: |
| operationID | string |     UUID     |
|  soundPath  | string | 音频文件地址(绝对路径) |
|  duration   | number |     语音时长     |

## CreateSoundMessageByURL

根据自定义文件url创建一条语音消息，用户可将语音文件上传到任意云空间后，将对应下载地址及文件信息传入即可，但通过该API创建的信息需要调用`sendMessageNotOss`进行发送

* Example:

```js
const res = im.createSoundMessageByURL(OperationID,soundInfo)
//返回语音信息结构体字符串
const soundInfo = {
  uuid:"xx", //唯一id
  soundPath:"xx", //留空字符即可
  sourceUrl:"http://xxx/mic.mp3", //音频地址
  dataSize:1234, //音频文件大小
  duration:42 //音频时长
}
```

* Parameters:

|    Name     |  Type  | Description |
| :---------: | :----: | :---------: |
| operationID | string |    UUID     |
|  soundInfo  | string |    语音信息     |

## CreateVideoMessage

根据相对路径创建一条视频消息

* Example:

```js
const res = im.createVideoMessage(OperationID, videoPath, videoType, duration, snapshotPath)
//返回视频信息结构体字符串
```

* Parameters:

|     Name     |  Type  |   Description   |
| :----------: | :----: | :-------------: |
| operationID  | string |      UUID       |
|  videoPath   | string |  视频文件地址(相对路径)   |
|  videoType   | string | 视频类型(MP4,AVI..) |
|   duration   |  int   |      视频时长       |
| snapshotPath | string |  视频快照地址(相对路径)   |

## CreateVideoMessageFromFullPath

根据绝对路径创建一条视频消息

* Example:

```js
const res = im.createVideoMessageFromFullPath(OperationID, videoPath, videoType, duration, snapshotPath)
//返回视频信息结构体字符串
```

* Parameters:

|     Name     |  Type  |   Description   |
| :----------: | :----: | :-------------: |
| operationID  | string |      UUID       |
|  videoPath   | string |  视频文件地址(绝对路径)   |
|  videoType   | string | 视频类型(MP4,AVI..) |
|   duration   |  int   |      视频时长       |
| snapshotPath | string |  视频快照地址(绝对路径)   |

## CreateVideoMessageByURL

根据自定义文件url创建一条视频消息，用户可将视频文件上传到任意云空间后，将对应下载地址及文件信息传入即可，但通过该API创建的信息需要调用`sendMessageNotOss`进行发送

* Example:

```js
const res = im.createVideoMessageByURL(OperationID, videoInfo)
//返回视频消息结构体字符串
const videoInfo = {
  videoPath: "xxx", //留为空字符串即可
  duration: 12, //视频时长
  videoType: "mp4", //视频类型(MP4,AVI..)
  snapshotPath: "xxx", //留为空字符串即可
  videoUUID:"xx", //视频文件唯一id
  videoUrl:"xx", //视频文件地址
  videoSize:1234, //视频文件大小
  snapshotUUID:"stringspn", //视频快照唯一id
  snapshotSize:123, //视频快照大小
  snapshotUrl:"xxx", //视频快照地址
  snapshotWidth:124, //视频快照宽度
  snapshotHeight:125 //视频快照高度
}
```

* Parameters:

|    Name     |  Type  | Description |
| :---------: | :----: | :---------: |
| operationID | string |    UUID     |
|  videoInfo  | string |    视频信息     |

## CreateFileMessage

根据相对路径创建一条文件消息

* Example:

```js
const res = im.createFileMessage(OperationID,filePath, fileName)
//返回文件信息结构体字符串
```

* Parameters:

|    Name     |  Type  | Description |
| :---------: | :----: | :---------: |
| operationID | string |    UUID     |
|  filePath   | string | 文件地址(相对路径)  |
|  fileName   | string |    文件名称     |

## CreateFileMessageFromFullPath

根据绝对路径创建一条文件消息

* Example:

```js
const res = im.createFileMessageFromFullPath(OperationID,filePath, fileName)
//返回文件信息结构体字符串
```

* Parameters:

|    Name     |  Type  | Description |
| :---------: | :----: | :---------: |
| operationID | string |    UUID     |
|  filePath   | string | 文件地址(绝对路径)  |
|  fileName   | string |    文件名称     |

## CreateFileMessageByURL

根据自定义文件url创建一条文件消息，用户可将文件上传到任意云空间后，将对应下载地址及文件信息传入即可，但通过该API创建的信息需要调用`sendMessageNotOss`进行发送

* Example:

```js
const res = im.createFileMessageByURL(OperationID,fileInfo)
//返回文件信息结构体字符串
const fileInfo = {
  filePath: "", //留为空字符串即可
  fileName: "test", //文件名称
  uuid:"xxsadsa", //文件唯一id
  sourceUrl:"wwwm", //文件地址
  fileSize:1234 //文件大小
}
```

* Parameters:

|    Name     |  Type  | Description |
| :---------: | :----: | :---------: |
| operationID | string |    UUID     |
|  fileInfo   | string |    文件信息     |

## CreateMergerMessage

创建一条合并消息

* Example:

```js
const res = im.createMergerMessage(operationID,msgListStr,title,summaryList)
//返回合并信息结构体字符串
```

* Parameters:

|    Name     |   Type   |               Description                |
| :---------: | :------: | :--------------------------------------: |
| operationID |  string  |                   UUID                   |
| messageList | string[] | [消息对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E6%B6%88%E6%81%AF%E5%AF%B9%E8%B1%A1)json字符串列表 |
|    title    |  string  |                  合并消息标题                  |
| summaryList | string[] |                合并消息的摘要列表                 |

## CreateForwardMessage

创建一条转发消息

* Example:

```js
const res = im.createForwardMessage(operationID,message)
//返回转发信息结构体字符串
```

* Parameters:

|    Name     |  Type  | Description  |
| :---------: | :----: | :----------: |
| operationID | string |     UUID     |
|   message   | string | 消息结构体json字符串 |

## CreateLocationMessage

创建一条地理位置消息

* Example:

```js
const res = im.createLocationMessage(OperationID,desc,latitude,longitude)
//返回地理信息结构体字符串
```

* Parameters:

|    Name     |  Type  | Description |
| :---------: | :----: | :---------: |
| operationID | string |    UUID     |
|    desc     | string |    描述信息     |
|  latitude   | double |     纬度      |
|  longitude  | double |     经度      |

## CreateCustomMessage

创建一条自定义消息

* Example:

```js
const res = im.createCustomMessage(operationID,data,expand,desc)
//返回自定义信息结构体字符串
```

* Parameters:

|    Name     |  Type  | Description |
| :---------: | :----: | :---------: |
| operationID | string |    UUID     |
|    data     | object |    自定义信息    |
|   expand    | object |  自定义信息扩展字段  |
|    desc     | string |   自定义消息描述   |

## CreateQuoteMessage

创建一条引用消息

* Example:

```js
const res = im.createQuoteMessage(OperationID,text,message)
//返回引用消息结构体字符串
```

* Parameters:

|    Name     |  Type  |               Description                |
| :---------: | :----: | :--------------------------------------: |
| operationID | string |                   UUID                   |
|    text     | string |                   消息内容                   |
|   message   | string | 引用[消息对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E6%B6%88%E6%81%AF%E5%AF%B9%E8%B1%A1)json字符串 |

## CreateCardMessage

创建一条名片位置消息

- Example:

```js
const res = im.createCardMessage(operationID,cardDesc)
//返回名片消息结构体字符串
```

- Parameters:

|    Name     |  Type  | Description |
| :---------: | :----: | :---------: |
| operationID | string |    UUID     |
|  cardDesc   | string |    true     |

## SendMessage

发送消息

* Example:

```js
im.sendMessage(operationID,message,recvID,groupID,offlinePushInfo)
//使用监听
//发送成功时为发送的消息对象json字符串

```

* Parameters:

|      Name       |    Type     | Description  |
| :-------------: | :---------: | :----------: |
|   operationID   |   string    |     UUID     |
|     message     |   string    | 消息结构体json字符串 |
|     recvID      |   string    |  接收者ID（单聊）   |
|     groupID     |   string    |  接收群组ID（群聊）  |
| offlinePushInfo | OfflinePush |    离线推送配置    |

## SendMessageNotOss

发送消息不通过sdk内置OSS上传多媒体文件

- Example:

```js
im.sendMessageNotOss(operationID,message,recvID,groupID,offlinePushInfo)
//使用监听
//发送成功时为发送的消息对象json字符串

```

- Parameters:

|      Name       |    Type     | Description  |
| :-------------: | :---------: | :----------: |
|   operationID   |   string    |     UUID     |
|     message     |   string    | 消息结构体json字符串 |
|     recvID      |   string    |  接收者ID（单聊）   |
|     groupID     |   string    |  接收群组ID（群聊）  |
| offlinePushInfo | OfflinePush |    离线推送配置    |

## GetHistoryMessageList

获取历史记录

- Example:

```js
im.getHistoryMessageList(operationID,getMessageOptions,data => {
	...
})
getMessageOptions:参数为json转换后的string，结构体如下：
{
    "userID": "", //拉取单个用户之间的聊天消息
    "groupID": "", //拉取群的聊天消息
    "startClientMsgID": "",// 起始的消息clientMsgID，第一次拉取为""
    "count": 20//拉取消息的数量
}
```

- Parameters:

|       Name        |   Type   | Description |
| :---------------: | :------: | :---------: |
|    operationID    |  string  |    UUID     |
| getMessageOptions |  string  |   获取消息参数    |
|     callback      | callback |    通用回调     |

## RevokeMessage

撤回一条消息

- Example:

```js
im.revokeMessage(operationID,message,data => {
	...
})
```

- Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
|   message   |  string  | MessageInfo |
|  callback   | callback |    通用回调     |

## TypingStatusUpdate

单聊正在输入消息

- Example:

```js
im.typingStatusUpdate(operationID,recvID,msgTip,data => {
	...
})
```

- Parameters:

|    Name     |   Type   |       Description        |
| :---------: | :------: | :----------------------: |
| operationID |  string  |           UUID           |
|   recvID    |  string  |          接收者ID           |
|   msgTip    |  string  | 自定义的提示信息为json序列化后的string |
|  callback   | callback |           通用回调           |

## MarkC2CMessageAsRead

标记单聊消息已读

- Example:

```js
im.markC2CMessageAsRead(operationID,userID,msgIDList,data => {
	...
})
```

- Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
|   userID    |  string  |    用户ID     |
|  msgIDList  | string[] |   消息ID的列表   |
|  callback   | callback |    通用回调     |

## DeleteMessageFromLocalStorage

本地删除一条消息，卸载APP后会重新获取到

- Example:

```js
im.deleteMessageFromLocalStorage(operationID,message,data => {
    ...
})
```

- Parameters:

|    Name     |    Type     | Description |
| :---------: | :---------: | :---------: |
| operationID |   string    |    UUID     |
|   message   | MessageInfo |     消息      |
|  callback   |  callback   |    通用回调     |

## ClearC2CHistoryMessage

清空单聊的历史记录

- Example:

```js
im.clearC2CHistoryMessage(operationID,userID,data => {
    ...
})
```

- Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
|   userID    |  string  |    用户ID     |
|  callback   | callback |    通用回调     |

## ClearGroupHistoryMessage

本地删除一条消息，卸载APP后会重新获取到

- Example:

```js
im.clearGroupHistoryMessage(operationID,groupID,data => {
    ...
})
```

- Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
|   groupID   |  string  |     群ID     |
|  callback   | callback |    通用回调     |

## InsertSingleMessageToLocalStorage

插入一条群聊消息到本地

- Example:

```js
im.insertSingleMessageToLocalStorage(operationID,message,recvID,sendID,data => {
    ...
})
//回调:成功时，OnSuccess回调插入的MessageInfo
```

- Parameters:

|    Name     |   Type   | Description  |
| :---------: | :------: | :----------: |
| operationID |  string  |     UUID     |
|   message   |  string  | 消息结构体json字符串 |
|   recvID    |  string  |    接收者ID     |
|   sendID    |  string  |    发送者ID     |
|  callback   | callback |     通用回调     |

## InsertGroupMessageToLocalStorage

插入一条群聊消息到本地

- Example:

```js
im.insertGroupMessageToLocalStorage(operationID,message,groupID,sendID,data => {
    ...
})
//回调:成功时，OnSuccess回调插入的MessageInfo
```

- Parameters:

|    Name     |   Type   | Description  |
| :---------: | :------: | :----------: |
| operationID |  string  |     UUID     |
|   message   |  string  | 消息结构体json字符串 |
|   groupID   |  string  |     群ID      |
|   sendID    |  string  |    发送者ID     |
|  callback   | callback |     通用回调     |

## SearchLocalMessages

搜索本地消息

- Example:

```js
im.searchLocalMessages(operationID,searchParam,data => {
    ...
})
//searchParam:参数为json转换后的string，结构体如下：
{
    "sourceID": "18090680773", //源ID,单聊为用户ID，群聊为群ID
    "sessionType": 1,  //会话类型，单聊为1，群聊为2，如果为0，则代表搜索全部
    "keywordList": [
        "78"    //搜索关键词列表，目前仅支持一个关键词搜索
    ], 
    "keywordListMatchType": 0,  //关键词匹配模式，1代表与，2代表或，暂时未用
    "senderUserIDList": [],  //指定消息发送的uid列表，暂时未用
    "messageTypeList": [],  //消息类型列表，暂时未用
    "searchTimePosition": 0,  //搜索的起始时间点。默认为0即代表从现在开始搜索。UTC 时间戳，单位：秒
    "searchTimePeriod": 864000,  //从起始时间点开始的过去时间范围，单位秒。默认为0即代表不限制时间范围，传24x60x60代表过去一天。
    "pageIndex": 0,  //分页使用的偏移，暂时未用
    "count": 0 //每页数量，暂时未用
}

//回调:成功时，OnSuccess回调结构：
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

- Parameters:

|    Name     |   Type   | Description |
| :---------: | :------: | :---------: |
| operationID |  string  |    UUID     |
| searchParam |  string  |    搜索参数     |
|  callback   | callback |    通用回调     |

# 监听

## SetUserListener

设置用户信息监听

- Example:

```js
im.setUserListener()
```

- Monitor:

|       Event       | Description |
| :---------------: | :---------: |
| onSelfInfoUpdated |   修改个人信息    |

## SetFriendListener

好友信息以及好友列表发生改变时

- Example:

```js
im.setFriendListener()
```

- Monitor:

|            Event            | Description  |
| :-------------------------: | :----------: |
|        OnBlackAdded         |   添加用户到黑名单   |
|       OnBlackDeleted        | 从黑名单中移除了某个用户 |
| OnFriendApplicationAccepted |   好友请求被接受    |
| OnFriendApplicationRejected |   好友请求被拒绝    |
|  OnFriendApplicationAdded   |   好友请求列表增加   |
| OnFriendApplicationDeleted  |   好友请求列表减少   |
|     OnFriendInfoChanged     |    好友信息更新    |
|        OnFriendAdded        |    好友列表增加    |
|       OnFriendDeleted       |    好友列表减少    |

## SetGroupListener

群组信息改变或群成员状态改变时回调

- Example:

```js
im.setGroupListener()
```

- Monitor:

| Event                      | Description |
| -------------------------- | ----------- |
| OnGroupApplicationAccepted | 入群申请被同意     |
| OnGroupApplicationRejected | 入群申请被拒绝     |
| OnGroupApplicationAdded    | 入群申请有新增     |
| OnGroupApplicationDeleted  | 入群申请被删除     |
| OnGroupInfoChanged         | 群组信息改变      |
| OnGroupMemberInfoChanged   | 群成员信息改变     |
| OnGroupMemberAdded         | 有新成员加入群组    |
| OnGroupMemberDeleted       | 有群成员退出群组    |
| OnJoinedGroupAdded         | 加入的群增加      |
| OnJoinedGroupDeleted       | 加入的群减少      |

## SetAdvancedMsgListener

收到新消息时会触发对应监听，开发者可在回调中进行处理

- Example:

```js
im.setAdvancedMsgListener()
```

- Monitor:

  | Event                | Description |
  | -------------------- | ----------- |
  | OnRecvNewMessage     | 接收到新消息      |
  | OnRecvMessageRevoked | 其他用户撤回信息回执  |
  | OnRecvC2CReadReceipt | 消息已读回执      |

## SetConversationListener

会话列表变化时触发监听

- Example:

```js
im.setConversationListener()
```

- Monitor:

  | Event                            | Description |
  | -------------------------------- | ----------- |
  | OnConversationChanged            | 会话列表发生改变    |
  | OnNewConversation                | 有新会话产生      |
  | OnSyncServerFailed               | -           |
  | OnSyncServerFinish               | -           |
  | OnSyncServerStart                | -           |
  | OnTotalUnreadMessageCountChanged | 消息未读总数改变    |

