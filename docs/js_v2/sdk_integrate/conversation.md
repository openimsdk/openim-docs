# 会话相关API

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
  openIM.getAllConversationList().then(({ data })=>{
    ...
  }).catch(err=>{
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
  const options:GetOneCveParams = {
    sourceID:"",
    sessionType:1
  }
  openIM.getOneConversation(options).then(({ data })=>{
    ...
  }).catch(err=>{
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
  const conversationIDList = ["xxx"]
  openIM.getMultipleConversation(conversationIDList).then(({ data })=>{
    ...
  }).catch(err=>{
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
  openIM.deleteConversation(conversationID).then(({ data })=>{
    ...
  }).catch(err=>{
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
  const options:SetDraftParams = {
    conversationID:"",
    draftText:""
  }
  openIM.setConversationDraft(options).then(({ data })=>{
    ...
  }).catch(err=>{
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
  const options:PinCveParams = {
    conversationID:"",
    isPinned:true
  }
  openIM.pinConversation(options).then(({ data })=>{
    ...
  }).catch(err=>{
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
  openIM.markGroupMessageHasRead(groupID).then(({ data })=>{
    ...
  }).catch(err=>{
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



## markNotifyMessageHasRead

> 置零系统通知会话未读数。

- Example:

  ```js
  openIM.markNotifyMessageHasRead(conversationID).then(({ data })=>{
    ...
  }).catch(err=>{
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
  openIM.getTotalUnreadMsgCount().then(({ data })=>{
    ...
  }).catch(err=>{
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
>

- Example:

  ```js
  const conversationIDList = [""]
  openIM.getConversationRecvMessageOpt(conversationIDList).then(({ data })=>{
    ...
  }).catch(err=>{
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

> 获取会话免打扰状态

- Example:

  ```js
  const options:setPrvParams = {
    conversationID: "",
    isPrivate: true
  }
  openIM.setOneConversationPrivateChat(options).then(({ data })=>{
    ...
  }).catch(err=>{
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
  openIM.deleteConversation(conversationID).then(({ data })=>{
    ...
  }).catch(err=>{
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
  openIM.deleteConversationFromLocalAndSvr(conversationID).then(({ data })=>{
    ...
  }).catch(err=>{
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
  openIM.deleteAllConversationFromLocal().then(({ data })=>{
    ...
  }).catch(err=>{
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



## resetConversationGroupAtType

> 重置会话强提醒状态，如有人@你、 @所有人、群公告等

- Example:

  ```js
  openIM.resetConversationGroupAtType(conversationID).then(({ data })=>{
    ...
  }).catch(err=>{
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
  const options = {
    opt:0
  }
  openIM.setGlobalRecvMessageOpt(options).then(({ data })=>{
    ...
  }).catch(err=>{
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

> 所有事件相关常量均封装在SDK的`CbEvents`中，可直接进行引入使用。

| 事件                             | 描述               | 响应                     |
| -------------------------------- | ------------------ | ------------------------ |
| OnNewConversation                | 新增新会话         | 新增的会话列表json字符串 |
| OnConversationChanged            | 已有的会话发生改变 | 改变的会话列表json字符串 |
| OnTotalUnreadMessageCountChanged | 消息总未读数改变   | 消息未读数               |