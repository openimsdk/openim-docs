# openIM callback使用说明

#### 回调说明
openIM为您提供了回调能力，所谓回调， 即openIM Server端会在某一事件发生之前或者之后，向APP后台服务器接口发送请求，第APP后台服务器可以据此进行必要的数据同步，或者干预事件的后续处理流程。
第三方回调将通过 HTTP/HTTPS 请求的方式发送给App 后台服务器， App 后台服务器需要处理openIM的回调请求并尽快进行应答是
App不仅可以基于该回调来实现消息同步，而且可以进行发消息管理。

#### 回调分类
从功能角度来看，回调可以分为：
- 发送消息前后回调
- 文字类型消息过滤回调
- 用户上下线通知回调
- 离线推送回调

从处理角度来看，回调可以分为以下两大类：
- 发送事件发生之前回调：回调的主要目的在于让 App 后台可以干预该事件的处理逻辑，即时通信 IM 会根据回调返回码确定后续处理流程。
- 发送事件发生之后通知：回调的主要目的在于让 App 后台实现必要的数据同步，即时通信 IM 忽略回调返回码和错误码。

#### 回调配置说明
```
   callbackUrl : "http://127.0.0.1:8080/callback"
         # 开启关闭操作前后回调的配置
         callbackbeforeSendSingleMsg:
           enable: false # 回调是否启用
           callbackTimeOut: 2 # 回调超时时间
           callbackFailedContinue: true # 回调超时是否继续执行代码
```
- callbackUrl：APP接口URL，回调URL
- enable：true代表该回调开启，false代表该回调关闭
- callbackTimeOut：回调超时时间，超时就直接返回请求超时异常
- callbackFailedContinue：回调超时或者因网络原因造成的失败后是否继续执行流程， 部分回调类型没有这个参数

#### 回调协议
第三方回调基于 HTTP/HTTPS 协议, openIM使用POST请求的方式来向App后台发起回调请求,具体的回调内容则会包含在 HTTP 请求包体中。
消息类回调请求字段和消息字段一致。

### 简单回调服务器demo代码
python代码样例，用于回调不同时问题排除等
main.py 文件 监听地址:0.0.0.0:8080
```
 from flask import Flask, request
 import time
 import json
 
 app = Flask(__name__)
 
 @app.route('/callback', methods=["POST"])
 def callback():
     print(request.data)
     resp = {
             "actionCode": 1,
             "errCode": 10,
             "errMsg": "err",
             "operationID": "operationID",
             "content":"ewew",
         }
     return json.dumps(resp)
 
 app.run(port="8080")
```
安装demo环境
```
    apt-get install python3-pip
    pip3 install flask 
    python3 main.py
```

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
| atUserList | []string |被@的用户列表|
| operationID | string | 本次操作ID |

- 响应
 
|    参数名       |   类型    | 说明                                 | 
| :----------:    | :------: | :------------------------------------| 
|  actionCode     |  int  | 操作码 0为允许本次消息发送  1为阻止本次消息发送|
|  errCode         | int | 错误码 0代表APP服务器正常处理响应回调 |
|  errMsg         |  string |           错误信息               |
| operationID     | string      |     本次操作ID       |
| content         | string | 替换后的内容 |

响应的content即要替换的全新内容。
actionCode和errCode都为0以及content不为空才会正常将响应的content替换到消息的content，继续消息的发送。
只有actionCode不为0才会停止消息发送，如果actionCode回传不为0切errCode为0，则向移动端回复201状态码
errCode会返回透传到客户端，客户端可以对此错误码做特殊处理

##### 发单聊/群聊消息之前回调
- 请求

|    参数名       |   类型    | 说明                                                          | 
| :----------:    | :------: | :----------------------------------------------------------- | 
|    sendID       |  string  | 发送者ID                                     | 
| callbackCommand |  string  | 回调指令    发单聊之前回调为 callbackBeforeSendSingleMsgCommand   发群聊之前回调为callbackBeforeSendGroupMsgCommand                       |
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
| atUserList | []string |被@的用户列表|   
| senderFaceURL| string |发送者头像|
| recvID | string | 接收者ID |

