> 每个方法中的参数`operationID`用于标识每一次操作的唯一性，一般为uuid。

# 初始化

## initSDK

初始化并登录OpenIM SDK Server，使用用户ID(userID)和token登录，userID来自于自身业务服务器，token需要业务服务器根据secret向OpenIM服务端交换获取。

- Example:

  ```js
  const config = {
    platform: 2,
    api_addr: 'http://121.37.25.71:10000',
    ws_addr: 'ws://121.37.25.71:17778',
    data_dir: RNFS.DocumentDirectoryPath + '/tmp',
    log_level: 6,
    object_storage: 'cos',
  };
  openIMSDK.initSDK(config).then(res => {
    console.log("init success...");
  }).catch((errCode,err) => {
    console.log("init failed...");
  })
  ```

- Parameters:


| Name           | Type   | Description                                                  |
| -------------- | ------ | ------------------------------------------------------------ |
| api_addr       | String | api域名或地址   一般为10000端口                              |
| ws_addr        | string | websocket地址  一般为17778端口                               |
| platform       | int    | 平台类型 1:ios 2:android 3:windows 4:osx 5:web&mini 7:linux 8:管理员 |
| data_dir       | string | SDK数据存放目录（绝对路径）                                  |
| log_level      | int    | 日志等级                                                     |
| object_storage | string | 对象存储类型 当前可选"cos" "minio"                           |

- Return:


| Name | Type   | Description    |
| ---- | ------ | -------------- |
| res  | string | 初始化成功描述 |



## login

使用用户ID(userID)和token登录，uid来自于自身业务服务器，token需要业务服务器根据secret向OpenIM服务端交换获取。

- Example:

  ```js
  openIMSDK.login(userID,token,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```

- Parameters:


