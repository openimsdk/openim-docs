# 消息相关API

> 所有API中需要用到的`operationID`为随机字符串，通常用于定位问题使用，建议每一次API调用均采用唯一ID，可通过npm包uuid生成。<br/>存在callback的API，callback的回调参数格式为统一格式，errCode为0则代表操作成功，否则为失败。具体参考[此处说明]()。

| 方法                                    | 描述                             |
| --------------------------------------- | -------------------------------- |
| getHistoryMessageList                   | 获取聊天记录                     |
| revokeMessage                           | 撤回某条消息                     |
| deleteMessageFromLocalStorage           | 从本地删除某条消息               |
| deleteMessageFromLocalAndSvr            | 从本地和服务器删除某条消息       |
| insertSingleMessageToLocalStorage       | 插入一条单聊消息到本地           |
| insertGroupMessageToLocalStorage        | 插入一条群聊消息到本地           |
| markC2CMessageAsRead                    | 标记单聊消息已读或置零会话未读数 |
| markGroupMessageAsRead                  | 标记群聊消息已读或置零会话未读数 |
| typingStatusUpdate                      | 正在输入提示                     |
| createTextMessage                       | 创建文本消息                     |
| createTextAtMessage                     | 创建@消息                        |
| createImageMessageByURL                 | 创建图片消息                     |
| createImageMessageFromFullPath          | 根据资源文件路径创建图片消息     |
| createSoundMessageByURL                 | 创建语音消息                     |
| createSoundMessageFromFullPath          | 根据资源文件路径创建语音消息     |
| createVideoMessageByURL                 | 创建视频消息                     |
| createVideoMessageFromFullPath          | 根据资源文件路径创建视频消息     |
| createFileMessageByURL                  | 创建文件消息                     |
| createFileMessageFromFullPath           | 根据资源文件路径创建文件消息     |
| createMergerMessage                     | 创建合并消息                     |
| createForwardMessage                    | 创建转发消息                     |
| createLocationMessage                   | 创建位置消息                     |
| createCustomMessage                     | 创建自定义消息                   |
| createQuoteMessage                      | 创建引用消息                     |
| createCardMessage                       | 创建卡片消息                     |
| createFaceMessage                       | 创建自定义表情消息               |
| sendMessage                             | 发送消息                         |
| sendMessageNotOss                       | 发送需要需要自行上传的文件类消息 |
| clearC2CHistoryMessage                  | 清空单聊消息记录                 |
| clearC2CHistoryMessageFromLocalAndSvr   | 删除本地跟服务器的单聊聊天记录   |
| clearGroupHistoryMessage                | 清空群聊消息记录                 |
| clearGroupHistoryMessageFromLocalAndSvr | 删除本地跟服务器的群聊天记录     |
| searchLocalMessages                     | 搜索消息记录                     |
| deleteAllMsgFromLocal                   | 删除本地所有聊天记录             |
| deleteAllMsgFromLocalAndSvr             | 删除本地跟服务器所有聊天记录     |
| getHistoryMessageListReverse            | 反向获取聊天记录                 |




## getHistoryMessageList

> 分页拉取单聊或群聊的历史消息。该API会拉取发送时间在`startClientMsgID`对应消息发送时间之前的消息。

- Example:

  ```js
  const options = {
    groupID:"",
    startClientMsgID:"",
    count:12,
    userID:"userID"
  }
  openIM.getHistoryMessageList(operationID,options,({ data })=>{
    ...
  })
  ```

- Parameters:

  | Name             | Type   | Required | Description                                                  |
  | ---------------- | ------ | -------- | ------------------------------------------------------------ |
  | groupID          | string | true     | 群聊ID，拉取群聊时传入，否则为“”                             |
  | startClientMsgID | string | true     | 上一次拉取的最后一条消息ID或空字符串,为空字符则从最新一条开始 |
  | count            | number | true     | 每次拉取的条数                                               |
  | userID           | string | true     | 用户ID，拉取单聊时传入，否则为“”                             |

- CallBack:

  | Name | Type   | Description                    |
  | ---- | ------ | ------------------------------ |
  | data | string | 历史[消息对象]()数组json字符串 |

  

