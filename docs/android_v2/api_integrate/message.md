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


#### 泛型回调接口（所有方法都会回调此接口）

```
public interface OnBase<T> {
    /**
     * 失败
     * @param code 错误码
     * @param error 错误信息
     */
    void onError(int code, String error);

    /**
     * 成功
     * @param data 返回的实体
     */
    void onSuccess(T data);
}
```

#### sendMessage（发送消息）

```
    /**
     * 发送消息
     *
     * @param message         消息体{@link Message}
     * @param recvUid         接受者用户id
     * @param recvGid         群id
     * @param offlinePushInfo 离线推送内容
     * @param base            callback
     *                        onProgress:消息发送进度，如图片，文件，视频等消息
     */
    public void sendMessage(OnMsgSendCallback base, Message message, String recvUid, String recvGid, OfflinePushInfo offlinePushInfo)

/**
 * 消息发送监听
 */
public interface OnMsgSendCallback extends OnBase<Message> {
    /**
     * 发送失败
     */
    void onError(int code, String error);

    /**
     * 上传进度
     */
    void onProgress(long progress);

    /**
     * 发送成功
     */
    void onSuccess(Message s);
}

```



#### getHistoryMessageList（获取聊天记录）

```
    /**
     * 获取历史消息
     *
     * @param userID   用户id
     * @param groupID  组ID
     * @param startMsg 从startMsg {@link Message}开始拉取消息
     *                 startMsg：如第一次拉取20条记录 startMsg=null && count=20 得到 list；
     *                 下一次拉取消息记录参数：startMsg=list.get(0) && count =20；以此内推，startMsg始终为list的第一条。
     * @param count    一次拉取count条
     * @param base     callback List<{@link Message}>
     */
    public void getHistoryMessageList(OnBase<List<Message>> base, String userID, String groupID, Message startMsg, int count)
```

注：消息列表list，index == list.length -1 是最新的一条消息。 index == 0 是从最新的这条记录后的第19条。所以startMsg首次传null，

下次就是list.first（index == 0），以此类推。



#### revokeMessage（撤回消息）

撤回成功需要当前用户从列表里移除Message然后更新ui，而另外一方通过撤回监听（onRecvMessageRevoked）移除。

```
    /**
     * 撤回消息
     *
     * @param message {@link Message}
     * @param base    callback String
     *                撤回成功需要将已显示到界面的消息类型替换为revoke类型并刷新界面
     */
    public void revokeMessage(OnBase<String> base, Message message)
```



#### deleteMessageFromLocalStorage（删除单条消息）

```
    /**
     * 删除消息
     *
     * @param message {@link Message}
     * @param base    callback String
     *                删除成功需要将已显示到界面的消息移除
     */
    public void deleteMessageFromLocalStorage(OnBase<String> base, Message message)
```



#### insertSingleMessageToLocalStorage（向本地插入一条消息）

```
    /**
     * 插入单挑消息到本地
     *
     * @param message  {@link Message}
     * @param receiver 接收者
     * @param sender   发送者
     * @param base     callback String
     */
    public void insertSingleMessageToLocalStorage(OnBase<String> base, Message message, String receiver, String sender)
```



#### markC2CMessageAsRead（标记c2c消息已读）

当调用此方法后，已读的消息会通过已读回执（onRecvC2CReadReceipt）告诉对方。

```
    /**
     * 标记消息已读
     * 会触发userid的onRecvC2CReadReceipt方法
     *
     * @param userID        聊天对象id
     * @param messageIDList 消息clientMsgID列表
     * @param base          callback String
     */
    public void markC2CMessageAsRead(OnBase<String> base, String userID, List<String> messageIDList)
```



#### typingStatusUpdate（正在输入提示）

会通过onRecvNewMessage回调

```
    /**
     * 提示对方我正在输入
     *
     * @param userID 用户ID
     * @param msgTip 提示信息
     */
    public void typingStatusUpdate(OnBase<String> base, String userID, String msgTip)
```



#### clearC2CHistoryMessage（清空c2c聊天记录）

```
    /**
     * 聊天设置里清除聊天记录
     *
     * @param uid 用户id
     */
    public void clearC2CHistoryMessage(OnBase<String> base, String uid)
```



#### clearGroupHistoryMessage（清空群聊天记录）

```
    /**
     * 聊天设置里清除聊天记录
     *
     * @param gid 群id
     */
    public void clearGroupHistoryMessage(OnBase<String> base, String gid) 
```



#### createTextMessage（文本消息）

```
    /**
     * 创建文本消息
     *
     * @param text 内容
     * @return {@link Message}
     */
    public Message createTextMessage(String text) 
```