| Name  | Type   | Description |
| ----- | ------ | ----------- |
| userID   | string | 用户ID      |
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
  openIMSDK.logout(operationID).then(res=>{}).catch((errCode,err)=>{})
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
  openIMSDK.getLoginStatus().then(res=>{})
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
  openIMSDK.getUsersInfo(userIDList,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```

- Parameters:


| Name    | Type     | Description |
| ------- | -------- | ----------- |
| userIDList | string[] | 用户ID数组  |

- Return:


| Name    | Type   | Description                    |
| ------- | ------ | ------------------------------ |
| res     | string | [用户信息对象]()列表Json字符串 |
| err     | string | 获取失败描述                   |
| errCode | int    | 错误码                         |

  

## getSelfUserInfo

获取当前用户资料。

- Example:

  ```js
  openIMSDK.getSelfUserInfo(operationID).then(res=>{}).catch((errCode,err)=>{})
  ```

- Return:


| Name    | Type   | Description                        |
| ------- | ------ | ---------------------------------- |
| res     | string | [用户个人信息对象]()列表Json字符串 |
| err     | string | 获取失败描述                       |
| errCode | int    | 错误码                             |



## setSelfInfo

修改当前用户资料。

- Example:

  ```js
  const selfInfo = {
    userID:"1234",
    nickname: "blooming",//用户昵称
    faceURL: "xxx.com",//头像URL
    gender:1,//性别，0未知，1男，2女
    phoneNumber:"123",//用户手机号
    birth:1642584426,//用户生日
    email:"123@qq.com",//用户邮箱
    ex:"ex"//用户扩展信息
  }
  openIMSDK.setSelfInfo(selfInfo,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```

- Parameters:


| Name        | Type   | Description           |
| ----------- | ------ | --------------------- |
| userID      | string | 用户ID                |
| nickname    | string | 用户昵称              |
| faceURL     | string | 用户头像              |
| gender      | number | 性别：0未知，1男，2女 |
| phoneNumber | string | 手机号                |
| birth       | number | 出生日期（时间戳）    |
| email       | string | 邮箱地址              |
| ex          | string | 扩展字段              |

- Return:


| Name    | Type   | Description          |
| ------- | ------ | -------------------- |
| res     | string | 用户资料是否修改成功 |
| err     | string | 获取失败描述         |
| errCode | int    | 错误码               |

  

# 消息收发

## createTextMessage

创建一条文字消息。

- Example:

  ```js
  const newTextMsg = await openIMSDK.createTextMessage(text,operationID)
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
  const newAtTextMsg = await openIMSDK.createTextAtMessage(text，atList,operationID)
  ```

- Parameters:


| Name   | Type   | Description  |
| ------ | ------ | ------------ |
| text   | string | 消息文字内容 |
| atList | string | @用户id数组  |

- Returns:


| Name         | Type   | Description           |
| ------------ | ------ | --------------------- |
| newAtTextMsg | string | @文字信息结构体字符串 |

  

## createImageMessage

根据相对路径创建一条图片消息。

- Example:

  ```js
  const newImageMsg =await openIMSDK.createImageMessage(imagePath,operationID)
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
  const newImageMsg = await openIMSDK.createImageMessageFromFullPath(imagePath,operationID)
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
  const newImageMsg = await openIMSDK.createImageMessageByURL(sourceInfo,bigPicInfo,snapshotPicInfo,operationID)
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
  const newSoundMsg = await openIMSDK.createSoundMessage(soundPath,duration,operationID)
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
  const newSoundMsg = await openIMSDK.createSoundMessageFromFullPath(soundPath,duration,operationID)
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
  const newSoundMsg = await openIMSDK.createSoundMessageByURL(soundInfo,operationID)
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
  const newVideoMsg = await openIMSDK.createVideoMessage(videoPath,videoType,duration,snapshotPath,operationID)
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
  const newVideoMsg = await openIMSDK.createVideoMessageFromFullPath(videoPath,videoType,duration,snapshotPath,operationID)
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
  const newVideoMsg = await openIMSDK.createVideoMessageByURL(videoInfo,operationID)
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
  const newFileMsg = await openIMSDK.createFileMessage(filePath,fileName,operationID)
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
  const newFileMsg = await openIMSDK.createFileMessageByURL(fileInfo,operationID)
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
  const newMergerMsg = await openIMSDK.createMergerMessage(messageList,title,summaryList,operationID)
  ```

- Parameters:


| Name        | Type     | Description                |
| ----------- | -------- | -------------------------- |
| messageList | string[] | [消息对象]()json字符串列表 |
| title       | string   | 合并消息标题               |
| summaryList | string[] | 合并消息的摘要列表         |

- Returns:


| Name         | Type   | Description          |
| ------------ | ------ | -------------------- |
| newMergerMsg | string | 合并信息结构体字符串 |

  

## createForwardMessage

创建一条转发消息。

- Example:

  ```js
  const newForwardMsg = await openIMSDK.createForwardMessage(message,operationID)
  ```

- Parameters:


| Name    | Type            | Description |
| ------- | --------------- | ----------- |
| message | [MessageItem]() | 消息结构体  |

- Returns:


| Name          | Type   | Description          |
| ------------- | ------ | -------------------- |
| newForwardMsg | string | 转发信息结构体字符串 |


​    

## createLocationMessage

创建一条地理位置消息。

- Example:

  ```js
  const newLocationMsg = await openIMSDK.createLocationMessage(latitude,longitude,desc,operationID)
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
  const newCustomMsg = await openIMSDK.createCustomMessage(data,expand,desc,operationID)
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
  const newQuoteMsg = await openIMSDK.createQuoteMessage(text,message,operationID)
  ```

- Parameters:


| Name    | Type   | Description      |
| ------- | ------ | ---------------- |
| text    | string | 消息内容         |
| message | string | 引用[消息对象]() |

- Returns:


| Name        | Type   | Description          |
| ----------- | ------ | -------------------- |
| newQuoteMsg | string | 引用消息结构体字符串 |




## sendMessage/sendMessageNotOss

OpenIM消息按照消息发送的目标可分为：“单聊消息”和“群聊消息”，在发送单聊消息时设置groupID为空字符串，同理发送群聊消息时设置userID为空字符串即可。

- Example:

  ```js
  const offlinePushInfo:OfflinePush = {
    title: "you have a new message",
    desc: "",
    ex: "",
    iOSPushSound: "",
    iOSBadgeCount: true
  }
  openIMSDK.sendMessage(message,recvID,groupID,offlinePushInfo,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```

- Parameters:


| Name                           | Type        | Description          |
| ------------------------------ | ----------- | -------------------- |
| message                        | string      | 消息结构体json字符串 |
| recvID                         | string      | 接收者ID（单聊）     |
| groupID                        | string      | 接收群组ID（群聊）   |
| offlinePushInfo                | OfflinePush | 离线推送配置         |
| offlinePushInfo->title         | string      | 推送标题             |
| offlinePushInfo->desc          | string      | 推送描述             |
| offlinePushInfo->ex            | string      | 推送扩展字段         |
| offlinePushInfo->iOSPushSound  | string      | ios推送声音          |
| offlinePushInfo->iOSBadgeCount | boolean     | ios推送角标          |

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
    startClientMsgID:"ClientMsgID",
    count:12,
    userID:"userID"
  }
  openIMSDK.getHistoryMessageList(options,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name             | Type   | Description                                                  |
| ---------------- | ------ | ------------------------------------------------------------ |
| groupID          | string | 群聊ID，拉取群聊时传入，否则为“”                             |
| startClientMsgID | string | 上一次拉取的最后一条消息ID或空字符串,为空字符则从最新一条开始 |
| count            | int    | 每次拉取的条数                                               |
| userID           | string | 用户ID，拉取单聊时传入，否则为“”                             |

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
  openIMSDK.revokeMessage(msg,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| msg  | string | 要撤回的消息结构体 |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 撤回成功     |
| err     | string | 撤回失败描述 |
| errCode | string | 错误码       |

  

## markC2CMessageAsRead

实时消息已读回执，在 C2C 单聊场景下，当接收方通过 markC2CMessageAsRead接口将来自某人的消息标记为已读时，消息的发送方将会收到“已读回执”，表示“xxx 已经读过我的消息了”。

**特别的，当clientMsgIDList为空数组时，该API的作用会将对应单聊会话标记为已读，即清空对应会话未读数。**

- Example:

  ```js
  openIMSDK.markC2CMessageAsRead(userID,clientMsgIDList,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name            | Type     | Description             |
| --------------- | -------- | ----------------------- |
| userID             | string   | 接收ID                  |
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
  openIMSDK.typingStatusUpdate(userID,typing,operationID)
  ```
  
- Parameters:


| Name   | Type   | Description    |
| ------ | ------ | -------------- |
| userID    | string | 接收者ID       |
| typing | string | 自定义输入描述 |

  

## deleteMessageFromLocalStorage

删除本地消息。

- Example:

  ```js
  openIMSDK.deleteMessageFromLocalStorage(msg,operationID).then(res=>{}).catch((errCode,err)=>{})
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

插入一条单聊消息到本地。

- Example:

  ```js
  openIMSDK.insertSingleMessageToLocalStorage(msg,recevier,sender,operationID).then(res=>{}).catch((errCode,err)=>{})
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

  

## insertGroupMessageToLocalStorage

插入一条群聊消息到本地。

- Example:

  ```js
  openIMSDK.insertGroupMessageToLocalStorage(msg,groupID,sender,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```

- Parameters:


| Name    | Type   | Description |
| ------- | ------ | ----------- |
| msg     | string | 消息结构体  |
| groupID | string | 群聊ID      |
| sender  | string | 发送者ID    |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 插入成功     |
| err     | string | 插入失败描述 |
| errCode | string | 错误码       |



## clearC2CHistoryMessage

删除指定单聊会话中所有消息

- Example:

  ```js
  openIMSDK.clearC2CHistoryMessage(userID,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```

- Parameters:

  | Name   | Type   | Required | Description        |
  | ------ | ------ | -------- | ------------------ |
  | userID | string | true     | 要删除对象的用户ID |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | res  | string | 删除成功或失败描述 |



## clearGroupHistoryMessage

删除指定群聊会话中所有消息

- Example:

  ```js
  openIMSDK.clearGroupHistoryMessage(groupID,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```

- Parameters:

  | Name    | Type   | Required | Description            |
  | ------- | ------ | -------- | ---------------------- |
  | groupID | string | true     | 要删除对象群聊的群聊ID |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | res  | string | 删除成功或失败描述 |

​    

# 会话

## getAllConversationList

获取所有会话列表。

- Example:

  ```js
  openIMSDK.getAllConversationList(operationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Return:


| Name    | Type   | Description                                                  |
| ------- | ------ | ------------------------------------------------------------ |
| res     | string | [会话对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E4%BC%9A%E8%AF%9D%E5%AF%B9%E8%B1%A1)列表json字符串 |
| err     | string | 获取失败描述                                                 |
| errCode | string | 错误码                                                       |

  

## getConversationListSplit

分页获取会话列表。

- Example:

  ```js
  openIMSDK.getConversationListSplit(offset,count,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```

- Parameters:

| Name   | Type   | Description        |
| ------ | ------ | ------------------ |
| offset | number | 偏移量             |
| count  | number | 一次拉取的会话数量 |

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
  openIMSDK.getOneConversation(sourceID,session,operationID).then(res=>{}).catch((errCode,err)=>{})
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

  

## getConversationIDBySessionType

根据用户ID或群聊ID和session类型获取单个会话ID。

- Example:

  ```js
  openIMSDK.getConversationIDBySessionType(sourceID,session).then(res=>{}).catch((errCode,err)=>{})
  ```

- Parameters:


| Name     | Type   | Description     |
| -------- | ------ | --------------- |
| sourceID | string | 用户ID或群聊ID  |
| session  | int    | 单聊为1 群聊为2 |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 会话ID       |
| err     | string | 获取失败描述 |
| errCode | string | 错误码       |



## getMultipleConversation

根据会话ID获取多个会话。

- Example:

  ```js
  openIMSDK.getMultipleConversation(conversationIDs,operationID).then(res=>{}).catch((errCode,err)=>{})
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
  openIMSDK.deleteConversation(conversationID,operationID).then(res=>{}).catch((errCode,err)=>{})
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
  openIMSDK.setConversationDraft(conversationID,draft,operationID).then(res=>{}).catch((errCode,err)=>{})
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
  openIMSDK.pinConversation(conversationID,isPinned,operationID).then(res=>{}).catch((errCode,err)=>{})
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

​    

## markGroupMessageHasRead

标记群聊会话消息已读。

- Example:

  ```js
  openIMSDK.markGroupMessageHasRead(groupID,operationID).then(res=>{}).catch((errCode,err)=>{})
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
  openIMSDK.getTotalUnreadMsgCount(operationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 消息总未读数 |
| err     | string | 获取失败描述 |
| errCode | string | 错误码       |

​    

## setConversationRecvMessageOpt

设置会话免打扰状态

设置为1时，不再接收改会话的消息。设置为2时，正常接收该会话的消息，但不计入总未读数（依然会计入该会话的未读数，但可根据会话中的recvOpt状态自行处理）。

- Example:

  ```js
  openIMSDK.setConversationRecvMessageOpt(conversationIDList,opt,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```

- Parameters:

  | Name               | Type   | Description                                      |
  | ------------------ | ------ | ------------------------------------------------ |
  | conversationIDList | string | 会话ID数组                                       |
  | opt                | number | 是否开启免打扰 0不开启 1不接受信息 2接收但不提醒 |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 设置成功或失败描述 |



## getConversationRecvMessageOpt

获取指定会话的免打扰状态

设置为1时，不再接收改会话的消息。设置为2时，正常接收该会话的消息，但不计入总未读数（依然会计入该会话的未读数，但可根据会话中的recvOpt状态自行处理）。

- Example:

  ```js
  openIMSDK.getConversationRecvMessageOpt(conversationIDList,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```

- Parameters:

  | Name               | Type   | Description |
  | ------------------ | ------ | ----------- |
  | conversationIDList | string | 会话ID数组  |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 设置成功或失败描述 |



# 好友

## getFriendList

获取好友列表。

- Example:

  ```js
  openIMSDK.getFriendList(operationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Return:


| Name    | Type   | Description                    |
| ------- | ------ | ------------------------------ |
| res     | string | [好友信息]()对象列表json字符串 |
| err     | string | 获取失败描述                   |
| errCode | string | 错误码                         |

  

## getDesignatedFriendsInfo

获取好友信息。

- Example:

  ```js
  openIMSDK.getDesignatedFriendsInfo(userIDList,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name    | Type     | Description |
| ------- | -------- | ----------- |
| userIDList | string[] | 好友ID数组  |

- Return:


| Name    | Type   | Description                    |
| ------- | ------ | ------------------------------ |
| res     | string | [好友信息]()对象列表json字符串 |
| err     | string | 获取失败描述                   |
| errCode | string | 错误码                         |

  

## setFriendRemark

设置好友备注信息。

- Example:

  ```js
  const info = {
  	toUserID:"",
    remark:""
  }
  openIMSDK.setFriendRemark(info,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name     | Type   | Description |
| -------- | ------ | ----------- |
| toUserID | string | 用户ID      |
| remark   | string | 备注        |

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
  openIMSDK.checkFriend(userIDList,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name    | Type     | Description |
| ------- | -------- | ----------- |
| userIDList | string[] | 用户ID数组  |

- Return:


| Name    | Type   | Description                |
| ------- | ------ | -------------------------- |
| res     | string | 好友关系对象列表json字符串 |
| err     | string | 获取失败描述               |
| errCode | String | 错误码                     |

  

## deleteFriend

从好友列表中删除用户。

- Example:

  ```js
  openIMSDK.deleteFriend(userID,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name | Type   | Description |
| ---- | ------ | ----------- |
| userID  | string | 用户ID      |

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
  	toUserID:"",
    reqMsg:""
  }
  openIMSDK.addFriend(reqParams,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name     | Type   | Description  |
| -------- | ------ | ------------ |
| toUserID | string | 用户ID       |
| reqMsg   | string | 申请验证信息 |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 发送请求成功 |
| err     | string | 发送失败描述 |
| errCode | string | 错误码       |

  

## getRecvFriendApplicationList

获取收到的好友请求列表。

- Example:

  ```js
  openIMSDK.getRecvFriendApplicationList(operationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Return:


| Name    | Type   | Description            |
| ------- | ------ | ---------------------- |
| res     | string | 好友请求对象json字符串 |
| err     | string | 获取失败描述           |
| errCode | string | 错误码                 |

  

## getSendFriendApplicationList

获取发出的好友请求列表。

- Example:

  ```js
  openIMSDK.getSendFriendApplicationList(operationID).then(res=>{}).catch((errCode,err)=>{})
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
  const options = {
    toUserID:"",
    handleMsg:""
  }
  openIMSDK.acceptFriendApplication(options,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name      | Type   | Description |
| --------- | ------ | ----------- |
| toUserID  | string | 申请者ID    |
| handleMsg | string | 回复消息    |

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
  const options = {
    toUserID:"",
    handleMsg:""
  }
  openIMSDK.refuseFriendApplication(options,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name      | Type   | Description |
| --------- | ------ | ----------- |
| toUserID  | string | 申请者ID    |
| handleMsg | string | 回复消息    |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 拒绝成功     |
| err     | string | 拒绝失败描述 |
| errCode | string | 错误码       |

  

## addBlack

将用户添加到黑名单。

- Example:

  ```js
  openIMSDK.addBlack(userID,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name | Type   | Description |
| ---- | ------ | ----------- |
| userID  | string | 用户ID      |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 添加成功     |
| err     | string | 添加失败描述 |
| errCode | String | 错误码       |

  

## removeBlack

从黑名单移除用户。

- Example:

  ```js
  openIMSDK.removeBlack(userID,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name | Type   | Description |
| ---- | ------ | ----------- |
| userID  | string | 用户ID      |

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
  openIMSDK.getBlackList(operationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Return:


| Name    | Type   | Description                                    |
| ------- | ------ | ---------------------------------------------- |
| res     | string | 被拉入黑名单的[黑名单用户对象]()列表json字符串 |
| err     | string | 获取失败描述                                   |
| errCode | string | 错误码                                         |

   

# 群组

## createGroup

创建一个群聊，并指定群信息以及群成员。

- Example:

  ```js
  const groupBaseInfo = {
    groupType:0,
    groupName: "",
    introduction: "",
    notification: "",
    faceURL: "",
    ex: ""
  }
  const memberList = [
    {
      userID:"",
      roleLevel:1
    }
  ]
  openIMSDK.createGroup(groupBaseInfo,memberList,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name                        | Type   | Description                  |
| --------------------------- | ------ | ---------------------------- |
| groupBaseInfo->groupName    | string | 群名称                       |
| groupBaseInfo->groupType    | number | 群聊类型 当前默认0           |
| groupBaseInfo->introduction | string | 群介绍                       |
| groupBaseInfo->notification | string | 群公告                       |
| groupBaseInfo->faceURL      | string | 群头像                       |
| groupBaseInfo->ex           | string | 扩展字段                     |
| memberList->userID          | string | 用户ID                       |
| memberList->roleLevel       | number | 设置角色 1:普通成员 3:管理员 |

- Return:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| res     | string | 群信息       |
| err     | string | 创建失败描述 |
| errCode | string | 错误码       |

  

## getGroupsInfo

批量获取群组信息。

- Example:

  ```js
  openIMSDK.getGroupsInfo(GroupIDList,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name        | Type     | Description |
| ----------- | -------- | ----------- |
| GroupIDList | string[] | 群组ID列表  |

- Return:


| Name    | Type   | Description                  |
| ------- | ------ | ---------------------------- |
| res     | string | [群信息对象]()列表json字符串 |
| err     | string | 获取失败描述                 |
| errCode | string | 错误码                       |

  

## setGroupInfo

设置、更新群聊信息。

- Example:

  ```js
  const gInfo = {
  	groupName:"",
    introduction:"",
    notification:"",
    faceURL:""，
    ex:""
  }
  openIMSDK.setGroupInfo(groupID,gInfo,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name         | Type   | Description |
| ------------ | ------ | ----------- |
| groupID      | string | 群ID        |
| groupName    | string | 群名称      |
| introduction | string | 群介绍      |
| notification | string | 群公告      |
| faceUrl      | string | 群头像      |
| ex           | string | false       |

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
  openIMSDK.getJoinedGroupList(operationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Return:


| Name    | Type   | Description                  |
| ------- | ------ | ---------------------------- |
| res     | string | [群信息对象]()列表json字符串 |
| err     | string | 获取失败描述                 |
| errCode | string | 错误码                       |

  

## getGroupMemberList

获取群成员列表。

- Example:

  ```js
  openIMSDK.getGroupMemberList(groupID,filter,offset,count,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name    | Type   | Description                         |
| ------- | ------ | ----------------------------------- |
| groupID | string | 群聊ID                              |
| filter  | int    | 过滤标识 0:所有成员 1:群主 2:管理员 |
| offset  | int    | 分页下标  从0开始                   |
| count   | number | 分页拉取总数                        |

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
  openIMSDK.getGroupMembersInfo(groupID,userIDList,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name    | Type     | Description  |
| ------- | -------- | ------------ |
| groupID | string   | 群聊ID       |
| userIDList | string[] | 群成员ID数组 |

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
  openIMSDK.joinGroup(groupID,reqMsg,operationID).then(res=>{}).catch((errCode,err)=>{})
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

  

## getRecvGroupApplicationList

获取加入群聊申请列表。

- Example:

  ```js
  openIMSDK.getRecvGroupApplicationList(operationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Return:


| Name    | Type   | Description                |
| ------- | ------ | -------------------------- |
| res     | string | 入群申请对象列表json字符串 |
| err     | string | 获取失败描述               |
| errCode | string | 错误码                     |

  

## getSendGroupApplicationList

获取发出的群聊申请列表。

- Example:

  ```js
  openIMSDK.getSendGroupApplicationList(operationID).then(res=>{}).catch((errCode,err)=>{})
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
  openIMSDK.acceptGroupApplication(groupID,fromUserID,handleMsg,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name       | Type   | Description |
| ---------- | ------ | ----------- |
| groupID    | string | 群ID        |
| fromUserID | string | 申请者ID    |
| handleMsg  | string | 同意原因    |

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
  openIMSDK.refuseGroupApplication(groupID,fromUserID,handleMsg,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name       | Type   | Description |
| ---------- | ------ | ----------- |
| groupID    | string | 群ID        |
| fromUserID | string | 申请者ID    |
| handleMsg  | string | 拒绝原因    |

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
  openIMSDK.inviteUserToGroup(groupID,reqMsg,userIDList,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name       | Type     | Description    |
| ---------- | -------- | -------------- |
| groupID    | string   | 群聊ID         |
| reqMsg     | string   | 请求验证信息   |
| userIDList | String[] | 邀请用户id列表 |

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
  openIMSDK.kickGroupMember(groupID,reqMsg,userIDList,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name       | Type     | Description    |
| ---------- | -------- | -------------- |
| groupID    | string   | 群聊ID         |
| reqMsg     | string   | 踢出原因       |
| userIDList | String[] | 踢出用户ID数组 |

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
  openIMSDK.quitGroup(groupID,operationID).then(res=>{}).catch((errCode,err)=>{})
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
  openIMSDK.transferGroupOwner(groupID,newOwnerUserID,operationID).then(res=>{}).catch((errCode,err)=>{})
  ```
  
- Parameters:


| Name           | Type   | Description |
| -------------- | ------ | ----------- |
| groupID        | string | 群聊ID      |
| newOwnerUserID | string | 用户ID      |

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

| Event             | Data                       | Description   |
| ----------------- | -------------------------- | ------------- |
| onConnectFailed   | -                          | 连接失败      |
| onConnectSuccess  | -                          | 连接成功      |
| onConnecting      | -                          | 连接中        |
| onKickedOffline   | -                          | 被踢下线      |
| onSelfInfoUpdated  | 用户个人信息对象json字符串 | 修改个人信息  |
| onUserTokenExpired | -                          | 账号token过期 |



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

| Event                       | Data             | Description              |
| --------------------------- | ---------------- | ------------------------ |
| onBlackAdded                | 新增的黑名单信息 | 添加用户到黑名单         |
| onBlackDeleted              | 移除的黑名单信息 | 从黑名单中移除了某个用户 |
| onFriendApplicationAccepted | 被接受的好友申请 | 好友请求被接受           |
| onFriendApplicationRejected | 被拒绝的好友申请 | 好友请求被拒绝           |
| onFriendApplicationAdded    | 新增的好友申请   | 好友请求列表增加         |
| onFriendApplicationDeleted  | 被移除的好友申请 | 好友请求列表减少         |
| onFriendInfoChanged         | 更新后的好友信息 | 好友信息更新             |
| onFriendAdded               | 新增的好友信息   | 好友列表增加             |
| onFriendDeleted             | 减少的好友信息   | 好友列表减少             |



## 群组关系

| Event                      | Data               | Description      |
| -------------------------- | ------------------ | ---------------- |
| onGroupApplicationAccepted | 被同意的群申请     | 入群申请被同意   |
| onGroupApplicationRejected | 被拒绝的群申请     | 入群申请被拒绝   |
| onGroupApplicationAdded    | 新增的群申请       | 入群申请有新增   |
| onGroupApplicationDeleted  | 删除的群申请       | 入群申请被删除   |
| onGroupInfoChanged         | 更新后的群信息     | 群组信息改变     |
| onGroupMemberInfoChanged   | 更新后的群成员信息 | 群成员信息改变   |
| onGroupMemberAdded         | 新入群的群成员     | 有新成员加入群组 |
| onGroupMemberDeleted       | 退出去的群成员     | 有群成员退出群组 |
| onJoinedGroupAdded         | 新加入的群 群信息  | 加入的群增加     |
| onJoinedGroupDeleted       | 退出的群 群信息    | 加入的群减少     |



# 数据对象结构

## 用户个人信息对象

- type

  ```typescript
  export type FullUserItem = {
    birth: number;
    createTime: number;
    email: string;
    ex: string;
    faceURL: string;
    gender: number;
    nickname: string;
    phoneNumber: string;
    userID: string;
  };
  ```

  

| Name        | Type   | Description                    |
| ----------- | ------ | ------------------------------ |
| userID      | string | 用户id                         |
| nickname    | string | 用户昵称                       |
| faceURL     | string | 用户头像                       |
| gender      | number | 用户性别 0:未知 1:女 2:男      |
| phoneNumber | string | 用户手机号                     |
| birth       | string | 用户生日                       |
| email       | string | 用户邮箱地址                   |
| ex          | string | 用户信息扩展字段对象Json字符串 |
| createTime  | number | 创建时间                       |



## 消息对象

- type

  ```typescript
  export type MessageItem = {
    clientMsgID: string;
    serverMsgID: string;
    createTime: number;
    sendTime: number;
    sessionType: number;
    sendID: string;
    recvID: string;
    msgFrom: number;
    contentType: number;
    platformID: number;
    senderNickname: string;
    senderFaceUrl: string;
    groupID: string;
    content: string;
    seq: number;
    isRead: boolean;
    status: number;
    offlinePush: OfflinePush;
    attachedInfo: string;
    ex: string;
    pictureElem: PictureElem;
    soundElem: SoundElem;
    videoElem: VideoElem;
    fileElem: FileElem;
    mergeElem: MergeElem;
    atElem: AtElem;
    locationElem: LocationElem;
    customElem: CustomElem;
    quoteElem: QuoteElem;
    notificationElem: NotificationElem;
  };
  
  export type AtElem = {
      text:       string;
      atUserList: string[]|null;
      isAtSelf:   boolean;
  }
  
  export type CustomElem = {
      data:        string;
      description: string;
      extension:   string;
  }
  
  export type FileElem = {
      filePath:  string;
      uuid:      string;
      sourceUrl: string;
      fileName:  string;
      fileSize:  number;
  }
  
  export type LocationElem = {
      description: string;
      longitude:   number;
      latitude:    number;
  }
  
  export type MergeElem = {
      title:        string;
      abstractList: string[]|null;
      multiMessage: string[]|null;
  }
  
  export type PictureElem = {
      sourcePath:      string;
      sourcePicture:   Picture;
      bigPicture:      Picture;
      snapshotPicture: Picture;
  }
  
  export type Picture = {
      uuid:   string;
      type:   string;
      size:   number;
      width:  number;
      height: number;
      url:    string;
  }
  
  export type QuoteElem = {
      quoteMessage: string[];
  }
  
  export type SoundElem = {
      uuid:      string;
      soundPath: string;
      sourceUrl: string;
      dataSize:  number;
      duration:  number;
  }
  
  export type VideoElem = {
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
  
  export type NotificationElem = {
    detail: string;
    defaultTips: string;
  }
  
  export type OfflinePush = {
    title: string;
    desc: string;
    ex: string;
    iOSPushSound: string;
    iOSBadgeCount: boolean;
  }
  ```



### Message

| Name             | Type             | Description                                                  |
| ---------------- | ---------------- | ------------------------------------------------------------ |
| clientMsgID      | string           | 消息唯一ID                                                   |
| serverMsgID      | string           | 消息服务器ID，暂时不使用                                     |
| createTime       | number           | 消息创建时间                                                 |
| sendTime         | number           | 消息发送时间                                                 |
| sessionType      | number           | 会话类型  1:单聊 2:群聊                                      |
| sendID           | string           | 发送者ID                                                     |
| recvID           | string           | 接收者ID                                                     |
| msgFrom          | number           | 标识消息是用户级别还是系统级别  100:用户 200:系统            |
| contentType      | number           | 消息类型：<br/>101:文本消息<br/>102:图片消息<br/>103:语音消息<br/>104:视频消息<br/>105:文件消息<br/>106:@消息<br/>107:合并消息<br/>108:转发消息<br/>109:位置消息<br/>110:自定义消息<br/>111:撤回消息回执<br/>112:C2C已读回执<br/>113:正在输入状态 |
| platformID       | number           | 平台类型 1:ios 2:android 3:windows 4:osx 5:web 6:mini 7:linux |
| senderNickname   | string           | 发送者昵称                                                   |
| senderFaceUrl    | string           | 发送者头像                                                   |
| groupID          | string           | 群聊ID                                                       |
| content          | string           | 消息内容                                                     |
| seq              | number           | 消息唯一序列号                                               |
| isRead           | bool             | 是否已读                                                     |
| status           | number           | 消息状态 1:发送中 2:发送成功 3:发送失败 4:已删除 5:已撤回    |
| offlinePush      | offlinePush      | 离线推送配置                                                 |
| attachedInfo     | string           | 预留字段                                                     |
| ex               | string           | 扩展字段                                                     |
| pictureElem      | PictureElem      | 图片信息结构                                                 |
| soundElem        | SoundElem        | 语音信息结构                                                 |
| videoElem        | VideoElem        | 视频信息结构                                                 |
| fileElem         | FileElem         | 文件信息结构                                                 |
| mergeElem        | MergeElem        | 合并信息结构                                                 |
| atElem           | AtElem           | @信息结构                                                    |
| locationElem     | LocationElem     | 位置信息结构                                                 |
| customElem       | CustomElem       | 自定义信息结构                                               |
| quoteElem        | QuoteElem        | 引用消息结构                                                 |
| notificationElem | NotificationElem | 通知消息结构                                                 |



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



### NotificationElem

| Name        | Type   | Description  |
| ----------- | ------ | ------------ |
| detail      | string | 通知详细信息 |
| defaultTips | string | 通知默认提示 |



## 会话对象

- Type

  ```typescript
  export type ConversationItem = {
    conversationID: string;
    conversationType: number;
    userID: string;
    groupID: string;
    showName: string;
    faceURL: string;
    recvMsgOpt: OptType;
    unreadCount: number;
    groupAtType: number;
    latestMsg: string;
    latestMsgSendTime: number;
    draftText: string;
    draftTextTime: number;
    isPinned: boolean;
    attachedInfo: string;
    ex: string;
  };
  
  ```



| Name              | Type   | Description                                                  |
| ----------------- | ------ | ------------------------------------------------------------ |
| conversationID    | string | 会话ID                                                       |
| conversationType  | number | 会话类型  1:单聊 2:群聊                                      |
| userID            | string | 会话对象用户ID                                               |
| groupID           | string | 会话群聊ID                                                   |
| showName          | string | 会话对象(用户或群聊)名称                                     |
| faceURL           | string | 用户头像或群聊头像                                           |
| recvMsgOpt        | number | 接收消息选项：<br>0:在线正常接收消息，离线时进行推送<br>1:不会接收到消息<br>2:在线正常接收消息，离线不会有推送 |
| unreadCount       | number | 未读消息数量                                                 |
| latestMsg         | string | 最后一条消息 [消息对象]()json字符串                          |
| latestMsgSendTime | number | 最后一条消息发送时间(ns)                                     |
| draftText         | string | 会话草稿                                                     |
| draftTextTime     | number | 会话草稿设置时间                                             |
| isPinned          | number | 是否置顶                                                     |
| attachedInfo      | string | 预留字段                                                     |
| ex                | string | 扩展字段                                                     |





## 用户信息对象

- type

  > 通过[getDesignatedFriendsInfo]()获取用户信息时，如果是好友将返回friendInfo，若同时为黑名单，则返回friendInfo和blackInfo。若不是好友，则需要另行调用[getUsersInfo](),此时仅返回publicInfo。
  >
  > 直接调用[getUsersInfo]()获取用户信息时，如果是好友将返回friendInfo与publicInfo，不是好友仅返回publicInfo。

  ```typescript
  export type TotalUserStruct = {
    blackInfo: BlackItem | null;
    friendInfo: FriendItem | null;
    publicInfo: PublicUserItem | null;
  };
  export type PublicUserItem = {
    gender: number;
    nickname: string;
    userID: string;
    faceURL: string;
  };
  export type FriendItem = {
    addSource: number;
    birth: number;
    createTime: number;
    email: string;
    ex: string;
    faceURL: string;
    userID: string;
    gender: number;
    nickname: string;
    operatorUserID: string;
    ownerUserID: string;
    phoneNumber: string;
    remark: string;
  };
  export type BlackItem = {
    addSource: number;
    userID: string;
    createTime: number;
    ex: string;
    faceURL: string;
    gender: number;
    nickname: string;
    operatorUserID: string;
    ownerUserID: string;
  };
  ```

  

| Name        | Type   | Description      |
| ----------- | ------ | ---------------- |
| userID      | string | 用户ID           |
| nickname    | string | 用户名称         |
| faceURL     | string | 用户头像         |
| gender      | number | 用户性别         |
| phoneNumber | string | 用户手机号       |
| birth       | string | 用户出生日期     |
| email       | string | 用户邮箱号       |
| ex          | string | 用户信息扩展字段 |
| remark      | string | 好友备注         |
| addSource   | number | 添加来源         |
| createTime  | number | 成为好友时间     |



## 群组信息对象

- type

  ```typescript
  export type GroupItem = {
    groupID: string;
    groupName: string;
    notification: string;
    introduction: string;
    faceURL: string;
    ownerUserID: string;
    createTime: number;
    memberCount: number;
    status: number;
    creatorUserID: string;
    groupType: number;
    ex: string;
  };
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



## 群成员信息对象

- type

  ```typescript
  export type GroupMemberItem = {
    groupID: string;
    userID: string;
    nickname: string;
    faceURL: string;
    roleLevel: number;
    joinTime: number;
    joinSource: number;
    operatorUserID: string;
    ex: string;
  };
  ```

  

| Name           | Type   | Description                    |
| -------------- | ------ | ------------------------------ |
| groupID        | string | 群组ID                         |
| userID         | string | 群成员ID                       |
| nickname       | string | 群成员昵称                     |
| faceURL        | string | 群成员头像                     |
| roleLevel      | string | 群成员等级 1普通 2群主 3管理员 |
| joinTime       | number | 加入时间                       |
| joinSource     | number | 加入方式                       |
| operatorUserID | number | 操作者ID                       |
| ex             | string | 扩展字段                       |



## 好友申请对象

- type

  ```typescript
  export type FriendApplicationItem = {
    createTime: number;
    ex: string;
    fromFaceURL: string;
    fromGender: number;
    fromNickname: string;
    fromUserID: string;
    handleMsg: string;
    handleResult: number;
    handleTime: number;
    handlerUserID: string;
    reqMsg: string;
    toFaceURL: string;
    toGender: number;
    toNickname: string;
    toUserID: string;
  };
  ```

  

| Name          | Type   | Description  |
| ------------- | ------ | ------------ |
| createTime    | number | 创建时间     |
| ex            | string | 扩展字段     |
| fromFaceURL   | string | 申请者头像   |
| fromGender    | number | 申请者性别   |
| fromNickname  | string | 申请者昵称   |
| fromUserID    | string | 申请者用户ID |
| handleMsg     | string | 回复信息     |
| handleResult  | number | 处理状态     |
| handleTime    | number | 处理时间     |
| handlerUserID | string | 处理者ID     |
| reqMsg        | string | 申请信息     |
| toFaceURL     | string | 接收者头像   |
| toGender      | number | 接收者性别   |
| toNickname    | string | 接收者昵称   |
| toUserID      | string | 接收者ID     |



## 入群申请对象

- type

  ```typescript
  export type GroupApplicationItem = {
    createTime: number;
    creatorUserID: string;
    ex: string;
    gender: number;
    groupFaceURL: string;
    groupID: string;
    groupName: string;
    groupType: number;
    handleResult: number;
    handleUserID: string;
    handledMsg: string;
    handledTime: number;
    introduction: string;
    memberCount: number;
    nickname: string;
    notification: string;
    ownerUserID: string;
    reqMsg: string;
    reqTime: number;
    status: number;
    userFaceURL: string;
    userID: string;
  };
  ```

  

| Name          | Type   | Description  |
| ------------- | ------ | ------------ |
| createTime    | number | 创建时间     |
| creatorUserID | string | 创建者ID     |
| ex            | string | 扩展字段     |
| gender        | number | 申请者性别   |
| groupFaceURL  | string | 群头像       |
| groupID       | string | 群ID         |
| groupName     | string | 群名         |
| groupType     | number | 群类型       |
| handleResult  | number | 处理状态     |
| handleUserID  | string | 处理者ID     |
| handledMsg    | string | 处理原因     |
| handledTime   | number | 处理时间     |
| introduction  | string | 群介绍       |
| memberCount   | number | 群成员数     |
| nickname      | string | 申请者昵称   |
| notification  | string | 群公告       |
| ownerUserID   | string | 群主ID       |
| reqMsg        | string | 入群申请信息 |
| reqTime       | number | 申请时间     |
| status        | number | 群状态       |
| userFaceURL   | string | 申请者头像   |
| userID        | string | 申请者ID     |