- 响应
 
|    参数名       |   类型    | 说明                                 | 
| :----------:    | :------: | :------------------------------------| 
|  actionCode     |  int  | 操作码 0为允许本次消息发送  1为阻止本次消息发送|
|  errCode         | int | 错误码 0代表APP服务器正常处理响应回调 |
|  errMsg         |  string |           错误信息               |
| operationID     | string      |     本次操作ID       |

actionCode为0 才会正常接受回调响应，继续消息的发送。
只有actionCode不为0才会停止消息发送，如果actionCode回传不为0切errCode为0，则向移动端回复201状态码
errCode会返回透传到客户端，客户端可以对此错误码做特殊处理


##### 发单聊/群聊消息之后回调
- 请求

|    参数名       |   类型    | 说明                                                          | 
| :----------:    | :------: | :----------------------------------------------------------- | 
|    sendID       |  string  | 发送者ID                                     | 
| callbackCommand |  string  | 回调指令  发单聊之后回调为 callbackAfterSendSingleMsgCommand   发群聊之后回调为callbackAfterSendGroupMsgCommand                                    |
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
| atUserList | []string |被@的用户列表|   
| senderFaceURL| string |发送者头像|

- 响应
 
|    参数名       |   类型    | 说明                                 | 
| :----------:    | :------: | :------------------------------------| 
|  actionCode     |  int  | 操作码 0为允许本次消息发送  1为阻止本次消息发送|
|  errCode         | int | 错误码 0代表APP服务器正常处理响应回调 |
|  errMsg         |  string |           错误信息               |
| operationID     | string      |     本次操作ID       |

actionCode和errCode不影响本次操作，openIM服务端会忽略actionCode并且在日志中打印errCode

##### 用户上线之后回调
- 请求

|    参数名       |   类型    | 说明                                                          | 
| :----------:    | :------: | :----------------------------------------------------------- | 
|    UserID       |  string  | 发送者ID                                     | 
| callbackCommand |  string  | 回调指令 callbackUserOnlineCommand                                      |
| operationID |  string  | 本次操作ID                                      |
| PlatformID |  string  | 平台ID                                      |
| Platform |  string  | 平台                                      |
| token |  string  | 使用token                                      |
| seq | int | 序号 服务器毫秒时间戳|
| isAppBackgroundStatusChanged | bool | 是否为前后台变更, true表示用户切到前台, false表示正常的上线 |


- 响应
 
|    参数名       |   类型    | 说明                                 | 
| :----------:    | :------: | :------------------------------------| 
|  actionCode     |  int  | 操作码 0为允许本次消息发送  1为阻止本次消息发送|
|  errCode         | int | 错误码 0代表APP服务器正常处理响应回调 |
|  errMsg         |  string |           错误信息               |
| operationID     | string      |     本次操作ID       |

ActionCode和ErrCode不影响本次操作

##### 用户离线之后回调
- 请求

|    参数名       |   类型    | 说明                                                          | 
| :----------:    | :------: | :----------------------------------------------------------- | 
|    UserID       |  string  | 发送者ID                                     | 
| callbackCommand |  string  | 回调指令   callbackUserOfflineCommand                                   |
| perationID |  string  | 本次操作ID                                      |
| PlatformID |  string  | 平台ID                                      |
| Platform |  string  | 平台                                      |
| seq | int | 序号 服务器毫秒时间戳|
| isAppBackgroundStatusChanged | bool | 是否为前后台变更, true表示用户切到后台, false表示正常的离线 |



- 响应
 
|    参数名       |   类型    | 说明                                 | 
| :----------:    | :------: | :------------------------------------| 
|  actionCode     |  int  | 操作码 0为允许本次消息发送  1为阻止本次消息发送|
|  errCode         | int | 错误码 0代表APP服务器正常处理响应回调 |
|  errMsg         |  string |           错误信息               |
| operationID     | string      |     本次操作ID       |

ActionCode和ErrCode不影响本次操作

##### 用户接受离线推送回调
- 请求

