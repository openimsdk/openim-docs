#### ConversationManager（会话管理）

| 方法                              | 描述                                   |
| --------------------------------- | -------------------------------------- |
| setConversationListener           | 会话监听                               |
| getAllConversationList            | 获取所有会话                           |
| getConversationListSplit          | 分页获取会话                           |
| getOneConversation                | 查询会话，如果会话不存在会自动生成一个 |
| getMultipleConversation           | 根据会话id获取多个会话                 |
| deleteConversation                | 通过会话id删除指定会话                 |
| setConversationDraft              | 设置会话草稿                           |
| pinConversation                   | 置顶会话                               |
| markGroupMessageHasRead           | 标记群聊会话已读                       |
| getTotalUnreadMsgCount            | 获取未读消息总数                       |
| getConversationIDBySessionType    | 查询会话id                             |
| setConversationRecvMessageOpt     | 消息免打扰设置                         |
| getConversationRecvMessageOpt     | 查询免打扰状态                         |
| setOneConversationPrivateChat     | 阅后即焚                               |
| deleteConversationFromLocalAndSvr | 删除本地以及服务器的会话               |
| deleteAllConversationFromLocal    | 删除所有本地会话                       |
| resetConversationGroupAtType      | 重置强提醒标识                         |
| getAtAllTag                       | 查询@所有人标识                        |
| setGlobalRecvMessageOpt           | 全局免打扰设置                         |



#### OnConversationListener（会话监听）

| 方法                             | 描述                       |
| -------------------------------- | -------------------------- |
| onNewConversation                | 新增会话时触发回调         |
| onConversationChanged            | 已添加的会话发送改变时回调 |
| onTotalUnreadMessageCountChanged | 未读消息数发送变化时回调   |



#### getAllConversationList（获取所有会话）

```
 OpenIM.iMManager.conversationManager.getAllConversationList().then((list) {
      // List<ConversationInfo> 会话列表
 });
```



#### getConversationListSplit（分页获取会话）

```
OpenIM.iMManager.conversationManager.getConversationListSplit(
      offset: 0, // 偏移量，如：第1页，offet：0，count：20；第2页：offset：20；
      count: 0, // 每页数量
 ).then((list) {
     // List<ConversationInfo> 会话列表
 });
```



#### getOneConversation（获取一个会话，如果不存在会自动创建）

```
OpenIM.iMManager.conversationManager.getOneConversation(
      sourceID: "", // 如果是单聊值传userID，如果是群聊groupID
      sessionType: 1, // 如果是单聊值传1，如果是群聊值传2
 ).then((info) {
     // 会话信息
 });
```



#### getMultipleConversation（根据会话id查询会话）

```
 OpenIM.iMManager.conversationManager.getMultipleConversation(
      conversationIDList: [], // 会话ID集合
    ).then((list) {
      // 返回与id匹配的会话列表
  });
```



#### deleteConversation（根据会话id删除指定会话)

会触onTotalUnreadMessageCountChanged回调

```
OpenIM.iMManager.conversationManager.deleteConversation(
     conversationID: "", // 会话id
 ).then((_) {
    // 成功
 }).catchError((_){
    // 失败
 });
```



#### setConversationDraft（设置会话草稿）

会触onConversationChanged回调

```
OpenIM.iMManager.conversationManager.setConversationDraft(
      conversationID: "", // 会话id
      draftText: "", // 草稿
 ).then((_) {
    // 成功
 }).catchError((_){
 		// 失败
 });
```



#### pinConversation（置顶会话）

会触onConversationChanged回调

```
OpenIM.iMManager.conversationManager.pinConversation(
      conversationID: "", // 会话id
      isPinned: true, // true：置顶；false：取消置顶
 ).then((_) {
    // 成功
 }).catchError((_){
 		// 失败
 });
```



#### markGroupMessageHasRead（标记群会话已读，清除未读数）

会触onConversationChanged、onTotalUnreadMessageCountChanged回调

```
OpenIM.iMManager.conversationManager.markGroupMessageHasRead(
      groupID: "", // 组id
 );
```



#### getTotalUnreadMsgCount（获取未读消息总数）

```
OpenIM.iMManager.conversationManager.getTotalUnreadMsgCount().then((count){
	// 总数
});
```



#### getConversationIDBySessionType（查询会话id）

```
  OpenIM.iMManager.conversationManager.getConversationIDBySessionType(
      sourceID: "", // 如果是单聊值传userID，如果是群聊groupID
      sessionType: 1, // 如果是单聊值传1，如果是群聊值传2
  ).then((conversationID){
  	// 会话ID
  });
```



#### setConversationRecvMessageOpt（设置免打扰模式）

```
OpenIM.iMManager.conversationManager.setConversationRecvMessageOpt(
      conversationIDList: [], // 会话id列表
      status: 1, // 1：不接受消息；2：接受在线消息不接受离线消息；0：正常
 ).then((_) {
    // 成功
 }).catchError((_){
 		// 失败
 });
```



#### getConversationRecvMessageOpt（查询免打扰状态）

```
/// 此方法已废弃，使用getOneConversation/getMultipleConversation方法替代
OpenIM.iMManager.conversationManager.getConversationRecvMessageOpt(
      conversationIDList: [], // 会话id列表
 ).then((list) {
    // 返回列表 [{"conversationId":"single_13922222222","result":0}] 
    // result: 1：不接受消息；2：接受在线消息不接受离线消息；0：正常
 });
```



#### setOneConversationPrivateChat（开启阅后即焚）

```
OpenIM.iMManager.conversationManager.setOneConversationPrivateChat(
      conversationID:"", // 会话id
      isPrivate:true,//true开启
 ).then((_) {
    // 成功
 }).catchError((_){
 		// 失败
 });
```



#### deleteConversationFromLocalAndSvr（删除本地跟服务器端会话记录）

```
OpenIM.iMManager.conversationManager.deleteConversationFromLocalAndSvr(
      conversationID:"", // 会话id
 ).then((_) {
    // 成功
 }).catchError((_){
 		// 失败
 });
```



#### deleteAllConversationFromLocal（清空本地所有会话）

```
OpenIM.iMManager.conversationManager.deleteAllConversationFromLocal(
 ).then((_) {
    // 成功
 }).catchError((_){
 		// 失败
 });
```



#### resetConversationGroupAtType（重置会话强提示标识位）

```
OpenIM.iMManager.conversationManager.resetConversationGroupAtType(
      conversationID:"", // 会话id
 ).then((_) {
    // 成功
 }).catchError((_){
 		// 失败
 });
```



#### getAtAllTag（@所有标识）

```
OpenIM.iMManager.conversationManager.getAtAllTag();
```



#### setGlobalRecvMessageOpt（设置全局免打扰状态）

```
OpenIM.iMManager.conversationManager.setGlobalRecvMessageOpt(
	status: status,// 0：正常；1：不接受消息；2：接受在线消息不接受离线消息；
);
```



#### simpleSort（自定义会话排序规则）

```
var list = OpenIM.iMManager.conversationManager.simpleSort([]);// 返回排序好的列表
```