#### ConversationManager（会话管理）

| 方法                              | 描述                                   |
| --------------------------------- | -------------------------------------- |
| setConversationListener           | 会话监听                               |
| addConversationListener           | 会话监听                               |
| getAllConversationList            | 获取所有会话                           |
| getConversationListSplit          | 分页获取会话                           |
| getOneConversation                | 查询会话，如果会话不存在会自动生成一个 |
| getMultipleConversation           | 根据会话id获取多个会话                 |
| deleteConversation                | 通过会话id删除指定会话                 |
| setConversationDraft              | 设置会话草稿                           |
| pinConversation                   | 置顶会话                               |
| markGroupMessageAsRead            | 标记群聊会话已读                       |
| getTotalUnreadMsgCount            | 获取未读消息总数                       |
| getConversationIDBySessionType    | 查询会话id                             |
| setConversationRecvMessageOpt     | 消息免打扰设置                         |
| getConversationRecvMessageOpt     | 查询免打扰状态                         |
| setOneConversationPrivateChat     | 阅后即焚                               |
| deleteConversationFromLocalAndSvr | 删除本地以及服务器的会话               |
| deleteAllConversationFromLocal    | 删除所有本地会话                       |
| resetConversationGroupAtType      | 重置强提醒标识                         |
| setGlobalRecvMessageOpt           | 全局免打扰设置                         |

#### getAllConversationList（获取所有会话）

```
         [OIMManager.manager getAllConversationListWithOnSuccess:^(NSArray<OIMConversationInfo *> * _Nullable conversations) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];

```



#### getConversationListSplit（分页获取会话）

```
        [OIMManager.manager getConversationListSplitWithOffset:0 // 偏移量，如：第1页，offet：0，count：20；第2页：offset：20；
                                                     count:1000
                                                 onSuccess:^(NSArray<OIMConversationInfo *> * _Nullable conversations) {
        
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        
        }];

```



#### getOneConversation（获取一个会话，如果不存在会自动创建）

```
        [OIMManager.manager getOneConversationWithSessionType:OIMConversationTypeC2C
                                                 sourceID:@"" // 如果是单聊值传userID，如果是群聊groupID
                                                onSuccess:^(OIMConversationInfo * _Nullable conversation) {
        
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        
        }];

```



#### getMultipleConversation（根据会话id查询会话）

```
        [OIMManager.manager getMultipleConversation:@[] // 会话ID集合
                                          onSuccess:^(NSArray<OIMConversationInfo *> * _Nullable conversations) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
            
        }];
```



#### deleteConversation（根据会话id删除指定会话)

会触onTotalUnreadMessageCountChanged回调

```
        [OIMManager.manager deleteConversation:@""
                                 onSuccess:^(NSString * _Nullable data) {
        
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        
        }];
```



#### setConversationDraft（设置会话草稿）

会触onConversationChanged回调

```
        [OIMManager.manager setConversationDraft:@"" // 会话id
                                       draftText:@"" // 草稿
                                       onSuccess:^(NSString * _Nullable data) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
            
        }];

```



#### pinConversation（置顶会话）

会触onConversationChanged回调

```
        [OIMManager.manager pinConversation:@"" // 会话id
                               isPinned:YES // true：置顶；false：取消置顶
                              onSuccess:^(NSString * _Nullable data) {
        
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        
        }];

```



#### markGroupMessageAsRead（标记群会话已读，清除未读数）

会触onConversationChanged、onTotalUnreadMessageCountChanged回调

```
        [OIMManager.manager markGroupMessageAsRead:@"" // group id
                                         msgIDList:@[]
                                         onSuccess:^(NSString * _Nullable data) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### getTotalUnreadMsgCount（获取未读消息总数）

```
        [OIMManager.manager getTotalUnreadMsgCountWithOnSuccess:^(NSInteger number) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];

```



#### getConversationIDBySessionType（查询会话id）

```
        [OIMManager.manager getConversationIDBySessionType:OIMConversationTypeC2C
                                                    sourceID:@""]; // 如果是单聊值传userID，如果是群聊groupID

```



#### setConversationRecvMessageOpt（设置免打扰模式）

```
        [OIMManager.manager setConversationRecvMessageOpt:@[] // 会话id列表
                                                   status:OIMReceiveMessageOptReceive
                                                onSuccess:^(NSString * _Nullable data) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];

```



#### getConversationRecvMessageOpt（查询免打扰状态）

```
        [OIMManager.manager getConversationRecvMessageOpt:@[]  // 会话id列表
                                                onSuccess:^(NSArray<OIMConversationNotDisturbInfo *> * _Nullable conversations) {
            
                // 返回列表 [{"conversationId":"single_13922222222","result":0}] 
                // result: 1：不接受消息；2：接受在线消息不接受离线消息；0：正常
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];

```



#### setOneConversationPrivateChat（开启阅后即焚）

```
        [OIMManager.manager setOneConversationPrivateChat:@"" // 回话id
                                            isPrivate:YES
                                            onSuccess:^(NSString * _Nullable data) {
        
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];

```



#### deleteConversationFromLocalAndSvr（删除本地跟服务器端会话记录）

```
        [OIMManager.manager deleteConversation:@"" // 会话id
                                     onSuccess:^(NSString * _Nullable data) {

        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];

```



#### deleteAllConversationFromLocal（清空本地所有会话）

```
        [OIMManager.manager deleteAllConversationFromLocalWithOnSuccess:^(NSString * _Nullable data) {

        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];

```



#### resetConversationGroupAtType（重置会话强提示标识位）

```
        [OIMManager.manager resetConversationGroupAtType:@"" // 回话id
                                               onSuccess:^(NSString * _Nullable data) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### getAtAllTag（@所有标识）

```
OpenIM.iMManager.conversationManager.getAtAllTag();
```



#### setGlobalRecvMessageOpt（设置全局免打扰状态）

```
        [OIMManager.manager setGlobalRecvMessageOpt:OIMReceiveMessageOptNotReceive
                                          onSuccess:^(NSString * _Nullable data) {

        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];

```