|    参数名       |   类型    | 说明                                                          | 
| :----------:    | :------: | :----------------------------------------------------------- | 
|    UserIDList       |  []string  | 发送者ID列表                                   | 
| callbackCommand |  string  | 回调指令    callbackOfflinePushCommand   |
| operationID |  string  | 本次操作ID                                      |
| platformID |  string  | 平台ID                                      |
| platform |  string  | 平台                                      |
|    Title       |  string  | 推送标题                                     | 
| desc |  string  | 推送描述                                      |
| ex |  string  | 扩展字段                                      |
| iOSPushSound |  string  | ios推送声音                                      |
| iOSBadgeCount |  string  |       推送消息是否计入桌面图标未读数                              |
| sendID |  string  |       发送id                              |
| groupID |  string  |       群id                              |
| contentType |  string  |       类型                              |
| sessionType |  string  |       消息单聊群聊类型                             |
| atUserIDList |  []string  |             atUserIDList                        |
| content | string | 内容 |

- 响应
 
|    参数名       |   类型    | 说明                                 | 
| :----------:    | :------: | :------------------------------------| 
|  actionCode     |  int  | 操作码 0为允许离线发送  1为阻止离线消息发送|
|  errCode        | int  | 错误码 0代表APP服务器正常处理响应回调 |
|  errMsg         |  string |           错误信息               |
| operationID     | string      |     本次操作ID       |
|    UserIDList       |  []string  | 需要离线推送的用户ID列表              | 


actionCode为0 才会正常接受回调响应，继续离线消息的推送。
errCode只在服务端做log打印日志处理。

响应的userIDList为离线推送的用户ID列表
actionCode和errCode都为0以及userIDList不为空才会正常离线推送响应的userIDList, 如果userIDList为空且actionCode为0会正常以请求的UserIDList进行离线推送


##### 用户接受在线推送前回调
- 请求

|    参数名       |   类型    | 说明                                                          | 
| :----------:    | :------: | :----------------------------------------------------------- | 
|    UserIDList       | []string  | 发送者ID列表                             | 
| callbackCommand |  string  | 回调指令    callbackOnlinePushCommand   |
| operationID |  string  | 本次操作ID                                      |
| platformID |  string  | 平台ID                                      |
| platform |  string  | 平台                                      |
|    Title       |  string  | 推送标题                                     | 
| desc |  string  | 推送描述                                      |
| ex |  string  | 扩展字段                                      |
| iOSPushSound |  string  | ios推送声音                                      |
| iOSBadgeCount |  string  |       推送消息是否计入桌面图标未读数                              |
| sendID |  string  |       发送id                              |
| groupID |  string  |       群id                              |
| contentType |  string  |       类型                              |
| sessionType |  string  |       消息单聊群聊类型                             |
| atUserIDList |  []string  |             atUserIDList                        |
| content | string | 内容 |

- 响应
 
|    参数名       |   类型    | 说明                                 | 
| :----------:    | :------: | :------------------------------------| 
|  actionCode     |  int  | 操作码 0为允许在线发送  1为阻止在线消息发送|
|  errCode        | int  | 错误码 0代表APP服务器正常处理响应回调 |
|  errMsg         |  string |           错误信息               |
| operationID     | string      |     本次操作ID       |

actionCode为0 才会正常接受回调响应，继续在线消息的推送。
errCode只在服务端做log打印日志处理。

##### superGroup在线推送前回调
- 请求

|    参数名       |   类型    | 说明                                                          | 
| :----------:    | :------: | :----------------------------------------------------------- | 
| callbackCommand |  string  | 回调指令    callbackSuperGroupOnlinePushCommand   |
| operationID |  string  | 本次操作ID                                      |
| platformID |  string  | 平台ID                                      |
| platform |  string  | 平台                                      |
|    Title       |  string  | 推送标题                                     | 
| desc |  string  | 推送描述                                      |
| ex |  string  | 扩展字段                                      |
| iOSPushSound |  string  | ios推送声音                                      |
| iOSBadgeCount |  string  |       推送消息是否计入桌面图标未读数                              |
| sendID |  string  |       发送id                              |
| groupID |  string  |       群id                              |
| contentType |  string  |       类型                              |
| sessionType |  string  |       消息单聊群聊类型                             |
| atUserIDList |  []string  |             atUserIDList                        |
| content | string | 内容 |

