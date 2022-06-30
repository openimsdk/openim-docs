#### MessageManager（消息管理）

| 方法                                    | 描述                                                         |
| --------------------------------------- | ------------------------------------------------------------ |
| setAdvancedMsgListener                  | 消息监听                                                     |
| setMsgSendProgressListener              | 消息发送进度监听                                             |
| sendMessage                             | 发送消息                                                     |
| getHistoryMessageList                   | 获取聊天记录(以startMsg为节点，以前的聊天记录)               |
| revokeMessage                           | 撤回消息                                                     |
| deleteMessageFromLocalStorage           | 删除本地消息                                                 |
| insertSingleMessageToLocalStorage       | 插入单聊消息到本地                                           |
| insertGroupMessageToLocalStorage        | 插入群聊消息到本地                                           |
| markC2CMessageAsRead                    | 标记c2c单条消息已读                                          |
| markGroupMessageAsRead                  | 标记群聊消息已读                                             |
| typingStatusUpdate                      | 正在输入提示                                                 |
| createTextMessage                       | 创建文本消息                                                 |
| createTextAtMessage                     | 创建@消息                                                    |
| createImageMessage                      | 创建图片消息                                                 |
| createImageMessageFromFullPath          | 创建图片消息                                                 |
| createSoundMessage                      | 创建语音消息                                                 |
| createSoundMessageFromFullPath          | 创建语音消息                                                 |
| createVideoMessage                      | 创建视频消息                                                 |
| createVideoMessageFromFullPath          | 创建视频消息                                                 |
| createFileMessage                       | 创建文件消息                                                 |
| createFileMessageFromFullPath           | 创建文件消息                                                 |
| createMergerMessage                     | 创建合并消息                                                 |
| createForwardMessage                    | 创建转发消息                                                 |
| createLocationMessage                   | 创建位置消息                                                 |
| createCustomMessage                     | 创建自定义消息                                               |
| createQuoteMessage                      | 创建引用消息                                                 |
| createCardMessage                       | 创建卡片消息                                                 |
| createFaceMessage                       | 创建自定义表情消息                                           |
| clearC2CHistoryMessage                  | 清空单聊消息记录                                             |
| clearGroupHistoryMessage                | 清空组消息记录                                               |
| searchLocalMessages                     | 搜索消息                                                     |
| deleteMessageFromLocalAndSvr            | 删除本地跟服务器的指定的消息                                 |
| deleteAllMsgFromLocal                   | 删除本地所有聊天记录                                         |
| deleteAllMsgFromLocalAndSvr             | 删除本地跟服务器所有聊天记录                                 |
| markMessageAsReadByConID                | 标记消息已读                                                 |
| clearC2CHistoryMessageFromLocalAndSvr   | 删除本地跟服务器的单聊聊天记录                               |
| clearGroupHistoryMessageFromLocalAndSvr | 删除本地跟服务器的群聊天记录                                 |
| getHistoryMessageListReverse            | 获取聊天记录(以startMsg为节点，新收到的聊天记录)，用在全局搜索定位某一条消息，然后此条消息后新增的消息 |



#### OnAdvancedMsgListener（消息监听）

| 方法                          | 描述                                   |
| ----------------------------- | -------------------------------------- |
| onRecvNewMessage              | 收到新消息，界面添加新消息             |
| onRecvMessageRevoked          | 消息成功撤回，从界面移除消息           |
| onRecvC2CReadReceipt          | 消息被阅读回执，将消息标记为已读       |
| onRecvGroupMessageReadReceipt | 组消息已读回执，更新已读人数跟未读人数 |



#### sendMessage（发送消息）

```
OpenIM.iMManager.messageManager.sendMessage(
  message: Message(), // 消息体
  userID: '', // 接受消息的userID
  groupID: '', // 接受消息的群ID
  offlinePushInfo: OfflinePushInfo(), // 离线推送的消息备注
).then((_) {
    // 成功
 }).catchError((_){
    // 失败
 });
```



#### getHistoryMessageList（获取聊天记录）

```
OpenIM.iMManager.messageManager.getHistoryMessageList(
  userID: '', // 单聊对象的userID
  groupID: '', // 群聊的组id
  startMsg: null, // 消息体
  count: 0, // 每次拉取的数量
).then((list){
  // List<Message>
});
```

