# 消息发送

- 消息发送需要根据消息类型调用对应Api创建相应消息结构体，然后将SDK返回的结构体通过sendMessage发送。

## 创建文本消息

传入文本信息，SDK会创建并返回一条文本消息。

```js
///
/// 创建文本消息
///
/// @param text 输入信息
/// @return  Message对象
///
var message = await OpenIM.iMManager.messageManager.createTextMessage(text: text)
```

## 创建@消息

传入文本信息，以及要@的用户，SDK会创建并返回一条文本形式的@消息。

```js
///
/// 创建@消息
///
/// @param text 输入信息
/// @param atList @用户id数组
/// @return  Message对象
///
var message = await OpenIM.iMManager.messageManager.createTextAtMessage(text: text, atUidList: atUidList)
```

## 创建图片消息

传入本地图片资源的绝对路径，SDK会创建并返回一条图片消息。

```js
///
/// 创建图片消息
///
/// @param imagePath 图片绝对路径 ,如：image_picker包选择图片返回的路径
/// @return  Message对象
///
var message = await OpenIM.iMManager.messageManager.createImageMessageFromFullPath(imagePath: imagePath)
```

## 创建语音消息

传入本地语音资源的绝对路径、时长，SDK会创建并返回一条语音消息。

```js
///
/// 创建语音消息
///
/// @param soundPath 语音绝对路径
/// @param duration 语音时长
/// @return  Message对象
///
var message = await OpenIM.iMManager.messageManager.createSoundMessageFromFullPath(
  soundPath: soundPath, 
  duration: duration)
```

## 创建视频消息

传入本地视频资源的绝对路径、时长等信息，SDK会创建并返回一条视频消息。

```js
///
/// 创建视频消息
///
/// @param videoPath 视频绝对路径
/// @param videoType 文件mineType
/// @param duration 视频时长
/// @param snapshotPath 视频快照绝对路径
/// @return  Message对象
///
var message = await OpenIM.iMManager.messageManager.createVideoMessageFromFullPath(
  videoPath: videoPath, 
  videoType: videoType, 
  duration: duration, 
  snapshotPath: snapshotPath)
```

## 创建文件消息

传入本地文件资源的相对路径、名称，SDK会创建并返回一条文件消息。

```js
///
/// 创建文件消息
///
/// @param filePath 文件绝对路径
/// @param fileName 文件名称
/// @return Message对象
///
var message = await OpenIM.iMManager.messageManager.createFileMessageFromFullPath(filePath: filePath, fileName: fileName)
```

## 创建合并消息

传入要合并的消息列表（messageList）和要显示的摘要列表（summaryList）并为其创建一个标题（title），SDK会创建并返回一条合并消息。摘要列表和标题可以用来在聊天界面进行简单展示合并消息主要内容。

```js
///
/// 创建合并消息
///
/// @param messageList 选择合并转发的消息体列表
/// @param title 标题
/// @param summaryList 摘要
/// @return Message对象
///
var message = await OpenIM.iMManager.messageManager.createMergerMessage(
  messageList: messageList, 
  title: title,
  summaryList: summaryList)
```

## 创建转发消息

传入要进行转发的消息对象json字符串，SDK会创建并返回一条转发消息。

```js
///
/// 创建转发消息
///
/// @param Message对象
/// @return Message对象
///
var message = await OpenIM.iMManager.messageManager.createForwardMessage(message: message)
```

## 创建位置消息

传入发送位置的经纬度以及描述信息，SDK会创建并返回一条位置消息。

```js
///
/// 创建位置消息
///
/// @param description 描述信息，跟自己需求定义内容
/// @param latitude 纬度
/// @param longitude 经度
/// @return Message对象
///
var message = await OpenIM.iMManager.messageManager.createLocationMessage(
  latitude: latitude, 
  longitude: longitude, 
  description: description)
```

## 创建自定义消息

开发者可根据自身业务需求将合适的对象结构转换为json字符串后传入，SDK将原封不动的将其返回，开发人员可根据自己需求再转换出来使用。