- 响应
 
|    参数名       |   类型    | 说明                                 | 
| :----------:    | :------: | :------------------------------------| 
|  actionCode     |  int  | 操作码 0为允许在线发送  1为阻止在线消息发送|
|  errCode        | int  | 错误码 0代表APP服务器正常处理响应回调 |
|  errMsg         |  string |           错误信息               |
| operationID     | string      |     本次操作ID       |
|userIDList  | []string | 要推送的用户列表 | 
响应的userIDList推送的用户ID列表
actionCode和errCode都为0以及userIDList不为空才会正常在线推送userIDList, 如果userIDList为空且actionCode为0会正常使用openIM的数据库群成员进行推送


actionCode为0 才会正常接受回调响应，继续在线消息的推送。
errCode只在服务端做log打印日志处理。

响应的userIDList推送的用户ID列表
actionCode和errCode都为0以及userIDList不为空才会正常在线推送userIDList, 如果userIDList为空且actionCode为0会正常使用openIM的数据库群成员进行推送


##### setGroupMemberInfo 回调
- 请求

|    参数名       |   类型    | 说明                                                          | 
| :----------:    | :------: | :----------------------------------------------------------- | 
| callbackCommand |  string  | 回调指令    CallbackBeforeSetGroupMemberInfoCommand   |
| operationID |  string  | 本次操作ID                                      |
| groupID        |  string      |  群ID              ｜
|  userID         |  string     | 用户ID        |
|  ex         |  string     | 拓展字段        |
|  nickName         |  string     | 群昵称        |
|  faceURL         |  string     | 头像     |
|  roleLevel        |  int32     | 用户等级        |

- 响应
 
|    参数名       |   类型    | 说明                                 | 
| :----------:    | :------: | :------------------------------------| 
|  actionCode     |  int  | 操作码 0为允许修改 1为阻止修改|
|  errCode        | int  | 错误码 0代表APP服务器正常处理响应回调 |
|  errMsg         |  string |           错误信息               |
| operationID     | string      |     本次操作ID       |
|  ex         |  string     | 拓展字段        |
|  nickName         |  string     | 群昵称        |
|  faceURL         |  string     | 头像     |
|  roleLevel        |  int32     | 用户等级        |

actionCode为0 才会正常接受回调响应，继续在线消息的推送。
errCode只在服务端做log打印日志处理。
响应中的ex, nickName, faceURL, roleLevel会对原本请求中的字段做替换，json中不包含对应的字段则不进行替换操作
##### setMessageReactionExtension 回调
> 消息回复修改回调，分为两种，第一种是外部直接控制的回调，IM负责透传数据，以及通知操作，不做存储，
> 第二种通过IM存储，但是回调后用于过滤修改操作，IM执行后续存储以及通知操作
- 请求

|    参数名       |   类型    | 说明                                                          | 
| :----------:    | :------: | :----------------------------------------------------------- | 
| callbackCommand |  string  | 回调指令    CallbackBeforeSetMessageReactionExtensionCommand   |
| operationID |  string  | 本次操作ID                                      |
| sourceID        |  string      |  源ID，如果为群聊为群ID，单聊为发送者和接受者ID结合的string              ｜
|  opUserID         |  string     | 操作者ID        |
|  sessionType         |  int32     | 会话类型        |
|  reactionExtensionList         |  map[string]*sdk_ws.KeyValue      | 需要修改的key-value map        |
|  clientMsgID         |  string     | 消息ID     |
|  isReact        |  bool     | 消息是否处于编辑状态，用于首次编辑的判断        |
|  isExternalExtensions        |  bool     | 消息是否处于外部存储回复扩展字段状态       |
|  msgFirstModifyTime        |  int64     | 消息首次编辑时间，单位为毫秒      |

- 子类型sdk_ws.KeyValue 说明

