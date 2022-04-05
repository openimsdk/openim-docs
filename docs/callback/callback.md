z# openIM callback使用说明


#### 回调说明
openIM为您提供了回调能力,所谓回调， 即openIM Server端会在某一事件发生之前或者之后，向APP后台服务器接口发送请求，第APP后台服务器可以据此进行必要的数据同步，或者干预事件的后续处理流程。
第三方回调将通过 HTTP/HTTPS 请求的方式发送给App 后台服务器，App 后台服务器需要处理openIM的回调请求并尽快进行应答。
App不仅可以基于该回调来实现消息同步，而且可以进行发消息安全打击。

#### 回调分类
从功能角度来看，回调可以分为：
- 发送消息前后回调
- 添加好友前后回调(开发中)
- 邀请进群前后回调(开发中)

从处理角度来看，回调可以分为以下两大类：
- 发送事件发生之前回调：回调的主要目的在于让 App 后台可以干预该事件的处理逻辑，即时通信 IM 会根据回调返回码确定后续处理流程。
- 发送事件发生之后通知：回调的主要目的在于让 App 后台实现必要的数据同步，即时通信 IM 忽略回调返回码。

#### 回调配置说明
```
   callbackUrl : "http://127.0.0.1:8080/callback"
         # 开启关闭操作前后回调的配置
         callbackbeforeSendSingleMsg:
           enable: false # 回调是否启用
           callbackTimeOut: 2 # 回调超时时间
           callbackFailedContinue: true # 回调超时是否继续执行代码
```
- callbackUrl：APP接口URL, 回调URL
- enable：true代表该回调开启， false代表该回调关闭
- callbackTimeOut：回调超时时间
- callbackFailedContinue：回调超时或者因网络原因造成的失败后是否继续执行流程

#### 回调协议
第三方回调基于 HTTP/HTTPS 协议, openIM使用POST请求的方式来向App后台发起回调请求,具体的回调内容则会包含在 HTTP 请求包体中。
回调请求字段和消息字段一致。

##### 文字过滤
- 请求

|    参数名       |   类型    | 说明                                                          | 
| :----------:    | :------: | :----------------------------------------------------------- | 
|    sendID       |  string  | 发送者ID                                     | 
| callbackCommand |  string  | 回调指令  文字过滤为callbackWordFilterCommand |
| serverMsgID     |  string  | 服务器生成的消息的唯一ID |
| clientMsgID     |  string  | 客户端生成的消息唯一ID   |
|  operationID    |  string |  本次操作ID |
|  senderPlatformID | int | 发送者平台号，模拟用户发送时填写， 1->IOS,2->Android,3->Windows,4->OSX,5->Web,5->MiniWeb,7->Linux|
|  senderNickname | string | 发送者昵称 |
|  sessionType    | int   | 发送的消息是单聊还是群聊,单聊为1，群聊为2 |
| contentType    | int  | 消息类型，101表示文本，102表示图片..详细参考[消息类型](https://doc.rentsoft.cn/server_doc/server_doc.html#%E6%B6%88%E6%81%AF%E7%B1%BB%E5%9E%8B%E6%A0%BC%E5%BC%8F%E6%8F%8F%E8%BF%B0)格式描述文档    |
| createTime | int | 生成时间戳 |
| content | string | 消息内容 |
| operationID | string | 本次操作ID |

- 响应
 
|    参数名       |   类型    | 说明                                 | 
| :----------:    | :------: | :------------------------------------| 
|  actionCode     |  int  | 操作码 0为允许本次消息发送  1为阻止本次消息发送|
|  errCode         | int | 错误码 0代表APP服务器正常处理响应回调 |
|  errMsg         |  string |           错误信息               |
| operationID     | string      |     本次操作ID       |
| content         | string | 替换后的内容 |

响应的content即要替换的全新内容
ActionCode和ErrCode都为0 才会正常过滤消息

##### 发单聊消息之前回调
- 请求

|    参数名       |   类型    | 说明                                                          | 
| :----------:    | :------: | :----------------------------------------------------------- | 
|    sendID       |  string  | 发送者ID                                     | 
| callbackCommand |  string  | 回调指令    发单聊之前回调为 callbackBeforeSendSingleMsgCommand                             |
| serverMsgID     |  string  | 服务器生成的消息的唯一ID |
| clientMsgID     |  string  | 客户端生成的消息唯一ID   |
|  operationID    |  string |  本次操作ID |
|  senderPlatformID | int | 发送者平台号，模拟用户发送时填写， 1->IOS,2->Android,3->Windows,4->OSX,5->Web,5->MiniWeb,7->Linux|
|  senderNickname | string | 发送者昵称 |
|  sessionType    | int   | 发送的消息是单聊还是群聊,单聊为1，群聊为2 |
| contentType    | int  | 消息类型，101表示文本，102表示图片..详细参考[消息类型](https://doc.rentsoft.cn/server_doc/server_doc.html#%E6%B6%88%E6%81%AF%E7%B1%BB%E5%9E%8B%E6%A0%BC%E5%BC%8F%E6%8F%8F%E8%BF%B0)格式描述文档    |
| createTime | int | 生成时间戳 |
| content | string | 消息内容 |
| operationID | string | 本次操作ID |
| recvID | string | 接收者ID |

- 响应
 
|    参数名       |   类型    | 说明                                 | 
| :----------:    | :------: | :------------------------------------| 
|  actionCode     |  int  | 操作码 0为允许本次消息发送  1为阻止本次消息发送|
|  errCode         | int | 错误码 0代表APP服务器正常处理响应回调 |
|  errMsg         |  string |           错误信息               |
| operationID     | string      |     本次操作ID       |

ActionCode和ErrCode都为0 才会正常接受回调响应

##### 发单聊消息之后回调
- 请求

|    参数名       |   类型    | 说明                                                          | 
| :----------:    | :------: | :----------------------------------------------------------- | 
|    sendID       |  string  | 发送者ID                                     | 
| callbackCommand |  string  | 回调指令                                      |
| serverMsgID     |  string  | 服务器生成的消息的唯一ID |
| clientMsgID     |  string  | 客户端生成的消息唯一ID   |
|  operationID    |  string |  本次操作ID |
|  senderPlatformID | int | 发送者平台号，模拟用户发送时填写， 1->IOS,2->Android,3->Windows,4->OSX,5->Web,5->MiniWeb,7->Linux|
|  senderNickname | string | 发送者昵称 |
|  sessionType    | int   | 发送的消息是单聊还是群聊,单聊为1，群聊为2 |
| contentType    | int  | 消息类型，101表示文本，102表示图片..详细参考[消息类型](https://doc.rentsoft.cn/server_doc/server_doc.html#%E6%B6%88%E6%81%AF%E7%B1%BB%E5%9E%8B%E6%A0%BC%E5%BC%8F%E6%8F%8F%E8%BF%B0)格式描述文档    |
| createTime | int | 生成时间戳 |
| content | string | 消息内容 |
| operationID | string | 本次操作ID |
| recvID | string | 接收者ID |

- 响应
 
|    参数名       |   类型    | 说明                                 | 
| :----------:    | :------: | :------------------------------------| 
|  actionCode     |  int  | 操作码 0为允许本次消息发送  1为阻止本次消息发送|
|  errCode         | int | 错误码 0代表APP服务器正常处理响应回调 |
|  errMsg         |  string |           错误信息               |
| operationID     | string      |     本次操作ID       |

ActionCode和ErrCode不影响本次操作