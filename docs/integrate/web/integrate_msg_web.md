# 消息发送

> 消息发送需要根据消息类型调用对应Api创建相应消息结构体，然后将SDK返回的普通消息的结构体通过[sendMessage]()发送，特别的，图片消息、语音消息、视频消息、文件消息需要通过[sendMessageNotOss]()发送。



## 创建文本消息

> 传入文本信息，SDK会创建并返回一条文本消息。

```js
/**
* 创建文本消息
*
* @param textMsg 输入信息
* @return 新文本消息对象结构Json字符串
*/
openIM.createTextMessage(textMsg).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



## 创建@消息

> 传入文本信息，以及要@的用户，SDK会创建并返回一条文本形式的@消息。

```js
/**
* 创建@消息
*
* @param text 输入信息
* @param atUserIDList @用户id数组
* @return 新@消息对象结构Json字符串
*/
const options = {
  text: "I am at Msg",
  atUserIDList: ["1f8e0d51d335301d"],
};
openIM.createTextAtMessage(options).then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



## 创建图片消息

> 传入已上传文件的URL及文件信息，SDK会创建并返回一条图片消息。

```js
/**
* 创建图片消息
*
* @param ImageMsgParams 图片信息结构
* @return 新图片消息对象结构Json字符串
*/
const baseInfo:PicBaseInfo = {
      uuid:"", 		//图片唯一id
      type:"png",	//图片类型
      size:12465,	//图片大小
      width:1080,	//图片宽度
      height:720,	//图片高度
      url:"http://www.ptbird.cn/usr/uploads/2019/07/2213642051.png"	//图片上传后url
  }
const data:ImageMsgParams = {
    sourcePicture:baseInfo,		//原图信息
    bigPicture:baseInfo,			//大图信息
    snapshotPicture:baseInfo,	//缩略图信息
  }
openIM.createImageMessage(data).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



## 创建语音消息

> 传入已上传文件的URL及文件信息，SDK会创建并返回一条语音消息。

```js
/**
* 创建语音消息
*
* @param SoundMsgParams 语音信息结构
* @return 新语音消息对象结构Json字符串
*/
const data:SoundMsgParams = {
      uuid:"xx",			//语音唯一id
      soundPath:"xx",	//留空字符串
      sourceUrl:"http://101.34.243.21:52013/mic.mp3",	//语音文件上传后地址
      dataSize:1234,	//语音文件大小
      duration:42			//语音时长
    }
openIM.createSoundMessage(data).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



## 创建视频消息

> 传入已上传文件的URL及文件信息，SDK会创建并返回一条视频消息。

```js
/**
* 创建视频消息
*
* @param VideoMsgParams 视频绝对路径
* @return 新视频消息对象结构Json字符串
*/
const data:VideoMsgParams = {
      videoPath: "xxx",					//留空字符串
      duration: 12,							//视频时长
      videoType: "mp4",					//视频格式
      snapshotPath: "xxx",			//留空字符串
      videoUUID:"xx",						//视频唯一id
      videoUrl:"xx",						//视频文件上传后地址
      videoSize:1234,						//视频文件大小
      snapshotUUID:"stringspn",	//视频快照唯一id
      snapshotSize:123,					//视频快照大小
      snapshotUrl:"xxx",				//视频快照上传后地址
      snapshotWidth:124,				//视频快照宽度
      snapshotHeight:125				//视频快照高度
    };
openIM.createVideoMessage(data).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



## 创建文件消息

> 传入已上传文件的URL及文件信息，SDK会创建并返回一条文件消息。

```js
/**
* 创建文件消息
*
* @param FileMsgParams 文件地址
* @return 新文件消息对象结构Json字符串
*/
const data:FileMsgParams = {
      filePath: "",			//留空字符串
      fileName: "test",	//文件名称
      uuid:"xxsadsa",		//文件唯一id
      sourceUrl:"wwwm",	//文件上传后地址
      fileSize:1234			//文件大小
    };
openIM.createFileMessage(data).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



## 创建合并消息