|    参数名       |   类型    | 说明                                                          | 
| :----------:    | :------: | :----------------------------------------------------------- | 
| typeKey |  string  | 需要修改的key  |
| value |  string  | 需要修改的value |
| latestUpdateTime |  int64  | 此key最近更新时间，单位为毫秒 |


- 响应

|    参数名       |   类型    | 说明                                 | 
| :----------:    | :------: | :------------------------------------| 
|  actionCode     |  int  | 操作码 0为允许IM执行， 1为阻止，isExternalExtensions为true时，IM默认不会向下执行|
|  errCode        | int  | 错误码 0代表APP服务器正常处理响应回调 |
|  errMsg         |  string |           错误信息               |
| operationID     | string      |     本次操作ID       |
|  resultReactionExtensionList         |  []*msg.KeyValueResp     | 设置kv的数组结果       |
|  msgFirstModifyTime        |  int64     | 消息首次编辑时间，单位为毫秒      |

- 子类型msg.KeyValueResp  说明

|    参数名       |   类型    | 说明                                                          | 
| :----------:    | :------: | :----------------------------------------------------------- | 
errCode        | int  | 错误码 0代表此key修改成功，否则失败|
|  errMsg         |  string |           错误信息               |
| typeKey |  string  | 需要修改的key  |
| value |  string  | 修改失败最新的value |
| latestUpdateTime |  int64  | 此key最近更新时间，单位为毫秒 |

##### DeleteMessageReactionExtensions 回调
> 消息回复修改回调，分为两种，第一种是外部直接控制的回调，IM负责透传数据，以及通知操作，不做存储，
> 第二种通过IM存储，但是回调后用于过滤修改操作，IM执行后续存储以及通知操作
- 请求

|    参数名       |   类型    | 说明                                                          | 
| :----------:    | :------: | :----------------------------------------------------------- | 
| callbackCommand |  string  | 回调指令    CallbackBeforeDeleteMessageReactionExtensionsCommand   |
| operationID |  string  | 本次操作ID                                      |
| sourceID        |  string      |  源ID，如果为群聊为群ID，单聊为发送者和接受者ID结合的string              ｜
|  opUserID         |  string     | 操作者ID        |
|  sessionType         |  int32     | 会话类型        |
|  reactionExtensionList         | []*sdk_ws.KeyValue      | 需要删除的key-value 数组        |
|  clientMsgID         |  string     | 消息ID     |
|  isExternalExtensions        |  bool     | 消息是否处于外部存储回复扩展字段状态       |
|  msgFirstModifyTime        |  int64     | 消息首次编辑时间，单位为毫秒      |

- 子类型sdk_ws.KeyValue 说明

|    参数名       |   类型    | 说明                                                          | 
| :----------:    | :------: | :----------------------------------------------------------- | 
| typeKey |  string  | 需要修改的key  |
| value |  string  | 删除操作下，value为空 |
| latestUpdateTime |  int64  | 此key最近更新时间，单位为毫秒 |


- 响应

|    参数名       |   类型    | 说明                                 | 
| :----------:    | :------: | :------------------------------------| 
|  actionCode     |  int  | 操作码 0为允许IM执行， 1为阻止，isExternalExtensions为true时，IM默认不会向下执行|
|  errCode        | int  | 错误码 0代表APP服务器正常处理响应回调 |
|  errMsg         |  string |           错误信息               |
| operationID     | string      |     本次操作ID       |
|  resultReactionExtensionList         |  []*msg.KeyValueResp     | 设置kv的数组结果        |
|  msgFirstModifyTime        |  int64     | 消息首次编辑时间，单位为毫秒      |

- 子类型msg.KeyValueResp  说明

|    参数名       |   类型    | 说明                                                          | 
| :----------:    | :------: | :----------------------------------------------------------- | 
errCode        | int  | 错误码 0代表此key修改成功，否则失败|
|  errMsg         |  string |           错误信息               |
| typeKey |  string  | 需要修改的key  |
| value |  string  | 修改失败最新的value |
| latestUpdateTime |  int64  | 此key最近更新时间，单位为毫秒 |

