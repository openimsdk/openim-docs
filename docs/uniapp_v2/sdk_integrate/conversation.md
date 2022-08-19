# 会话相关API

> 所有API中需要用到的`operationID`为随机字符串，通常用于定位问题使用，建议每一次API调用均采用唯一ID，可通过npm包uuid生成。<br/>存在callback的API，callback的回调参数格式为统一格式，errCode为0则代表操作成功，否则为失败。具体参考[此处说明]()。

| 方法                              | 描述                                   |
| --------------------------------- | -------------------------------------- |
| getAllConversationList            | 获取所有会话                           |
| getConversationListSplit          | 分页获取会话                           |
| getOneConversation                | 获取会话，如果会话不存在会自动生成一个 |
| getMultipleConversation           | 根据会话id获取多个会话                 |
| deleteConversation                | 通过会话id删除指定会话                 |
| setConversationDraft              | 设置会话草稿                           |
| pinConversation                   | 置顶会话                               |
| markGroupMessageHasRead           | 标记群聊会话已读                       |
| markNotifyMessageHasRead          | 标记系统通知会话已读                   |
| getTotalUnreadMsgCount            | 获取未读消息总数                       |
| setConversationRecvMessageOpt     | 消息免打扰设置                         |
| getConversationRecvMessageOpt     | 查询免打扰状态                         |
| setOneConversationPrivateChat     | 设置阅后即焚状态                       |
| deleteConversation                | 删除本地会话                           |
| deleteConversationFromLocalAndSvr | 删除本地以及服务器的会话               |
| deleteAllConversationFromLocal    | 删除所有本地会话                       |
| resetConversationGroupAtType      | 重置强提醒标识                         |
| setGlobalRecvMessageOpt           | 全局免打扰设置                         |

## getAllConversationList

> 获取所有会话列表。

- Example:

  ```js
  openIM.getAllConversationList(operationID,({data}) => {
  	...
  })
  ```

- CallBack:

  | Name | Type   | Description                |
  | ---- | ------ | -------------------------- |
  | data | string | [会话对象]()列表json字符串 |



## getConversationListSplit

> 分页获取会话列表。

- Example:

  ```js
  openIM.getConversationListSplit(operationID,offset,count,({data}) => {
  	...
  })
  ```

- Parameters:

  | Name   | Type   | Required | Description        |
  | ------ | ------ | -------- | ------------------ |
  | offset | number | true     | 偏移量             |
  | count  | number | true     | 一次拉取的会话数量 |

- CallBack:

  | Name | Type   | Description                |
  | ---- | ------ | -------------------------- |
  | data | string | [会话对象]()列表json字符串 |




## getOneConversation

> 根据用户ID或群聊ID和会话类型获取单个会话，如果会话不存在，会生成并返回会话信息。

- Example:

  ```js
  openIM.getOneConversation(operationID,sessionType,sourceID,({data}) => {
  	...
  })
  ```

- Parameters:

  | Name        | Type   | Required | Description     |
  | ----------- | ------ | -------- | --------------- |
  | sourceID    | string | true     | 用户ID或群聊ID  |
  | sessionType | number | true     | 单聊为1 群聊为2 |


- CallBack:

  | Name | Type   | Description            |
  | ---- | ------ | ---------------------- |
  | data | string | [会话对象]()json字符串 |

  


## getMultipleConversation

> 根据会话ID获取多个会话。

- Example:

  ```js
  openIM.getMultipleConversation(operationID,conversationIDList,({data}) => {
  	...
  })
  ```

- Parameters:

  | Name               | Type     | Required | Description |
  | ------------------ | -------- | -------- | ----------- |
  | conversationIDList | string[] | True     | 会话ID数组  |