注：消息列表list，index == list.length -1 是最新的一条消息。 index == 0 是从最新的这条记录后的第19条。所以startMsg首次传null，

下次就是list.first（index == 0），以此类推。



#### revokeMessage（撤回消息）

撤回成功需要当前用户从列表里移除Message然后更新ui，而另外一方通过撤回监听（onRecvMessageRevoked）移除。

```
OpenIM.iMManager.messageManager.revokeMessage(
  message: Message(), // 消息体
).then((_) {
    // 成功
 }).catchError((_){
    // 失败
 });
```



#### deleteMessageFromLocalStorage（删除单条消息）

```
OpenIM.iMManager.messageManager.deleteMessageFromLocalStorage(
  message: Message(),
).then((_) {
    // 成功，从列表里移除Message，然后更新ui
 }).catchError((_){
    // 失败
 });
```



#### insertSingleMessageToLocalStorage（向本地插入一条消息）

```
OpenIM.iMManager.messageManager.insertSingleMessageToLocalStorage(
  receiverID: '', // 接收者userID
  senderID: '', // 发送者userID
  message: Message(), // 消息体
);
```



#### markC2CMessageAsRead（标记c2c消息已读）

当调用此方法后，已读的消息会通过已读回执（onRecvC2CReadReceipt）告诉对方。

```
OpenIM.iMManager.messageManager.markC2CMessageAsRead(
  userID: '', // 接收者 userID
  messageIDList: [], // 已读的消息id列表
);
```



#### typingStatusUpdate（正在输入提示）

会通过onRecvNewMessage回调

```
OpenIM.iMManager.messageManager.typingStatusUpdate(
  userID: '', // 接收者 userID
  msgTip: '', // 自定义提示内容
);
```



#### clearC2CHistoryMessage（清空c2c聊天记录）

```
OpenIM.iMManager.messageManager.clearC2CHistoryMessage(
  uid: "", // userID
).then((_) {
    // 成功
 }).catchError((_){
    // 失败
 });
```



#### clearGroupHistoryMessage（清空群聊天记录）

```
OpenIM.iMManager.messageManager.clearGroupHistoryMessage(
  gid: '', // 群ID
).then((_) {
    // 成功
 }).catchError((_){
    // 失败
 });
```



#### createTextMessage（文本消息）

```
var message = await OpenIM.iMManager.messageManager.createTextMessage(
  text: '', // 发送的内容
);
```



#### createTextAtMessage（@消息）

```
var message = await OpenIM.iMManager.messageManager.createTextAtMessage(
      text: '', // 发送的内容
      atUserIDList: [], // 被@到的用户ID集合
      atUserInfoList: [], // 被@到的用户Info集合
      quoteMessage: null, //被引用的消息体
 );
```



#### createImageMessage（图片消息，相对路径）

```
var message = await OpenIM.iMManager.messageManager.createImageMessage(
  imagePath: '', // 相对路径
);
```

注：initSDK时传入了数据缓存（dataDir）路径，如路径：A，这时需要你将图片复制到A路径下后，如 A/pic/a.png路径，imagePath的值：“/pic/a.png”。同以下其他消息的相对路径。



#### createImageMessageFromFullPath（图片消息全路径）

```
var message = await OpenIM.iMManager.messageManager.createImageMessageFromFullPath(
  imagePath: '', // 绝对路径
);
```



#### createSoundMessage（语音消息，相对路径）

```
var message = await OpenIM.iMManager.messageManager.createSoundMessage(
  soundPath: '', // 相对路径
  duration: 0, // 时长s
);
```



#### createSoundMessageFromFullPath（语音消息全路径）

```
var message = await OpenIM.iMManager.messageManager.createSoundMessageFromFullPath(
  soundPath: '', // 绝对路径
  duration: 0, // 时长s
);
```



#### createVideoMessage（视频消息，相对路径）

```
var message = await OpenIM.iMManager.messageManager.createVideoMessage(
  videoPath: '', // 相对路径
  videoType: '', // minetype
  duration: 0, // 时长s
  snapshotPath: '', // 站位缩略图
);
```



#### createVideoMessageFromFullPath（视频消息全路径）

```
var message = await OpenIM.iMManager.messageManager.createVideoMessageFromFullPath(
  videoPath: '', // 绝对路径
  videoType: '', // minetype
  duration: 0, // 时长s
  snapshotPath: '', // 站位缩略图
);
```



#### createFileMessage（文件消息，相对路径）

