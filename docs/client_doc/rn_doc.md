# 初始化

## initSDK

初始化并登录OpenIM SDK Server，使用用户ID(uid)和token登录，uid来自于自身业务服务器，token需要业务服务器根据secret向OpenIM服务端交换获取。

- Example:

  ```js
  const config = {
    ipApi: "http://1.14.194.38:10000",
    ipWs: "ws://1.14.194.38:17778",
    platform: 1,
    dbDir:"..."
  };
  openIMSDK.initSDK(config).then(res => {
    console.log("init success...");
  }).catch((errCode,err) => {
    console.log("init failed...");
  })
  ```

- Parameters:


| Name     | Type   | Description                                                  |
| -------- | ------ | ------------------------------------------------------------ |
| ipApi    | String | api域名或地址   一般为10000端口                              |
| ipWs     | string | websocket地址  一般为17778端口                               |
| platform | int    | 平台类型 1:ios 2:android 3:windows 4:osx 5:web&mini 7:linux 8:管理员 |
| dbDir    | string | SDK数据存放目录（绝对路径）                                  |

- Return:


| Name | Type   | Description    |
| ---- | ------ | -------------- |
| res  | string | 初始化成功描述 |



## login

使用用户ID(uid)和token登录，uid来自于自身业务服务器，token需要业务服务器根据secret向OpenIM服务端交换获取。

- Example:

  ```js
  openIMSDK.login(uid,token).then(res=>{}).catch((errCode,err)=>{})
  ```

- Parameters:


| Name  | Type   | Description |
| ----- | ------ | ----------- |
| uid   | string | 用户ID      |
| token | string | 用户token   |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 登录成功     |
| err     | string | 登录失败描述 |
| errCode | string | 错误码       |

  

## logout

登出OpenIM，通常在切换账号的时候调用，清楚登录态以及内存中的所有数据。

- Example:

  ```js
  openIMSDK.logout().then(res=>{}).catch((errCode,err)=>{})
  ```

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 登出成功     |
| err     | string | 登出失败描述 |
| errCode | string | 错误码       |

  

## getLoginStatus

获取当前用户登录状态。

- Example:

  ```js
  openIMSDK.getLoginStatus.then(res=>{})
  ```

- Return:


| Name | Type | Description                                   |
| ---- | ---- | --------------------------------------------- |
| res  | int  | 101:登录成功 102:登陆中 103:登录失败 201:登出 |

  

# 用户资料

## getUsersInfo

根据用户ID获取用户资料，可批量获取。

- Example:

  ```js
  openIMSDK.getUsersInfo(uidList).then(res=>{}).catch((errCode,err)=>{})
  ```

- Parameters:


| Name    | Type     | Description |
| ------- | -------- | ----------- |
| uidList | string[] | 用户ID数组  |

- Return:


| Name    | Type   | Description                    |
| ------- | ------ | ------------------------------ |
| res     | string | [用户信息对象]()列表Json字符串 |
| err     | string | 获取失败描述                   |
| errCode | int    | 错误码                         |

  

## setSelfInfo

根据用户ID获取用户资料，可批量获取。

- Example:

  ```js
  openIMSDK.setSelfInfo(info).then(res=>{}).catch((errCode,err)=>{})
  ```

- Parameters:


| Name | Type         | Description      |
| ---- | ------------ | ---------------- |
| Info | [UserInfo]() | [用户信息对象]() |

- Return:


| Name    | Type   | Description                                                  |
| ------- | ------ | ------------------------------------------------------------ |
| res     | string | [用户信息对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E7%94%A8%E6%88%B7%E4%BF%A1%E6%81%AF%E5%AF%B9%E8%B1%A1)列表Json字符串(可只传要修改的字段) |
| err     | string | 获取失败描述                                                 |
| errCode | int    | 错误码                                                       |

  

# 消息收发

## createTextMessage

创建一条文字消息。

- Example:

  ```js
  const newTextMsg = await openIMSDK.createTextMessage(text)
  ```

- Parameters:


| Name | Type   | Description  |
| ---- | ------ | ------------ |
| text | string | 消息文字内容 |

- Returns:


| Name       | Type   | Description          |
| ---------- | ------ | -------------------- |
| newTextMsg | string | 文字信息结构体字符串 |



## createTextAtMessage

创建一条@文字消息。

- Example:

  ```js
  const newAtTextMsg = await openIMSDK.createTextAtMessage(text，atList)
  ```

- Parameters:


| Name   | Type   | Description           |
| ------ | ------ | --------------------- |
| text   | string | 消息文字内容          |
| atList | string | @用户id数组json字符串 |

- Returns:


| Name         | Type   | Description           |
| ------------ | ------ | --------------------- |
| newAtTextMsg | string | @文字信息结构体字符串 |

  

## createImageMessage

根据相对路径创建一条图片消息。

- Example:

  ```js
  const newImageMsg =await openIMSDK.createImageMessage(imagePath)
  ```

- Parameters:


| Name      | Type   | Description        |
| --------- | ------ | ------------------ |
| imagePath | string | 图片地址(相对路径) |

- Returns:


| Name        | Type   | Description          |
| ----------- | ------ | -------------------- |
| newImageMsg | string | 图片信息结构体字符串 |

  

## createImageMessageFromFullPath

根据绝对路径创建一条图片消息。