## revokeMessage

> 撤回某条消息。

- Example:

  ```js
  openIM.revokeMessage(operationID,message,({ data })=>{
    ...
  })
  ```

- Parameters:

  | Name    | Type        | Description        |
  | ------- | ----------- | ------------------ |
  | message | MessageItem | 要撤回的消息结构体 |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 撤回成功或失败描述 |



## deleteMessageFromLocalStorage

> 删除本地消息。

- Example:

  ```js
  openIM.deleteMessageFromLocalStorage(operationID,message,({ data })=>{
    ...
  })
  ```

- Parameters:

  | Name    | Type        | Required | Description |
  | ------- | ----------- | -------- | ----------- |
  | message | MessageItem | true     | 消息结构体  |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 删除成功或失败描述 |



## deleteMessageFromLocalAndSvr

> 删除本地消息。

- Example:

  ```js
  openIM.deleteMessageFromLocalAndSvr(operationID,message,({ data })=>{
    ...
  })
  ```

- Parameters:

  | Name    | Type        | Required | Description |
  | ------- | ----------- | -------- | ----------- |
  | message | MessageItem | true     | 消息结构体  |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 删除成功或失败描述 |



## insertSingleMessageToLocalStorage

> 插入一条单聊消息到本地。

- Example:

  ```js
  openIM.insertSingleMessageToLocalStorage(operationID,message,recvID,sendID,({ data })=>{
    ...
  })
  ```

- Parameters:

  | Name    | Type   | Required | Description          |
  | ------- | ------ | -------- | -------------------- |
  | message | string | true     | 消息结构体json字符串 |
  | recvID  | string | true     | 接收者ID             |
  | sendID  | string | true     | 发送者ID             |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 插入成功或失败描述 |

  

## insertGroupMessageToLocalStorage

> 插入一条群聊消息到本地。

- Example:

  ```js
  openIM.insertGroupMessageToLocalStorage(operationID,message,groupID,sendID,({ data })=>{
    ...
  })
  ```

- Parameters:

  | Name    | Type   | Required | Description          |
  | ------- | ------ | -------- | -------------------- |
  | message | string | true     | 消息结构体json字符串 |
  | groupID | string | true     | 接收者群聊ID         |
  | sendID  | string | true     | 发送者ID             |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 插入成功或失败描述 |



## markC2CMessageAsRead

> 实时消息已读回执，在 C2C 单聊场景下，当接收方通过 markC2CMessageAsRead接口将来自某人的消息标记为已读时，消息的发送方将会收到“已读回执”，表示“xxx 已经读过我的消息了”。
>
> **特别的：**当msgIDList为一个空数组[]时，该API作用同v1.x版本markSingleMessageHasRead（现已移除），即标记单聊会话为已读，置零该会话未读数。

- Example:

  ```js
  openIM.markC2CMessageAsRead(operationID,userID,msgIDList,({ data })=>{
    ...
  })
  ```

- Parameters:

  | Name      | Type     | Required | Description             |
  | --------- | -------- | -------- | ----------------------- |
  | userID    | string   | true     | 会话对象用户ID          |
  | msgIDList | string[] | true     | 已读消息clientMsgID数组 |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 标记成功或失败描述 |



## markGroupMessageAsRead

> 实时消息已读回执，在群聊场景下，当接收方通过 markGroupMessageAsRead接口将来自某人的消息标记为已读时，消息的发送方将会收到“已读回执”，表示“xxx 已经读过我的消息了”。
>
> **特别的：**当msgIDList为一个空数组[]时，该API作用同v1.x版本markGroupMessageHasRead（现已移除），即标记群聊会话为已读，置零该会话未读数。

- Example:

  ```js
  openIM.markC2CMessageAsRead(operationID,groupID,msgIDList,({ data })=>{
    ...
  })
  ```

- Parameters:

  | Name      | Type     | Required | Description             |
  | --------- | -------- | -------- | ----------------------- |
  | groupID   | string   | true     | 群聊ID                  |
  | msgIDList | string[] | true     | 已读消息clientMsgID数组 |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 标记成功或失败描述 |