```js
///
/// 创建自定义消息
///
/// @param data  Uint8List格式的自定义内容
/// @param extension Uint8List格式的自定义内容
/// @param description 消息描述
/// @return Message对象
///
var message = await OpenIM.iMManager.messageManager.createCustomMessage(
  data: data, 
  extension: extension, 
  description: description)
```

## 创建引用消息

传入要引用的消息与对该消息的引用描述文本，SDK会创建并返回一条引用消息。

```js
///
/// 创建引用消息
///
/// @param text 对引用消息的描述文本
/// @param quoteMsg 要进行引用的消息对象
/// @return Message对象
///
var message = await OpenIM.iMManager.messageManager.createQuoteMessage(text: text, quoteMsg: quoteMsg)
```

## 发送消息

- OpenIM消息按照消息发送的目标可分为：“单聊消息”和“群聊消息”，在发送单聊消息时设置groupID为空，同理发送群聊消息时设置userID为空即可。
- newMessage为通过创建消息Api返回的任一类型的消息结构体Json字符串。

```js
///
/// 发送消息
///
/// @param message 创建消息后返回的消息结构
/// @param userID 用户id 发送群聊信息时为null
/// @param groupID 群组id 发送单聊信息时为null
/// @param onlineUserOnly 是否指定仅在线用户可接收 bool
///
OpenIM.iMManager.messageManager.sendMessage(message: message)
```

## 消息发送监听回调

调用`sendMessage`发送消息后可以通过下列事件对消息的发送状态进行监听，以便及时在UI上对消息发送状态进行展示。

### 调用示例

```js
/// 发送状态：成功或失败
OpenIM.iMManager.messageManager.sendMessage(message: message)
	.then((_){
        // 发送成功
  }).catchError((e){
        // 发送失败
  })

/// 发送进度： 如图片，视频，文件。
OpenIM.iMManager.messageManager.setMsgSendProgressListener(new OnMsgSendProgressListener(
	onProgress:(msgId,progress){
      // 如果当前消息的 clientMsgID == msgId ，说明是这条消息的发送进度                                             
  }
))


```



# 消息接收

有新消息到达时会触发`onRecvNewMessage`回调，并附带了消息结构体，开发者可通过判断当前所在聊天窗口对象的用户ID是否与新消息的发送者ID相同，若相同则实时渲染到聊天界面上。

```js
OpenIM.iMManager.messageManager.addAdvancedMsgListener(OnAdvancedMsgListener(
        onRecvMessageRevoked: (msgId) {
              // 对方撤回了一条 clientMsgID == msgId 消息。 需用从UI上移除                     
        },
        onRecvC2CReadReceipt: (list) {
          	// 对方阅读了消息，需要在UI线更改消息从未读到已读
          	// messageList为当前聊天窗口产生的消息集合
           messageList.forEach((e) {
            var info = list.firstWhere((element) => element.uid == uid);
            if (info.msgIDList?.contains(e.clientMsgID) == true) {
     					// 消息已读，更新界面
              e.isRead = true;
            }
          });
        },
        onRecvNewMessage: (msg) {
          // 对方撤回了一条 clientMsgID == msg.clientMsgID 消息。 需用从UI上移除     
        },
      ))
```

# 历史消息

进入某个聊天窗口时调用，支持指定数量的分页拉取，防止一次性拉取消息过多造成的卡顿等现象。

## 拉取历史消息

```js
/// @param userID 拉取单聊消息不能为null
/// @param groupID 拉取群聊消息不能为null
/// @param startMsg 从startMsg消息出开始拉取消息
/// @param count 一次拉取count条
/// @return List<Message> 
OpenIM.iMManager.messageManager.getHistoryMessageList(
  userID: ,
  groupID: ,
  startMsg: ,//第一次传null，之后拉取传之前拉取的消息的第一个条： list.first
  count: )
```

## 删除本地历史消息

可删除本地数据库存储的消息记录，但不会删除服务端记录。

### 删除单条消息

```js
///
/// 删除单条消息
///
/// @param message 消息对象json
///
OpenIM.iMManager.messageManager.deleteMessageFromLocalStorage(message: message)
```

