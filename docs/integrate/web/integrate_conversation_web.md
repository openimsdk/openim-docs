# 获取会话列表

> 用户在登录后调用getAllConversationList拉取本地会话列表做 UI 展示
>
> - OpenIM SDK 会在登录成功后、用户上线后、以及断线重连后，自动更新会话列表。更新过程如下：
>   - 当有会话更新时，例如新收到一条消息，SDK 会通过[会话监听回调]()中的`OnConversationChanged`事件通知您。
>   - 当有会话新增时，SDK 会通过[会话监听回调]()中的`OnNewConversation`事件通知您。

## 全量拉取会话列表

```js
openIM.getAllConversationList().then(res=>{
  //注意 会话对象中latestMsg（会话最后一条消息）仍为Json字符串格式 若需要使用请自行转换
  ...
}).catch(err=>{
  ...
})
```

## 分页获取会话列表

```js
/**
* 分页获取会话列表
*
* @param offset 偏移量（起始点）
* @param count 每一页获取总数
*/
const options:SplitParams = {
  offset: 0,
  count: 20
}
openIM.getConversationListSplit(options).then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



# 获取会话总未读数

> 调用 getTotalUnreadMsgCount接口可以获取所有会话的未读消息总数。您不用再遍历会话列表，把单个会话的未读数相加，才能得到未读总数。当会话的未读总数发生变更的时候，SDK 会主动向您回调`OnTotalUnreadMessageCountChanged`，把最新的未读总数通知给您。

```js
openIM.getTotalUnreadMsgCount().then(res=>{
  ...
}).catch(err=>{
  ...
})
```





# 设置会话已读

> 将某个单聊或群聊会话置为已读状态，同时总未读数减少。

## 设置单聊会话已读

```js
/**
* 设置单聊会话已读
*
* @param userID 会话对象用户ID
* @param msgIDList 需要标记为已读的消息clientMsgID 传空数组时会将对应会话未读数置0
*/
const options:MarkC2CParams = {
	userID:"xxx",
  msgIDList:[]
}
openIM.markC2CMessageAsRead(options).then(res=>{
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

> 会话置顶指的是把特定的好友或者群会话固定在会话列表的最前面，用于主动设置或者取消会话置顶。

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



# 设置会话免打扰状态

> 会话免打扰分为三种状态：正常接收和推送消息；仅接收，但不推送消息；不接收，也不推送消息。
>
> 设置为1时，不再接收改会话的消息。设置为2时，正常接收该会话的消息，但不计入总未读数（依然会计入该会话的未读数，但可根据会话中的recvOpt状态自行处理）。

```js
/**
* 设置会话置顶
*
* @param conversationIDList 会话ID数组
* @param opt 免打扰状态 	0正常接收和推送消息 1不接受信息 2接收但不提醒
*/
const options:isRecvParams = {
  conversationIDList:["xx"],
  opt:0
}
openIM.setConversationRecvMessageOpt(options).then(({ data })=>{
  ...
}).catch(err=>{
  ...
})
```



# 删除会话

> 调用deleteConversation接口可以删除某个会话，删除会话时默认删除本地历史消息。

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
openIM.on(CbEvents.ONCONVERSATIONCHANGED,(data:WsResponse)=>{
  ...
})
```



## 回调列表

| Event                            | Callback Parameters    | Description      |
| -------------------------------- | ---------------------- | ---------------- |
| OnConversationChanged            | 改变会话数组json字符串 | 会话列表发生改变 |
| OnNewConversation                | 新会话数组json字符串   | 有新会话产生     |
| OnSyncServerFailed               | -                      | -                |
| OnSyncServerFinish               | -                      | -                |
| OnSyncServerStart                | -                      | -                |
| OnTotalUnreadMessageCountChanged | 消息未读总数           | 消息未读总数改变 |