## typingStatusUpdate

> 更新正在输入状态。

- Example:

  ```js
  openIM.typingStatusUpdate(operationID,recvID,msgTip,({ data })=>{
    ...
  })
  ```

- Parameters:

  | Name   | Type   | Required | Description    |
  | ------ | ------ | -------- | -------------- |
  | recvID | string | true     | 接收者ID       |
  | msgTip | string | true     | 自定义输入描述 |




## createTextMessage

> 创建一条文字消息。

- Example:

  ```js
  const data = openIM.createTextMessage(OperationID,textStr)
  ```

- Parameters:

  | Name    | Type   | Required | Description  |
  | ------- | ------ | -------- | ------------ |
  | textStr | string | true     | 消息文字内容 |

- Returns:

  | Name | Type   | Description          |
  | ---- | ------ | -------------------- |
  | data | string | 文字信息结构体字符串 |

## createTextAtMessage

> 创建一条@文字消息。

- Example:

  ```js
  const atUserInfoList = {
    userID:"",
    groupNickname:""
  }
  const data = openIM.createTextMessage(OperationID,text,atUserIDList,atUserInfoList,message)
  ```

- Parameters:

  | Name                          | Type     | Required | Description   |
  | ----------------------------- | -------- | -------- | ------------- |
  | text                          | string   | true     | 消息文字内容  |
  | atUserIDList                  | string[] | true     | @用户id数组   |
  | atUserInfoList->userID        | string   | true     | @用户id       |
  | atUserInfoList->groupNickname | string   | true     | @用户昵称     |
  | message                       | string   | false    | @消息引用消息 |

- Returns:

  | Name | Type   | Description           |
  | ---- | ------ | --------------------- |
  | Data | string | @文字信息结构体字符串 |



## createImageMessageByURL

> 根据已上传文件的URL及文件信息创建一条图片消息。

**注意:通过该API创建的消息需要通过[sendMessageNotOss]()方法发送。**

- Example:

  ```js
  const sourceImageInfo = {
        uuid:"xxx",
        type:"png",
        size:12465,
        width:1080,
        height:720,
        url:"http://www.ptbird.cn/usr/uploads/2019/07/2213642051.png"
    }
  const data = openIM.createImageMessageByURL(OperationID,sourceImageInfo,bigImageInfo:sourceImageInfo,snapImageInfo:sourceImageInfo)
  ```

- Parameters:

  | Name   | Type   | Required | Description |
  | ------ | ------ | -------- | ----------- |
  | uuid   | string | true     | 图片唯一id  |
  | type   | string | true     | 图片类型    |
  | size   | number | true     | 图片大小    |
  | width  | number | true     | 图片宽度    |
  | height | number | true     | 图片高度    |
  | url    | string | true     | 图片地址    |

- Returns:

  | Name | Type   | Description          |
  | ---- | ------ | -------------------- |
  | data | string | 图片信息结构体字符串 |




## createImageMessageFromFullPath

> 根据文件在本机的绝对路径创建一条图片消息。<br/>

- Example:

  ```js
  const data = openIM.createImageMessageFromFullPath(OperationID,path)
  ```

- Parameters:

  | Name | Type   | Required | Description  |
  | ---- | ------ | -------- | ------------ |
  | path | string | true     | 图片绝对路径 |

- Returns:

  | Name | Type   | Description          |
  | ---- | ------ | -------------------- |
  | data | string | 图片信息结构体字符串 |




## createSoundMessageByURL

> 根据已上传文件的URL及文件信息创建一条语音消息。

**注意:通过该API创建的消息需要通过[sendMessageNotOss]()方法发送。**

- Example:

  ```js
  const options = {
        uuid:"xx",
        soundPath:"xx",
        sourceUrl:"http://xxx/mic.mp3",
        dataSize:1234,
        duration:42
      }
  const data = openIM.createSoundMessageByURL(OperationID,options)
  ```

