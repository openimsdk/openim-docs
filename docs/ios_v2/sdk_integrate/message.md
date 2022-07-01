#### MessageManager（消息管理）

| 方法                                    | 描述                                                         |
| --------------------------------------- | ------------------------------------------------------------ |
| setAdvancedMsgListener                  | 消息监听                                                     |
| addAdvancedMsgListener                  | 消息监听                                                     |
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

#### sendMessage（发送消息）

```
        self.testMessage = [OIMMessageInfo createTextMessage:[@"测试消息" stringByAppendingFormat:@"%d", arc4random() % 1000]];
        
        //        self.testMessage = [OIMMessageInfo createTextAtMessage:@"" atUidList:@[]];
        //        self.testMessage = [OIMMessageInfo createMergeMessage:@[] title:@"" summaryList:@[]];
        //        self.testMessage = [OIMMessageInfo createForwardMessage:self.testMessage];
        //        self.testMessage = [OIMMessageInfo createLocationMessage:@"" latitude:0 longitude:0];
        //        self.testMessage = [OIMMessageInfo createCustomMessage:@"" extension:@"" description:@""];
        //        self.testMessage = [OIMMessageInfo createQuoteMessage:@"" message:self.testMessage];
        //        NSString *path1 = [[NSBundle mainBundle]pathForResource:@"photo_test" ofType:@"jpeg"];
        //        self.testMessage = [OIMMessageInfo createImageMessageFromFullPath:path1];
        //
        //        NSString *path2 = [[NSBundle mainBundle]pathForResource:@"voice_test" ofType:@"m4a"];
        //        self.testMessage = [OIMMessageInfo createSoundMessageFromFullPath:path2 duration:8];
        //
        //        NSString *path3 = [[NSBundle mainBundle]pathForResource:@"video_test" ofType:@"mp4"];
        //        self.testMessage = [OIMMessageInfo createVideoMessageFromFullPath:path3 videoType:@"mp4" duration:43 snapshotPath:path1];
        //
        //        NSString *path4 = [[NSBundle mainBundle]pathForResource:@"file_test" ofType:@"zip"];
        //        self.testMessage = [OIMMessageInfo createFileMessageFromFullPath:path4 fileName:@"file_test"];
        //        OIMAtInfo *t = [OIMAtInfo new];
        //        t.atUserID = OTHER_USER_ID;
        //        t.groupNickname = @"x2";
        //        self.testMessage = [OIMMessageInfo createTextAtMessage:@"一条消息" atUidList:@[] atUsersInfo:@[t] message:nil];

        [OIMManager.manager sendMessage:self.testMessage
                                 recvID:@"OTHER_USER_ID" // 单聊设置
                                groupID:@"GROUP_ID"      // 群聊设置
                        offlinePushInfo:nil
                              onSuccess:^(OIMMessageInfo * _Nullable message) {
            // 这里特别注意下，返回的这个message 需要替换数据源。
            self.testMessage = message;

        } onProgress:^(NSInteger number) {

        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### getHistoryMessageList（常用到的获取聊天记录）

```
        [OIMManager.manager getHistoryMessageListWithUserId:@"OTHER_USER_ID" // 单聊对象的userID, 否则传nil
                                                    groupID:@"GROUP_ID" // 群聊的组id, 否则为nil
                                           startClientMsgID:nil // 起始的消息clientMsgID，第一次拉取为""
                                                      count:20
                                                  onSuccess:^(NSArray<OIMMessageInfo *> * _Nullable messages) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```

注：消息列表list，index == list.length - 1 是最新的一条消息。 index == 0 是从最新的这条记录后的第19条。所以startMsg首次传null，

下次就是list.first（index == 0），以此类推。



#### revokeMessage（撤回消息）

撤回成功需要当前用户从列表里移除Message然后更新ui，而另外一方通过撤回监听（onRecvMessageRevoked）移除。

```
        [OIMManager.manager revokeMessage:self.testMessage // 消息体
                                onSuccess:^(NSString * _Nullable data) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];

```



#### deleteMessageFromLocalStorage（删除单条消息）

```
        [OIMManager.manager deleteMessageFromLocalStorage:self.testMessage // 消息题
                                                onSuccess:^(NSString * _Nullable data) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### insertSingleMessageToLocalStorage（向本地插入一条消息）

```
        [OIMManager.manager insertSingleMessageToLocalStorage:self.testMessage // 消息体
                                                       recvID:@"" // 接收者userID
                                                       sendID:@"" // 发送者userID
                                                    onSuccess:^(NSString * _Nullable data) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### markC2CMessageAsRead（标记c2c消息已读）

当调用此方法后，已读的消息会通过已读回执（onRecvC2CReadReceipt）告诉对方。

```
        [OIMManager.manager markC2CMessageAsRead:@"" // 接收者 userID
                                       msgIDList:@[] // 已读的消息id列表, 若为空数组，清空已读数
                                       onSuccess:^(NSString * _Nullable data) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### typingStatusUpdate（正在输入提示）

会通过onRecvNewMessage回调

```
        [OIMManager.manager typingStatusUpdate:@""  // 接收者 userID
                                        msgTip:@""  // 自定义内容
                                     onSuccess:^(NSString * _Nullable data) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### clearC2CHistoryMessage（清空c2c聊天记录）

```
        [OIMManager.manager clearC2CHistoryMessage:OTHER_USER_ID
                                         onSuccess:^(NSString * _Nullable data) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### clearGroupHistoryMessage（清空群聊天记录）

```
        [OIMManager.manager clearGroupHistoryMessage:@""    // 群ID
                                           onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];

        [OIMManager.manager clearGroupHistoryMessageFromLocalAndSvr:@""    // 群ID
                                                          onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];

```



#### createTextMessage（文本消息）

```
        [OIMMessageInfo createTextMessage:@"测试消息"];
```



#### createTextAtMessage（@消息）

```
        OIMAtInfo *t = [OIMAtInfo new];
        t.atUserID = OTHER_USER_ID;
        t.groupNickname = @"x2";

        [OIMMessageInfo createTextAtMessage:@"" // 发送的内容
                                  atUidList:@[]     // 被@到的用户ID集合
                                atUsersInfo:@[t]     // 被@到的用户Info集合
                                    message:nil];   //被引用的消息体

```



#### createImageMessage（图片消息，相对路径）

```
        [OIMMessageInfo createImageMessage:@"path"];
```

注：initSDK时传入了数据缓存（dataDir）路径，如路径：A，这时需要你将图片复制到A路径下后，如 A/pic/a.png路径，path的值：“/pic/a.png”。同以下其他消息的相对路径。



#### createImageMessageFromFullPath（图片消息全路径）

```
        [OIMMessageInfo createImageMessageFromFullPath:path];
```



#### createSoundMessage（语音消息，相对路径）

```
        [OIMMessageInfo createSoundMessage:path duration:0];
```



#### createSoundMessageFromFullPath（语音消息全路径）

```
        [OIMMessageInfo createSoundMessageFromFullPath:path duration:0];
```



#### createVideoMessage（视频消息，相对路径）

```
        [OIMMessageInfo createVideoMessage:path // 相对路径
                                  videoType:@"mp4" // minetype
                                  duration:0 // 时长s
                              snapshotPath:path1]; // 站位缩略图
```



#### createVideoMessageFromFullPath（视频消息全路径）

```
        [OIMMessageInfo createVideoMessageFromFullPath:path // 绝对路径
                                             videoType:@"mp4" // minetype
                                             duration:0 // 时长s
                                             snapshotPath:path1]; // 站位缩略图
```



#### createFileMessage（文件消息，相对路径）

```
        [OIMMessageInfo createFileMessage:path fileName:@"file_test"];
```



#### createFileMessageFromFullPath（文件消息全路径）

```
        [OIMMessageInfo createFileMessageFromFullPath:path fileName:@"file_test"];
```



#### createForwardMessage（转发消息）

```
        [OIMMessageInfo createForwardMessage:self.testMessage]; // 被转发的消息体
```



#### createMergerMessage（合并消息）

```
         [OIMMessageInfo createMergeMessage:@[]  // 被转发的消息列表
                                      title:@""  // 标题
                                      summaryList:@[]]; // 每一条消息摘要
```



#### createLocationMessage（位置消息）

```
        [OIMMessageInfo createLocationMessage:@"" // 位置描述信息
                                     latitude:0
                                    longitude:0];

```



#### createCustomMessage（自定义消息）

```
        [OIMMessageInfo createCustomMessage:@""  // 自定义内容
                                  extension:@""  // 扩展信息
                                  description:@""]; // 描述消息

```



#### createQuoteMessage（引用消息/消息回复）

```
        [OIMMessageInfo createQuoteMessage:@"" // 回复内容
                                  message:[OIMMessageInfo new]]; // 被回复的消息体

```



#### createCardMessage（名片消息）

```
        [OIMMessageInfo createCardMessage:@""];  // 自定义内容
```



#### searchLocalMessages（全局搜索)

```
        OIMSearchParam *t = [OIMSearchParam new]; // 更多搜索条件，看头文件
        t.conversationID = @""; // 会话id
        t.keywordList = @[@""]; // 关键字
        
        [OIMManager.manager searchLocalMessages:t
                                      onSuccess:^(OIMSearchResultInfo * _Nullable result) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### deleteMessageFromLocalAndSvr（删除本地跟服务器聊天记录）

```
        [OIMManager.manager deleteMessageFromLocalStorage:nil   // 消息体
                                                onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```



#### deleteAllMsgFromLocal（清空所有本地聊天记录）

```
        [OIMManager.manager deleteAllMsgFromLocalWithOnSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```



#### deleteAllMsgFromLocalAndSvr（清空本地跟服务器所有聊天记录)

```
        [OIMManager.manager deleteAllMsgFromLocalAndSvrWithOnSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```



#### markMessageAsReadByConID（标记会话里某些消息为已读）

```
    [OIMManager.manager markMessageAsReadByConID:@""
                                       msgIDList:@[]
                                       onSuccess:^(NSString * _Nullable data) {
        
    } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        
    }];
```



#### clearC2CHistoryMessageFromLocalAndSvr（清空单聊本地跟服务端聊天记录）

```
        [OIMManager.manager clearC2CHistoryMessageFromLocalAndSvr:@""  // userID
                                                          onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```



#### clearGroupHistoryMessageFromLocalAndSvr（清空群聊本地跟服务端聊天记录)

```
        [OIMManager.manager clearGroupHistoryMessageFromLocalAndSvr:@""    // 群ID
                                                          onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```



#### getHistoryMessageListReverse（主要用于搜索功能，获取新的聊天记录）

```
        // 获取聊天记录(以startMsg为节点，新收到的聊天记录)，用在全局搜索定位某一条消息，然后此条消息后新增的消息（大于startMsg sendtime的消息）
        OIMGetMessageOptions *options = [OIMGetMessageOptions new];
        options.userID = @"";
        options.groupID = @"";
        options.conversationID = @"";

        [OIMManager.manager getHistoryMessageListReverse:options
                                                onSuccess:^(NSArray<OIMMessageInfo *> * _Nullable messages) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];

```
