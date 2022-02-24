# 获取会话列表

- 用户在登录后调用getAllConversationList拉取本地会话列表做 UI 展示

```js
this.$openSdk.getAllConversationList(data=>{
    const conversationList = JSON.parse(data.msg);
    //注意 会话对象中latestMsg（会话最后一条消息）仍为Json字符串格式 若需要使用请自行转换
    ...
})
```

- OpenIM SDK 会在登录成功后、用户上线后、以及断线重连后，自动更新会话列表。更新过程如下：
  - 当有会话更新时，例如新收到一条消息，SDK 会通过初始化前设置的会话监听器 `setConversationListener` 中的 [onConversationChanged]() 事件通知您。
  - 当有会话新增时，SDK 会通过初始化前设置的会话监听器 `setConversationListener` 中的 [onNewConversation]() 事件通知您。

# 获取会话总未读数

- 调用 getTotalUnreadMsgCount接口可以获取所有会话的未读消息总数。您不用再遍历会话列表，把单个会话的未读数相加，才能得到未读总数。当会话的未读总数发生变更的时候，SDK 会主动向您的 App 回调 [onTotalUnreadMessageCountChanged](https://im.sdk.qcloud.com/doc/zh-cn/classcom_1_1tencent_1_1imsdk_1_1v2_1_1V2TIMConversationListener.html#a292e893a04cb092fe49c06873c1ea4b3) ，把最新的未读总数通知给您。

```js
this.$openSdk.getTotalUnreadMsgCount(data=>{
    const count = data.msg
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
this.$openSdk.markSingleMessageHasRead(uid, data => {
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
this.$openSdk.markGroupMessageHasRead(groupID, data => {
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
* @param newState 置顶状态（true,flase）
*/
this.$openSdk.pinConversation(conversationID, newState,data=>{
    ...
})
```



# 删除会话

- 调用 [deleteConversation](https://im.sdk.qcloud.com/doc/zh-cn/classcom_1_1tencent_1_1imsdk_1_1v2_1_1V2TIMConversationManager.html#a7a6e38c5a7431646bd4c0c4c66279077) 接口可以删除某个会话，删除会话时默认删除本地历史消息。

```js
/**
* 删除会话
*
* @param conversationID 会话id
*/
this.$openSdk.deleteConversation(conversationID,data=>{
    ...
})
```



# 会话监听回调

## 调用示例

```js
this.$globalEvent.addEventListener("onNewConversation",data=>{
    ...
})
```



## 回调列表

| 回调事件名称                     | 说明             |
| -------------------------------- | ---------------- |
| onConversationChanged            | 会话列表改变     |
| onNewConversation                | 产生新会话       |
| onSyncServerFailed               | -                |
| onSyncServerFinish               | -                |
| onSyncServerStart                | -                |
| onTotalUnreadMessageCountChanged | 消息总未读数改变 |