> 传入要合并的消息列表（messageList）和要显示的摘要列表（summaryList）并为其创建一个标题（title），SDK会创建并返回一条合并消息。摘要列表和标题可以用来在聊天界面进行简单展示合并消息主要内容。

```js
/**
* 创建合并消息
*
* @param messageList 消息对象json字符串列表
* @param title 合并消息标题
* @param summaryList 合并消息的摘要列表
* @return 新合并消息对象结构Json字符串
*/
const data:MergerMsgParams = {
  messageList:[''],
  title:"",
  summaryList:['']
}
openIM.createMergerMessage(data).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



## 创建转发消息

> 传入要进行转发的消息对象json字符串，SDK会创建并返回一条转发消息。

```js
/**
* 创建转发消息
*
* @param message 消息对象json字符串
* @return 新转发消息对象结构Json字符串
*/
openIM.createForwardMessage(message).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



## 创建位置消息

> 传入发送位置的经纬度以及描述信息，SDK会创建并返回一条位置消息。

```js
/**
* 创建位置消息
*
* @param description 消息描述
* @param longitude 经度
* @param latitude 纬度
* @return 新位置消息对象结构Json字符串
*/
const data:LocationMsgParams = {
	description:"",
  longitude:12.13,
  latitude:13.14
} 
openIM.createLocationMessage(data).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



## 创建名片消息

> 传入自定义名片描述结构对象json字符串，SDK会创建并返回一条名片消息。

```js
/**
* 创建名片消息
*
* @param cardDesc 自定义消息结构json字符串
* @return 新位置消息对象结构Json字符串
*/
const cardDesc = ""
openIM.createCardMessage(cardDesc).then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



## 创建自定义消息

> 开发者可根据自身业务需求将合适的对象结构转换为json字符串后传入，SDK将原封不动的将其返回，开发人员可根据自己需求再转换出来使用。

```js
/**
* 创建自定义消息
*
* @param data 自定义消息对象json字符串
* @param extension 自定义消息对象扩展字段json字符串
* @param description 消息描述
* @return 新自定义消息对象结构Json字符串
*/
const data:CustomMsgParams = {
	data:"",
  extension:"",
  description:""
} 
openIM.createCustomMessage(data).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



## 创建引用消息

> 传入要引用的消息与对该消息的引用描述文本，SDK会创建并返回一条引用消息。

```js
/**
* 创建引用消息
*
* @param text 对引用消息的描述文本
* @param message 要进行引用的消息对象json字符串
* @return 新自定义消息对象结构Json字符串
*/
const data:QuoteMsgParams = {
	text:"",
  message:"",
} 
openIM.createQuoteMessage(data).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



## 发送消息（不需要本地上传获取URL）

> OpenIM消息按照消息发送的目标可分为：“单聊消息”和“群聊消息”，在发送单聊消息时设置groupID为空，同理发送群聊消息时设置userID为空即可。
>
> message为通过创建消息Api返回的任一类型的消息结构体Json字符串。

```js
/**
* 发送消息
*
* @param message 创建消息后返回的消息结构Json字符串
* @param recvID 用户id 发送群聊信息时为""
* @param groupID 群组id 发送单聊信息时为""
* @param offlinePushInfo 离线推送配置 可不传
*/
const offlinePushInfo:OfflinePush = {
  title: "you have a new message",	// 推送标题
  desc: "",													// 推送描述
  ex: "",														// 扩展字段
  iOSPushSound: "",									// ios推送声音
  iOSBadgeCount: true,							// ios推送角标
}
const options:SendMsgParams = {
  recvID: "xxx",
  groupID: "",
  offlinePushInfo:offlinePushInfo,
  message: "",
};
openIM.sendMessage(options).then(({ data,errCode })=>{
  ...
}).catch(err=>{
  ...
})
```



## 发送消息（需要本地上传获取URL）

> OpenIM消息按照消息发送的目标可分为：“单聊消息”和“群聊消息”，在发送单聊消息时设置groupID为空，同理发送群聊消息时设置userID为空即可。
>
> message为通过创建消息Api返回的任一类型的消息结构体Json字符串。