```
var message = await OpenIM.iMManager.messageManager.createFileMessage(
  filePath: '', // 相对路径
  fileName: '', // 文件名
);
```



#### createFileMessageFromFullPath（文件消息全路径）

```
var message = await OpenIM.iMManager.messageManager.createFileMessageFromFullPath(
  filePath: '', // 绝对路径
  fileName: '', // 文件名
);
```



#### createForwardMessage（转发消息）

```
var message = await OpenIM.iMManager.messageManager.createForwardMessage(
  message: Message(), // 被转发的消息体
);
```



#### createMergerMessage（合并消息）

```
var message = await OpenIM.iMManager.messageManager.createMergerMessage(
  messageList: [], // 被转发的消息列表
  title: '', // 标题
  summaryList: [], // 每一条消息摘要
);
```



#### createLocationMessage（位置消息）

```
var message = await OpenIM.iMManager.messageManager.createLocationMessage(
  latitude: 0,// 纬度
  longitude: 0, // 经度
  description: '', // 位置描述信息
);
```



#### createCustomMessage（自定义消息）

```
var message = await OpenIM.iMManager.messageManager.createCustomMessage(
  data: '', // 自定义内容
  extension: '', // 扩展信息
  description: '', // 描述消息
);
```



#### createQuoteMessage（引用消息/消息回复）

```
var message = await OpenIM.iMManager.messageManager.createQuoteMessage(
  text: '', // 回复内容
  quoteMsg: Message(), // 被回复的消息体
);
```



#### createCardMessage（名片消息）

```
OpenIM.iMManager.messageManager.createCardMessage(
  data: {}, // 自定义内容
);
```



#### searchLocalMessages（全局搜索)

```
SearchResult result = await OpenIM.iMManager.messageManager.searchLocalMessages(
  conversationID: null, // 根据会话查询，如果是全局搜索传null
  keywordList: [], // 搜索关键词列表，目前仅支持一个关键词搜索
  keywordListMatchType: 0, // 关键词匹配模式，1代表与，2代表或，暂时未用
  senderUserIDList: [], // 指定消息发送的uid列表 暂时未用
  messageTypeList: [], // 消息类型列表
  searchTimePosition: 0, // 搜索的起始时间点。默认为0即代表从现在开始搜索。UTC 时间戳，单位：秒
  searchTimePeriod: 0, // 从起始时间点开始的过去时间范围，单位秒。默认为0即代表不限制时间范围，传24x60x60代表过去一天
  pageIndex: 1, // 当前页数
  count: 10, // 每页数量
);
```



#### deleteMessageFromLocalAndSvr（删除本地跟服务器聊天记录）

```
OpenIM.iMManager.messageManager.createCardMessage(
  message: null, // 消息体
);
```



#### deleteAllMsgFromLocal（清空所有本地聊天记录）

```
OpenIM.iMManager.messageManager.deleteAllMsgFromLocal(
);
```



#### deleteAllMsgFromLocalAndSvr（清空本地跟服务器所有聊天记录)

```
OpenIM.iMManager.messageManager.deleteAllMsgFromLocalAndSvr(
);
```



#### markMessageAsReadByConID（标记会话里某些消息为已读）

```
OpenIM.iMManager.messageManager.markMessageAsReadByConID(
  conversationID: null, // 会话ID
  messageIDList: [], // 消息id列表
);
```



#### clearC2CHistoryMessageFromLocalAndSvr（清空单聊本地跟服务端聊天记录）

```
OpenIM.iMManager.messageManager.clearC2CHistoryMessageFromLocalAndSvr(
  uid: null, // 用户id
);
```



#### clearGroupHistoryMessageFromLocalAndSvr（清空群聊本地跟服务端聊天记录)

```
OpenIM.iMManager.messageManager.clearGroupHistoryMessageFromLocalAndSvr(
	gid: null, // 群组id
);
```



#### getHistoryMessageListReverse（获取新的聊天记录）

```
// 获取聊天记录(以startMsg为节点，新收到的聊天记录)，用在全局搜索定位某一条消息，然后此条消息后新增的消息
OpenIM.iMManager.messageManager.getHistoryMessageListReverse(
  userID: '', // 单聊对象的userID
  groupID: '', // 群聊的组id
  startMsg: null, // 消息体
  count: 0, // 每次拉取的数量
).then((list){
  // List<Message>
});
```