- Example:

  ```js
  const newImageMsg = await openIMSDK.createImageMessageFromFullPath(imagePath)
  ```

- Parameters:


| Name      | Type   | Description        |
| --------- | ------ | ------------------ |
| imagePath | string | 图片地址(绝对路径) |

- Returns:


| Name        | Type   | Description          |
| ----------- | ------ | -------------------- |
| newImageMsg | string | 图片信息结构体字符串 |



## createImageMessageByURL

根据自定义文件url创建一条图片消息，用户可将图片上传到任意云空间后，将对应下载地址及文件信息传入即可，但通过该API创建的信息需要调用`sendMessageNotOss`进行发送。

- Example:

  ```js
  const sourceInfo = {	//原图片信息
    uuid:"",
    type:"png",
    size:12465,
    width:1080,
    height:720,
    url:"http://www.ptbird.cn/usr/uploads/2019/07/2213642051.png"
  }
  const bigPicInfo = sourceInfo					//大图信息
  const snapshotPicInfo = sourceInfo		//缩略图信息
  const newImageMsg = await openIMSDK.createImageMessageByURL(sourceInfo,bigPicInfo,snapshotPicInfo)
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


| Name        | Type   | Description          |
| ----------- | ------ | -------------------- |
| newImageMsg | string | 图片信息结构体字符串 |



## createSoundMessage

根据相对路径创建一条语音消息。

- Example:

  ```js
  const newSoundMsg = await openIMSDK.createSoundMessage(soundPath,duration)
  ```

- Parameters:


| Name      | Type   | Description            |
| --------- | ------ | ---------------------- |
| soundPath | string | 音频文件地址(相对路径) |
| duration  | int    | 语音时长               |

- Returns:


| Name        | Type   | Description          |
| ----------- | ------ | -------------------- |
| newSoundMsg | string | 语音信息结构体字符串 |

  

## createSoundMessageFromFullPath

根据绝对路径创建一条语音消息。

- Example:

  ```js
  const newSoundMsg = await openIMSDK.createSoundMessageFromFullPath(soundPath,duration)
  ```

- Parameters:


| Name      | Type   | Description            |
| --------- | ------ | ---------------------- |
| soundPath | string | 音频文件地址(绝对路径) |
| duration  | int    | 语音时长               |

- Returns:


| Name        | Type   | Description          |
| ----------- | ------ | -------------------- |
| newSoundMsg | string | 语音信息结构体字符串 |

  

## createSoundMessageByURL

根据自定义文件url创建一条语音消息，用户可将语音文件上传到任意云空间后，将对应下载地址及文件信息传入即可，但通过该API创建的信息需要调用`sendMessageNotOss`进行发送。

- Example:

  ```js
  const soundInfo = {
    uuid:"xx",
    soundPath:"xx",
    sourceUrl:"http://xxx/mic.mp3",
    dataSize:1234,
    duration:42
  }
  const newSoundMsg = await openIMSDK.createSoundMessageByURL(soundInfo)
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


| Name        | Type   | Description          |
| ----------- | ------ | -------------------- |
| newSoundMsg | string | 语音信息结构体字符串 |



## createVideoMessage

根据相对路径创建一条视频消息。

- Example:

  ```js
  const newVideoMsg = await openIMSDK.createVideoMessage(videoPath,videoType,duration,snapshotPath)
  ```

- Parameters:


| Name         | Type   | Description            |
| ------------ | ------ | ---------------------- |
| videoPath    | string | 视频文件地址(相对路径) |
| videoType    | string | 视频类型(MP4,AVI..)    |
| duration     | int    | 视频时长               |
| snapshotPath | string | 视频快照地址(相对路径) |

- Returns:


| Name        | Type   | Description          |
| ----------- | ------ | -------------------- |
| newVideoMsg | string | 视频信息结构体字符串 |

  

## createVideoMessageFromFullPath

根据绝对路径创建一条视频消息。

- Example:

  ```js
  const newVideoMsg = await openIMSDK.createVideoMessageFromFullPath(videoPath,videoType,duration,snapshotPath)
  ```

- Parameters:


| Name         | Type   | Description            |
| ------------ | ------ | ---------------------- |
| videoPath    | string | 视频文件地址(绝对路径) |
| videoType    | string | 视频类型(MP4,AVI..)    |
| duration     | int    | 视频时长               |
| snapshotPath | string | 视频快照地址(绝对路径) |

- Returns:


| Name        | Type   | Description          |
| ----------- | ------ | -------------------- |
| newVideoMsg | string | 视频信息结构体字符串 |

  

## createVideoMessageByURL

根据自定义文件url创建一条视频消息，用户可将视频文件上传到任意云空间后，将对应下载地址及文件信息传入即可，但通过该API创建的信息需要调用`sendMessageNotOss`进行发送。

