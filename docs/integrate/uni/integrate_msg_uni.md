# 消息发送

- 消息发送需要根据消息类型调用对应Api创建相应消息结构体，然后将SDK返回的结构体通过sendMessage发送。



## 创建文本消息

传入文本信息，SDK会创建并返回一条文本消息。

```js
/**
* 创建文本消息
*
* @param textMsg 输入信息
* @return 新文本消息对象结构Json字符串
*/
const newTextMessage = this.$openSdk.createTextMessage(textMsg)
```



## 创建@消息

传入文本信息，以及要@的用户，SDK会创建并返回一条文本形式的@消息。

```js
/**
* 创建@消息
*
* @param textMsg 输入信息
* @param atList @用户id数组
* @return 新@消息对象结构Json字符串
*/
const newTextAtMessage = this.$openSdk.createTextMessage(textMsg,atList)
```



## 创建图片消息

传入本地图片资源的绝对路径，SDK会创建并返回一条图片消息。

```js
/**
* 创建图片消息
*
* @param fullPath 图片绝对路径
* @return 新图片消息对象结构Json字符串
*/
const newImgMessage = this.$openSdk.createImageMessageFromFullPath(fullPath)
```



## 创建语音消息

传入本地语音资源的绝对路径、时长，SDK会创建并返回一条语音消息。

```js
/**
* 创建语音消息
*
* @param fullPath 语音绝对路径
* @param intervalTime 语音时长
* @return 新语音消息对象结构Json字符串
*/
const newSoundMessage = this.$openSdk.createSoundMessageFromFullPath(fullPath,intervalTime)
```



## 创建视频消息

传入本地视频资源的绝对路径、时长等信息，SDK会创建并返回一条视频消息。

```js
/**
* 创建视频消息
*
* @param fullPath 视频绝对路径
* @param suffix 视频后缀
* @param duration 视频时长
* @param snapshotFullPath 视频快照绝对路径
* @return 新视频消息对象结构Json字符串
*/
const newVideoMessage = this.$openSdk.createVideoMessageFromFullPath(fullPath,suffix,duration,snapshotFullPath)
```



## 创建文件消息

传入本地文件资源的相对路径、名称，SDK会创建并返回一条文件消息。

```js
/**
* 创建文件消息
*
* @param filePath 文件地址
* @param fileName 文件名称
* @return 新文件消息对象结构Json字符串
*/
const newVideoMessage = this.$openSdk.createFileMessage(filePath,fileName)
```



## 创建合并消息

传入要合并的消息列表（messageList）和要显示的摘要列表（summaryList）并为其创建一个标题（title），SDK会创建并返回一条合并消息。摘要列表和标题可以用来在聊天界面进行简单展示合并消息主要内容。

```js
/**
* 创建合并消息
*
* @param messageList 消息对象json字符串列表
* @param title 合并消息标题
* @param summaryList 合并消息的摘要列表
* @return 新合并消息对象结构Json字符串
*/
const newMergerMessage = this.$openSdk.createMergerMessage(messageList,title,summaryList)
```



## 创建转发消息

传入要进行转发的消息对象json字符串，SDK会创建并返回一条转发消息。

```js
/**
* 创建转发消息
*
* @param message 消息对象json字符串
* @return 新转发消息对象结构Json字符串
*/
const newForwardMessage = this.$openSdk.createForwardMessage(message)
```



## 创建位置消息

传入发送位置的经纬度以及描述信息，SDK会创建并返回一条位置消息。

```js
/**
* 创建位置消息
*
* @param desc 消息对象json字符串
* @param desc 纬度
* @param desc 经度
* @return 新位置消息对象结构Json字符串
*/
const newLocationMessage = this.$openSdk.createLocationMessage(desc,latitude,longitude)
```



## 创建自定义消息

开发者可根据自身业务需求将合适的对象结构转换为json字符串后传入，SDK将原封不动的将其返回，开发人员可根据自己需求再转换出来使用。

```js
/**
* 创建自定义消息
*
* @param data 自定义消息对象json字符串
* @param expand 自定义消息对象扩展字段json字符串
* @param desc 消息描述
* @return 新自定义消息对象结构Json字符串
*/
const newCustomMessage = this.$openSdk.createCustomMessage(desc,latitude,longitude)
```



## 创建引用消息

传入要引用的消息与对该消息的引用描述文本，SDK会创建并返回一条引用消息。

```js
/**
* 创建引用消息
*
* @param text 对引用消息的描述文本
* @param message 要进行引用的消息对象json字符串
* @return 新自定义消息对象结构Json字符串
*/
const newQuoteMessage = this.$openSdk.createQuoteMessage(text,message)
```



## 发送消息

- OpenIM消息按照消息发送的目标可分为：“单聊消息”和“群聊消息”，在发送单聊消息时设置groupID为空，同理发送群聊消息时设置userID为空即可。
- newMessage为通过创建消息Api返回的任一类型的消息结构体Json字符串。

```js
/**
* 发送消息
*
* @param newMessage 创建消息后返回的消息结构Json字符串
* @param userID 用户id 发送群聊信息时为null
* @param groupID 群组id 发送单聊信息时为null
* @param onlineUserOnly 是否指定仅在线用户可接收 bool
*/
this.$openSdk.sendMessage(newMessage,userID,groupID,onlineUserOnly);
```



## 消息发送监听回调

调用`sendMessage`发送消息后可以通过下列事件对消息的发送状态进行监听，以便及时在UI上对消息发送状态进行展示。

### 调用示例

```js
this.$globalEvent.addEventListener("sendMessageSuccess",data=>{
    ...
})
```



### 回调列表

| 回调事件名称        | 说明         |
| ------------------- | ------------ |
| sendMessageSuccess  | 消息发送成功 |
| sendMessageFailed   | 消息发送失败 |
| sendMessageProgress | 消息发送进度 |



# 消息接收

有新消息到达时会触发`onRecvNewMessage`回调，并附带了消息结构体，开发者可通过判断当前所在聊天窗口对象的用户ID是否与新消息的发送者ID相同，若相同则实时渲染到聊天界面上。

```js
this.$globalEvent.addEventListener("onRecvNewMessage",data=>{
    //接收到新消息时可通过判断消息的recvID是否为当前聊天对象 实时渲染数据
    ...
})
```



# 历史消息

进入某个聊天窗口时调用，支持指定数量的分页拉取，防止一次性拉取消息过多造成的卡顿等现象。

## 拉取历史消息

```js
const options = {
    groupID,	//群聊id 单聊时为空
    startMsg,	//消息拉取起点 消息对象结构Json字符串 null则拉取最新
    count,		//拉取消息数量
    userID		//用户id 群聊时为空
}
this.$openSdk.getHistoryMessageList(options,data=>{
    const messageList = JSON.parse(data.msg)
    ...
})
```



## 删除本地历史消息

可删除本地数据库存储的消息记录，但不会删除服务端记录。

 ### 删除单条消息

```js
/**
* 删除单条消息
*
* @param msg 消息对象json字符串
*/
this.$openSdk.deleteMessageFromLocalStorage(msg,data=>{
    ...
})
```

