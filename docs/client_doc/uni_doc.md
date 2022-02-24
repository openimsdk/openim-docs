# 初始化与登录

## initSDK

初始化OpenIM SDK,设置SDK网络连接地址以及本地数据存放目录等。

- Example:

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

- Parameters:


| Name     | Type   | Description                                                  |
| -------- | ------ | ------------------------------------------------------------ |
| platform | int    | 平台类型 1:ios 2:android 3:windows 4:osx 5:web&mini 7:linux 8:管理员 |
| ipApi    | string | api域名地址                                                  |
| ipWs     | string | websocket地址                                                |
| dbDir    | String | SDK数据存放目录（绝对路径）                                  |

- Returns:


| Type | Description        |
| ---- | ------------------ |
| bool | 返回是否初始化成功 |

- Monitor:


| Event              | Parameters                                                   | Description   |
| ------------------ | ------------------------------------------------------------ | ------------- |
| onConnectFailed    | err:错误信息<br/>errCode:错误码                              | 连接失败      |
| onConnectSuccess   | msg:onConnectSuccess                                         | 连接成功      |
| onConnecting       | msg:onConnecting                                             | 连接中        |
| onKickedOffline    | msg:onKickedOffline                                          | 被踢下线      |
| onSelfInfoUpdated  | msg:[用户信息对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E7%94%A8%E6%88%B7%E4%BF%A1%E6%81%AF%E5%AF%B9%E8%B1%A1)json字符串 | 修改个人信息  |
| onUserTokenExpired | msg:onUserTokenExpired                                       | 账号token过期 |




## login

使用用户ID(uid)和token登录，uid来自于自身业务服务器，token需要业务服务器根据secret向OpenIM服务端交换获取。

- Example:

  ```js
  this.$openSdk.login(uid,token,data=>{
      ...
  })
  ```

- Parameters:


| Name  | Type   | Description |
| ----- | ------ | ----------- |
| uid   | string | 用户ID      |
| token | string | 用户token   |

- CallBack:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 登录成功     |
| err     | string | 登录失败描述 |
| errCode | int    | 错误码       |

  

## logout

登出OpenIM，通常在切换账号的时候调用，清楚登录态以及内存中的所有数据。

- Example:

  ```js
  this.$openSdk.logout(data=>{
      ...
  })
  ```

- CallBack:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 登出成功     |
| err     | string | 登出失败描述 |
| errCode | int    | 错误码       |

  

## getLoginStatus

获取当前用户登录状态。

- Example:

  ```js
  this.$openSdk.getLoginStatus(data=>{
      ...
  })
  ```

- CallBack:


| Name    | Type   | Description                                   |
| ------- | ------ | --------------------------------------------- |
| msg     | int    | 101:登录成功 102:登陆中 103:登录失败 201:登出 |
| err     | string | 获取失败描述                                  |
| errCode | int    | 错误码                                        |

  


## getLoginUid

获取当前登录用户ID。

- Example:

  ```js
  this.$openSdk.getLoginUid(data=>{
      ...
  })
  ```

- CallBack:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 用户ID       |
| err     | string | 获取失败描述 |
| errCode | int    | 错误码       |

  

# 用户资料

## getUsersInfo

根据用户ID获取用户资料，可批量获取。

- Example:

  ```js
  this.$openSdk.getUsersInfo(uidList,data=>{
      ...
  })
  ```

- Parameters:


| Name    | Type     | Description |
| ------- | -------- | ----------- |
| uidList | string[] | 用户ID数组  |

- CallBack:


| Name    | Type   | Description                                                  |
| ------- | ------ | ------------------------------------------------------------ |
| msg     | string | [用户信息对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E7%94%A8%E6%88%B7%E4%BF%A1%E6%81%AF%E5%AF%B9%E8%B1%A1)列表Json字符串 |
| err     | string | 获取失败描述                                                 |
| errCode | int    | 错误码                                                       |

  

## setSelfInfo

根据用户ID获取用户资料，可批量获取。

- Example:

  ```js
  this.$openSdk.setSelfInfo(info,data=>{
      ...
  })
  ```

- Parameters:


| Name | Type                                                         | Description                                                  |
| ---- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| info | [UserInfo](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E7%94%A8%E6%88%B7%E4%BF%A1%E6%81%AF%E5%AF%B9%E8%B1%A1) | [用户信息对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E7%94%A8%E6%88%B7%E4%BF%A1%E6%81%AF%E5%AF%B9%E8%B1%A1) |