- Example:

  ```js
  const videoInfo = {
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
  }
  const newVideoMsg = await openIMSDK.createVideoMessageByURL(videoInfo)
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


| Name        | Type   | Description          |
| ----------- | ------ | -------------------- |
| newVideoMsg | string | 语音信息结构体字符串 |



## createFileMessage

根据相对路径创建一条文件消息。

- Example:

  ```js
  const newFileMsg = await openIMSDK.createFileMessage(filePath,fileName)
  ```

- Parameters:


| Name     | Type   | Description        |
| -------- | ------ | ------------------ |
| filePath | string | 文件地址(相对路径) |
| fileName | string | 文件名称           |

- Returns:


| Name       | Type   | Description          |
| ---------- | ------ | -------------------- |
| newFileMsg | string | 文件信息结构体字符串 |



## createFileMessageByURL

根据自定义文件url创建一条文件消息，用户可将文件上传到任意云空间后，将对应下载地址及文件信息传入即可，但通过该API创建的信息需要调用`sendMessageNotOss`进行发送。

- Example:

  ```js
  const fileInfo = {
    filePath: "",
    fileName: "test",
    uuid:"xxsadsa",
    sourceUrl:"wwwm",
    fileSize:1234
  }
  const newFileMsg = await openIMSDK.createFileMessageByURL(fileInfo)
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


| Name       | Type   | Description          |
| ---------- | ------ | -------------------- |
| newFileMsg | string | 文件信息结构体字符串 |

  

## createMergerMessage

创建一条合并消息。

- Example:

  ```js
  const newMergerMsg = await openIMSDK.createMergerMessage(messageList,title,summaryList)
  ```

- Parameters:


| Name        | Type     | Description                                                  |
| ----------- | -------- | ------------------------------------------------------------ |
| messageList | string[] | [消息对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E6%B6%88%E6%81%AF%E5%AF%B9%E8%B1%A1)json字符串列表 |
| title       | string   | 合并消息标题                                                 |
| summaryList | string[] | 合并消息的摘要列表                                           |

- Returns:


| Name         | Type   | Description          |
| ------------ | ------ | -------------------- |
| newMergerMsg | string | 合并信息结构体字符串 |

  

## createForwardMessage

创建一条转发消息。

- Example:

  ```js
  const newForwardMsg = await openIMSDK.createForwardMessage(message)
  ```

- Parameters:


| Name    | Type   | Description          |
| ------- | ------ | -------------------- |
| message | string | 消息结构体json字符串 |

- Returns:


| Name          | Type   | Description          |
| ------------- | ------ | -------------------- |
| newForwardMsg | string | 转发信息结构体字符串 |


​    

## createLocationMessage

创建一条地理位置消息。

- Example:

  ```js
  const newLocationMsg = await openIMSDK.createLocationMessage(latitude,longitude,desc)
  ```

- Parameters:


| Name      | Type   | Description |
| --------- | ------ | ----------- |
| desc      | string | 描述信息    |
| latitude  | double | 纬度        |
| longitude | double | 经度        |

- Returns:


| Name           | Type   | Description          |
| -------------- | ------ | -------------------- |
| newLocationMsg | string | 地理信息结构体字符串 |


​    

## createCustomMessage

创建一条自定义消息。

- Example:

  ```js
  const newCustomMsg = await openIMSDK.createCustomMessage(data,expand,desc)
  ```

- Parameters:


| Name   | Type   | Description        |
| ------ | ------ | ------------------ |
| data   | object | 自定义信息         |
| expand | object | 自定义信息扩展字段 |
| desc   | string | 自定义消息描述     |

- Returns:


| Name         | Type   | Description            |
| ------------ | ------ | ---------------------- |
| newCustomMsg | string | 自定义信息结构体字符串 |


​    

## createQuoteMessage

创建一条引用消息。

- Example:

  ```js
  const newQuoteMsg = await openIMSDK.createQuoteMessage(text,message)
  ```

- Parameters:


| Name    | Type   | Description                                                  |
| ------- | ------ | ------------------------------------------------------------ |
| text    | string | 消息内容                                                     |
| message | string | 引用[消息对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E6%B6%88%E6%81%AF%E5%AF%B9%E8%B1%A1)json字符串 |

- Returns:


| Name        | Type   | Description          |
| ----------- | ------ | -------------------- |
| newQuoteMsg | string | 引用消息结构体字符串 |




## sendMessage/sendMessageNotOss

OpenIM消息按照消息发送的目标可分为：“单聊消息”和“群聊消息”，在发送单聊消息时设置groupID为空字符串，同理发送群聊消息时设置userID为空字符串即可。

- Example:

  ```js
  openIMSDK.sendMessage(message,receiver,groupID,onlineUserOnly).then(res=>{}).catch((errCode,err)=>{})
  ```

- Returns:


| Name           | Type   | Description          |
| -------------- | ------ | -------------------- |
| message        | string | 消息结构体json字符串 |
| receiver       | string | 接收者ID（单聊）     |
| groupID        | string | 接收群组ID（群聊）   |
| onlineUserOnly | bool   | 是否仅在线用户接收   |

- Return:


| Name    | Type   | Description        |
| ------- | ------ | ------------------ |
| res     | string | 消息发送成功       |
| errCode | string | 消息发送失败错误码 |
| err     | string | 消息发送失败描述   |

- Events:

| Name                | Data                                                     | Description      |
| ------------------- | -------------------------------------------------------- | ---------------- |
| SendMessageProgress | progress:发送进度<br/>message:对应的消息结构体json字符串 | 消息发送进度监听 |

  

## getHistoryMessageList

分页拉取单聊或群聊的历史消息。