- CallBack:

  | Name | Type   | Description                                                  |
  | ---- | ------ | ------------------------------------------------------------ |
  | data | string | [会话对象](https://doc.rentsoft.cn/client_doc/web_doc.html#%E4%BC%9A%E8%AF%9D%E5%AF%B9%E8%B1%A1)列表json字符串 |




## deleteConversation

> 根据会话ID删除指定会话。

- Example:

  ```js
  openIM.deleteConversation(operationID,conversationID,({data}) => {
  	...
  })
  ```

- Parameters:

  | Name           | Type   | Description |
  | -------------- | ------ | ----------- |
  | conversationID | string | 会话ID      |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 删除成功或失败描述 |

  

## setConversationDraft

> 设置会话草稿信息。

- Example:

  ```js
  openIM.setConversationDraft(operationID,conversationID,draftText,({data}) => {
  	...
  })
  ```

- Parameters:

  | Name           | Type   | Description |
  | -------------- | ------ | ----------- |
  | conversationID | string | 会话ID      |
  | draftText      | string | 草稿信息    |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 设置成功或失败描述 |

  

## pinConversation

> 置顶会话。

- Example:

  ```js
  openIM.pinConversation(operationID,conversationID,isPinned,({data}) => {
  	...
  })
  ```

- Parameters:

  | Name           | Type   | Description |
  | -------------- | ------ | ----------- |
  | conversationID | string | 会话ID      |
  | isPinned       | bool   | 是否置顶    |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 置顶成功或失败描述 |




## markGroupMessageHasRead

> 置零群聊会话未读数。

- Example:

  ```js
  openIM.markGroupMessageHasRead(operationID,groupID,({data}) => {
  	...
  })
  ```

- Parameters:

  | Name    | Type   | Description |
  | ------- | ------ | ----------- |
  | groupID | string | 群组ID      |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 标记成功或失败描述 |



## markConversationHasRead

> 置零系统通知会话未读数。

- Example:

  ```js
  openIM.markConversationHasRead(operationID,conversationID,({data}) => {
  	...
  })
  ```

- Parameters:

  | Name           | Type   | Description        |
  | -------------- | ------ | ------------------ |
  | conversationID | string | 会话conversationID |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 标记成功或失败描述 |





## getTotalUnreadMsgCount

> 获取消息总未读。

- Example:

  ```js
  openIM.getTotalUnreadMsgCount(operationID,({data}) => {
  	...
  })
  ```

- CallBack:

  | Name | Type   | Description  |
  | ---- | ------ | ------------ |
  | data | string | 消息总未读数 |



## setConversationRecvMessageOpt

> 设置会话免打扰状态
>
> 设置为1时，不再接收改会话的消息。设置为2时，正常接收该会话的消息，但不计入总未读数（依然会计入该会话的未读数，但可根据会话中的recvOpt状态自行处理）。

- Example:

  ```js
  openIM.setConversationRecvMessageOpt(operationID,conversationIDList,opt,({data}) => {
  	...
  })
  ```

- Parameters:

  | Name               | Type   | Required | Description                                      |
  | ------------------ | ------ | -------- | ------------------------------------------------ |
  | conversationIDList | string | true     | 会话ID数组                                       |
  | opt                | number | true     | 是否开启免打扰 0不开启 1不接受信息 2接收但不提醒 |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 设置成功或失败描述 |



## getConversationRecvMessageOpt

> 获取会话免打扰状态

- Example:

  ```js
  openIM.getConversationRecvMessageOpt(operationID,conversationIDList,({data}) => {
  	...
  })
  ```

- Parameters:

  | Name               | Type   | Required | Description |
  | ------------------ | ------ | -------- | ----------- |
  | conversationIDList | string | true     | 会话ID数组  |

- CallBack:

  | Name | Type   | Description                  |
  | ---- | ------ | ---------------------------- |
  | data | string | 会话免打扰状态列表json字符串 |



## setOneConversationPrivateChat

> 设置阅后即焚状态。

- Example:

  ```js
  openIM.setOneConversationPrivateChat(operationID,conversationID,isPrivate,({data}) => {
  	...
  })
  ```

- Parameters:

  | Name           | Type    | Required | Description      |
  | -------------- | ------- | -------- | ---------------- |
  | conversationID | string  | true     | 会话ID           |
  | isPrivate      | boolean | true     | 是否开启阅后即焚 |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 设置成功或失败描述 |



## deleteConversation

> 根据会话ID删除指定会话，仅删除本地记录。

- Example:

  ```js
  openIM.deleteConversation(operationID,conversationID,({data}) => {
  	...
  })
  ```

- Parameters:

  | Name           | Type   | Description |
  | -------------- | ------ | ----------- |
  | conversationID | string | 会话ID      |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 删除成功或失败描述 |



## deleteConversationFromLocalAndSvr

> 根据会话ID删除指定会话，同时删除本地及服务端记录。

- Example:

  ```js
  openIM.deleteConversationFromLocalAndSvr(operationID,conversationID,({data}) => {
  	...
  })
  ```

- Parameters:

  | Name           | Type   | Description |
  | -------------- | ------ | ----------- |
  | conversationID | string | 会话ID      |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 删除成功或失败描述 |



## deleteAllConversationFromLocal

> 删除所有会话，仅删除本地记录。

- Example:

  ```js
  openIM.deleteAllConversationFromLocal(operationID,({data}) => {
  	...
  })
  ```

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 操作成功或失败描述 |



## resetConversationGroupAtType

> 重置会话强提醒状态，如有人@你、 @所有人、群公告等

- Example:

  ```js
  openIM.resetConversationGroupAtType(operationID,conversationID,({data}) => {
  	...
  })
  ```

- Parameters:

  | Name           | Type   | Description |
  | -------------- | ------ | ----------- |
  | conversationID | string | 会话ID      |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 操作成功或失败描述 |





## setGlobalRecvMessageOpt

> 设置全局会话免打扰状态
>
> 设置为1时，不再接收消息。设置为2时，正常接收会话的消息，但不会进行推送。

- Example:

  ```js
  openIM.setGlobalRecvMessageOpt(operationID,opt,({data}) => {
  	...
  })
  ```

- Parameters:

  | Name | Type   | Required | Description                                      |
  | ---- | ------ | -------- | ------------------------------------------------ |
  | opt  | number | true     | 是否开启免打扰 0不开启 1不接受信息 2接收但不提醒 |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 设置成功或失败描述 |

  

# 会话相关回调

> 相关回调需要通过导入`globalEvent`进行监听，引入步骤参考[SDK引入]()。

| 事件                             | 描述               | 响应                     |
| -------------------------------- | ------------------ | ------------------------ |
| onNewConversation                | 新增新会话         | 新增的会话列表json字符串 |
| onConversationChanged            | 已有的会话发生改变 | 改变的会话列表json字符串 |
| onTotalUnreadMessageCountChanged | 消息总未读数改变   | 消息未读数               |