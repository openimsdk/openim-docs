# 消息发送

- 消息发送需要根据消息类型调用对应Api创建相应消息结构体，然后将SDK返回的结构体通过sendMessage发送。

## 创建文本消息

传入文本信息，SDK会创建并返回一条文本消息。

```objc
///
/// 创建文本消息
///
/// @param text 输入信息
/// @return  Message对象
///
OIMMessageInfo *message = [OIMMessageInfo createTextMessage:@""];
```

## 创建@消息

传入文本信息，以及要@的用户，SDK会创建并返回一条文本形式的@消息。

```objc
///
/// 创建@消息
///
/// @param text 输入信息
/// @param atList @用户id数组
/// @return  Message对象
///
OIMMessageInfo *message = [OIMMessageInfo createTextAtMessage:@"" atUidList:@[]];
```

## 创建图片消息

传入本地图片资源的绝对路径，SDK会创建并返回一条图片消息。

```objc
///
/// 创建图片消息
///
/// @param imagePath 图片绝对路径 ,如：image_picker包选择图片返回的路径
/// @return  Message对象
///
OIMMessageInfo *message = [OIMMessageInfo createImageMessageFromFullPath:imagePath];
```

## 创建语音消息

传入本地语音资源的绝对路径、时长，SDK会创建并返回一条语音消息。

```objc
///
/// 创建语音消息
///
/// @param soundPath 语音绝对路径
/// @param duration 语音时长
/// @return  Message对象
///
OIMMessageInfo *message = [OIMMessageInfo createSoundMessageFromFullPath:soundPath duration:duration];
```

## 创建视频消息

传入本地视频资源的绝对路径、时长等信息，SDK会创建并返回一条视频消息。

```objc
///
/// 创建视频消息
///
/// @param videoPath 视频绝对路径
/// @param videoType 文件mineType
/// @param duration 视频时长
/// @param snapshotPath 视频快照绝对路径
/// @return  Message对象
///
OIMMessageInfo *message = [OIMMessageInfo createVideoMessageFromFullPath:videoPath videoType:videoType duration:duration snapshotPath:snapshotPath]; 
```

## 创建文件消息

传入本地文件资源的相对路径、名称，SDK会创建并返回一条文件消息。

```objc
///
/// 创建文件消息
///
/// @param filePath 文件绝对路径
/// @param fileName 文件名称
/// @return Message对象
///
OIMMessageInfo *message = [OIMMessageInfo createFileMessageFromFullPath:filePath fileName:fileName];
```

## 创建合并消息

传入要合并的消息列表（messageList）和要显示的摘要列表（summaryList）并为其创建一个标题（title），SDK会创建并返回一条合并消息。摘要列表和标题可以用来在聊天界面进行简单展示合并消息主要内容。

```objc
///
/// 创建合并消息
///
/// @param messageList 选择合并转发的消息体列表
/// @param title 标题
/// @param summaryList 摘要
/// @return Message对象
///
OIMMessageInfo *message = [OIMMessageInfo createMergeMessage:messageList title:title summaryList:summaryList];
```

## 创建转发消息

传入要进行转发的消息对象json字符串，SDK会创建并返回一条转发消息。

```objc
///
/// 创建转发消息
///
/// @param Message对象
/// @return Message对象
///
OIMMessageInfo *message = [OIMMessageInfo createForwardMessage:message];
```

## 创建位置消息

传入发送位置的经纬度以及描述信息，SDK会创建并返回一条位置消息。

```objc
///
/// 创建位置消息
///
/// @param description 描述信息，跟自己需求定义内容
/// @param latitude 纬度
/// @param longitude 经度
/// @return Message对象
///
OIMMessageInfo *message = [OIMMessageInfo createLocationMessage:description latitude:latitude longitude:longitude];
```

## 创建自定义消息

开发者可根据自身业务需求将合适的对象结构转换为json字符串后传入，SDK将原封不动的将其返回，开发人员可根据自己需求再转换出来使用。

```objc
///
/// 创建自定义消息
///
/// @param data  json格式的自定义内容
/// @param extension 
/// @param description 消息描述
/// @return Message对象
///
OIMMessageInfo *message = [OIMMessageInfo createCustomMessage:data extension:extension description:description];
```

## 创建引用消息

传入要引用的消息与对该消息的引用描述文本，SDK会创建并返回一条引用消息。

```objc
///
/// 创建引用消息
///
/// @param text 对引用消息的描述文本
/// @param quoteMsg 要进行引用的消息对象
/// @return Message对象
///
OIMMessageInfo *message =  [OIMMessageInfo createQuoteMessage:text message:quoteMsg];
```