#### createTextAtMessage（@消息）

```

    /**
     * 创建@文本消息
     *
     * @param text           内容
     * @param atUserIDList   用户id列表
     * @param atUserInfoList 被@的用户id跟昵称映射
     * @param quoteMessage   @消息带引用消息
     * @return {@link Message}
     */
    public Message createTextAtMessage(String text, List<String> atUserIDList, List<AtUserInfo> atUserInfoList, Message quoteMessage)
```



#### createImageMessage（图片消息，相对路径）

```
    /**
     * 创建图片消息（
     * initSDK时传入了数据缓存路径，如路径：A，这时需要你将图片复制到A路径下后，如 A/pic/a.png路径，imagePath的值：“/pic/.png”
     *
     * @param imagePath 相对路径
     * @return {@link Message}
     */
    public Message createImageMessage(String imagePath)
```

注：initSDK时传入了数据缓存（dataDir）路径，如路径：A，这时需要你将图片复制到A路径下后，如 A/pic/a.png路径，imagePath的值：“/pic/a.png”。同以下其他消息的相对路径。



#### createImageMessageFromFullPath（图片消息全路径）

```
    /**
     * 创建图片消息
     *
     * @param imagePath 绝对路径
     * @return {@link Message}
     */
    public Message createImageMessageFromFullPath(String imagePath)
```



#### createSoundMessage（语音消息，相对路径）

```
    /**
     * 创建声音消息
     * initSDK时传入了数据缓存路径，如路径：A，这时需要你将声音文件复制到A路径下后，如 A/voice/a.m4c路径，soundPath的值：“/voice/.m4c”
     *
     * @param soundPath 相对路径
     * @param duration  时长
     * @return {@link Message}
     */
    public Message createSoundMessage(String soundPath, long duration) 
```



#### createSoundMessageFromFullPath（语音消息全路径）

```
    /**
     * 创建声音消息
     *
     * @param soundPath 绝对路径
     * @param duration  时长
     * @return {@link Message}
     */
    public Message createSoundMessageFromFullPath(String soundPath, long duration)
```



#### createVideoMessage（视频消息，相对路径）

```
    /**
     * 创建视频消息
     * initSDK时传入了数据缓存路径，如路径：A，这时需要你将声音文件复制到A路径下后，如 A/video/a.mp4路径，soundPath的值：“/video/.mp4”
     *
     * @param videoPath    视频相对路径
     * @param videoType    mine type
     * @param duration     时长
     * @param snapshotPath 缩略图相对路径
     * @return {@link Message}
     */
    public Message createVideoMessage(String videoPath, String videoType, long duration, String snapshotPath) 
```



#### createVideoMessageFromFullPath（视频消息全路径）

```

    /**
     * 创建视频消息
     *
     * @param videoPath    绝对路径
     * @param videoType    mine type
     * @param duration     时长
     * @param snapshotPath 缩略图绝对路径
     * @return {@link Message}
     */
    public Message createVideoMessageFromFullPath(String videoPath, String videoType, long duration, String snapshotPath) 
```



#### createFileMessage（文件消息，相对路径）

```
    /**
     * 创建文件消息
     * initSDK时传入了数据缓存路径，如路径：A，这时需要你将声音文件复制到A路径下后，如 A/file/a.txt路径，soundPath的值：“/file/.txt”
     *
     * @param filePath 相对路径
     * @param fileName 文件名
     * @return {@link Message}
     */
    public Message createFileMessage(String filePath, String fileName) 
```



#### createFileMessageFromFullPath（文件消息全路径）

```
    /**
     * 创建文件消息
     * initSDK时传入了数据缓存路径，如路径：A，这时需要你将声音文件复制到A路径下后，如 A/file/a.txt路径，soundPath的值：“/file/.txt”
     *
     * @param filePath 绝对路径
     * @param fileName 文件名
     * @return {@link Message}
     */
    public Message createFileMessageFromFullPath(String filePath, String fileName) 
```



#### createForwardMessage（转发消息）

```
    /**
     * 创建转发消息
     *
     * @param message 消息体
     * @return {@link Message}
     */
    public Message createForwardMessage(Message message) 
```



#### createMergerMessage（合并消息）

```
    /**
     * 创建合并消息
     *
     * @param title       标题
     * @param summaryList 摘要
     * @param messageList 消息列表
     * @return {@link Message}
     */
    public Message createMergerMessage(List<Message> messageList, String title, List<String> summaryList) 
```



#### createLocationMessage（位置消息）

