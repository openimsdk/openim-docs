# 鉴权相关

## **换取管理员Token**

### **简要描述**

  AppServer 通过调用（auth/user_token）获取或刷新管理员token以取得超级权限。在调用以下所有的api时，必须获取管理员token，并设置到请求header中。如果没有特别说明，请求方式一律为POST

### **请求URL**

-  ` http://x.x.x.x:10000/auth/user_token`


### **请求方式**

 -  `POST`

  ### **请求示例**

  ```json
{
    "secret": "tuoyun",
    "platform": 1,
    "userID": "openIM123456",
    "operationID": "asdfasdfsadf"
}
  ```

### **请求参数**

|   参数名    | 必选 | 说明                                                         |
| :---------: | :--: | :----------------------------------------------------------- |
|   secret    |  是  |                                                              |
|  platform   |  是  | 管理员填8                                                    |
|   userID    |  是  | 管理员userID，IM启动时会根据IM服务器配置文件config/config.yaml初始化管理员；此处的userID必须为配置文件的appManagerUid的其中一个 |
| operationID |  是  |                                                              |

### **返回示例**

   ```json
{
    "errCode": 0,
    "errMsg": "",
    "data": {
        "userID": "openIM123456",
        "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVSUQiOiJvcGVuSU0xMjM0NTYiLCJQbGF0Zm9ybSI6IklPUyIsImV4cCI6MTY0NjI5Mzk5NCwibmJmIjoxNjQ1Njg5MTk0LCJpYXQiOjE2NDU2ODkxOTR9.cHEgLEHyzC1bmHoPjz7chYqIanfodeLT6LmQhPDeGPA",
        "expiredTime": 1646293994
    }
}
   ```

# 群组相关

### 创建群组

#### **简要描述**

- APP管理员创建群组

#### **请求URL**

- `http://x.x.x.x:10000/group/create_group`

#### **请求数据方式**

- POST

#### **请求示例**

```
{
    "ownerUserID": "19828950910",
    "groupType": 0,
    "groupName": "test group name",
    "notification": "",
    "introduction": "",
    "faceURL": "",
    "ex": "",
    "operationID": "sdadfsdfssdfasdafvcdxsdafdsfsdfaa",
    "memberList": [
        {
            "userID": "18666662412",
            "roleLevel": 1
        }
    ]
}
```

#### **请求参数**

| 参数名      | 必选 | 说明           |
| :---------- | :--- | -------------- |
| memberList  | 是   | 指定初始群成员 |
| ownerUserID | 是   | 群主UserID     |
| operationID | 是   |                |

### **返回示例**

```
{
    "errCode": 0,
    "errMsg": "",
    "data": {
        "creatorUserID": "openIM123456",
        "groupID": "f69e9aae6edb2c86b3380b7b0125e579",
        "groupName": "test group name",
        "memberCount": 2,
        "ownerUserID": "openIM123456"
    }
}
```

### **返回参数**

| 参数名  | 类型     | 说明                                                 |
| :------ | :------- | ---------------------------------------------------- |
| errCode | int      | 0成功，非0失败                                       |
| errMsg  | string   | 错误信息                                             |
| data    | json对象 | creatorUserID：创建者userID，ownerUserID：群主UserID |

## 邀请进群

### **简要描述**

- APP管理员邀请用户直接进群

### **请求URL**

- `http://x.x.x.x:10000/group/invite_user_to_group`

### **请求方式**

- POST

### **请求示例**

```
{
    "groupID": "f69e9aae6edb2c86b3380b7b0125e579",
    "operationID": "341323253454352",
    "invitedUserIDList": [
        "18349115126"
    ],
    "reason": "hello"
}
```

### **请求参数**

| 参数名            | 必选 | 类型     | 说明                    |
| :---------------- | :--- | :------- | ----------------------- |
| groupID           | 是   | string   |                         |
| invitedUserIDList | 是   | json数组 | 被邀请进群的用户uid列表 |
| reason            | 是   | string   |                         |
| token             | 是   | string   | 管理员token             |
| operationID       | 是   | string   | 操作id，用随机字符串    |

### **返回示例**

```
{
    "errCode": 0,
    "errMsg": "",
    "data": [
        {
            "userID": "18349115126",
            "result": -1
        }
    ]
}
```

### **返回参数**

| 参数名  | 类型     | 说明                              |
| :------ | :------- | --------------------------------- |
| errCode | int      | 0成功，非0失败                    |
| errMsg  | string   | 错误信息                          |
| data    | json对象 | 被邀请用户的uid，result 0表示成功 |



## 把用户踢出群

### **简要描述**

