# 获取会话列表

- 用户在登录后调用getAllConversationList拉取本地会话列表做 UI 展示

```js
openIM.getAllConversationList(data).then(res=>{
  //注意 会话对象中latestMsg（会话最后一条消息）仍为Json字符串格式 若需要使用请自行转换
  ...
}).catch(err=>{
  ...
})
```

- OpenIM SDK 会在登录成功后、用户上线后、以及断线重连后，自动更新会话列表。更新过程如下：
  - 当有会话更新时，例如新收到一条消息，SDK 会通过[会话监听回调](https://doc.rentsoft.cn/client_doc/web_doc.html#%E4%BC%9A%E8%AF%9D%E5%88%97%E8%A1%A8%E7%9B%91%E5%90%AC%E5%9B%9E%E8%B0%83)中的`OnConversationChanged`事件通知您。
  - 当有会话新增时，SDK 会通过[会话监听回调](https://doc.rentsoft.cn/client_doc/web_doc.html#%E4%BC%9A%E8%AF%9D%E5%88%97%E8%A1%A8%E7%9B%91%E5%90%AC%E5%9B%9E%E8%B0%83)中的`OnNewConversation`事件通知您。

# 获取会话总未读数

- 调用 getTotalUnreadMsgCount接口可以获取所有会话的未读消息总数。您不用再遍历会话列表，把单个会话的未读数相加，才能得到未读总数。当会话的未读总数发生变更的时候，SDK 会主动向您回调`OnTotalUnreadMessageCountChanged`，把最新的未读总数通知给您。

```js
openIM.getTotalUnreadMsgCount().then(res=>{
  ...
}).catch(err=>{
  ...
})
```



# 设置会话已读

- 将某个单聊或群聊会话置为已读状态，同时总未读数减少。

## 设置单聊会话已读

```js
/**
* 设置单聊会话已读
*
* @param uid 会话对象id
*/
openIM.markSingleMessageHasRead(uid).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



## 设置群聊会话已读

```js
/**
* 设置群聊会话已读
*
* @param groupID 会话群聊id
*/
openIM.markGroupMessageHasRead(groupID).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



# 设置会话置顶

- 会话置顶指的是把特定的好友或者群会话固定在会话列表的最前面，用于主动设置或者取消会话置顶。

```js
/**
* 设置会话置顶
*
* @param conversationID 会话id
* @param isPinned 置顶状态 	bool
*/
const data:PinCveParams = {
  conversationID:"",
  isPinned:true
}
openIM.pinConversation(data).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



# 删除会话

- 调用deleteConversation接口可以删除某个会话，删除会话时默认删除本地历史消息。

```js
/**
* 删除会话
*
* @param conversationID 会话id
*/
openIM.deleteConversation(conversationID).then(res=>{
  ...
}).catch(err=>{
  ...
})
```



# 会话监听回调

## 调用示例

```js
openIM.on(OnConversationChanged,(data:WsResponse)=>{
  ...
})
```



## 回调列表

| 回调事件名称                     | 说明             |
| -------------------------------- | ---------------- |
| OnConversationChanged            | 会话列表改变     |
| OnNewConversation                | 产生新会话       |
| OnSyncServerFailed               | -                |
| OnSyncServerFinish               | -                |
| OnSyncServerStart                | -                |
| OnTotalUnreadMessageCountChanged | 消息总未读数改变 |