- Parameters:

  | Name      | Type   | Required | Description  |
  | --------- | ------ | -------- | ------------ |
  | uuid      | string | true     | 唯一id       |
  | soundPath | string | true     | 留空字符即可 |
  | sourceUrl | string | true     | 音频地址     |
  | dataSize  | number | true     | 音频文件大小 |
  | duration  | number | true     | 音频时长     |

- Returns:


| Name | Type   | Description          |
| ---- | ------ | -------------------- |
| data | string | 语音信息结构体字符串 |

​    

## createSoundMessageFromFullPath

> 根据语音文件在本机的绝对路径创建一条语音消息。<br/>

- Example:

  ```js
  const data = openIM.createSoundMessageFromFullPath(OperationID,soundPath,duration)
  ```

- Parameters:

  | Name      | Type   | Required | Description      |
  | --------- | ------ | -------- | ---------------- |
  | soundPath | string | true     | 音频文件绝对路径 |
  | duration  | number | true     | 音频时长         |

- Returns:


| Name | Type   | Description          |
| ---- | ------ | -------------------- |
| data | string | 语音信息结构体字符串 |





## createVideoMessageByURL

> 根据已上传文件的URL及文件信息创建一条视频消息。

**注意:通过该API创建的消息需要通过[sendMessageNotOss]()方法发送。**

- Example:

  ```js
  const options = {
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
  const data = openIM.createVideoMessageByURL(OperationID,options)
  ```

- Parameters:

  | Name           | Type   | Required | Description         |
  | -------------- | ------ | -------- | ------------------- |
  | videoPath      | string | true     | 留为空字符串即可    |
  | videoType      | string | true     | 视频类型(MP4,AVI..) |
  | duration       | number | true     | 视频时长            |
  | snapshotPath   | string | true     | 留为空字符串即可    |
  | videoUUID      | string | true     | 视频文件唯一id      |
  | videoUrl       | string | true     | 视频文件地址        |
  | videoSize      | number | true     | 视频文件大小        |
  | snapshotUUID   | string | true     | 视频快照唯一id      |
  | snapshotSize   | number | true     | 视频快照大小        |
  | snapshotUrl    | string | true     | 视频快照地址        |
  | snapshotWidth  | number | true     | 视频快照宽度        |
  | snapshotHeight | number | true     | 视频快照高度        |

- Returns:

  | Name | Type   | Description          |
  | ---- | ------ | -------------------- |
  | data | string | 视频信息结构体字符串 |

    

## createVideoMessageFromFullPath

> 根据本机视频文件绝对路径创建一条视频消息。<br/>

- Example:

  ```js
  const data = openIM.createVideoMessageFromFullPath(OperationID,videoFullPath,videoType,duration,snapshotFullPath)
  ```

- Parameters:

  | Name             | Type   | Required | Description         |
  | ---------------- | ------ | -------- | ------------------- |
  | videoFullPath    | string | true     | 视频文件绝对路径    |
  | videoType        | string | true     | 视频类型(MP4,AVI..) |
  | duration         | number | true     | 视频时长            |
  | snapshotFullPath | string | true     | 视频快照绝对路径    |

- Returns:

  | Name | Type   | Description          |
  | ---- | ------ | -------------------- |
  | data | string | 视频信息结构体字符串 |

    

## createFileMessageByURL

> 根据已上传文件的URL及文件信息创建一条文件消息。

**注意:通过该API创建的消息需要通过[sendMessageNotOss]()方法发送。**

- Example:

  ```js
  const options = {
        filePath: "",
        fileName: "test",
        uuid:"xxsadsa",
        sourceUrl:"wwwm",
        fileSize:1234
      };
  const data = openIM.createFileMessageByURL(OperationID,options)
  ```

- Parameters:

  | Name      | Type   | Required | Description      |
  | --------- | ------ | -------- | ---------------- |
  | filePath  | string | true     | 留为空字符串即可 |
  | fileName  | string | true     | 文件名称         |
  | uuid      | string | true     | 文件唯一id       |
  | sourceUrl | string | true     | 文件地址         |
  | fileSize  | number | true     | 文件大小         |

- Returns:

  | Name | Type   | Description          |
  | ---- | ------ | -------------------- |
  | data | string | 文件信息结构体字符串 |






## createFileMessageFromFullPath