## 发送消息

- OpenIM消息按照消息发送的目标可分为：“单聊消息”和“群聊消息”，在发送单聊消息时设置groupID为空，同理发送群聊消息时设置userID为空即可。
- newMessage为通过创建消息Api返回的任一类型的消息结构体Json字符串。

```objc
        OIMMessageInfo testMessage = [OIMMessageInfo createTextMessage:@""];
        [OIMManager.manager sendMessage:testMessage // 消息体
                                 recvID:@"" // 接受消息的userID
                                groupID:@"" // 接受消息的群ID
                        offlinePushInfo:nil // 离线推送的消息备
                              onSuccess:^(NSString * _Nullable data) {
            //  这里特别注意下，返回的这个message 需要替换创建的消息体。做撤回等动作需要这个新的消息体
            //  自行将data转换成OIMMessageInfo对象，切记
            testMessage = [OIMMessageInfo objectFromJson:data];
        } onProgress:^(NSInteger number) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];

```

## 消息发送监听回调

调用`sendMessage`发送消息后可以通过下列事件对消息的发送状态进行监听，以便及时在UI上对消息发送状态进行展示。

### 调用示例

```objc
        [OIMManager.manager sendMessage:self.testMessage
                                 recvID:@""
                                groupID:@""
                        offlinePushInfo:nil
                              onSuccess:^(NSString * _Nullable data) {
            // 这里特别注意下，返回的这个message 需要替换创建的消息体。
            OIMMessageInfo *newMsg = [OIMMessageInfo mj_objectWithKeyValues:data];
            self.testMessage = newMsg;
        } onProgress:^(NSInteger number) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

# 历史消息

进入某个聊天窗口时调用，支持指定数量的分页拉取，防止一次性拉取消息过多造成的卡顿等现象。

## 拉取历史消息

```objc
        [OIMManager.manager getHistoryMessageListWithUserId:@"" // 单聊对象的userID
                                                    groupID:@"" // 群聊的组id
                                           startClientMsgID:nil //第一次传null，之后拉取传之前拉取的消息的第一个条： list.firstObject
                                                      count:200 // 每次拉取的数量
                                                  onSuccess:^(NSArray<OIMMessageInfo *> * _Nullable messages) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

## 删除本地历史消息

可删除本地数据库存储的消息记录，及删除服务端记录。

### 删除消息

```objc
        [OIMManager.manager deleteMessageFromLocalStorage:nil   // 消息体
                                                onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];

        [OIMManager.manager deleteAllMsgFromLocalAndSvrWithOnSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];

        [OIMManager.manager deleteAllMsgFromLocalWithOnSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

### 清空c2c消息

```objc
        [OIMManager.manager clearC2CHistoryMessage:@""  // userID
                                         onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];

        [OIMManager.manager clearC2CHistoryMessageFromLocalAndSvr:@""  // userID
                                                          onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

### 清空群聊消息

```objc
        [OIMManager.manager clearGroupHistoryMessage:@""    // 群ID
                                           onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];

        [OIMManager.manager clearGroupHistoryMessageFromLocalAndSvr:@""    // 群ID
                                                          onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```

## 搜索本地消息

```objc
        OIMSearchParam *t = [OIMSearchParam new];
        t.sourceID = "";
        t.sessionType = 1;
        t.keywordList = @[];
        
        [OIMManager.manager searchLocalMessages:t
                                      onSuccess:^(OIMSearchResultInfo * _Nullable result) {

        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```



# 消息接收

有新消息到达时会触发`onRecvNewMessage`回调，并附带了消息结构体，开发者可通过判断当前所在聊天窗口对象的用户ID是否与新消息的发送者ID相同，若相同则实时渲染到聊天界面上。

```objc
/// 高级消息监听器
@protocol OIMAdvancedMsgListener <NSObject>
@optional

/*
 *  收到新消息
 */
- (void)onRecvNewMessage:(OIMMessageInfo *)msg;

/*
 *  群聊消息已读回执
 */
- (void)onRecvGroupReadReceipt:(NSArray<OIMReceiptInfo *> *)groupMsgReceiptList;

/*
 *  单聊消息已读回执
 */
- (void)onRecvC2CReadReceipt:(NSArray<OIMReceiptInfo *> *)receiptList;


/*
 *  收到消息撤回
 */
- (void)onRecvMessageRevoked:(NSString *)msgID;
```