- Example:

  ```js
  const options = {
    groupID:"",
    startMsg:"msg",
    count:12,
    userID:"userID"
  }
  openIMSDK.getHistoryMessageList(options).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name     | Type   | Description                      |
| -------- | ------ | -------------------------------- |
| groupID  | string | 群聊ID，拉取群聊时传入，否则为“” |
| startMsg | string | 上一次拉取的最后一条消息结构体   |
| count    | int    | 每次拉取的条数                   |
| userID   | string | 用户ID，拉取单聊时传入，否则为“” |

- Return:


| Name    | Type   | Description                                                  |
| ------- | ------ | ------------------------------------------------------------ |
| res     | string | 历史[消息对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E6%B6%88%E6%81%AF%E5%AF%B9%E8%B1%A1)数组json字符串 |
| err     | string | 获取失败描述                                                 |
| errCode | string | 错误码                                                       |

  

## revokeMessage

撤回某条消息。

- Example:

  ```js
  openIMSDK.revokeMessage(msg).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name | Type   | Description                  |
| ---- | ------ | ---------------------------- |
| msg  | string | 要撤回的消息结构体json字符串 |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 撤回成功     |
| err     | string | 撤回失败描述 |
| errCode | string | 错误码       |

  

## markC2CMessageAsRead

实时消息已读回执，在 C2C 单聊场景下，当接收方通过 markC2CMessageAsRead接口将来自某人的消息标记为已读时，消息的发送方将会收到“已读回执”，表示“xxx 已经读过我的消息了”。

- Example:

  ```js
  openIMSDK.markC2CMessageAsRead(uid,clientMsgIDList).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name            | Type     | Description             |
| --------------- | -------- | ----------------------- |
| uid             | string   | 接收ID                  |
| clientMsgIDList | string[] | 已读消息clientMsgID数组 |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 标记成功     |
| err     | string | 标记失败描述 |
| errCode | string | 错误码       |

  

## typingStatusUpdate

更新正在输入状态。

- Example:

  ```js
  openIMSDK.typingStatusUpdate(uid,typing)
  ```
  
- Parameters:


| Name   | Type   | Description    |
| ------ | ------ | -------------- |
| uid    | string | 接收者ID       |
| typing | string | 自定义输入描述 |

  

## deleteMessageFromLocalStorage

删除本地消息。

- Example:

  ```js
  openIMSDK.deleteMessageFromLocalStorage(msg).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| msg  | string | 要删除的消息结构体 |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 删除成功     |
| err     | string | 删除失败描述 |
| errCode | string | 错误码       |

  

## insertSingleMessageToLocalStorage

插入一条消息到本地。

- Example:

  ```js
  openIMSDK.insertSingleMessageToLocalStorage(msg,recevier,sender).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name     | Type   | Description |
| -------- | ------ | ----------- |
| msg      | string | 消息结构体  |
| recevier | string | 接收者ID    |
| sender   | string | 发送者ID    |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 插入成功     |
| err     | string | 插入失败描述 |
| errCode | string | 错误码       |

  

## findMessages

根据消息ID查找本地消息。

- Example:

  ```js
  openIMSDK.findMessages(clientMsgIDList).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name            | Type     | Description         |
| --------------- | -------- | ------------------- |
| clientMsgIDList | string[] | 消息clientMsgID数组 |

- Return:


| Name    | Type   | Description                |
| ------- | ------ | -------------------------- |
| res     | string | [消息对象]()数组json字符串 |
| err     | string | 获取失败描述               |
| errCode | string | 错误码                     |

  

# 会话

## getAllConversationList

获取所有会话列表。

- Example:

  ```js
  openIMSDK.getAllConversationList().then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Return:


| Name    | Type   | Description                                                  |
| ------- | ------ | ------------------------------------------------------------ |
| res     | string | [会话对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E4%BC%9A%E8%AF%9D%E5%AF%B9%E8%B1%A1)列表json字符串 |
| err     | string | 获取失败描述                                                 |
| errCode | string | 错误码                                                       |

  

## getOneConversation

根据用户ID或群聊ID和session类型获取单个会话。

- Example:

  ```js
  openIMSDK.getOneConversation(sourceID,session).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name     | Type   | Description     |
| -------- | ------ | --------------- |
| sourceID | string | 用户ID或群聊ID  |
| session  | int    | 单聊为1 群聊为2 |

- Return:


| Name    | Type   | Description                                                  |
| ------- | ------ | ------------------------------------------------------------ |
| res     | string | [会话对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E4%BC%9A%E8%AF%9D%E5%AF%B9%E8%B1%A1)json字符串 |
| err     | string | 获取失败描述                                                 |
| errCode | string | 错误码                                                       |

  

## getMultipleConversation

根据会话ID获取多个会话。