> 根据文件在本机的绝对路径创建一条文件消息。<br/>

- Example:

  ```js
  const data = openIM.createFileMessageFromFullPath(OperationID,fileFullPath,fileName)
  ```

- Parameters:

  | Name         | Type   | Required | Description  |
  | ------------ | ------ | -------- | ------------ |
  | fileFullPath | string | true     | 文件绝对路径 |
  | fileName     | string | true     | 文件名称     |

- Returns:

  | Name | Type   | Description          |
  | ---- | ------ | -------------------- |
  | data | string | 文件信息结构体字符串 |

  

## createMergerMessage

> 创建一条合并消息。

- Example:

  ```js
  const data = openIM.createFileMessageFromFullPath(OperationID,messageList,title,summaryList)
  ```

- Parameters:

  | Name        | Type     | Required | Description        |
  | ----------- | -------- | -------- | ------------------ |
  | messageList | string[] | true     | [消息对象]()列表   |
  | title       | string   | true     | 合并消息标题       |
  | summaryList | string[] | true     | 合并消息的摘要列表 |

- Returns:

  | Name | Type   | Description          |
  | ---- | ------ | -------------------- |
  | data | string | 合并信息结构体字符串 |




## createForwardMessage

> 创建一条转发消息。

- Example:

  ```js
  const data = openIM.createForwardMessage(OperationID,message)
  ```

- Parameters:

  | Name    | Type   | Required | Description          |
  | ------- | ------ | -------- | -------------------- |
  | message | string | true     | 消息结构体json字符串 |

- Returns:

  | Name | Type   | Description          |
  | ---- | ------ | -------------------- |
  | data | string | 转发信息结构体字符串 |


​    

## createLocationMessage

> 创建一条地理位置消息。

- Example:

  ```js
  const data = openIM.createLocationMessage(OperationID,description,latitude,longitude)
  ```

- Parameters:

  | Name        | Type   | Required | Description |
  | ----------- | ------ | -------- | ----------- |
  | description | string | true     | 描述信息    |
  | latitude    | number | true     | 纬度        |
  | longitude   | number | true     | 经度        |

- Returns:

  | Name | Type   | Description          |
  | ---- | ------ | -------------------- |
  | data | string | 地理信息结构体字符串 |



## createCustomMessage

> 创建一条自定义消息。

- Example:

  ```js
  const data = openIM.createCustomMessage(OperationID,data,extension,description)
  ```

- Parameters:

  | Name        | Type   | Required | Description                  |
  | ----------- | ------ | -------- | ---------------------------- |
  | data        | string | true     | 自定义信息结构json字符串     |
  | extension   | string | true     | 自定义信息扩展字段json字符串 |
  | description | string | true     | 自定义消息描述               |

- Return:

  | Name | Type   | Description            |
  | ---- | ------ | ---------------------- |
  | data | string | 自定义信息结构体字符串 |


​    

## createQuoteMessage

> 创建一条引用消息。

- Example:

  ```js
  const data = openIM.createQuoteMessage(OperationID,text,message)
  ```