```

    /**
     * 创建位置消息
     *
     * @param latitude    经度
     * @param longitude   纬度
     * @param description 描述消息
     * @return {@link Message}
     */
    public Message createLocationMessage(double latitude, double longitude, String description)
```



#### createCustomMessage（自定义消息）

```
    /**
     * 创建自定义消息
     *
     * @param data        json String
     * @param extension   json String
     * @param description 描述
     * @return {@link Message}
     */
    public Message createCustomMessage(String data, String extension, String description)
```



#### createQuoteMessage（引用消息/消息回复）

```
    /**
     * 创建引用消息
     *
     * @param text    内容
     * @param message 被引用的消息体
     * @return {@link Message}
     */
    public Message createQuoteMessage(String text, Message message) 
```



#### createCardMessage（名片消息）

```
    /**
     * 创建名片消息
     *
     * @param content json String
     * @return {@link Message}
     */
    public Message createCardMessage(String content) 
```



#### searchLocalMessages（全局搜索)

```
    /**
     * 搜索消息
     *
     * @param conversationID       根据会话查询，如果是全局搜索传null
     * @param keywordList          搜索关键词列表，目前仅支持一个关键词搜索
     * @param keywordListMatchType 关键词匹配模式，1代表与，2代表或，暂时未用
     * @param senderUserIDList     指定消息发送的uid列表 暂时未用
     * @param messageTypeList      消息类型列表
     * @param searchTimePosition   搜索的起始时间点。默认为0即代表从现在开始搜索。UTC 时间戳，单位：秒
     * @param searchTimePeriod     从起始时间点开始的过去时间范围，单位秒。默认为0即代表不限制时间范围，传24x60x60代表过去一天
     * @param pageIndex            当前页数
     * @param count                每页数量
     */
    public void searchLocalMessages(OnBase<SearchResult> base,
                                    String conversationID,
                                    List<String> keywordList,
                                    int keywordListMatchType,
                                    List<String> senderUserIDList,
                                    List<Integer> messageTypeList,
                                    int searchTimePosition,
                                    int searchTimePeriod,
                                    int pageIndex,
                                    int count)
```



#### deleteMessageFromLocalAndSvr（删除本地跟服务器聊天记录）

```
    /**
     * 删除本地跟服务器消息
     *
     * @param message 消息体
     */
    public void deleteMessageFromLocalAndSvr(OnBase<String> base, Message message) 
```



#### deleteAllMsgFromLocal（清空所有本地聊天记录）

```
    /**
     * 删除本地所有消息
     */
    public void deleteAllMsgFromLocal(OnBase<String> base) 
```



#### deleteAllMsgFromLocalAndSvr（清空本地跟服务器所有聊天记录)

```
    /**
     * 删除本地跟服务器所有消息
     */
    public void deleteAllMsgFromLocalAndSvr(OnBase<String> base) 
```



#### markMessageAsReadByConID（标记会话里某些消息为已读）

```
    /**
     * 标记会话全部已读，用于OA通知类消息
     *
     * @param conversationID 会话id
     * @param messageIDList  消息clientID列表
     */
    public void markMessageAsReadByConID(OnBase<String> base, String conversationID, List<String> messageIDList) 
```



#### clearC2CHistoryMessageFromLocalAndSvr（清空单聊本地跟服务端聊天记录）

```
    /**
     * 聊天设置里清除聊天记录
     *
     * @param uid 用户id
     */
    public void clearC2CHistoryMessageFromLocalAndSvr(OnBase<String> base, String uid) 
```



#### clearGroupHistoryMessageFromLocalAndSvr（清空群聊本地跟服务端聊天记录)

```
    /**
     * 聊天设置里清除聊天记录
     *
     * @param gid 群id
     */
    public void clearGroupHistoryMessageFromLocalAndSvr(OnBase<String> base, String gid)
```



#### getHistoryMessageListReverse（获取新的聊天记录）

```
    /**
     * 获取历史消息
     * 在搜索消息时定位到消息位置，获取新消息列表
     * getHistoryMessageList是获取该条消息之前的记录（旧消息），getHistoryMessageListReverse是获取该条消息之后的记录（新消息）
     *
     * @param userID   用户id
     * @param groupID  组ID
     * @param startMsg 从startMsg {@link Message}开始拉取消息
     *                 startMsg：如第一次拉取20条记录 startMsg=null && count=20 得到 list；
     *                 下一次拉取消息记录参数：startMsg=list.last && count =20；以此内推，startMsg始终为list的最后一条。
     * @param count    一次拉取count条
     * @param base     callback List<{@link Message}>
     */
    public void getHistoryMessageListReverse(OnBase<List<Message>> base, String userID, String groupID, Message startMsg, int count) 
```