- Example:

  ```js
  openIMSDK.getMultipleConversation(conversationIDs).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name            | Type     | Description |
| --------------- | -------- | ----------- |
| conversationIDs | string[] | 会话ID数组  |

- Return:


| Name    | Type   | Description                                                  |
| ------- | ------ | ------------------------------------------------------------ |
| res     | string | [会话对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E4%BC%9A%E8%AF%9D%E5%AF%B9%E8%B1%A1)列表json字符串 |
| err     | string | 获取失败描述                                                 |
| errCode | int    | 错误码                                                       |

  

## deleteConversation

根据会话ID删除指定会话。

- Example:

  ```js
  openIMSDK.deleteConversation(conversationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name           | Type   | Description |
| -------------- | ------ | ----------- |
| conversationID | string | 会话ID      |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 删除成功     |
| err     | string | 删除失败描述 |
| errCode | string | 错误码       |

  

## setConversationDraft

设置会话草稿信息。

- Example:

  ```js
  openIMSDK.setConversationDraft(conversationID,draft).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name           | Type   | Description |
| -------------- | ------ | ----------- |
| conversationID | string | 会话ID      |
| draft          | string | 草稿信息    |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 设置成功     |
| err     | string | 设置失败描述 |
| errCode | int    | 错误码       |

  

## pinConversation

置顶会话。

- Example:

  ```js
  openIMSDK.pinConversation(conversationID,isPinned).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name           | Type   | Description |
| -------------- | ------ | ----------- |
| conversationID | string | 会话ID      |
| isPinned       | bool   | 是否置顶    |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 置顶成功     |
| err     | string | 置顶失败描述 |
| errCode | string | 错误码       |

  

## markSingleMessageHasRead

标记单聊会话消息为已读。

- Example:

  ```js
  openIMSDK.markSingleMessageHasRead(uid).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name | Type   | Description |
| ---- | ------ | ----------- |
| uid  | string | 用户ID      |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 标记成功     |
| err     | string | 标记失败描述 |
| errCode | string | 错误码       |

  

## markGroupMessageHasRead

标记群聊会话消息已读。

- Example:

  ```js
  openIMSDK.markGroupMessageHasRead(groupID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name    | Type   | Description |
| ------- | ------ | ----------- |
| groupID | string | 群组ID      |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 标记成功     |
| err     | string | 标记失败描述 |
| errCode | string | 错误码       |

  

## getTotalUnreadMsgCount

获取消息总未读。

- Example:

  ```js
  openIMSDK.getTotalUnreadMsgCount().then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 消息总未读数 |
| err     | string | 获取失败描述 |
| errCode | string | 错误码       |

​    

# 好友

## getFriendList

获取好友列表。

- Example:

  ```js
  openIMSDK.getFriendList().then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Return:


| Name    | Type   | Description                                                  |
| ------- | ------ | ------------------------------------------------------------ |
| res     | string | [好友信息](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E5%A5%BD%E5%8F%8B%E4%BF%A1%E6%81%AF%E5%AF%B9%E8%B1%A1)对象列表json字符串 |
| err     | string | 获取失败描述                                                 |
| errCode | string | 错误码                                                       |

  

## getFriendsInfo

获取好友信息。

- Example:

  ```js
  openIMSDK.getFriendsInfo(uidList).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name    | Type  | Description |
| ------- | ----- | ----------- |
| uidList | array | 好友ID数组  |

- Return:


| Name    | Type   | Description                                                  |
| ------- | ------ | ------------------------------------------------------------ |
| res     | string | [好友信息](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E5%A5%BD%E5%8F%8B%E4%BF%A1%E6%81%AF%E5%AF%B9%E8%B1%A1)对象列表json字符串 |
| err     | string | 获取失败描述                                                 |
| errCode | string | 错误码                                                       |

  

## setFriendInfo

设置好友备注信息。

- Example:

  ```js
  const info = {
  	uid:"",
    comment:""
  }
  openIMSDK.setFriendInfo(info).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name    | Type   | Description |
| ------- | ------ | ----------- |
| uid     | string | 用户ID      |
| comment | string | 备注        |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 设置成功     |
| err     | string | 设置失败描述 |
| errCode | String | 错误码       |

  

## checkFriend

检查与用户间是否有好友关系。

- Example:

  ```js
  openIMSDK.checkFriend(uidList).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name    | Type  | Description |
| ------- | ----- | ----------- |
| uidList | Array | 用户ID数组  |

- Return:


| Name    | Type   | Description                |
| ------- | ------ | -------------------------- |
| res     | string | 好友关系对象列表json字符串 |
| err     | string | 获取失败描述               |
| errCode | String | 错误码                     |

  

## deleteFromFriendList

从好友列表中删除用户。

- Example:

  ```js
  openIMSDK.deleteFromFriendList(uid).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name | Type   | Description |
| ---- | ------ | ----------- |
| uid  | string | 用户ID      |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 删除成功     |
| err     | string | 删除失败描述 |
| errCode | string | 错误码       |

  

## addFriend

发起添加好友申请。

- Example:

  ```js
  const reqParams = {
  	uid:"",
    reqMessage:""
  }
  openIMSDK.addFriend(reqParams).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name       | Type   | Description  |
| ---------- | ------ | ------------ |
| uid        | string | 用户ID       |
| reqMessage | string | 申请验证信息 |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 发送请求成功 |
| err     | string | 发送失败描述 |
| errCode | string | 错误码       |

  

## getFriendApplicationList

获取好友请求列表。

- Example:

  ```js
  openIMSDK.getFriendApplicationList().then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Return:


| Name    | Type   | Description            |
| ------- | ------ | ---------------------- |
| res     | string | 好友请求对象json字符串 |
| err     | string | 获取失败描述           |
| errCode | string | 错误码                 |

  

## acceptFriendApplication

接受好友请求。

- Example:

  ```js
  openIMSDK.acceptFriendApplication(uid).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name | Type   | Description |
| ---- | ------ | ----------- |
| uid  | string | 申请者ID    |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 接受成功     |
| err     | string | 接受失败描述 |
| errCode | string | 错误码       |

  

## refuseFriendApplication

拒绝好友请求。

- Example:

  ```js
  openIMSDK.refuseFriendApplication(uid).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name | Type   | Description |
| ---- | ------ | ----------- |
| uid  | string | 申请者ID    |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 拒绝成功     |
| err     | string | 拒绝失败描述 |
| errCode | string | 错误码       |

  

## addToBlackList

将用户添加到黑名单。

- Example:

  ```js
  openIMSDK.addToBlackList(uid).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name | Type   | Description |
| ---- | ------ | ----------- |
| uid  | string | 用户ID      |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 添加成功     |
| err     | string | 添加失败描述 |
| errCode | String | 错误码       |

  

## deleteFromBlackList

从黑名单移除用户。

- Example:

  ```js
  openIMSDK.deleteFromBlackList(uid).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name | Type   | Description |
| ---- | ------ | ----------- |
| uid  | string | 用户ID      |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 移除成功     |
| err     | string | 移除失败描述 |
| errCode | string | 错误码       |

  

## getBlackList

获取黑名单列表。

- Example:

  ```js
  openIMSDK.getBlackList().then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Return:


| Name    | Type   | Description                                                  |
| ------- | ------ | ------------------------------------------------------------ |
| res     | string | 被拉入黑名单的[用户信息对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E7%94%A8%E6%88%B7%E4%BF%A1%E6%81%AF%E5%AF%B9%E8%B1%A1)列表json字符串 |
| err     | string | 获取失败描述                                                 |
| errCode | string | 错误码                                                       |

   

# 群组

## createGroup

创建一个群聊，并指定群信息以及群成员。

- Example:

  ```js
  const gInfo = {
  	groupName:"",
    introduction:"",
    notification:"",
    faceUrl:""
  }
  const memberList = [
    {
      uid:"",
      setRole:0
    }
  ]
  openIMSDK.createGroup(gInfo,memberList).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name         | Type   | Description                  |
| ------------ | ------ | ---------------------------- |
| groupName    | string | 群名称                       |
| introduction | string | 群介绍                       |
| notification | string | 群公告                       |
| faceUrl      | string | 群头像                       |
| uid          | string | 用户ID                       |
| setRole      | int    | 设置角色 0:普通成员 2:管理员 |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 群聊ID       |
| err     | string | 创建失败描述 |
| errCode | string | 错误码       |

  

## getGroupsInfo

批量获取群组信息。

- Example:

  ```js
  openIMSDK.getGroupsInfo(GroupIDList).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name        | Type  | Description |
| ----------- | ----- | ----------- |
| GroupIDList | array | 群组ID列表  |

- Return:


| Name    | Type   | Description                                                  |
| ------- | ------ | ------------------------------------------------------------ |
| res     | string | [群信息对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E7%BE%A4%E7%BB%84%E4%BF%A1%E6%81%AF%E5%AF%B9%E8%B1%A1)列表json字符串 |
| err     | string | 获取失败描述                                                 |
| errCode | string | 错误码                                                       |

  

## setGroupInfo

设置、更新群聊信息。

- Example:

  ```js
  const gInfo = {
  	groupName:"",
    introduction:"",
    notification:"",
    faceUrl:""
  }
  openIMSDK.setGroupInfo(gInfo).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name         | Type   | Description |
| ------------ | ------ | ----------- |
| groupName    | string | 群名称      |
| introduction | string | 群介绍      |
| notification | string | 群公告      |
| faceUrl      | string | 群头像      |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 设置成功     |
| err     | string | 设置失败描述 |
| errCode | string | 错误码       |

  

## getJoinedGroupList

获取已加入的群列表。

- Example:

  ```js
  openIMSDK.getJoinedGroupList().then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Return:


| Name    | Type   | Description                                                  |
| ------- | ------ | ------------------------------------------------------------ |
| res     | string | [群信息对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E7%BE%A4%E7%BB%84%E4%BF%A1%E6%81%AF%E5%AF%B9%E8%B1%A1)列表json字符串 |
| err     | string | 获取失败描述                                                 |
| errCode | string | 错误码                                                       |

  

## getGroupMemberList

获取群成员列表。

- Example:

  ```js
  openIMSDK.getGroupMemberList(groupID,filter,next).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name    | Type   | Description                         |
| ------- | ------ | ----------------------------------- |
| groupID | string | 群聊ID                              |
| filter  | int    | 过滤标识 0:所有成员 1:群主 2:管理员 |
| next    | int    | 分页下标  从0开始                   |

- Return:


| Name    | Type   | Description                  |
| ------- | ------ | ---------------------------- |
| res     | string | 群成员信息对象列表json字符串 |
| err     | string | 获取失败描述                 |
| errCode | string | 错误码                       |

  

## getGroupMembersInfo

批量获取群成员信息。

- Example:

  ```js
  openIMSDK.getGroupMembersInfo(groupID,uidList).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name    | Type     | Description  |
| ------- | -------- | ------------ |
| groupID | string   | 群聊ID       |
| uidList | string[] | 群成员ID数组 |

- Return:


| Name    | Type   | Description                  |
| ------- | ------ | ---------------------------- |
| res     | string | 群成员信息对象列表json字符串 |
| err     | string | 获取失败描述                 |
| errCode | int    | 错误码                       |

  

## joinGroup

申请加入群聊。

- Example:

  ```js
  openIMSDK.joinGroup(groupID,reqMsg).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| groupID | string | 群聊ID       |
| reqMsg  | string | 请求验证信息 |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 发送申请成功 |
| err     | string | 申请失败描述 |
| errCode | string | 错误码       |

  

## getGroupApplicationList

获取加入群聊申请列表。

- Example:

  ```js
  openIMSDK.getGroupApplicationList().then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Return:


| Name    | Type   | Description                |
| ------- | ------ | -------------------------- |
| res     | string | 入群申请对象列表json字符串 |
| err     | string | 获取失败描述               |
| errCode | string | 错误码                     |

  

## acceptGroupApplication

同意入群请求。

- Example:

  ```js
  openIMSDK.acceptGroupApplication(application,reason).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name        | Type   | Description  |
| ----------- | ------ | ------------ |
| application | object | 入群申请对象 |
| reason      | string | 同意原因     |

- Return:


| Name    | Type   | Description      |
| ------- | ------ | ---------------- |
| res     | string | 同意入群成功     |
| err     | string | 同意入群失败描述 |
| errCode | string | 错误码           |

  

## refuseGroupApplication

拒绝入群请求。

- Example:

  ```js
  openIMSDK.refuseGroupApplication(application,reason).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name        | Type   | Description            |
| ----------- | ------ | ---------------------- |
| application | object | 入群申请对象json字符串 |
| reason      | string | 拒绝入群原因           |

- Return:


| Name    | Type   | Description      |
| ------- | ------ | ---------------- |
| msg     | string | 拒绝入群成功     |
| err     | string | 拒绝入群失败描述 |
| errCode | string | 错误码           |

  

## inviteUserToGroup

邀请用户加入群组(可批量)。

- Example:

  ```js
  openIMSDK.inviteUserToGroup(groupID,reqMsg,uidList).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name    | Type     | Description    |
| ------- | -------- | -------------- |
| groupID | string   | 群聊ID         |
| reqMsg  | string   | 请求验证信息   |
| uidList | String[] | 邀请用户id列表 |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 邀请成功     |
| err     | string | 邀请失败描述 |
| errCode | string | 错误码       |

  

## kickGroupMember

踢出群聊(可批量)。

- Example:

  ```js
  openIMSDK.kickGroupMember(groupID,reqMsg,uidList).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name    | Type     | Description    |
| ------- | -------- | -------------- |
| groupID | string   | 群聊ID         |
| reqMsg  | string   | 踢出原因       |
| uidList | String[] | 踢出用户ID数组 |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 踢出成功     |
| err     | string | 踢出失败描述 |
| errCode | string | 错误码       |

  

## quitGroup

退出群聊。

- Example:

  ```js
  openIMSDK.quitGroup(groupID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name    | Type   | Description |
| ------- | ------ | ----------- |
| groupID | string | 群聊ID      |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 退出成功     |
| err     | string | 退出失败描述 |
| errCode | string | 错误码       |

  

## transferGroupOwner

转让群主。

- Example:

  ```js
  openIMSDK.transferGroupOwner(groupID,uid).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name    | Type   | Description |
| ------- | ------ | ----------- |
| groupID | string | 群聊ID      |
| uid     | string | 用户ID      |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 转让成功     |
| err     | string | 转让失败描述 |
| errCode | string | 错误码       |





# 事件监听

> 事件监听统一回调格式
>
> | Name    | Type   | Description                   |
> | ------- | ------ | ----------------------------- |
> | errMsg  | string | 错误描述                      |
> | errCode | int    | 错误码，0为正常               |
> | data    | string | 回调数据，string或json string |



## 连接状态

| Event              | Data                        | Description       |
| ------------------ | --------------------------- | ----------------- |
| onConnectFailed    | "connectFailed"             | 连接失败回调      |
| onConnectSuccess   | "connectSuccess"            | 连接成功回调      |
| onConnecting       | "connecting"                | 连接中回调        |
| onKickedOffline    | "kickedOffline"             | 被踢下线回调      |
| onSelfInfoUpdated  | [用户信息对象]()json string | 修改个人信息回调  |
| onUserTokenExpired | "userTokenExpired"          | 账号token过期回调 |



## 消息监听

| Event                | Data                             | Description         |
| -------------------- | -------------------------------- | ------------------- |
| onRecvC2CReadReceipt | c2c已读回执消息ID数组json string | 收到c2c已读回执回调 |
| onRecvMessageRevoked | 被撤回消息的ID                   | 有消息被撤回回调    |
| onRecvNewMessage     | 新消息结构体json string          | 接收到新消息回调    |



## 会话监听

| Event                            | Data                        | Description      |
| -------------------------------- | --------------------------- | ---------------- |
| onConversationChanged            | 有改变的会话对象json string | 会话改变回调     |
| onNewConversation                | 新增的会话对象json string   | 新会话回调       |
| onSyncServerFailed               | -                           | -                |
| onSyncServerFinish               | -                           | -                |
| onSyncServerStart                | -                           | -                |
| onTotalUnreadMessageCountChanged | 最新会话总未读数            | 总未读数改变回调 |



## 好友关系

| Event                          | Data                                | Description              |
| ------------------------------ | ----------------------------------- | ------------------------ |
| onBlackListAdd                 | 新增的黑名单成员信息json string     | 添加用户到黑名单         |
| onBlackListDeleted             | 移除的黑名单成员信息json string     | 从黑名单中移除了某个用户 |
| onFriendApplicationListAccept  | 接受的好友请求json string           | 发出的好友请求被接受     |
| onFriendApplicationListAdded   | 新增的好友请求json string           | 好友请求列表增加         |
| onFriendApplicationListDeleted | 移除的好友请求json string           | 好友请求列表减少         |
| onFriendApplicationListReject  | 拒绝的好友请求json string           | 发出的好友请求被拒绝     |
| onFriendInfoChanged            | 修改信息后最新的好友信息json string | 好友信息更新             |
| onFriendListAdded              | 新增的好友个人信息json string       | 好友列表增加             |
| onFriendListDeleted            | 移除的好友个人信息json string       | 好友列表减少             |



## 群组关系

| Event                    | Data                                                         | Description        |
| ------------------------ | ------------------------------------------------------------ | ------------------ |
| onApplicationProcessed   | gourpId:群聊id<br/>opUser:操作者id<br/>agreeOrReject:同意或拒绝<br/>opReason:操作原因 | 入群申请被处理     |
| onGroupCreated           | gourpId:群聊id                                               | 群聊创建           |
| onGroupInfoChanged       | gourpId:群聊id<br/>groupInfo:改变后的群聊信息                | 群聊信息更新       |
| onMemberEnter            | gourpId:群聊id<br/>memberList:进入群聊的成员id数组json string | 同意申请新成员入群 |
| onMemberInvited          | gourpId:群聊id<br/>opUser:操作者id<br/>memberList:被邀请进入群聊的成员id数组json string | 新成员被邀请入群   |
| onMemberKicked           | gourpId:群聊id<br/>opUser:操作者id<br/>memberList:被踢出群聊的成员id数组json string | 成员被踢出群聊     |
| onMemberLeave            | gourpId:群聊id<br/>member:入群者id                           | 成员主动退群       |
| onReceiveJoinApplication | gourpId:群聊id<br/>member:入群者id<br/>opReason:操作原因     | 收到新的入群申请   |





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

| Name           | Type            | Description                                                  |
| -------------- | --------------- | ------------------------------------------------------------ |
| clientMsgID    | string          | 消息唯一ID                                                   |
| serverMsgID    | string          | 消息服务器ID，暂时不使用                                     |
| createTime     | number          | 消息创建时间                                                 |
| sendTime       | number          | 消息发送时间                                                 |
| sessionType    | number          | 会话类型  1:单聊 2:群聊                                      |
| sendID         | string          | 发送者ID                                                     |
| recvID         | string          | 接收者ID                                                     |
| msgFrom        | number          | 标识消息是用户级别还是系统级别  100:用户 200:系统            |
| contentType    | number          | 消息类型：<br/>101:文本消息<br/>102:图片消息<br/>103:语音消息<br/>104:视频消息<br/>105:文件消息<br/>106:@消息<br/>107:合并消息<br/>108:转发消息<br/>109:位置消息<br/>110:自定义消息<br/>111:撤回消息回执<br/>112:C2C已读回执<br/>113:正在输入状态 |
| platformID     | number          | 平台类型 1:ios 2:android 3:windows 4:osx 5:web 6:mini 7:linux |
| forceList      | array&#124;null | 强制推送列表(被@的用户)                                      |
| senderNickName | string          | 发送者昵称                                                   |
| senderFaceUrl  | string          | 发送者头像                                                   |
| groupID        | string          | 群聊ID                                                       |
| content        | string          | 消息内容                                                     |
| seq            | number          | 消息唯一序列号                                               |
| isRead         | bool            | 是否已读                                                     |
| status         | number          | 消息状态 1:发送中 2:发送成功 3:发送失败 4:已删除 5:已撤回    |
| remark         | string          | 消息备注                                                     |
| pictureElem    | PictureElem     | 图片信息                                                     |
| soundElem      | SoundElem       | 语音信息                                                     |
| videoElem      | VideoElem       | 视频信息                                                     |
| fileElem       | FileElem        | 文件信息                                                     |
| mergeElem      | MergeElem       | 合并信息                                                     |
| atElem         | AtElem          | @信息                                                        |
| locationElem   | LocationElem    | 位置信息                                                     |
| customElem     | CustomElem      | 自定义信息                                                   |
| quoteElem      | QuoteElem       | 引用消息                                                     |



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

| Name         | Type            | Description  |
| ------------ | --------------- | ------------ |
| title        | string          | 合并消息标题 |
| abstractList | array&#124;null | 摘要列表     |
| multiMessage | array&#124;null | 合并消息列表 |



### AtElem

| Name       | Type            | Description |
| ---------- | --------------- | ----------- |
| text       | string          | 文本消息    |
| atUserList | array&#124;null | @用户ID列表 |
| isAtSelf   | bool            | 是否@自己   |



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

| Name         | Type             | Description |
| ------------ | ---------------- | ----------- |
| quoteMessage | string&#124;null | 引用消息    |



## 会话对象

- interface

  ```typescript
  export interface Conversation {
      conversationID:    string;
      conversationType:  number;
      userID:            string;
      groupID:           string;
      showName:          string;
      faceUrl:           string;
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
| faceUrl           | string | 用户头像或群聊头像                                           |
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
      faceUrl:      string;
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
| faceUrl      | string | 群头像         |
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