- CallBack:


| Name    | Type   | Description                                                  |
| ------- | ------ | ------------------------------------------------------------ |
| msg     | string | [用户信息对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E7%94%A8%E6%88%B7%E4%BF%A1%E6%81%AF%E5%AF%B9%E8%B1%A1)列表Json字符串(可只传要修改的字段) |
| err     | string | 获取失败描述                                                 |
| errCode | int    | 错误码                                                       |

  

# 消息收发

## createTextMessage

创建一条文字消息。

- Example:

  ```js
  const newTextMsg = this.$openSdk.createTextMessage(text,data=>{
      ...
  })
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
  const newAtTextMsg = this.$openSdk.createTextAtMessage(text，atList,data=>{
      ...
  })
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
  const newImageMsg = this.$openSdk.createImageMessage(imagePath,data=>{
      ...
  })
  ```

- Parameters:


| Name      | Type   | Description        |
| --------- | ------ | ------------------ |
| imagePath | string | 图片地址(相对路径) |

- Returns:


| Name        | Type   | Description          |
| ----------- | ------ | -------------------- |
| newImageMsg | string | 图片信息结构体字符串 |

  

# createImageMessageFromFullPath

根据绝对路径创建一条图片消息。

- Example:

  ```js
  const newImageMsg = this.$openSdk.createImageMessageFromFullPath(imagePath,data=>{
      ...
  })
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
  const snapshotPicInfo = sourceInfo		//搜略图信息
  const newImageMsg = this.$openSdk.createImageMessageByURL(sourceInfo,bigPicInfo,snapshotPicInfo,data=>{
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


| Name        | Type   | Description          |
| ----------- | ------ | -------------------- |
| newImageMsg | string | 图片信息结构体字符串 |



## createSoundMessage

根据相对路径创建一条语音消息。

- Example:

  ```js
  const newSoundMsg = this.$openSdk.createSoundMessage(soundPath,duration,data=>{
      ...
  })
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
  const newSoundMsg = this.$openSdk.createSoundMessageFromFullPath(soundPath,duration,data=>{
      ...
  })
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
  const newSoundMsg = this.$openSdk.createSoundMessageByURL(soundInfo,data=>{
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


| Name        | Type   | Description          |
| ----------- | ------ | -------------------- |
| newSoundMsg | string | 语音信息结构体字符串 |



## createVideoMessage

根据相对路径创建一条视频消息。

- Example:

  ```js
  const newVideoMsg = this.$openSdk.createVideoMessage(videoPath,videoType,duration,snapshotPath,data=>{
      ...
  })
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
  const newVideoMsg = this.$openSdk.createVideoMessageFromFullPath(videoPath,videoType,duration,snapshotPath,data=>{
      ...
  })
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
  const newVideoMsg = this.$openSdk.createVideoMessageByURL(videoInfo,data=>{
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


| Name        | Type   | Description          |
| ----------- | ------ | -------------------- |
| newVideoMsg | string | 语音信息结构体字符串 |



## createFileMessage

根据相对路径创建一条文件消息。

- Example:

  ```js
  const newFileMsg = this.$openSdk.createFileMessage(filePath,fileName,data=>{
      ...
  })
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
  const newFileMsg = this.$openSdk.createFileMessageByURL(fileInfo,data=>{
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


| Name       | Type   | Description          |
| ---------- | ------ | -------------------- |
| newFileMsg | string | 文件信息结构体字符串 |

  

## createMergerMessage

创建一条合并消息。

- Example:

  ```js
  const newMergerMsg = this.$openSdk.createMergerMessage(messageList,title,summaryList,data=>{
      ...
  })
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
  const newForwardMsg = this.$openSdk.createForwardMessage(message,data=>{
      ...
  })
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
  const newLocationMsg = this.$openSdk.createLocationMessage(desc,latitude,longitude,data=>{
      ...
  })
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
  const newCustomMsg = this.$openSdk.createCustomMessage(data,expand,desc,data=>{
      ...
  })
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
  const newQuoteMsg = this.$openSdk.createQuoteMessage(text,message,data=>{
      ...
  })
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




## sendMessage

OpenIM消息按照消息发送的目标可分为：“单聊消息”和“群聊消息”，在发送单聊消息时设置groupID为空，同理发送群聊消息时设置userID为空即可。

- Example:

  ```js
  this.$openSdk.sendMessage(message,receiver,groupID,onlineUserOnly,data=>{
      ...
  })
  ```

- Parameters:


| Name           | Type   | Description          |
| -------------- | ------ | -------------------- |
| message        | string | 消息结构体json字符串 |
| receiver       | string | 接收者ID（单聊）     |
| groupID        | string | 接收群组ID（群聊）   |
| onlineUserOnly | bool   | 是否仅在线用户接收   |

- Monitor:


| Event           | Parameters                                                   | Description  |
| --------------- | ------------------------------------------------------------ | ------------ |
| sendMsgError    | err:错误信息<br>errCode:错误码<br>errMsg:发送失败的[消息对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E6%B6%88%E6%81%AF%E5%AF%B9%E8%B1%A1)json字符串 | 消息发送失败 |
| sendMsgProgress | percent:发送进度<br>progressMsg:正在发送的[消息对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E6%B6%88%E6%81%AF%E5%AF%B9%E8%B1%A1)json字符串 | 消息发送进度 |
| sendMsgSuccess  | msg:成功信息<br>sucMsg:发送成功的[消息对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E6%B6%88%E6%81%AF%E5%AF%B9%E8%B1%A1)json字符串 | 消息发送成功 |

  

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
  this.$openSdk.getHistoryMessageList(options,data=>{
      ...
  })
  ```

- Parameters:


| Name     | Type   | Description                      |
| -------- | ------ | -------------------------------- |
| groupID  | string | 群聊ID，拉取群聊时传入，否则为“” |
| startMsg | string | 上一次拉取的最后一条消息结构体   |
| count    | int    | 每次拉取的条数                   |
| userID   | string | 用户ID，拉取单聊时传入，否则为“” |

- CallBack:


| Name    | Type   | Description                                                  |
| ------- | ------ | ------------------------------------------------------------ |
| msg     | string | 历史[消息对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E6%B6%88%E6%81%AF%E5%AF%B9%E8%B1%A1)数组json字符串 |
| err     | string | 获取失败描述                                                 |
| errCode | int    | 错误码                                                       |

  

## revokeMessage

撤回某条消息。

- Example:

  ```js
  this.$openSdk.revokeMessage(msg,data=>{
      ...
  })
  ```

- Parameters:


| Name | Type   | Description                  |
| ---- | ------ | ---------------------------- |
| msg  | string | 要撤回的消息结构体json字符串 |

- CallBack:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 撤回成功     |
| err     | string | 撤回失败描述 |
| errCode | int    | 错误码       |

  

## markC2CMessageAsRead

实时消息已读回执，在 C2C 单聊场景下，当接收方通过 markC2CMessageAsRead接口将来自某人的消息标记为已读时，消息的发送方将会收到“已读回执”，表示“xxx 已经读过我的消息了”。

- Example:

  ```js
  this.$openSdk.markC2CMessageAsRead(uid,clientMsgIDList,data=>{
      ...
  })
  ```

- Parameters:


| Name            | Type   | Description             |
| --------------- | ------ | ----------------------- |
| uid             | string | 接收ID                  |
| clientMsgIDList | string | 已读消息clientMsgID数组 |

- CallBack:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 标记成功     |
| err     | string | 标记失败描述 |
| errCode | int    | 错误码       |

  

## typingStatusUpdate

更新正在输入状态。

- Example:

  ```js
  this.$openSdk.typingStatusUpdate(uid,typing,data=>{
      ...
  })
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
  this.$openSdk.deleteMessageFromLocalStorage(msg,data=>{
      ...
  })
  ```

- Parameters:


| Name | Type   | Description          |
| ---- | ------ | -------------------- |
| msg  | string | 消息结构体json字符串 |

- CallBack:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 删除成功     |
| err     | string | 删除失败描述 |
| errCode | int    | 错误码       |

  

## insertSingleMessageToLocalStorage

插入一条消息到本地。

- Example:

  ```js
  this.$openSdk.insertSingleMessageToLocalStorage(msg,recevier,sender,data=>{
      ...
  })
  ```

- Parameters:


| Name     | Type   | Description          |
| -------- | ------ | -------------------- |
| msg      | string | 消息结构体json字符串 |
| recevier | string | 接收者ID             |
| sender   | string | 发送者ID             |

- CallBack:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 插入成功     |
| err     | string | 插入失败描述 |
| errCode | int    | 错误码       |

  

## findMessages

根据消息ID查找本地消息。

- Example:

  ```js
  this.$openSdk.findMessages(clientMsgIDList,data=>{
      ...
  })
  ```

- Parameters:


| Name            | Type   | Description         |
| --------------- | ------ | ------------------- |
| clientMsgIDList | string | 消息clientMsgID数组 |

- CallBack:


| Name    | Type   | Description                                                  |
| ------- | ------ | ------------------------------------------------------------ |
| msg     | string | [消息对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E6%B6%88%E6%81%AF%E5%AF%B9%E8%B1%A1)数组json字符串 |
| err     | string | 获取失败描述                                                 |
| errCode | int    | 错误码                                                       |

  

## addAdvancedMsgListener

设置消息监听器。

- Example:

  ```js
  this.$openSdk.addAdvancedMsgListener(data=>{
      ...
  })
  ```

- Monitor:


| Event                | Parameters                                                   | Description          |
| -------------------- | ------------------------------------------------------------ | -------------------- |
| onRecvNewMessage     | msg:新[消息对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E6%B6%88%E6%81%AF%E5%AF%B9%E8%B1%A1)json字符串 | 接收到新消息         |
| onRecvMessageRevoked | msg:被撤回消息的clientMsgID                                  | 其他用户撤回信息回执 |
| onRecvC2CReadReceipt | msg:[已读回执信息对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E5%B7%B2%E8%AF%BB%E5%9B%9E%E6%89%A7%E4%BF%A1%E6%81%AF%E5%AF%B9%E8%B1%A1)json字符串 | 消息已读回执         |



# 会话

## getAllConversationList

获取所有会话列表。

- Example:

  ```js
  this.$openSdk.getAllConversationList(data=>{
      ...
  })
  ```

- CallBack:


| Name    | Type   | Description                                                  |
| ------- | ------ | ------------------------------------------------------------ |
| msg     | string | [会话对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E4%BC%9A%E8%AF%9D%E5%AF%B9%E8%B1%A1)列表json字符串 |
| err     | string | 获取失败描述                                                 |
| errCode | int    | 错误码                                                       |

  

## getOneConversation

根据用户ID或群聊ID和session类型获取单个会话。

- Example:

  ```js
  this.$openSdk.getOneConversation(sourceID,session,data=>{
      ...
  })
  ```

- Parameters:


| Name     | Type   | Description     |
| -------- | ------ | --------------- |
| sourceID | string | 用户ID或群聊ID  |
| session  | int    | 单聊为1 群聊为2 |

- CallBack:


| Name    | Type   | Description                                                  |
| ------- | ------ | ------------------------------------------------------------ |
| msg     | string | [会话对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E4%BC%9A%E8%AF%9D%E5%AF%B9%E8%B1%A1)json字符串 |
| err     | string | 获取失败描述                                                 |
| errCode | int    | 错误码                                                       |

  

## getMultipleConversation

根据会话ID获取多个会话。

- Example:

  ```js
  this.$openSdk.getMultipleConversation(conversationIDs,data=>{
      ...
  })
  ```

- Parameters:


| Name            | Type     | Description |
| --------------- | -------- | ----------- |
| conversationIDs | string[] | 会话ID数组  |

- CallBack:


| Name    | Type   | Description                                                  |
| ------- | ------ | ------------------------------------------------------------ |
| msg     | string | [会话对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E4%BC%9A%E8%AF%9D%E5%AF%B9%E8%B1%A1)列表json字符串 |
| err     | string | 获取失败描述                                                 |
| errCode | int    | 错误码                                                       |

  

## deleteConversation

根据会话ID删除指定会话。

- Example:

  ```js
  this.$openSdk.deleteConversation(conversationID,data=>{
      ...
  })
  ```

- Parameters:


| Name           | Type   | Description |
| -------------- | ------ | ----------- |
| conversationID | string | 会话ID      |

- CallBack:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 删除成功     |
| err     | string | 删除失败描述 |
| errCode | int    | 错误码       |

  

## setConversationDraft

设置会话草稿信息。

- Example:

  ```js
  this.$openSdk.setConversationDraft(conversationID,draft,data=>{
      ...
  })
  ```

- Parameters:


| Name           | Type   | Description |
| -------------- | ------ | ----------- |
| conversationID | string | 会话ID      |
| draft          | string | 草稿信息    |

- CallBack:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 设置成功     |
| err     | string | 设置失败描述 |
| errCode | int    | 错误码       |

  

## pinConversation

置顶会话。

- Example:

  ```js
  this.$openSdk.pinConversation(conversationID,isPinned,data=>{
      ...
  })
  ```

- Parameters:


| Name           | Type   | Description |
| -------------- | ------ | ----------- |
| conversationID | string | 会话ID      |
| isPinned       | bool   | 是否置顶    |

- CallBack:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 置顶成功     |
| err     | string | 置顶失败描述 |
| errCode | int    | 错误码       |

  

## markSingleMessageHasRead

标记单聊会话消息为已读。

- Example:

  ```js
  this.$openSdk.markSingleMessageHasRead(uid,data=>{
      ...
  })
  ```

- Parameters:


| Name | Type   | Description |
| ---- | ------ | ----------- |
| uid  | string | 用户ID      |

- CallBack:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 标记成功     |
| err     | string | 标记失败描述 |
| errCode | int    | 错误码       |

  

## markGroupMessageHasRead

标记群聊会话消息已读。

- Example:

  ```js
  this.$openSdk.markGroupMessageHasRead(groupID,data=>{
      ...
  })
  ```

- Parameters:


| Name    | Type   | Description |
| ------- | ------ | ----------- |
| groupID | string | 群组ID      |

- CallBack:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 标记成功     |
| err     | string | 标记失败描述 |
| errCode | int    | 错误码       |

  

## getTotalUnreadMsgCount

获取消息总未读。

- Example:

  ```js
  this.$openSdk.getTotalUnreadMsgCount(data=>{
      ...
  })
  ```

- CallBack:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 消息总未读数 |
| err     | string | 获取失败描述 |
| errCode | int    | 错误码       |

  

## setConversationListener

设置会话监听器。

- Example:

  ```js
  this.$openSdk.setConversationListener(data=>{
      ...
  })
  ```

- Monitor:


| Event                            | Description      |
| -------------------------------- | ---------------- |
| onConversationChanged            | 会话列表发生改变 |
| onNewConversation                | 有新会话产生     |
| onSyncServerFailed               | -                |
| onSyncServerFinish               | -                |
| onSyncServerStart                | -                |
| onTotalUnreadMessageCountChanged | 消息未读总数改变 |

  

# 好友

## getFriendList

获取好友列表。

- Example:

  ```js
  this.$openSdk.getFriendList(data=>{
      ...
  })
  ```

- CallBack:


| Name    | Type   | Description                                                  |
| ------- | ------ | ------------------------------------------------------------ |
| msg     | string | [好友信息](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E5%A5%BD%E5%8F%8B%E4%BF%A1%E6%81%AF%E5%AF%B9%E8%B1%A1)对象列表json字符串 |
| err     | string | 获取失败描述                                                 |
| errCode | int    | 错误码                                                       |

  

## getFriendsInfo

获取好友信息。

- Example:

  ```js
  this.$openSdk.getFriendsInfo(uidList,data=>{
      ...
  })
  ```

- Parameters:


| Name    | Type  | Description |
| ------- | ----- | ----------- |
| uidList | array | 好友ID数组  |

- CallBack:


| Name    | Type   | Description                                                  |
| ------- | ------ | ------------------------------------------------------------ |
| msg     | string | [好友信息](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E5%A5%BD%E5%8F%8B%E4%BF%A1%E6%81%AF%E5%AF%B9%E8%B1%A1)对象列表json字符串 |
| err     | string | 获取失败描述                                                 |
| errCode | int    | 错误码                                                       |

  

## setFriendInfo

设置好友备注信息。

- Example:

  ```js
  const info = {
  	uid:"",
    comment:""
  }
  this.$openSdk.setFriendInfo(info,data=>{
      ...
  })
  ```

- Parameters:


| Name    | Type   | Description |
| ------- | ------ | ----------- |
| uid     | string | 用户ID      |
| comment | string | 备注        |

- CallBack:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 设置成功     |
| err     | string | 设置失败描述 |
| errCode | int    | 错误码       |

  

## checkFriend

检查与用户间是否有好友关系。

- Example:

  ```js
  this.$openSdk.checkFriend(uidList,data=>{
      ...
  })
  ```

- Parameters:


| Name    | Type  | Description |
| ------- | ----- | ----------- |
| uidList | Array | 用户ID数组  |

- CallBack:


| Name    | Type   | Description                |
| ------- | ------ | -------------------------- |
| msg     | string | 好友关系对象列表json字符串 |
| err     | string | 获取失败描述               |
| errCode | int    | 错误码                     |

  

## deleteFromFriendList

从好友列表中删除用户。

- Example:

  ```js
  this.$openSdk.deleteFromFriendList(uid,data=>{
      ...
  })
  ```

- Parameters:


| Name | Type   | Description |
| ---- | ------ | ----------- |
| uid  | string | 用户ID      |

- CallBack:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 删除成功     |
| err     | string | 删除失败描述 |
| errCode | int    | 错误码       |

  

## addFriend

发起添加好友申请。

- Example:

  ```js
  const reqParams = {
  	uid:"",
    reqMessage:""
  }
  this.$openSdk.addFriend(reqParams,data=>{
      ...
  })
  ```

- Parameters:


| Name       | Type   | Description  |
| ---------- | ------ | ------------ |
| uid        | string | 用户ID       |
| reqMessage | string | 申请验证信息 |

- CallBack:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 发送请求成功 |
| err     | string | 发送失败描述 |
| errCode | int    | 错误码       |

  

## getFriendApplicationList

获取好友请求列表。

- Example:

  ```js
  this.$openSdk.getFriendApplicationList(data=>{
      ...
  })
  ```

- CallBack:


| Name    | Type   | Description            |
| ------- | ------ | ---------------------- |
| msg     | string | 好友请求对象json字符串 |
| err     | string | 获取失败描述           |
| errCode | int    | 错误码                 |

  

## acceptFriendApplication

接受好友请求。

- Example:

  ```js
  this.$openSdk.acceptFriendApplication(uid,data=>{
      ...
  })
  ```

- Parameters:


| Name | Type   | Description |
| ---- | ------ | ----------- |
| uid  | string | 申请者ID    |

- CallBack:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 接受成功     |
| err     | string | 接受失败描述 |
| errCode | int    | 错误码       |

  

## refuseFriendApplication

拒绝好友请求。

- Example:

  ```js
  this.$openSdk.refuseFriendApplication(uid,data=>{
      ...
  })
  ```

- Parameters:


| Name | Type   | Description |
| ---- | ------ | ----------- |
| uid  | string | 申请者ID    |

- CallBack:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 拒绝成功     |
| err     | string | 拒绝失败描述 |
| errCode | int    | 错误码       |

  

## addToBlackList

将用户添加到黑名单。

- Example:

  ```js
  this.$openSdk.addToBlackList(uid,data=>{
      ...
  })
  ```

- Parameters:


| Name | Type   | Description |
| ---- | ------ | ----------- |
| uid  | string | 用户ID      |

- CallBack:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 添加成功     |
| err     | string | 添加失败描述 |
| errCode | int    | 错误码       |

  

## deleteFromBlackList

从黑名单移除用户。

- Example:

  ```js
  this.$openSdk.deleteFromBlackList(uid,data=>{
      ...
  })
  ```

- Parameters:


| Name | Type   | Description |
| ---- | ------ | ----------- |
| uid  | string | 用户ID      |

- CallBack:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 移除成功     |
| err     | string | 移除失败描述 |
| errCode | int    | 错误码       |

  

## getBlackList

获取黑名单列表。

- Example:

  ```js
  this.$openSdk.getBlackList(data=>{
      ...
  })
  ```

- CallBack:


| Name    | Type   | Description                                                  |
| ------- | ------ | ------------------------------------------------------------ |
| msg     | string | 被拉入黑名单的[用户信息对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E7%94%A8%E6%88%B7%E4%BF%A1%E6%81%AF%E5%AF%B9%E8%B1%A1)列表json字符串 |
| err     | string | 获取失败描述                                                 |
| errCode | int    | 错误码                                                       |

  

## setFriendListener

设置好友监听器。

- Example:

  ```js
  this.$openSdk.setFriendListener(data=>{
      ...
  })
  ```

- Monitor:


| Event                          | Description              |
| ------------------------------ | ------------------------ |
| onBlackListAdd                 | 添加用户到黑名单         |
| onBlackListDeleted             | 从黑名单中移除了某个用户 |
| onFriendApplicationListAccept  | 发出的好友请求被接受     |
| onFriendApplicationListAdded   | 好友请求列表增加         |
| onFriendApplicationListDeleted | 好友请求列表减少         |
| onFriendApplicationListReject  | 发出的好友请求被拒绝     |
| onFriendInfoChanged            | 好友信息更新             |
| onFriendListAdded              | 好友列表增加             |
| onFriendListDeleted            | 好友列表减少             |

  

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
  this.$openSdk.createGroup(gInfo,memberList,data=>{
      ...
  })
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

- CallBack:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 群聊ID       |
| err     | string | 创建失败描述 |
| errCode | int    | 错误码       |

  

## getGroupsInfo

批量获取群组信息。

- Example:

  ```js
  this.$openSdk.getGroupsInfo(GroupIDList,data=>{
      ...
  })
  ```

- Parameters:


| Name        | Type  | Description |
| ----------- | ----- | ----------- |
| GroupIDList | array | 群组ID列表  |

- CallBack:


| Name    | Type   | Description                                                  |
| ------- | ------ | ------------------------------------------------------------ |
| msg     | string | [群信息对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E7%BE%A4%E7%BB%84%E4%BF%A1%E6%81%AF%E5%AF%B9%E8%B1%A1)列表json字符串 |
| err     | string | 获取失败描述                                                 |
| errCode | int    | 错误码                                                       |

  

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
  this.$openSdk.setGroupInfo(gInfo,data=>{
      ...
  })
  ```

- Parameters:


| Name         | Type   | Description |
| ------------ | ------ | ----------- |
| groupName    | string | 群名称      |
| introduction | string | 群介绍      |
| notification | string | 群公告      |
| faceUrl      | string | 群头像      |

- CallBack:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 设置成功     |
| err     | string | 设置失败描述 |
| errCode | int    | 错误码       |

  

## getJoinedGroupList

获取已加入的群列表。

- Example:

  ```js
  this.$openSdk.getJoinedGroupList(data=>{
      ...
  })
  ```

- CallBack:


| Name    | Type   | Description                                                  |
| ------- | ------ | ------------------------------------------------------------ |
| msg     | string | [群信息对象](https://doc.rentsoft.cn/client_doc/uni_doc.html#%E7%BE%A4%E7%BB%84%E4%BF%A1%E6%81%AF%E5%AF%B9%E8%B1%A1)列表json字符串 |
| err     | string | 获取失败描述                                                 |
| errCode | int    | 错误码                                                       |

  

## getGroupMemberList

获取群成员列表。

- Example:

  ```js
  this.$openSdk.getGroupMemberList(groupID,filter,next,data=>{
      ...
  })
  ```

- Parameters:


| Name    | Type   | Description                         |
| ------- | ------ | ----------------------------------- |
| groupID | string | 群聊ID                              |
| filter  | int    | 过滤标识 0:所有成员 1:群主 2:管理员 |
| next    | int    | 分页下标  从0开始                   |

- CallBack:


| Name    | Type   | Description                  |
| ------- | ------ | ---------------------------- |
| msg     | string | 群成员信息对象列表json字符串 |
| err     | string | 获取失败描述                 |
| errCode | int    | 错误码                       |

  

## getGroupMembersInfo

批量获取群成员信息。

- Example:

  ```js
  this.$openSdk.getGroupMembersInfo(groupID,uidList,data=>{
      ...
  })
  ```

- Parameters:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| groupID | string | 群聊ID       |
| uidList | array  | 群成员ID数组 |

- CallBack:


| Name    | Type   | Description                  |
| ------- | ------ | ---------------------------- |
| msg     | string | 群成员信息对象列表json字符串 |
| err     | string | 获取失败描述                 |
| errCode | int    | 错误码                       |

  

## joinGroup

申请加入群聊。

- Example:

  ```js
  this.$openSdk.joinGroup(groupID,reqMsg,data=>{
      ...
  })
  ```

- Parameters:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| groupID | string | 群聊ID       |
| reqMsg  | string | 请求验证信息 |

- CallBack:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 发送申请成功 |
| err     | string | 申请失败描述 |
| errCode | int    | 错误码       |

  

## getGroupApplicationList

获取加入群聊申请列表。

- Example:

  ```js
  this.$openSdk.getGroupApplicationList(data=>{
      ...
  })
  ```

- CallBack:


| Name    | Type   | Description                |
| ------- | ------ | -------------------------- |
| msg     | string | 入群申请对象列表json字符串 |
| err     | string | 获取失败描述               |
| errCode | int    | 错误码                     |

  

## acceptGroupApplication

同意入群请求。

- Example:

  ```js
  this.$openSdk.acceptGroupApplication(application,reason,data=>{
      ...
  })
  ```

- Parameters:


| Name        | Type   | Description            |
| ----------- | ------ | ---------------------- |
| application | string | 入群申请对象json字符串 |
| reason      | string | 同意原因               |

- CallBack:


| Name    | Type   | Description      |
| ------- | ------ | ---------------- |
| msg     | string | 同意入群成功     |
| err     | string | 同意入群失败描述 |
| errCode | int    | 错误码           |

  

## refuseGroupApplication

拒绝入群请求。

- Example:

  ```js
  this.$openSdk.refuseGroupApplication(application,reason,data=>{
      ...
  })
  ```

- Parameters:


| Name        | Type   | Description            |
| ----------- | ------ | ---------------------- |
| application | string | 入群申请对象json字符串 |
| reason      | string | 拒绝入群原因           |

- CallBack:


| Name    | Type   | Description      |
| ------- | ------ | ---------------- |
| msg     | string | 拒绝入群成功     |
| err     | string | 拒绝入群失败描述 |
| errCode | int    | 错误码           |

  

## inviteUserToGroup

邀请用户加入群组(可批量)。

- Example:

  ```js
  this.$openSdk.inviteUserToGroup(groupID,reqMsg,uidList,data=>{
      ...
  })
  ```

- Parameters:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| groupID | string | 群聊ID       |
| reqMsg  | string | 请求验证信息 |
| uidList | array  | 邀请用户列表 |

- CallBack:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 邀请成功     |
| err     | string | 邀请失败描述 |
| errCode | int    | 错误码       |

  

## kickGroupMember

踢出群聊(可批量)。

- Example:

  ```js
  this.$openSdk.kickGroupMember(groupID,reqMsg,uidList,data=>{
      ...
  })
  ```

- Parameters:


| Name    | Type   | Description    |
| ------- | ------ | -------------- |
| groupID | string | 群聊ID         |
| reqMsg  | string | 踢出原因       |
| uidList | array  | 踢出用户ID数组 |

- CallBack:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 踢出成功     |
| err     | string | 踢出失败描述 |
| errCode | int    | 错误码       |

  

## quitGroup

退出群聊。

- Example:

  ```js
  this.$openSdk.quitGroup(groupID,data=>{
      ...
  })
  ```

- Parameters:


| Name    | Type   | Description |
| ------- | ------ | ----------- |
| groupID | string | 群聊ID      |

- CallBack:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 退出成功     |
| err     | string | 退出失败描述 |
| errCode | int    | 错误码       |

  

## transferGroupOwner

转让群主。

- Example:

  ```js
  this.$openSdk.transferGroupOwner(groupID,uid,data=>{
      ...
  })
  ```

- Parameters:


| Name    | Type   | Description |
| ------- | ------ | ----------- |
| groupID | string | 群聊ID      |
| uid     | string | 用户ID      |

- CallBack:


| Name    | Type   | Description  |
| ------- | ------ | ------------ |
| msg     | string | 转让成功     |
| err     | string | 转让失败描述 |
| errCode | int    | 错误码       |

  

## setGroupListener

设置群组监听器。

- Example:

  ```js
  this.$openSdk.setGroupListener(data=>{
      ...
  })
  ```

- Monitor:


| Event                    | Description          |
| ------------------------ | -------------------- |
| onApplicationProcessed   | 入群申请被处理       |
| onGroupCreated           | 群组创建             |
| onGroupInfoChanged       | 群组信息改变         |
| onMemberEnter            | 有新成员加入群组     |
| onMemberInvited          | 邀请新成员加入了群组 |
| onMemberKicked           | 有群成员被踢出       |
| onMemberLeave            | 有群成员退群         |
| onReceiveJoinApplication | 收到入群申请         |





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
| gender | int    | 用户性别 0:                    |
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
      atUserList: array|null;
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
      abstractList: any[]|null;
      multiMessage: any[]|null;
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
      quoteMessage: any[];
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