- APP管理员把用户从群里直接踢出

### **请求URL**

- `http://x.x.x.x:10000/group/kick_group`

### **请求方式**

- POST

### **请求示例 **

```
{
    "groupID": "f69e9aae6edb2c86b3380b7b0125e579",
    "operationID": "dasdavdsadsfasdf",
     "reason":"kkk",
	"kickedUserIDList": [
        "18666662412"
    ]
   
}
```

### **请求参数**

| 参数名      | 必选 | 类型     | 说明                                                         |
| :---------- | :--- | :------- | ------------------------------------------------------------ |
| groupID     | 是   | string   | 群id                                                         |
| uidListInfo | 是   | json数组 | 被踢用户id列表                                               |
| token       | 是   | string   | 从header中获取，此token必须以APP管理员身份调用auth/user_token生成，具体参考[换取管理员IMToken]() |
| operationID | 是   | string   | 操作id，用随机字符串                                         |

### **返回示例**

```
{
    "errCode": 0,
    "errMsg": "",
    "data": [
        {
            "userID": "18666662412",
            "result": 0
        }
    ]
}
```

### **返回参数**

| 参数名  | 类型     | 说明                                 |
| :------ | :------- | ------------------------------------ |
| errCode | int      | 0成功，非0失败                       |
| errMsg  | string   | 错误信息                             |
| data    | json对象 | uid：被踢用户uid， result：0表示成功 |

# 好友相关

## 导入好友

### **简要描述**

- APP管理员使用户A和其他人成为好友

### **请求URL**

- `http://x.x.x.x:10000/friend/import_friend`

### **请求方式**

- POST

### **请求示例 **

```
{
    "friendUserIDList": [
        "21979710c3fe454d", 
        "3434344"
    ], 
    "operationID": "1111111222", 
    "fromUserID": "f732156059eeb5d0"
}
```

### **请求参数**

| 参数名           | 必选 | 类型   | 说明                                                         |
| :--------------- | :--- | :----- | ------------------------------------------------------------ |
| friendUserIDList | 是   | string | 要建立好友关系的好友UserID列表                               |
| operationID      | 是   | string |                                                              |
| fromUserID       | 是   | string |                                                              |
| token            | 是   | string | 从header中获取，此token必须以APP管理员身份调用auth/user_token生成，具体参考[换取管理员IMToken]() |

### **返回示例**

```
{
    "errCode": 0, 
    "errMsg": "", 
    "data": [
        {
            "userID": "12121", 
            "result": -1
        }, 
        {
            "userID": "23465", 
            "result": 0
        }
    ]
}
```

### **返回参数说明**

| 参数名  | 类型   | 说明                            |
| :------ | :----- | ------------------------------- |
| errCode | int    | 0成功，非0失败                  |
| errMsg  | string | 错误信息                        |
| userID  | string | 用户userID                      |
| result  | int    | 导入结果，0代表成功，-1代表失败 |



# 黑名单相关

## 加入黑名单

### **简要描述**

- APP管理员包uid添加到ownerUid的黑名单中

### **请求URL**

- `http://x.x.x.x:10000/friend/add_blacklist`

### **请求方式**

- POST

### 请求示例

```
{
    "ToUserID": "21979710c3fe454d", 
    "operationID": "1111111222", 
    "fromUserID": "f732156059eeb5d0"
}
```

### **请求参数**

| 参数名      | 必选 | 类型   | 说明                                                         |
| :---------- | :--- | :----- | ------------------------------------------------------------ |
| ToUserID    | 是   | string | 被拉黑的用户id                                               |
| operationID | 是   | string | 操作id，用随机字符串                                         |
| token       | 是   | string | 从header中获取，此token必须以APP管理员身份调用auth/user_token生成，具体参考[换取管理员IMToken]() |
| fromUserID  | 是   | string | 需要拉黑别人的                                               |

### **返回示例**

```
{
    "errCode": 0, 
    "errMsg": ""
}
```

### **返回参数**

| 参数名  | 类型   | 说明           |
| :------ | :----- | -------------- |
| errCode | int    | 0成功，非0失败 |
| errMsg  | string | 错误信息       |

# 用户相关

## 更新用户信息

### **简要描述**

APP管理员更新用户信息

### **请求URL**

- `http://x.x.x.x:10000/user/update_user_info`

### **请求方式**

- POST

### 请求示例

```
{
    "userID": "21979710c3fe454d", 
    "operationID": "1111111222", 
    "nickname": "sssssssssskkkkk", 
    "faceURL": "", 
    "gender": 1, 
    "phoneNumber": "", 
    "birth": 167762763, 
    "email": "", 
    "ex": ""
}
```

