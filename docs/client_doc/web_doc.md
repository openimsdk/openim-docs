> 所有SDK提供的所有API均以Promise方式返回，成功、失败回调参数类型均为[WsResponse](https://doc.rentsoft.cn/client_doc/web_doc.html#promise-%E8%BF%94%E5%9B%9E%E5%8F%82%E6%95%B0)。文档中列出的返回值为[WsResponse](https://doc.rentsoft.cn/client_doc/web_doc.html#promise-%E8%BF%94%E5%9B%9E%E5%8F%82%E6%95%B0)中的data参数。
>
> 每个方法有一个可选参数`operationID`用于标识每一次操作的唯一性，对应[WsResponse](https://doc.rentsoft.cn/client_doc/web_doc.html#promise-%E8%BF%94%E5%9B%9E%E5%8F%82%E6%95%B0)中的`operationID`若不传则由SDK默认生成。

# 登录

## login

初始化并登录OpenIM SDK Server，使用用户ID(uid)和token登录，uid来自于自身业务服务器，token需要业务服务器根据secret向OpenIM服务端交换获取。

- Example:

  ```js
  
  const config: InitConfig = {
    uid: "xxx",
    token: "xxx",
    url: "ws://1.14.194.38:30000",
    platformID: 5,
  };
  openIM.login(config).then(({ data }) => {
    console.log("login suc...");
  }).catch(err => {
    console.log("login failed...");
  })
  ```
  
- Parameters:


| Name       | Type   | Description                                                  |
| ---------- | ------ | ------------------------------------------------------------ |
| uid        | String | 用户ID                                                       |
| token      | string | 用户tokn                                                     |
| url        | string | websocket地址                                                |
| platformID | int    | 平台类型 1:ios 2:android 3:windows 4:osx 5:web&mini 7:linux 8:管理员 |

- Return:


| Type                                                         | Description      |
| ------------------------------------------------------------ | ---------------- |
| [WsResponse](https://doc.rentsoft.cn/client_doc/web_doc.html#promise-%E8%BF%94%E5%9B%9E%E5%8F%82%E6%95%B0) | 返回登录是否成功 |



## logout

登出OpenIM，通常在切换账号的时候调用，清除登录态以及内存中的所有数据。

- Example:

  ```js
  openIM.logout().then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Return:

| Type           | Description      |
| -------------- | ---------------- |
| [WsResponse]() | 返回登出是否成功 |



## getLoginStatus

获取当前用户登录状态。

- Example:

  ```js
  openIM.getLoginStatus().then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- CallBack:


| Name | Type   | Description                                   |
| ---- | ------ | --------------------------------------------- |
| data | string | 101:登录成功 102:登陆中 103:登录失败 201:登出 |

  


## getLoginUser

获取当前登录用户ID。

- Example:

  ```js
  openIM.getLoginUser().then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- CallBack:


| Name | Type   | Description |
| ---- | ------ | ----------- |
| data | string | 用户ID      |

  

# 用户资料

## getUsersInfo

根据用户ID获取用户资料，可批量获取。

- Example:

  ```js
  const userList = ["1f8e0d51d335301d"]
  openIM.getUsersInfo(userList).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name    | Type     | Description |
| ------- | -------- | ----------- |
| uidList | string[] | 用户ID数组  |

- CallBack:


| Name | Type   | Description                |
| ---- | ------ | -------------------------- |
| data | string | 用户信息对象列表Json字符串 |

  

## setSelfInfo

修改当前用户资料。

- Example:

  ```typescript
  const info:SelfInfo = {
    userID:"1234",
    nickname: "blooming",//用户昵称
    faceURL: "xxx.com",//头像URL
    gender:1,//性别，0未知，1男，2女
    phoneNumber:"123",//用户手机号
    birth:1642584426,//用户生日
    email:"123@qq.com",//用户邮箱
    ex:"ex"//用户扩展信息
  }
  openIM.setSelfInfo(info).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name | Type                                                         | Description  |
| ---- | ------------------------------------------------------------ | ------------ |
| info | [SelfInfo](https://doc.rentsoft.cn/client_doc/web_doc.html#%E7%94%A8%E6%88%B7%E4%BF%A1%E6%81%AF%E5%AF%B9%E8%B1%A1) | 用户信息对象 |

- CallBack:


| Name | Type   | Description          |
| ---- | ------ | -------------------- |
| data | string | 用户资料是否修改成功 |

  

# 消息收发

## createTextMessage

创建一条文字消息。

- Example:

  ```js
  const textStr = "hello open im";
  openIM.createTextMessage(textStr).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| textStr | string | 消息文字内容 |

- Returns:


| Name | Type   | Description          |
| ---- | ------ | -------------------- |
| data | string | 文字信息结构体字符串 |

## createTextAtMessage

创建一条@文字消息。

- Example:

  ```js
  const options = {
    textMsg: "I am at Msg",
    atList: ["1f8e0d51d335301d"],
  };
  openIM.createTextAtMessage(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name    | Type     | Description           |
| ------- | -------- | --------------------- |
| textMsg | string   | 消息文字内容          |
| atList  | string[] | @用户id数组json字符串 |

- Returns:


| Name | Type   | Description           |
| ---- | ------ | --------------------- |
| Data | string | @文字信息结构体字符串 |

  

## createImageMessage

根据已上传文件的URL及文件信息创建一条图片消息。

**注意:通过该API创建的消息需要通过[sendMessageNotOss](https://doc.rentsoft.cn/client_doc/web_doc.html#sendmessagenotoss)方法发送。**

- Example:

  ```js
  const baseInfo:PicBaseInfo = {
        uuid:"xxx",
        type:"png",
        size:12465,
        width:1080,
        height:720,
        url:"http://www.ptbird.cn/usr/uploads/2019/07/2213642051.png"
    }
  const options:ImageMsgParams = {
      sourcePicture:baseInfo,
      bigPicture:baseInfo,
      snapshotPicture:baseInfo,
    }
  openIM.createImageMessage(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name   | Type   | Description |
| ------ | ------ | ----------- |
| uuid   | string | 图片唯一id  |
| type   | string | 图片类型    |
| size   | number | 图片大小    |
| width  | number | 图片宽度    |
| height | number | 图片高度    |
| url    | string | 图片地址    |

- Returns:


| Name | Type   | Description          |
| ---- | ------ | -------------------- |
| data | string | 图片信息结构体字符串 |

  

## createSoundMessage

根据已上传文件的URL及文件信息创建一条语音消息。

**注意:通过该API创建的消息需要通过[sendMessageNotOss](https://doc.rentsoft.cn/client_doc/web_doc.html#sendmessagenotoss)方法发送。**

- Example:

  ```js
  const options:SoundMsgParams = {
        uuid:"xx",
        soundPath:"xx",
        sourceUrl:"http://xxx/mic.mp3",
        dataSize:1234,
        duration:42
      }
  openIM.createSoundMessage(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name      | Type   | Description  |
| --------- | ------ | ------------ |
| uuid      | string | 唯一id       |
| soundPath | string | 留空字符即可 |
| sourceUrl | string | 音频地址     |
| dataSize  | number | 音频文件大小 |
| duration  | number | 音频时长     |

- Returns:


| Name | Type   | Description          |
| ---- | ------ | -------------------- |
| data | string | 语音信息结构体字符串 |

​    

## createVideoMessage

根据已上传文件的URL及文件信息创建一条视频消息。

**注意:通过该API创建的消息需要通过[sendMessageNotOss](https://doc.rentsoft.cn/client_doc/web_doc.html#sendmessagenotoss)方法发送。**

- Example:

  ```js
  const options:VideoMsgParams = {
        videoPath: "xxx",
        duration: 12,
        videoType: "mp4",
        snapshotPath: "xxx",
        videoUUID:"xx",
        videoUrl:"xx",
        videoSize:1234,
        snapshotUUID:"stringspn",
        snapshotSize:123,
        snapshotUrl:"xxx",
        snapshotWidth:124,
        snapshotHeight:125
      };
  openIM.createVideoMessage(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name           | Type   | Description         |
| -------------- | ------ | ------------------- |
| videoPath      | string | 留为空字符串即可    |
| videoType      | string | 视频类型(MP4,AVI..) |
| duration       | number | 视频时长            |
| snapshotPath   | string | 留为空字符串即可    |
| videoUUID      | string | 视频文件唯一id      |
| videoUrl       | string | 视频文件地址        |
| videoSize      | number | 视频文件大小        |
| snapshotUUID   | string | 视频快照唯一id      |
| snapshotSize   | number | 视频快照大小        |
| snapshotUrl    | string | 视频快照地址        |
| snapshotWidth  | number | 视频快照宽度        |
| snapshotHeight | number | 视频快照高度        |

- Returns:


| Name | Type   | Description          |
| ---- | ------ | -------------------- |
| data | string | 视频信息结构体字符串 |

​    

## createFileMessage

根据已上传文件的URL及文件信息创建一条文件消息。

**注意:通过该API创建的消息需要通过[sendMessageNotOss](https://doc.rentsoft.cn/client_doc/web_doc.html#sendmessagenotoss)方法发送。**

- Example:

  ```js
  const options:FileMsgParams = {
        filePath: "",
        fileName: "test",
        uuid:"xxsadsa",
        sourceUrl:"wwwm",
        fileSize:1234
      };
  openIM.createFileMessage(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name      | Type   | Description      |
| --------- | ------ | ---------------- |
| filePath  | string | 留为空字符串即可 |
| fileName  | string | 文件名称         |
| uuid      | string | 文件唯一id       |
| sourceUrl | string | 文件地址         |
| fileSize  | number | 文件大小         |

- Returns:


| Name | Type   | Description          |
| ---- | ------ | -------------------- |
| data | string | 文件信息结构体字符串 |

  

## createMergerMessage

创建一条合并消息。

- Example:

  ```js
  const options:MergerMsgParams = {
    messageList:[''],
    title:"",
    summaryList:['']
  }
  openIM.createMergerMessage(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name        | Type     | Description                                                  |
| ----------- | -------- | ------------------------------------------------------------ |
| messageList | string[] | [消息对象](https://doc.rentsoft.cn/client_doc/web_doc.html#%E6%B6%88%E6%81%AF%E5%AF%B9%E8%B1%A1)json字符串列表 |
| title       | string   | 合并消息标题                                                 |
| summaryList | string[] | 合并消息的摘要列表                                           |

- Returns:


| Name | Type   | Description          |
| ---- | ------ | -------------------- |
| data | string | 合并信息结构体字符串 |

  

## createForwardMessage

创建一条转发消息。

- Example:

  ```js
  openIM.createForwardMessage(message).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name    | Type   | Description          |
| ------- | ------ | -------------------- |
| message | string | 消息结构体json字符串 |

- Returns:


| Name | Type   | Description          |
| ---- | ------ | -------------------- |
| data | string | 转发信息结构体字符串 |


​    

## createLocationMessage

创建一条地理位置消息。

- Example:

  ```js
  const options:LocationMsgParams = {
  	description:"",
    longitude:12.13,
    latitude:13.14
  } 
  openIM.createLocationMessage(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name        | Type   | Description |
| ----------- | ------ | ----------- |
| description | string | 描述信息    |
| latitude    | double | 纬度        |
| longitude   | double | 经度        |

- Returns:


| Name | Type   | Description          |
| ---- | ------ | -------------------- |
| data | string | 地理信息结构体字符串 |


​    

## createCustomMessage

创建一条自定义消息。

- Example:

  ```js
  const options:CustomMsgParams = {
  	data:"",
    expand:"",
    desc:""
  } 
  openIM.createCustomMessage(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name   | Type   | Description                  |
| ------ | ------ | ---------------------------- |
| data   | string | 自定义信息结构json字符串     |
| expand | string | 自定义信息扩展字段json字符串 |
| desc   | string | 自定义消息描述               |

- Return:


| Name | Type   | Description            |
| ---- | ------ | ---------------------- |
| data | string | 自定义信息结构体字符串 |


​    

## createQuoteMessage

创建一条引用消息。

- Example:

  ```js
  const options:QuoteMsgParams = {
  	text:"",
    message:"",
  } 
  openIM.createQuoteMessage(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name    | Type   | Description                                                  |
| ------- | ------ | ------------------------------------------------------------ |
| text    | string | 消息内容                                                     |
| message | string | 引用[消息对象](https://doc.rentsoft.cn/client_doc/web_doc.html#%E6%B6%88%E6%81%AF%E5%AF%B9%E8%B1%A1)json字符串 |

- Returns:


| Name | Type   | Description          |
| ---- | ------ | -------------------- |
| data | string | 引用消息结构体字符串 |




## sendMessage

OpenIM消息按照消息发送的目标可分为：“单聊消息”和“群聊消息”，在发送单聊消息时设置groupID为空字符串，同理发送群聊消息时设置userID为空字符串即可。

- Example:

  ```js
  const options:SendMsgParams = {
    recvID: "xxx",
    groupID: "",
    onlineUserOnly: false,
    message: "",
  };
  openIM.sendMessage(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name           | Type   | Description          |
| -------------- | ------ | -------------------- |
| message        | string | 消息结构体json字符串 |
| recvID         | string | 接收者ID（单聊）     |
| groupID        | string | 接收群组ID（群聊）   |
| onlineUserOnly | bool   | 是否仅在线用户接收   |



## sendMessageNotOss

OpenIM消息按照消息发送的目标可分为：“单聊消息”和“群聊消息”，在发送单聊消息时设置groupID为空，同理发送群聊消息时设置userID为空即可。

- Example:

  ```js
  const options:SendMsgNotParams = {
    recvID: "xxx",
    groupID: "",
    onlineUserOnly: false,
    message: "",
  };
  openIM.sendMessageNotOss(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name           | Type   | Description          |
| -------------- | ------ | -------------------- |
| message        | string | 消息结构体json字符串 |
| recvID         | string | 接收者ID（单聊）     |
| groupID        | string | 接收群组ID（群聊）   |
| onlineUserOnly | bool   | 是否仅在线用户接收   |



## getHistoryMessageList

分页拉取单聊或群聊的历史消息。

- Example:

  ```js
  const options:GetHistoryMsgParams = {
    groupID:"",
    startMsg:null,
    count:12,
    userID:"userID"
  }
  openIM.getHistoryMessageList(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name     | Type                                                         | Description                                                 |
| -------- | ------------------------------------------------------------ | ----------------------------------------------------------- |
| groupID  | string                                                       | 群聊ID，拉取群聊时传入，否则为“”                            |
| startMsg | null\|[Message](https://doc.rentsoft.cn/client_doc/web_doc.html#%E6%B6%88%E6%81%AF%E5%AF%B9%E8%B1%A1) | 上一次拉取的最后一条消息结构体或null,为null则从最新一条开始 |
| count    | number                                                       | 每次拉取的条数                                              |
| userID   | string                                                       | 用户ID，拉取单聊时传入，否则为“”                            |

- CallBack:


| Name | Type   | Description                                                  |
| ---- | ------ | ------------------------------------------------------------ |
| data | string | 历史[消息对象](https://doc.rentsoft.cn/client_doc/web_doc.html#%E6%B6%88%E6%81%AF%E5%AF%B9%E8%B1%A1)数组json字符串 |

  

## revokeMessage

撤回某条消息。

- Example:

  ```js
  openIM.revokeMessage(message).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name    | Type   | Description                  |
| ------- | ------ | ---------------------------- |
| message | string | 要撤回的消息结构体json字符串 |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 撤回成功或失败描述 |

  

## markC2CMessageAsRead

实时消息已读回执，在 C2C 单聊场景下，当接收方通过 markC2CMessageAsRead接口将来自某人的消息标记为已读时，消息的发送方将会收到“已读回执”，表示“xxx 已经读过我的消息了”。

- Example:

  ```js
  const options:MarkC2CParams = {
  	receiver:"",
    msgIDList:["xxx"]
  }
  openIM.markC2CMessageAsRead(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name      | Type     | Description             |
| --------- | -------- | ----------------------- |
| receiver  | string   | 接收ID                  |
| msgIDList | string[] | 已读消息clientMsgID数组 |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 标记成功或失败描述 |

  

## typingStatusUpdate

更新正在输入状态。

- Example:

  ```js
  const options:TypingUpdateParams = {
    receiver: "";
    msgTip: "";
  }
  openIM.typingStatusUpdate(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name     | Type   | Description    |
| -------- | ------ | -------------- |
| receiver | string | 接收者ID       |
| msgTip   | string | 自定义输入描述 |

  

## deleteMessageFromLocalStorage

删除本地消息。

- Example:

  ```js
  openIM.deleteMessageFromLocalStorage(message).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name    | Type   | Description          |
| ------- | ------ | -------------------- |
| message | string | 消息结构体json字符串 |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 删除成功或失败描述 |

  

## insertSingleMessageToLocalStorage

插入一条消息到本地。

- Example:

  ```js
  const options:InsertSingleMsgParams = {
    message:"",
    userID:"",
    sender:""
  }
  openIM.insertSingleMessageToLocalStorage(message).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name    | Type   | Description          |
| ------- | ------ | -------------------- |
| message | string | 消息结构体json字符串 |
| userID  | string | 接收者ID             |
| sender  | string | 发送者ID             |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 插入成功或失败描述 |

  

## findMessages

根据消息ID查找本地消息。

- Example:

  ```js
  const options = ["xx"]
  openIM.findMessages(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name | Type     | Description         |
| ---- | -------- | ------------------- |
| data | string[] | 消息clientMsgID数组 |

- CallBack:


| Name | Type   | Description                                                  |
| ---- | ------ | ------------------------------------------------------------ |
| data | string | [消息对象](https://doc.rentsoft.cn/client_doc/web_doc.html#%E6%B6%88%E6%81%AF%E5%AF%B9%E8%B1%A1)数组json字符串 |

  

# 会话

## getAllConversationList

获取所有会话列表。

- Example:

  ```js
  openIM.getAllConversationList().then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- CallBack:


| Name | Type   | Description                                                  |
| ---- | ------ | ------------------------------------------------------------ |
| data | string | [会话对象](https://doc.rentsoft.cn/client_doc/web_doc.html#%E4%BC%9A%E8%AF%9D%E5%AF%B9%E8%B1%A1)列表json字符串 |

  

## getOneConversation

根据用户ID或群聊ID和session类型获取单个会话。

- Example:

  ```js
  const options:GetOneCveParams = {
    sourceID:"",
    sessionType:1
  }
  openIM.getOneConversation(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name        | Type   | Description     |
| ----------- | ------ | --------------- |
| sourceID    | string | 用户ID或群聊ID  |
| sessionType | number | 单聊为1 群聊为2 |

- CallBack:


| Name | Type   | Description                                                  |
| ---- | ------ | ------------------------------------------------------------ |
| data | string | [会话对象](https://doc.rentsoft.cn/client_doc/web_doc.html#%E4%BC%9A%E8%AF%9D%E5%AF%B9%E8%B1%A1)json字符串 |

  

## getMultipleConversation

根据会话ID获取多个会话。

- Example:

  ```js
  const options = ["xxx"]
  openIM.getMultipleConversation(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name | Type     | Description |
| ---- | -------- | ----------- |
| data | string[] | 会话ID数组  |

- CallBack:


| Name | Type   | Description                                                  |
| ---- | ------ | ------------------------------------------------------------ |
| data | string | [会话对象](https://doc.rentsoft.cn/client_doc/web_doc.html#%E4%BC%9A%E8%AF%9D%E5%AF%B9%E8%B1%A1)列表json字符串 |

  

## deleteConversation

根据会话ID删除指定会话。

- Example:

  ```js
  openIM.deleteConversation(conversationID).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name           | Type   | Description |
| -------------- | ------ | ----------- |
| conversationID | string | 会话ID      |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 删除成功或失败描述 |

  

## setConversationDraft

设置会话草稿信息。

- Example:

  ```js
  const options:SetDraftParams = {
    conversationID:"",
    draftText:""
  }
  openIM.setConversationDraft(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name           | Type   | Description |
| -------------- | ------ | ----------- |
| conversationID | string | 会话ID      |
| draftText      | string | 草稿信息    |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 设置成功或失败描述 |

  

## pinConversation

置顶会话。

- Example:

  ```js
  const options:PinCveParams = {
    conversationID:"",
    isPinned:true
  }
  openIM.pinConversation(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name           | Type   | Description |
| -------------- | ------ | ----------- |
| conversationID | string | 会话ID      |
| isPinned       | bool   | 是否置顶    |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 置顶成功或失败描述 |

  

## markSingleMessageHasRead

标记单聊会话消息为已读。

- Example:

  ```js
  openIM.markSingleMessageHasRead(uid).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name | Type   | Description |
| ---- | ------ | ----------- |
| uid  | string | 用户ID      |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 标记成功或失败描述 |

  

## markGroupMessageHasRead

标记群聊会话消息已读。

- Example:

  ```js
  openIM.markGroupMessageHasRead(groupID).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name    | Type   | Description |
| ------- | ------ | ----------- |
| groupID | string | 群组ID      |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 标记成功或失败描述 |

  

## getTotalUnreadMsgCount

获取消息总未读。

- Example:

  ```js
  openIM.getTotalUnreadMsgCount().then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- CallBack:


| Name | Type   | Description  |
| ---- | ------ | ------------ |
| data | string | 消息总未读数 |

​    

# 好友

## getFriendList

获取好友列表。

- Example:

  ```js
  openIM.getFriendList().then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- CallBack:


| Name | Type   | Description                                                  |
| ---- | ------ | ------------------------------------------------------------ |
| data | string | [会话对象](https://doc.rentsoft.cn/client_doc/web_doc.html#%E4%BC%9A%E8%AF%9D%E5%AF%B9%E8%B1%A1)对象列表json字符串 |

  

## getDesignatedFriendsInfo

获取好友信息。

- Example:

  ```js
  const options = ["xxx"]
  openIM.getDesignatedFriendsInfo(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name | Type     | Description |
| ---- | -------- | ----------- |
| data | string[] | 好友ID数组  |

- CallBack:


| Name | Type   | Description                                                  |
| ---- | ------ | ------------------------------------------------------------ |
| data | string | [好友信息](https://doc.rentsoft.cn/client_doc/web_doc.html#%E5%A5%BD%E5%8F%8B%E4%BF%A1%E6%81%AF%E5%AF%B9%E8%B1%A1)对象列表json字符串 |

  

## setFriendRemark

设置好友备注信息。

- Example:

  ```js
  const options:RemarkFriendParams = {
    toUserID:"",
    remark:""
  }
  openIM.setFriendRemark(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name     | Type   | Description |
| -------- | ------ | ----------- |
| toUserID | string | 用户ID      |
| remark   | string | 备注        |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 设置成功或失败描述 |

  

## checkFriend

检查与用户间是否有好友关系。

- Example:

  ```js
  const options = ["xxx"]
  openIM.checkFriend(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name | Type     | Description |
| ---- | -------- | ----------- |
| data | string[] | 用户ID数组  |

- CallBack:


| Name | Type   | Description                |
| ---- | ------ | -------------------------- |
| data | string | 好友关系对象列表json字符串 |

  

## deleteFriend

从好友列表中删除用户。

- Example:

  ```js
  openIM.deleteFriend(uid).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name | Type   | Description |
| ---- | ------ | ----------- |
| uid  | string | 用户ID      |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 删除成功或失败描述 |

  

## addFriend

发起添加好友申请。

- Example:

  ```js
  const options:AddFriendParams = {
  	toUserID:"",
    reqMsg:""
  }
  openIM.addFriend(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name     | Type   | Description  |
| -------- | ------ | ------------ |
| toUserID | string | 用户ID       |
| reqMsg   | string | 申请验证信息 |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 发送请求成功或失败 |

  

## getRecvFriendApplicationList

获取收到的好友请求列表。

- Example:

  ```js
  openIM.getRecvFriendApplicationList().then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- CallBack:


| Name | Type   | Description                |
| ---- | ------ | -------------------------- |
| data | string | 好友请求对象列表json字符串 |



## getSendFriendApplicationList

获取发出的好友请求列表。

- Example:

  ```js
  openIM.getSendFriendApplicationList().then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- CallBack:


| Name | Type   | Description                |
| ---- | ------ | -------------------------- |
| data | string | 好友请求对象列表json字符串 |

  

## acceptFriendApplication

接受好友请求。

- Example:

  ```js
  const options:AccessFriendParams = {
    toUserID:"",
    handleMsg:""
  }
  openIM.acceptFriendApplication(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name      | Type   | Description |
| --------- | ------ | ----------- |
| toUserID  | string | 申请者ID    |
| handleMsg | string | 回复消息    |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 接受成功或失败描述 |

  

## refuseFriendApplication

拒绝好友请求。

- Example:

  ```js
  const options:AccessFriendParams = {
    toUserID:"",
    handleMsg:""
  }
  openIM.refuseFriendApplication(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name      | Type   | Description |
| --------- | ------ | ----------- |
| toUserID  | string | 申请者ID    |
| handleMsg | string | 回复消息    |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 拒绝成功或失败描述 |

  

## addBlack

将用户添加到黑名单。

- Example:

  ```js
  openIM.addBlack(uid).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name | Type   | Description |
| ---- | ------ | ----------- |
| uid  | string | 用户ID      |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 添加成功或失败描述 |

  

## removeBlack

从黑名单移除用户。

- Example:

  ```js
  openIM.removeBlack(uid).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name | Type   | Description |
| ---- | ------ | ----------- |
| uid  | string | 用户ID      |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 移除成功或失败描述 |

  

## getBlackList

获取黑名单列表。

- Example:

  ```js
  openIM.getBlackList().then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- CallBack:


| Name | Type   | Description                                                  |
| ---- | ------ | ------------------------------------------------------------ |
| data | string | 被拉入黑名单的[用户信息对象](https://doc.rentsoft.cn/client_doc/web_doc.html#%E7%94%A8%E6%88%B7%E4%BF%A1%E6%81%AF%E5%AF%B9%E8%B1%A1)列表json字符串 |

​    

# 群组

## createGroup

创建一个群聊，并指定群信息以及群成员。

- Example:

  ```js
  const groupBaseInfo:GroupInitInfo = {
  	groupName:"",
    groupType:0
  }
  const memberList:member[] = [
    {
      userID:"",
      roleLevel:1
    }
  ]
  const options:CreateGroupParams = {
  	groupBaseInfo,
    memberList
  }
  openIM.createGroup(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```
  
- Parameters:


| Name      | Type   | Description                  |
| --------- | ------ | ---------------------------- |
| groupName | string | 群名称                       |
| groupType | number | 群聊类型                     |
| userID    | string | 用户ID                       |
| roleLevel | number | 设置角色 1:普通成员 3:管理员 |

- CallBack:


| Name | Type   | Description |
| ---- | ------ | ----------- |
| data | string | 群聊ID      |

  

## getGroupsInfo

批量获取群组信息。

- Example:

  ```js
  const options = ["xxx"]
  openIM.getGroupsInfo(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name | Type     | Description |
| ---- | -------- | ----------- |
| data | string[] | 群组ID列表  |

- CallBack:


| Name | Type   | Description                                                  |
| ---- | ------ | ------------------------------------------------------------ |
| data | string | [群信息对象](https://doc.rentsoft.cn/client_doc/web_doc.html#%E7%BE%A4%E7%BB%84%E4%BF%A1%E6%81%AF%E5%AF%B9%E8%B1%A1)列表json字符串 |

  

## setGroupInfo

设置、更新群聊信息。

- Example:

  ```js
  const groupInfo:GroupBaseInfo = {
    groupName: "",
    introduction: "",
    notification: "",
    faceURL: "",
    ex: ""
  }
  const options:GroupInfo = {
    groupID:"xxx",
    groupInfo
  }
  openIM.setGroupInfo(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name         | Type   | Description    |
| ------------ | ------ | -------------- |
| groupName    | string | 群名称         |
| introduction | string | 群介绍         |
| notification | string | 群公告         |
| faceURL      | string | 群头像         |
| ex           | string | 群信息扩展字段 |
| groupID      | string | 群ID           |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 设置成功或失败描述 |

  

## getJoinedGroupList

获取已加入的群列表。

- Example:

  ```js
  openIM.getJoinedGroupList().then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- CallBack:


| Name | Type   | Description                                                  |
| ---- | ------ | ------------------------------------------------------------ |
| data | string | [群信息对象](https://doc.rentsoft.cn/client_doc/web_doc.html#%E7%BE%A4%E7%BB%84%E4%BF%A1%E6%81%AF%E5%AF%B9%E8%B1%A1)列表json字符串 |

  

## getGroupMemberList

获取群成员列表。

- Example:

  ```js
  const options:GetGroupMemberParams = {
    groupID:"",
    filter:0,
    offset:0,
    count:20
  }
  openIM.getGroupMemberList(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name    | Type   | Description                         |
| ------- | ------ | ----------------------------------- |
| groupID | string | 群聊ID                              |
| filter  | number | 过滤标识 0:所有成员 1:群主 2:管理员 |
| offset  | number | 分页拉取起点                        |
| count   | number | 分页拉取总数                        |

- CallBack:


| Name | Type   | Description                  |
| ---- | ------ | ---------------------------- |
| data | string | 群成员信息对象列表json字符串 |

  

## getGroupMembersInfo

批量获取群成员信息。

- Example:

  ```js
  const options:Omit<InviteGroupParams, "reason"> = {
    groupID:"",
    userIDList:["xxx"]
  }
  openIM.getGroupMembersInfo(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name       | Type     | Description  |
| ---------- | -------- | ------------ |
| groupID    | string   | 群聊ID       |
| userIDList | string[] | 群成员ID数组 |

- CallBack:


| Name | Type   | Description                  |
| ---- | ------ | ---------------------------- |
| data | string | 群成员信息对象列表json字符串 |

  

## joinGroup

申请加入群聊。

- Example:

  ```js
  const options:joinGroupParams = {
    groupID:"",
    reqMsg:""
  } 
  openIM.joinGroup(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| groupID | string | 群聊ID       |
| reqMsg  | string | 请求验证信息 |

- CallBack:


| Name | Type   | Description  |
| ---- | ------ | ------------ |
| data | string | 发送申请成功 |

  

## getRecvGroupApplicationList

获取收到的加入群聊申请列表。

- Example:

  ```js
  openIM.getRecvGroupApplicationList().then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- CallBack:


| Name | Type   | Description                |
| ---- | ------ | -------------------------- |
| data | string | 入群申请对象列表json字符串 |

  

## getSendGroupApplicationList

获取发出的加入群聊申请列表。

- Example:

  ```js
  openIM.getSendGroupApplicationList().then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- CallBack:


| Name | Type   | Description                |
| ---- | ------ | -------------------------- |
| data | string | 入群申请对象列表json字符串 |



## acceptGroupApplication

同意入群请求。

- Example:

  ```js
  const options:AccessGroupParams = {
    groupID:"",
    fromUserID:""，
    handleMsg:""
  }
  openIM.acceptGroupApplication(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name       | Type   | Description |
| ---------- | ------ | ----------- |
| groupID    | string | 群ID        |
| fromUserID | string | 申请者ID    |
| handleMsg  | string | 同意原因    |

- CallBack:


| Name | Type   | Description            |
| ---- | ------ | ---------------------- |
| data | string | 同意入群成功或失败描述 |

  

## refuseGroupApplication

拒绝入群请求。

- Example:

  ```js
  const options:AccessGroupParams = {
    groupID:"",
    fromUserID:""，
    handleMsg:""
  }
  openIM.refuseGroupApplication(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name       | Type   | Description |
| ---------- | ------ | ----------- |
| groupID    | string | 群ID        |
| fromUserID | string | 申请者ID    |
| handleMsg  | string | 拒绝原因    |

- CallBack:


| Name | Type   | Description            |
| ---- | ------ | ---------------------- |
| data | string | 拒绝入群成功或失败描述 |

  

## inviteUserToGroup

邀请用户加入群组(可批量)。

- Example:

  ```js
  const options:InviteGroupParams = {
    groupID:"",
    reason:"",
    userIDList:["xxx"]
  }
  openIM.inviteUserToGroup(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name       | Type     | Description  |
| ---------- | -------- | ------------ |
| groupID    | string   | 群聊ID       |
| reason     | string   | 请求验证信息 |
| userIDList | string[] | 邀请用户列表 |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 邀请成功或失败描述 |

  

## kickGroupMember

踢出群聊(可批量)。

- Example:

  ```js
  const options:InviteGroupParams = {
    groupID:"",
    reason:"",
    userIDList:["xxx"]
  }
  openIM.kickGroupMember(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name       | Type     | Description  |
| ---------- | -------- | ------------ |
| groupID    | string   | 群聊ID       |
| reason     | string   | 踢出原因     |
| userIDList | string[] | 邀请用户列表 |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 踢出成功或失败描述 |

  

## quitGroup

退出群聊。

- Example:

  ```js
  openIM.quitGroup(groupID).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name    | Type   | Description |
| ------- | ------ | ----------- |
| groupID | string | 群聊ID      |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 退出成功或失败描述 |

  

## transferGroupOwner

转让群主。

- Example:

  ```js
  const options:TransferGroupParams = {
  	groupID:"",
    newOwnerUserID:""
  }
  openIM.transferGroupOwner(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name           | Type   | Description |
| -------------- | ------ | ----------- |
| groupID        | string | 群聊ID      |
| newOwnerUserID | string | 用户ID      |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 转让成功或失败描述 |



# 事件监听

> 增加事件监听方式：
>
> ```typescript
> openIM.on(CbEvents.xxx,(data:WsResponse)=>{
>   ...
> })
> ```

## 连接状态监听回调

- 监听当前端与服务器的连接状况

| Event              | Callback Parameters                                          | Description   |
| ------------------ | ------------------------------------------------------------ | ------------- |
| OnConnectFailed    | -                                                            | 连接失败      |
| OnConnectSuccess   | -                                                            | 连接成功      |
| OnConnecting       | -                                                            | 连接中        |
| OnKickedOffline    | -                                                            | 被踢下线      |
| OnSelfInfoUpdated  | data:[用户信息对象](https://doc.rentsoft.cn/client_doc/web_doc.html#%E7%94%A8%E6%88%B7%E4%BF%A1%E6%81%AF%E5%AF%B9%E8%B1%A1)json字符串 | 修改个人信息  |
| OnUserTokenExpired | -                                                            | 账号token过期 |



## 消息发送状态监听回调

- 监听当前发送的消息进度以及是否发送成功

| Event      | Callback Parameters | Description  |
| ---------- | ------------------- | ------------ |
| OnProgress | data:发送进度       | 消息发送进度 |



## 接收新消息监听回调

- 收到新消息时会触发对应监听，开发者可在回调中进行处理

| Event                | Callback Parameters                                          | Description          |
| -------------------- | ------------------------------------------------------------ | -------------------- |
| OnRecvNewMessage     | data:新[消息对象](https://doc.rentsoft.cn/client_doc/web_doc.html#%E6%B6%88%E6%81%AF%E5%AF%B9%E8%B1%A1)json字符串 | 接收到新消息         |
| OnRecvMessageRevoked | data:被撤回消息的clientMsgID                                 | 其他用户撤回信息回执 |
| OnRecvC2CReadReceipt | data:[已读回执信息对象](https://doc.rentsoft.cn/client_doc/web_doc.html#%E5%B7%B2%E8%AF%BB%E5%9B%9E%E6%89%A7%E4%BF%A1%E6%81%AF%E5%AF%B9%E8%B1%A1)json字符串 | 消息已读回执         |



## 会话列表监听回调

- 会话列表变化时触发监听

| Event                            | Callback Parameters       | Description      |
| -------------------------------- | ------------------------- | ---------------- |
| OnConversationChanged            | data:会话列表json字符串   | 会话列表发生改变 |
| OnNewConversation                | data:新会话对象json字符串 | 有新会话产生     |
| OnSyncServerFailed               | -                         | -                |
| OnSyncServerFinish               | -                         | -                |
| OnSyncServerStart                | -                         | -                |
| OnTotalUnreadMessageCountChanged | data:消息未读总数         | 消息未读总数改变 |



## 好友关系监听回调

- 好友信息以及好友列表发生改变时

| Event                          | Callback Parameters | Description              |
| ------------------------------ | ------------------- | ------------------------ |
| OnBlackListAdd                 | -                   | 添加用户到黑名单         |
| OnBlackListDeleted             | -                   | 从黑名单中移除了某个用户 |
| OnFriendApplicationListAccept  | -                   | 发出的好友请求被接受     |
| OnFriendApplicationListAdded   | -                   | 好友请求列表增加         |
| OnFriendApplicationListDeleted | -                   | 好友请求列表减少         |
| OnFriendApplicationListReject  | -                   | 发出的好友请求被拒绝     |
| OnFriendInfoChanged            | -                   | 好友信息更新             |
| OnFriendListAdded              | -                   | 好友列表增加             |
| OnFriendListDeleted            | -                   | 好友列表减少             |



## 群组信息改变监听回调

- 群组信息改变或群成员状态改变时回调

| Event                    | Callback Parameters | Description          |
| ------------------------ | ------------------- | -------------------- |
| OnApplicationProcessed   | -                   | 入群申请被处理       |
| OnGroupCreated           | -                   | 群组创建             |
| OnGroupInfoChanged       | -                   | 群组信息改变         |
| OnMemberEnter            | -                   | 有新成员加入群组     |
| OnMemberInvited          | -                   | 邀请新成员加入了群组 |
| OnMemberKicked           | -                   | 有群成员被踢出       |
| OnMemberLeave            | -                   | 有群成员退群         |
| OnReceiveJoinApplication | -                   | 收到入群申请         |





# 数据对象结构

## 用户信息对象

- interface

  ```typescript
  export interface UserInfo {
      uid:    string;
      name:   string;
      icon:   string;
      gender: number;
      mobile: string;
      birth:  string;
      email:  string;
      ex:     string;
  }
  ```

  

| Name   | Type   | Description                    |
| ------ | ------ | ------------------------------ |
| uid    | string | 用户id                         |
| name   | string | 用户昵称                       |
| icon   | string | 用户头像                       |
| gender | number | 用户性别 0:                    |
| mobile | string | 用户手机号                     |
| birth  | string | 用户生日                       |
| email  | string | 用户邮箱地址                   |
| ex     | string | 用户信息扩展字段对象Json字符串 |



## 消息对象

- interface

  ```typescript
  export interface Message {
      clientMsgID:    string;
      serverMsgID:    string;
      createTime:     number;
      sendTime:       number;
      sessionType:    number;
      sendID:         string;
      recvID:         string;
      msgFrom:        number;
      contentType:    number;
      platformID:     number;
      forceList:      string|null;
      senderNickName: string;
      senderFaceUrl:  string;
      groupID:        string;
      content:        string;
      seq:            number;
      isRead:         boolean;
      status:         number;
      remark:         string;
      pictureElem:    PictureElem;
      soundElem:      SoundElem;
      videoElem:      VideoElem;
      fileElem:       FileElem;
      mergeElem:      MergeElem;
      atElem:         AtElem;
      locationElem:   LocationElem;
      customElem:     CustomElem;
      quoteElem:      QuoteElem;
  }
  
  export interface AtElem {
      text:       string;
      atUserList: string[]|null;
      isAtSelf:   boolean;
  }
  
  export interface CustomElem {
      data:        string;
      description: string;
      extension:   string;
  }
  
  export interface FileElem {
      filePath:  string;
      uuid:      string;
      sourceUrl: string;
      fileName:  string;
      fileSize:  number;
  }
  
  export interface LocationElem {
      description: string;
      longitude:   number;
      latitude:    number;
  }
  
  export interface MergeElem {
      title:        string;
      abstractList: string[]|null;
      multiMessage: string[]|null;
  }
  
  export interface PictureElem {
      sourcePath:      string;
      sourcePicture:   Picture;
      bigPicture:      Picture;
      snapshotPicture: Picture;
  }
  
  export interface Picture {
      uuid:   string;
      type:   string;
      size:   number;
      width:  number;
      height: number;
      url:    string;
  }
  
  export interface QuoteElem {
      quoteMessage: string[];
  }
  
  export interface SoundElem {
      uuid:      string;
      soundPath: string;
      sourceUrl: string;
      dataSize:  number;
      duration:  number;
  }
  
  export interface VideoElem {
      videoPath:      string;
      videoUUID:      string;
      videoUrl:       string;
      videoType:      string;
      videoSize:      number;
      duration:       number;
      snapshotPath:   string;
      snapshotUUID:   string;
      snapshotSize:   number;
      snapshotUrl:    string;
      snapshotWidth:  number;
      snapshotHeight: number;
  }
  
  ```



### Message

| Name           | Type         | Description |
| -------------- | ------------ | ----------- |
| clientMsgID    | string       | 消息唯一ID |
| serverMsgID    | string       | 消息服务器ID，暂时不使用 |
| createTime     | number       | 消息创建时间 |
| sendTime       | number       | 消息发送时间 |
| sessionType    | number       | 会话类型  1:单聊 2:群聊 |
| sendID         | string       | 发送者ID |
| recvID         | string       | 接收者ID |
| msgFrom        | number       | 标识消息是用户级别还是系统级别  100:用户 200:系统 |
| contentType    | number       | 消息类型：<br/>101:文本消息<br/>102:图片消息<br/>103:语音消息<br/>104:视频消息<br/>105:文件消息<br/>106:@消息<br/>107:合并消息<br/>108:转发消息<br/>109:位置消息<br/>110:自定义消息<br/>111:撤回消息回执<br/>112:C2C已读回执<br/>113:正在输入状态 |
| platformID     | number       | 平台类型 1:ios 2:android 3:windows 4:osx 5:web 6:mini 7:linux |
| forceList      | array&#124;null  | 强制推送列表(被@的用户) |
| senderNickName | string       | 发送者昵称 |
| senderFaceUrl  | string       | 发送者头像 |
| groupID        | string       | 群聊ID |
| content        | string       | 消息内容 |
| seq            | number       | 消息唯一序列号 |
| isRead         | bool         | 是否已读 |
| status         | number       | 消息状态 1:发送中 2:发送成功 3:发送失败 4:已删除 5:已撤回 |
| remark         | string       | 消息备注 |
| pictureElem    | PictureElem  | 图片信息 |
| soundElem      | SoundElem    | 语音信息 |
| videoElem      | VideoElem    | 视频信息 |
| fileElem       | FileElem     | 文件信息 |
| mergeElem      | MergeElem    | 合并信息 |
| atElem         | AtElem       | @信息 |
| locationElem   | LocationElem | 位置信息 |
| customElem     | CustomElem   | 自定义信息 |
| quoteElem      | QuoteElem    | 引用消息 |



### PictureElem

| Name            | Type    | Description  |
| --------------- | ------- | ------------ |
| sourcePath      | string  | 本地资源地址 |
| sourcePicture   | Picture | 本地图片详情 |
| bigPicture      | Picture | 大图详情     |
| snapshotPicture | Picture | 缩略图详情   |



### Picture

| Name   | Type   | Description |
| ------ | ------ | ----------- |
| uuid   | string | 唯一ID      |
| type   | string | 图片类型    |
| size   | number | 图片大小    |
| width  | number | 图片宽度    |
| height | number | 图片高度    |
| url    | String | 图片oss地址 |



### SoundElem

| Name      | Type   | Description  |
| --------- | ------ | ------------ |
| uuid      | string | 唯一ID       |
| soundPath | string | 本地资源地址 |
| sourceUrl | string | oss地址      |
| dataSize  | number | 音频大小     |
| duration  | number | 音频时长     |



### VideoElem

| Name           | Type   | Description      |
| -------------- | ------ | ---------------- |
| videoPath      | string | 视频本地资源地址 |
| videoUUID      | string | 视频唯一ID       |
| videoUrl       | string | 视频oss地址      |
| videoType      | string | 视频类型         |
| videoSize      | number | 视频大小         |
| duration       | number | 视频时长         |
| snapshotPath   | string | 视频快照本地地址 |
| snapshotUUID   | string | 视频快照唯一ID   |
| snapshotSize   | number | 视频快照大小     |
| snapshotUrl    | string | 视频快照oss地址  |
| snapshotWidth  | number | 视频快照宽度     |
| snapshotHeight | number | 视频快照高度     |



### FileElem

| Name      | Type   | Description      |
| --------- | ------ | ---------------- |
| filePath  | string | 文件本地资源地址 |
| uuid      | string | 唯一ID           |
| sourceUrl | string | oss地址          |
| fileName  | string | 文件名称         |
| fileSize  | number | 文件大小         |



### MergeElem

| Name         | Type        | Description |
| ------------ | ----------- | ----------- |
| title        | string      | 合并消息标题 |
| abstractList | array&#124;null | 摘要列表 |
| multiMessage | array&#124;null | 合并消息列表 |



### AtElem

| Name       | Type        | Description |
| ---------- | ----------- | ----------- |
| text       | string      | 文本消息 |
| atUserList | array&#124;null | @用户ID列表 |
| isAtSelf   | bool        | 是否@自己 |



### LocationElem

| Name        | Type   | Description |
| ----------- | ------ | ----------- |
| description | String | 描述        |
| longitude   | number | 经度        |
| latitude    | number | 纬度        |



### CustomElem

| Name        | Type   | Description              |
| ----------- | ------ | ------------------------ |
| data        | string | 自定义消息json字符串     |
| extension   | string | 自定义消息扩展json字符串 |
| description | string | 描述                     |



### QuoteElem

| Name         | Type        | Description |
| ------------ | ----------- | ----------- |
| quoteMessage | string&#124;null | 引用消息 |



## 会话对象

- interface

  ```typescript
  export interface Conversation {
      conversationID:    string;
      conversationType:  number;
      userID:            string;
      groupID:           string;
      showName:          string;
      faceURL:           string;
      recvMsgOpt:        number;
      unreadCount:       number;
      latestMsg:         string;
      latestMsgSendTime: number;
      draftText:         string;
      draftTimestamp:    number;
      isPinned:          number;
  }
  
  ```



| Name              | Type   | Description                                                  |
| ----------------- | ------ | ------------------------------------------------------------ |
| conversationID    | string | 会话ID                                                       |
| conversationType  | number | 会话类型  1:单聊 2:群聊                                      |
| userID            | string | 会话对象用户ID                                               |
| groupID           | string | 会话群聊ID                                                   |
| showName          | string | 会话对象(用户或群聊)名称                                     |
| faceURL           | string | 用户头像或群聊头像                                           |
| recvMsgOpt        | number | 接收消息选项：<br>1:在线正常接收消息，离线时进行推送<br>2:不会接收到消息<br>3:在线正常接收消息，离线不会有推送 |
| unreadCount       | number | 未读消息数量                                                 |
| latestMsg         | string | 最后一条消息 [消息对象]()json字符串                          |
| latestMsgSendTime | number | 最后一条消息发送时间(ns)                                     |
| draftText         | string | 会话草稿                                                     |
| draftTimestamp    | number | 会话草稿设置时间                                             |
| isPinned          | number | 是否置顶                                                     |





## 好友信息对象

- interface

  ```typescript
  export interface FriendInfo {
      uid:           string;
      name:          string;
      icon:          string;
      gender:        number;
      mobile:        string;
      birth:         string;
      email:         string;
      ex:            string;
      comment:       string;
      isInBlackList: number;
  }
  ```

  

| Name          | Type   | Description      |
| ------------- | ------ | ---------------- |
| uid           | string | 用户ID           |
| name          | string | 用户名称         |
| icon          | string | 用户头像         |
| gender        | number | 用户性别         |
| mobile        | string | 用户手机号       |
| birth         | string | 用户出生日期     |
| email         | string | 用户邮箱号       |
| ex            | string | 用户信息扩展字段 |
| comment       | string | 好友备注         |
| isInBlackList | number | 是否在黑名单内   |



## 群组信息对象

- interface

  ```typescript
  export interface GroupInfo {
      groupID:      string;
      groupName:    string;
      notification: string;
      introduction: string;
      faceURL:      string;
      ex:           string;
      ownerId:      string;
      createTime:   number;
      memberCount:  number;
  }
  ```

  

| Name         | Type   | Description    |
| ------------ | ------ | -------------- |
| groupID      | string | 群组ID         |
| groupName    | string | 群组名称       |
| notification | string | 群公告         |
| introduction | string | 群介绍         |
| faceURL      | string | 群头像         |
| ex           | string | 群信息扩展字段 |
| ownerId      | string | 群主ID         |
| createTime   | number | 群组创建时间   |
| memberCount  | number | 群成员总数     |



## 已读回执信息对象

- interface

  ```typescript
  export interface Welcome {
      contentType: number;
      msgFrom:     number;
      msgIDList:   string[];
      readTime:    number;
      sessionType: number;
  }
  ```



| Name        | Type     | Description                                                  |
| ----------- | -------- | ------------------------------------------------------------ |
| contentType | number   | 消息类型：<br>101:文本消息<br>102:图片消息<br>103:语音消息<br>104:视频消息<br>105:文件消息<br>106:@消息<br>107:合并消息<br/>108:转发消息<br/>109:位置消息<br/>110:自定义消息<br/>111:撤回消息回执<br/>112:C2C已读回执<br/>113:正在输入状态 |
| msgFrom     | number   | 标识消息是用户级别还是系统级别  100:用户 200:系统            |
| msgIDList   | string[] | 已读消息clientMsgID数组                                      |
| readTime    | number   | 已读时间                                                     |
| sessionType | number   | 会话类型  1:单聊 2:群聊                                      |



## Promise 返回参数

- type

  ```typescript
  export type WsResponse = {
    event: RequestFunc;
    errCode: number;
    errMsg: string;
    data: any;
    operationID: string;
  };
  
  ```

  

| Name        | Type        | Description         |
| ----------- | ----------- | ------------------- |
| event       | RequestFunc | 事件(方法标识)      |
| errCode     | number      | 错误码，0为正确返回 |
| errMsg      | string      | 错误描述信息        |
| data        | any         | 返回参数            |
| operationID | string      | 操作唯一ID          |