- Parameters:

  | Name    | Type   | Required | Description                                                  |
  | ------- | ------ | -------- | ------------------------------------------------------------ |
  | text    | string | true     | 消息内容                                                     |
  | message | string | true     | 引用[消息对象](https://doc.rentsoft.cn/client_doc/web_doc.html#%E6%B6%88%E6%81%AF%E5%AF%B9%E8%B1%A1)json字符串 |

- Returns:

  | Name | Type   | Description          |
  | ---- | ------ | -------------------- |
  | data | string | 引用消息结构体字符串 |




## createCardMessage

> 创建一条名片位置消息。

- Example:

  ```js
  const data = openIM.createQuoteMessage(OperationID,cardDesc)
  ```

- Parameters

  | Name     | Type   | Required | Description                  |
  | -------- | ------ | -------- | ---------------------------- |
  | cardDesc | string | true     | 自定义名片信息对象json字符串 |

- Returns:

  | Name | Type   | Description          |
  | ---- | ------ | -------------------- |
  | data | string | 名片消息结构体字符串 |


​    

## createFaceMessage

> 创建一条表情消息。

- Example:

  ```js
  const data = openIM.createFaceMessage(OperationID,index,data)
  ```

- Parameters

  | Name  | Type   | Required | Description              |
  | ----- | ------ | -------- | ------------------------ |
  | index | number | true     | 表情下标                 |
  | data  | string | true     | 自定义表情信息json字符串 |

- Returns:

  | Name | Type   | Description          |
  | ---- | ------ | -------------------- |
  | data | string | 表情消息结构体字符串 |

​    

## sendMessage/sendMessageNotOss

> OpenIM消息按照消息发送的目标可分为：“单聊消息”和“群聊消息”，在发送单聊消息时设置groupID为空字符串，同理发送群聊消息时设置userID为空字符串即可。<br/>sendMessage和sendMessageNotOss方法参数相同，但通过`createImageMessageByURL`、`createSoundMessageByURL`、`createVideoMessageByURL`、`createFileMessageByURL`方法创建的消息必须通过sendMessageNotOss进行发送。

- Example:

  ```js
  const offlinePushInfo = {
    title: "you have a new message",
    desc: "",
    ex: "",
    iOSPushSound: "",
    iOSBadgeCount: true
  }
  openIM.sendMessage(OperationID,message,recvID,groupID,offlinePushInfo,({ data })=>{
    ...
  })
  ```

- Parameters:

  | Name                           | Type        | Required | Description          |
  | ------------------------------ | ----------- | -------- | -------------------- |
  | message                        | string      | true     | 消息结构体json字符串 |
  | recvID                         | string      | true     | 接收者ID（单聊）     |
  | groupID                        | string      | true     | 接收群组ID（群聊）   |
  | offlinePushInfo                | OfflinePush | false    | 离线推送配置         |
  | offlinePushInfo->title         | string      | true     | 推送标题             |
  | offlinePushInfo->desc          | string      | true     | 推送描述             |
  | offlinePushInfo->ex            | string      | true     | 推送扩展字段         |
  | offlinePushInfo->iOSPushSound  | string      | true     | ios推送声音          |
  | offlinePushInfo->iOSBadgeCount | boolean     | true     | ios推送角标          |

- Returns:

  | Name    | Type   | Description                          |
  | ------- | ------ | ------------------------------------ |
  | data    | string | 发送成功时为发送的消息对象json字符串 |
  | errCode | number | 为0时即发送成功，其他为失败          |




## clearC2CHistoryMessage

> 从本地删除指定单聊会话中所有消息

- Example:

  ```js
  openIM.clearC2CHistoryMessage(OperationID,userID,({ data })=>{
    ...
  })
  ```

- Parameters:

  | Name   | Type   | Required | Description        |
  | ------ | ------ | -------- | ------------------ |
  | userID | string | true     | 要删除对象的用户ID |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 删除成功或失败描述 |



## clearC2CHistoryMessageFromLocalAndSvr

> 从本地及服务端删除指定单聊会话中所有消息

- Example:

  ```js
  openIM.clearC2CHistoryMessageFromLocalAndSvr(OperationID,userID,({ data })=>{
    ...
  })
  ```

- Parameters:

  | Name   | Type   | Required | Description        |
  | ------ | ------ | -------- | ------------------ |
  | userID | string | true     | 要删除对象的用户ID |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 删除成功或失败描述 |



## clearGroupHistoryMessage

> 从本地删除指定群聊会话中所有消息

- Example:

  ```js
  openIM.clearGroupHistoryMessage(OperationID,groupID,({ data })=>{
    ...
  })
  ```

- Parameters:

  | Name    | Type   | Required | Description            |
  | ------- | ------ | -------- | ---------------------- |
  | groupID | string | true     | 要删除对象群聊的群聊ID |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 删除成功或失败描述 |



## clearGroupHistoryMessageFromLocalAndSvr

> 从本地删除指定群聊会话中所有消息

- Example:

  ```js
  openIM.clearGroupHistoryMessageFromLocalAndSvr(OperationID,groupID,({ data })=>{
    ...
  })
  ```

- Parameters:

  | Name    | Type   | Required | Description            |
  | ------- | ------ | -------- | ---------------------- |
  | groupID | string | true     | 要删除对象群聊的群聊ID |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 删除成功或失败描述 |



## searchLocalMessages

> 搜索聊天记录

- Example:

  ```js
  const options = {
    conversationID: "",
    keywordList: [""],
    keywordListMatchType: 0,
    senderUserIDList: [],
    messageTypeList: [],
    searchTimePosition: 0,
    searchTimePeriod: 0,
    pageIndex: 0,
    count: 0,
  }
  openIM.clearGroupHistoryMessageFromLocalAndSvr(OperationID,options,({ data })=>{
    ...
  })
  ```

- Parameters:

  | Name                 | Type          | Required | Description                             |
  | -------------------- | ------------- | -------- | --------------------------------------- |
  | conversationID       | string        | true     | 会话ID，为空字符串时会进行全局搜索      |
  | keywordList          | string[]      | true     | 搜索关键词                              |
  | keywordListMatchType | number        | true     | 关键词匹配模式，暂未使用                |
  | senderUserIDList     | string[]      | true     | 消息发送者ID数组，为空数组时不限制      |
  | messageTypeList      | MessageType[] | true     | 消息类型数组，为空数组时不限制          |
  | searchTimePosition   | number        | true     | 消息起始时间，为0时不限制               |
  | searchTimePeriod     | number        | true     | 消息从起始时间开始搜索区间，为0时不限制 |
  | pageIndex            | number        | true     | 分页下标，全局搜索时无效                |
  | count                | number        | true     | 分页数量，全局搜索时无效                |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 搜索结果json字符串 |



## deleteAllMsgFromLocal

> 从本地删除所有聊天记录

- Example:

  ```js
  openIM.deleteAllMsgFromLocal(OperationID,({ data })=>{
    ...
  })
  ```

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 删除成功或失败描述 |



## deleteAllMsgFromLocalAndSvr

> 从本地及服务端删除所有聊天记录

- Example:

  ```js
  openIM.deleteAllMsgFromLocalAndSvr(OperationID,({ data })=>{
    ...
  })
  ```

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 删除成功或失败描述 |



## getHistoryMessageListReverse

> **反向**分页拉取单聊或群聊的历史消息。该API会拉取发送时间在`startClientMsgID`对应消息发送时间之后的消息。

- Example:

  ```js
  const options = {
    groupID:"",
    startClientMsgID:"",
    count:12,
    userID:"userID"
  }
  openIM.deleteAllMsgFromLocalAndSvr(OperationID,options,({ data })=>{
    ...
  })
  ```

- Parameters:

  | Name             | Type   | Required | Description                                                  |
  | ---------------- | ------ | -------- | ------------------------------------------------------------ |
  | groupID          | string | true     | 群聊ID，拉取群聊时传入，否则为“”                             |
  | startClientMsgID | string | true     | 上一次拉取的最后一条消息ID或空字符串,为空字符则从最新一条开始 |
  | count            | number | true     | 每次拉取的条数                                               |
  | userID           | string | true     | 用户ID，拉取单聊时传入，否则为“”                             |

- CallBack:

  | Name | Type   | Description                    |
  | ---- | ------ | ------------------------------ |
  | data | string | 历史[消息对象]()数组json字符串 |

  



# 消息相关回调

> 相关回调需要通过导入`globalEvent`进行监听，引入步骤参考[SDK引入]()。

| 事件                          | 描述                                   | 响应                   |
| ----------------------------- | -------------------------------------- | ---------------------- |
| onRecvNewMessage              | 收到新消息                             | 新消息结构体json字符串 |
| onRecvNewMessages             | 收到新消息（开启批量推送时）           | 新消息数组json字符串   |
| onRecvMessageRevoked          | 有消息被撤回                           | 被撤回的消息ID         |
| onRecvC2CReadReceipt          | 收到单聊已读回执，即有人读了发出的消息 | 消息ID列表             |
| onRecvGroupMessageReadReceipt | 收到群聊已读回执，即有人读了发出的消息 | 消息ID列表             |