### **请求参数**

| 参数名      | 类型   | 必选 | 说明                                              |
| :---------- | :----- | :--- | ------------------------------------------------- |
| operationID | string | 是   | 操作ID，保持唯一，建议用当前时间微秒+随机数       |
| nickname    | string | 否   | 用户昵称或者群昵称                                |
| faceURL     | string | 否   | 用户头像或者群头像url，根据上下文理解             |
| gender      | int    | 否   | 用户性别 1 表示男，2 表示女                       |
| phoneNumber | string | 否   | 用户手机号码，包括地区，(如香港：+852-xxxxxxxx)， |
| birth       | int    | 否   | 用户生日，Unix时间戳（秒）                        |
| email       | string | 否   | 邮箱地址                                          |
| ex          | string | 否   | 用户扩展信息                                      |
| userID      | string | 是   | 用户 ID，必须保证IM内唯一                         |

### **返回示例**

```
{
    "errCode": 0, 
    "errMsg": ""
}
```

### **返回参数**

| 参数名  | 类型   | 说明           |
| :------ | :----- | -------------- |
| errCode | int    | 0成功，非0失败 |
| errCode | string | 错误信息       |

## **删除用户**

### **简要描述**

 - 管理员调用删除IM用户接口。

### **请求URL**


 - `http://x.x.x.x:10000/manager/delete_user`


### **请求方式**


 - `POST`

### **请求示例**

  ```json
{
    "operationID": "1111111222", 
    "deleteUserIDList": [
        "123", 
        "343", 
        "456"
    ]
}
  ```

### **请求参数**

|      参数名      |   类型   | 必选 | 说明                                        |
| :--------------: | :------: | :--: | :------------------------------------------ |
|   operationID    |  string  |  是  | 操作ID，保持唯一，建议用当前时间微秒+随机数 |
| deleteUserIDList | json数组 |  是  | 需要删除的userID数组列表                    |


### **返回示例**

  ```json
{
    "errCode": 0, 
    "errMsg": "", 
    "data": [
        "122", 
        "466"
    ]
}
  ```

###  **返回参数**

| 参数名  | 类型     | 说明                 |
| :------ | :------- | -------------------- |
| errMsg  | string   | 错误信息             |
| errCode | int      | 0成功，非0失败       |
| data    | json数组 | 删除失败的用户UserID |

## **获取用户详细信息**

### **简要描述**

 - 管理员调用获取用户详细信息接口可以获取多个用户注册的详细信息。

### **请求URL**


 - `http://x.x.x.x:10000/user/get_users_info`


### **请求方式**


 - `POST`

### **请求示例**

  ```json
{
    "operationID": "1111111222", 
    "userIDList": [
        "123", 
        "3434"
    ]
}
  ```

### **请求参数**

|   参数名    |   类型   | 必选 | 说明                                        |
| :---------: | :------: | :--: | :------------------------------------------ |
| operationID |  string  |  是  | 操作ID，保持唯一，建议用当前时间微秒+随机数 |
| userIDList  | json数组 |  是  | 用户的userID列表                            |


### **返回示例**

  ```json
{
    "errCode": 0,
    "errMsg": "",
    "data": [
        {
            "faceURL": "ic_avatar_05",
            "nickname": "Gordon",
            "userID": "18349115126"
        },
        {
            "faceURL": "ic_avatar_04",
            "nickname": "OpenIM-sk",
            "userID": "18666662412"
        }
    ]
}
  ```

### **返回参数**

| 参数名   | 类型   | 说明           |
| :------- | :----- | -------------- |
| errCode  | int    | 0成功，非0失败 |
| errMsg   | string | 错误信息       |
| faceURL  | string | 用户头像url    |
| nickname | string | 用户昵称       |

### **简要描述**

 -   以管理员身份获取用户在线状态。