```js
/**
* 发送消息
*
* @param message 创建消息后返回的消息结构Json字符串
* @param recvID 用户id 发送群聊信息时为""
* @param groupID 群组id 发送单聊信息时为""
* @param offlinePushInfo 离线推送配置 可不传
*/
const offlinePushInfo:OfflinePush = {
  title: "you have a new message",	// 推送标题
  desc: "",													// 推送描述
  ex: "",														// 扩展字段
  iOSPushSound: "",									// ios推送声音
  iOSBadgeCount: true,							// ios推送角标
}
const options:SendMsgParams = {
  recvID: "xxx",
  groupID: "",
  offlinePushInfo:offlinePushInfo,
  message: "",
};
openIM.sendMessageNotOss(options).then(({ data,errCode })=>{
  ...
}).catch(err=>{
  ...
})
```



## 消息发送监听回调

> 调用`sendMessage`发送消息后可以通过下列事件对消息的发送状态进行监听，以便及时在UI上对消息发送状态进行展示。

### 调用示例

```js
openIM.on(CbEvents.SENDMSGPROGRESS,(data:WsResponse)=>{
  ...
})
```



### 回调列表

| 回调事件名称 | 说明         |
| ------------ | ------------ |
| OnProgress   | 消息发送进度 |



# 消息接收

> 有新消息到达时会触发`OnRecvNewMessage`回调，并附带了消息结构体，开发者可通过判断当前所在聊天窗口对象的用户ID是否与新消息的发送者ID相同，若相同则实时渲染到聊天界面上。

```js
openIM.on(CbEvents.ONRECVNEWMESSAGE,(data:WsResponse)=>{
  ...
})
```



# 历史消息

> 进入某个聊天窗口时调用，支持指定数量的分页拉取，防止一次性拉取消息过多造成的卡顿等现象。

## 拉取历史消息

```js
const options:GetHistoryMsgParams = {
  groupID:"",							// 群聊ID，拉取群聊时传入，否则为“”
  startClientMsgID:"",		// 上一次拉取的最后一条消息ID或空字符串,为空字符则从最新一条开始
  count:12,								// 每次拉取条数
  userID:"userID"					// 用户ID，拉取单聊时传入，否则为“”
}
openIM.getHistoryMessageList(options).then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



## 插入本地消息

> 可向本地插入一条任意类型的消息，一般用于插入自定义消息。

### 在单聊会话中插入消息

```js
/**
* 在单聊会话中插入消息
*
* @param message 消息对象json字符串
* @param recvID 消息接收者ID
* @param sendID 消息发送者ID
*/
const options:InsertSingleMsgParams = {
  message:"",
  recvID:"",
  sendID:""
}
openIM.insertSingleMessageToLocalStorage(message).then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```

### 在群聊会话中插入消息

```js
/**
* 在群聊会话中插入消息
*
* @param message 消息对象json字符串
* @param groupID 消息接收群聊ID
* @param sendID 消息发送者ID
*/
const options:InsertGroupMsgParams = {
  message:"",
  groupID:"",
  sendID:""
}
openIM.insertSingleMessageToLocalStorage(message).then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```





## 删除本地历史消息

> 可删除服务器sqlite数据库存储的消息记录，但不会删除服务端记录。

 ### 删除单条消息

```js
/**
* 删除单条消息
*
* @param message 消息对象json字符串
*/
openIM.deleteMessageFromLocalStorage(message).then(res=>{
  ...
}).catch(err=>{
  ...
})
```

### 删除指定单聊会话中的所有消息

```js
/**
* 删除指定单聊会话中的所有消息
*
* @param userID 单聊会话对象用户ID
*/
openIM.clearC2CHistoryMessage(userID).then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```

### 删除指定群聊会话中的所有消息

```js
/**
* 删除指定群聊会话中的所有消息
*
* @param groupID 群聊会话对象群聊ID
*/
openIM.clearGroupHistoryMessage(groupID).then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```