### **请求URL**


 - `http://x.x.x.x:10000/user/get_users_online_status


### **请求方式**


 - `POST`

### **请求示例**

  ```json
{
    "operationID": "545454", 
    "userIDList": [
        "17396220460","sadsdf"
    ]
}
  ```

### **请求参数**

|   参数名    | 类型     | 必选 | 说明                                        |
| :---------: | -------- | :--: | :------------------------------------------ |
| operationID | string   |  是  | 操作ID，保持唯一，建议用当前时间微秒+随机数 |
| userIDList  | json数组 |  是  | 用户的userID列表                            |


### **返回示例**

  ```json
{
    "errCode": 0,
    "errMsg": "",
    "data": [
        {
            "userID": "17396220460",
            "status": "online",
            "detailPlatformStatus": [
                {
                    "platform": "OSX",
                    "status": "online"
                },
                {
                    "platform": "Web",
                    "status": "online"
                }
            ]
        },
        {
            "userID": "sadsdf",
            "status": "offline"
        }
    ]
}
  ```

### **返回参数**

| 参数名   | 类型   | 说明                                                         |
| :------- | :----- | ------------------------------------------------------------ |
| errCode  | int    | 0成功，非0失败                                               |
| errMsg   | string | 错误信息                                                     |
| userID   | string | 用户 ID，必须保证IM内唯一                                    |
| status   | string | 在线状态，目前只有offline和online两种                        |
| platform | string | 目前平台有"IOS"，"Android"，"Windows"，"OSX"，"Web"， "Linux" |

## **获取IM注册的所有用户(userID)**

### **简要描述**

 - 管理员调用获取IM已经注册的所有用户的userID接口。

### **请求URL**


 - `http://x.x.x.x:10000/manager/get_all_users_uid`


### **请求方式**


 - `POST`

### **请求示例**

  ```json
{
    "operationID": "1111111222"
}
  ```

### **请求参数**

|   参数名    |  类型  | 必选 | 说明                                        |
| :---------: | :----: | :--: | :------------------------------------------ |
| operationID | string |  是  | 操作ID，保持唯一，建议用当前时间微秒+随机数 |


### **返回示例**

  ```json
{
    "errCode": 0, 
    "errMsg": "", 
    "data": [
        "122", 
        "466"
    ]
}
  ```

###  **返回参数**

| 参数名  | 类型     | 说明                         |
| :------ | :------- | ---------------------------- |
| errCode | int      | 0成功，非0失败               |
| errMsg  | string   | 错误信息                     |
| data    | json数组 | 已经注册的所有用户userID数组 |

## **查询用户是否在IM中已经注册**

### **简要描述**

 - 管理员调用查询用户是否在IM中已经注册接口。

### **请求URL**


 - `http://x.x.x.x:10000/manager/account_check`


### **请求方式**


 - `POST`

### **请求示例**

  ```json
{
    "operationID":"1111",
    "checkUserIDList":["18349115126","111","222","17396220460"]
}
  ```

### **请求参数**

|   参数名    | 类型 |  必选  | 说明                                                         |
| :---------: | :--: | :----: | :----------------------------------------------------------- |
| operationID |  string  | 是 | 操作ID，保持唯一，建议用当前时间微秒+随机数 |
| checkUserIDList |  json字符串数组  | 是 | 需要check的用户userID数组，单次数量不超过100 |


### **返回示例**

  ```json
{
    "data": [
        {
            "userID": "18349115126",
            "accountStatus": "registered"
        },
        {
            "userID": "111",
            "accountStatus": "unregistered"
        },
        {
            "userID": "222",
            "accountStatus": "unregistered"
        },
        {
            "userID": "17396220460",
            "accountStatus": "registered"
        }
    ],
    "errCode": 0,
    "errMsg": ""
}
  ```

###  **返回参数**

| 参数名  | 类型     | 说明                      |
| :------ | :------- | ------------------------- |
| errCode | int      | 0成功，非0失败            |
| errMsg  | string   | 错误信息                  |
| accountStatus  | string   | 用户注册状态，registered代表已经注册， unregistered代表未注册                  |

# 消息相关

## **发送单聊群聊消息**

### **简要描述**

 - 管理员通过后台接口发送单聊群聊消息，可以以管理员身份发消息，也可以以其他用户的身份发消息，通过sendID区分。

### **请求URL**


 - `http://x.x.x.x:10000/manager/send_msg`


### **请求方式**


 - `POST`

### **请求示例**

  ```json
{
    "operationID": "1111111222", 
    "sendID": "1111111222", 
    "recvID": "1111111222", 
    "groupID": "121212", 
    "senderNickname": "Gordon", 
    "senderFaceURL": "http://www.head.com", 
    "senderPlatformID": 1, 
    "forceList": [
        "122", 
        "223"
    ], 
    "content": {
        "text": "nihao"
    }, 
    "contentType": 101, 
    "sessionType": 1, 
    "isOnlineOnly": true, 
    "offlinePushInfo": {
        "title": "send message", 
        "desc": "", 
        "ex": "", 
        "iOSPushSound": "default", 
        "iOSBadgeCount": true
    }
}
  ```

### **请求参数**

|     参数名     | 类型 |  必选  | 说明                                                         |
| :------------: | :--: | :----: | :----------------------------------------------------------- |
|  operationID   |  string  |  是  | 操作ID，保持唯一，建议用当前时间微秒+随机数                  |
|     sendID     |  string  | 是 | 发送者ID                                                     |
|     recvID     |  string  | 否 | 接收者ID，单聊为用户ID，如果是群聊，则不填            |
| groupID | string | 否 | 群聊ID，如果为单聊，则不填 |
| senderNickname |  string  | 否 | 发送者昵称|
| senderFaceURL |  string  |  否  | 发送者头像|
|senderPlatformID|int|否|发送者平台号，模拟用户发送时填写， 1->IOS,2->Android,3->Windows,4->OSX,5->Web,5->MiniWeb,7->Linux|
|   forceList    |  json数组  | 否 | 当聊天类型为群聊时，使用@指定强推用户userID列表              |
|    content     |  json对象  |  是  | 消息的具体内容，内部是json 对象，其他消息的详细字段请参考[消息类型](https://doc.rentsoft.cn/server_doc/server_doc.html#%E6%B6%88%E6%81%AF%E7%B1%BB%E5%9E%8B%E6%A0%BC%E5%BC%8F%E6%8F%8F%E8%BF%B0)格式描述文档 |
|  contentType   |  int  |   是   | 消息类型，101表示文本，102表示图片..详细参考[消息类型](https://doc.rentsoft.cn/server_doc/server_doc.html#%E6%B6%88%E6%81%AF%E7%B1%BB%E5%9E%8B%E6%A0%BC%E5%BC%8F%E6%8F%8F%E8%BF%B0)格式描述文档 |
|  sessionType   |  int  |   是   | 发送的消息是单聊还是群聊,单聊为1，群聊为2                    |
|isOnlineOnly|bool|  否  |改字段设置为true时候，发送的消息服务器不会存储，接收者在线才会收到并存储到本地，不在线该消息丢失，当消息的类型为113->typing时候，接收者本地也不会做存储|
|offlinePushInfo|json对象|否|离线推送的具体内容，如果不填写，使用服务器默认推送标题|
|title|string|否|推送的标题|
|desc|string|否|推送的具体描述|
|ex|string|否|扩展字段|
|iOSPushSound|string|否|IOS的推送声音|
|iOSBadgeCount|bool|否|IOS推送消息是否计入桌面图标未读数|


### **返回示例**

  ```json
{
    "errCode": 0, 
    "errMsg": "", 
    "data": {
        "serverMsgID": "", 
        "clientMsgID": "", 
        "sendTime": 1645697804432
    }
}
  ```

###  **返回参数**

| 参数名      |  类型  | 说明                                           |
| :---------- | :----: | ---------------------------------------------- |
| errCode     |  int   | 0成功，非0失败                                 |
| errMsg      | string | 错误信息                                       |
| sendTime    |  int   | 消息发送的具体时间，具体为毫秒的时间戳         |
| serverMsgID | string | 服务器生成的消息的唯一ID                       |
| clientMsgID | string | 客户端生成的消息唯一ID，默认情况使用这个为主键 |

## 消息类型格式描述

### **简要描述**

 - 管理员消息发送字段中contentType支持的消息类型说明以及消息content的具体字段说明。

### **ContentType消息类型说明**

| ContentType值 | 类型说明          |
| :-----------: | :---------------- |
|      101      | 文本消息          |
|      102      | 图片消息          |
|      103      | 音频消息          |
|      104      | 视频消息          |
|      105      | 文件消息          |
|      106      | 群聊中的@类型消息 |
|      107      | 合并转发类型消息  |
|      108      | 名片消息          |
|      109      | 地理位置类型消息  |
|      110      | 自定义消息        |
|      111      | 撤回类型消息      |
|      112      | 已读回执类型消息  |
|      114      | 引用类型消息      |



### **Content具体内容**

- content内部为具体的json对象，不同的消息类型是不同的json对象

#### **文本消息**

  ```json
{
    ...,
    "content": {
        "text": "nihao"
    },
    ....
}
  ```

| 参数名 | 必选 |  类型  | 说明               |
| :----: | :--: | :----: | :----------------- |
|  text  |  是  | string | 文本消息的具体内容 |

  #### **自定义消息**

  ```json
{
    ...,
    "content": {
        "data": "", 
        "description": "", 
        "extension": ""
    },
    ....
}
  ```

|   参数名    |    类型     | 必选 | 说明                                               |
| :---------: | :---------: | :--: | :------------------------------------------------- |
|    data     | json string |  是  | 用户自定义的消息为json对象转换后的string           |
| description | json string |  否  | 扩展的描述信息为json对象转换后的string，可以不使用 |
|  extension  | json string |  否  | 扩展字段，暂时不使用                               |



