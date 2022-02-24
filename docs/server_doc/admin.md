## **换取管理员IMToken**

### **简要描述**

  AppServer 通过调用 IMServer（auth/user_token）获取或刷新管理员token，在进行以下所有的管理员操作的时候，必须传入管理员token进行校验。

### **请求URL**

-  ` http://x.x.x.x:10000/auth/user_token`


### **请求方式**

 -  `POST`

  ### **请求示例**

  ```json
 {
  "secret": "tuoyun", 
  "platform": 8, 
  "uid": "d5645454517"
 }
  ```

### **请求参数**

|  参数名  | 必选 |  类型  | 说明                                                         |
| :------: | :--: | :----: | :----------------------------------------------------------- |
|  secret  |  是  | string | AppServer 请求 IMToken 用到的秘钥，最大长度 32 字符，必须保证 AppServer 和 IMServer 秘钥一致， secret 泄露有风险，最好保存在用户服务器端 |
| platform |  是  |  int   | 管理员默认填8                                                |
|   uid    |  是  | string | 管理员uid，IM启动时会根据IM服务器配置文件config/config.yaml的appManagerUid初始化管理员；此处的uid必须为配置文件的appManagerUid的其中一个 |

### **返回示例**

   ```json
 {
 "errCode": 0, 
 "errMsg": "", 
 "data": {
     "uid": "", 
     "token": "", 
     "expiredTime": 0
 }
}
   ```

   ### **返回参数**

| 参数名      | 类型   | 说明              |
| :---------- | :----- | ----------------- |
| errCode     | int    | 0成功，非0失败    |
| errMsg      | string | 错误信息          |
| uid         | string | 管理员的Uid       |
| token       | string | 生成的管理员token |
| expiredTime | int    | 过期时间戳        |

## 创建群组

### **简要描述**

- APP管理员创建群组，需指定群主

### **请求URL**

- `http://x.x.x.x:10000/group/create_group`

### **请求数据方式**

- POST

### **请求示例**

```
 {
    "memberList":[{"uid":"21979710c3fe454d","setRole":1},{"uid":"89b8924ea455a642","setRole":2}],
    "groupName":"groupName_on10",
    "introduction":"简介",
    "notification":"公告",
    "faceUrl":"url",
    "operationID":"1"
}
```

### **请求参数**

| 参数名       | 必选 | 类型   | 说明                                                         |
| :----------- | :--- | :----- | ------------------------------------------------------------ |
| memberList   | 是   | 数组   | 指定初始群成员  setRole 0为普通成员 1为群主 2为管理员        |
| groupName    | 是   | string | 群聊的名字                                                   |
| introduction | 否   | string | 群简介                                                       |
| notification | 否   | string | 群公告                                                       |
| faceUrl      | 否   | string | 群头像                                                       |
| token        | 是   | string | 从header中获取，此token必须以APP管理员身份调用auth/user_token生成，具体参考[换取管理员IMToken]() |
| operationID  | 是   | string | 操作id，用随机字符串                                         |

### **返回示例**

```
 {
    "errCode": 0,
    "errMsg": "",
    "data": {
        "groupID": "05dc84b52829e82242a710ecf999c72c"
    }
}
```

### **返回参数**

| 参数名  | 类型     | 说明                                   |
| :------ | :------- | -------------------------------------- |
| errCode | int      | 0成功，非0失败                         |
| errMsg  | string   | 错误信息                               |
| data    | json对象 | 返回创建群结果 groupID为创建成功的群id |



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
	"groupID": "f21f9f84c14f3a978352ff339f1a800a",
	"uidList": [
		 "f732156059eeb5d0"
	],
	"reason": "reason",
	"operationID": "1111111111111 "
}
```

### **请求参数**

| 参数名      | 必选 | 类型     | 说明                                                         |
| :---------- | :--- | :------- | ------------------------------------------------------------ |
| groupID     | 是   | string   | 群id                                                         |
| uidList     | 是   | json数组 | 被邀请进群的用户uid列表                                      |
| reason      | 是   | string   | 进群理由                                                     |
| token       | 是   | string   | 从header中获取，此token必须以APP管理员身份调用auth/user_token生成，具体参考[换取管理员IMToken]() |
| operationID | 是   | string   | 操作id，用随机字符串                                         |

### **返回示例**

```
{
    "errCode": 0,
    "errMsg": "ok",
    "data": [
        {
            "uid": "f732156059eeb5d0",
            "result": 0
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
	"groupID": "56d274fad86685be3ea4ee70498eca61",
	"uidListInfo": [{
		"userId": "21979710c3fe454d"
	}],
	"operationID": "1111111111111 "
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
            "uid": "21979710c3fe454d",
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
    "uidList": [
        "21979710c3fe454d", 
        "3434344"
    ], 
    "operationID": "1111111222", 
    "ownerUid": "f732156059eeb5d0"
}
```

### **请求参数**

| 参数名      | 必选 | 类型   | 说明                                                         |
| :---------- | :--- | :----- | ------------------------------------------------------------ |
| uidList     | 是   | string | 要建立好友关系的好友列表                                     |
| operationID | 是   | string | 操作id，用随机字符串                                         |
| ownerUid    | 是   | string | A用户uid                                                     |
| token       | 是   | string | 从header中获取，此token必须以APP管理员身份调用auth/user_token生成，具体参考[换取管理员IMToken]() |

### **返回示例**

```
{
    "errCode": 0, 
    "errMsg": "", 
    "failedUidList": [
        "21979710c3fe454d", 
        "3434344"
    ]
}
```

### **返回参数说明**

| 参数名        | 类型      | 说明                  |
| :------------ | :-------- | --------------------- |
| errCode       | int       | 0成功，非0失败        |
| errMsg        | string    | 错误信息              |
| failedUidList | json 数组 | 建立好友失败的uid列表 |





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
    "uid": "21979710c3fe454d", 
    "operationID": "1111111222", 
    "ownerUid": "f732156059eeb5d0"
}
```

### **请求参数**

| 参数名      | 必选 | 类型   | 说明                                                         |
| :---------- | :--- | :----- | ------------------------------------------------------------ |
| uid         | 是   | string | 被拉黑的用户id                                               |
| operationID | 是   | string | 操作id，用随机字符串                                         |
| token       | 是   | string | 从header中获取，此token必须以APP管理员身份调用auth/user_token生成，具体参考[换取管理员IMToken]() |
| ownerUid    |      |        | 用户id                                                       |

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
    "uid": "21979710c3fe454d", 
    "operationID": "1111111222", 
    "name": "sssssssssskkkkk"
}
```

### **请求参数**

| 参数名      | 必选 | 类型   | 说明                                                         |
| :---------- | :--- | :----- | ------------------------------------------------------------ |
| token       | 是   | string | 从header中获取，此token必须以APP管理员身份调用auth/user_token生成，具体参考[换取管理员IMToken]() |
| operationID | 是   | string | 操作id，用随机字符串                                         |
| name        | 否   | string | 用户昵称                                                     |
| icon        | 否   | string | 头像URL                                                      |
| gender      | 否   | int    | 性别，0未知，1男，2女                                        |
| mobile      | 否   | string | 用户手机号                                                   |
| birth       | 否   | string | 用户生日                                                     |
| email       | 否   | string | 用户邮箱                                                     |
| ex          | 否   | string | 用户扩展信息                                                 |
| uid         | 是   | string | 被更新的用户id                                               |

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
    "deleteUidList": [
        "123", 
        "343", 
        "456"
    ]
}
  ```

### **请求参数**

|    参数名     | 必选 |   类型   | 说明                                                         |
| :-----------: | :--: | :------: | :----------------------------------------------------------- |
|  operationID  |  是  |  string  | 操作id，用随机字符串                                         |
|     token     |  是  |  string  | 注：放置于POST请求Header中，此token必须以APP管理员身份调用auth/user_token生成，具体参考[换取管理员IMToken]() |
| deleteUidList |  是  | json数组 | 需要删除的uid数组列表                                        |


### **返回示例**

  ```json
{
    "errCode": 0, 
    "errMsg": "", 
    "failedUidList": [
        "122", 
        "466"
    ]
}
  ```

###  **返回参数**

| 参数名        | 类型     | 说明              |
| :------------ | :------- | ----------------- |
| errCode       | int      | 0成功，非0失败    |
| errMsg        | string   | 错误信息          |
| failedUidList | json数组 | 删除失败的用户Uid |

## **获取用户详细信息**

### **简要描述**

 - 管理员调用获取用户详细信息接口可以获取多个用户注册的详细信息。

### **请求URL**


 - `http://x.x.x.x:10000/user/get_user_info`


### **请求方式**


 - `POST`

### **请求示例**

  ```json
{
    "operationID": "1111111222", 
    "uidList": [
        "123", 
        "3434"
    ]
}
  ```

### **请求参数**

|   参数名    | 必选 |   类型   | 说明                                                         |
| :---------: | :--: | :------: | :----------------------------------------------------------- |
| operationID |  是  |  string  | 操作id，用随机字符串                                         |
|    token    |  是  |  string  | 注：放置于POST请求Header中，此token必须以APP管理员身份调用auth/user_token生成，具体参考[换取管理员IMToken]() |
|   uidList   |  是  | json数组 | 需要获取详细信息的用户Uid数组                                |


### **返回示例**

  ```json
{
    "errCode": 0, 
    "errMsg": "", 
    "data": [
        {
            "uid": "06577eb8ed751416", 
            "name": "Oxcupb....cool", 
            "icon": "", 
            "gender": 0, 
            "mobile": "", 
            "birth": "", 
            "email": "", 
            "ex": ""
        }, 
        {
            "uid": "1308", 
            "name": "Allen", 
            "icon": "https://yt-bullet-s.oss-ap-southeast-1.aliyuncs.com/1-10.png", 
            "gender": 0, 
            "mobile": "", 
            "birth": "", 
            "email": "", 
            "ex": ""
        }, 
        {
            "uid": "1514", 
            "name": "angel 1514", 
            "icon": "https://indie-project-earthangle.oss-cn-beijing.aliyuncs.com/earthAngel/20210827043129233-6806.jpg", 
            "gender": 0, 
            "mobile": "", 
            "birth": "", 
            "email": "", 
            "ex": ""
        }
    ]
}
  ```

### **返回参数**

| 参数名  | 类型         | 说明                   |
| :------ | :----------- | ---------------------- |
| errCode | int          | 0成功，非0失败         |
| errMsg  | string       | 错误信息               |
| data    | json对象数组 | 获取的用户详细信息列表 |

## **获取用户在线状态**

### **简要描述**

 - 管理员调用获取用户在线状态接口可以获取多个用户在线状态。

### **请求URL**


 - `http://x.x.x.x:10000/manager/get_users_online_status


### **请求方式**


 - `POST`

### **请求示例**

  ```json
{
    "operationID": "545454", 
    "userIDList": [
        "18349115126","45","17396220460","sadsdf"
    ]
}
  ```

### **请求参数**

|   参数名    | 必选 |   类型   | 说明                                                         |
| :---------: | :--: | :------: | :----------------------------------------------------------- |
| operationID |  是  |  string  | 操作id，用随机字符串                                         |
|    token    |  是  |  string  | 注：放置于POST请求Header中，此token必须以APP管理员身份调用auth/user_token生成，具体参考[换取管理员IMToken]() |
| userIDList  |  是  | json数组 | 需要获取在线状态的用户Uid数组，单次数量不超过200             |


### **返回示例**

  ```json
{
    "errCode": 0,
    "errMsg": "",
    "successResult": [
        {
            "userID": "18349115126",
            "status": "online",
            "detailPlatformStatus": [
                {
                    "platform": "Android",
                    "status": "online"
                }
            ]
        },
        {
            "userID": "45",
            "status": "offline"
        },
        {
            "userID": "17396220460",
            "status": "online",
            "detailPlatformStatus": [
                {
                    "platform": "Web",
                    "status": "online"
                }
            ]
        },
        {
            "userID": "sadsdf",
            "status": "offline"
        }
    ]
}
  ```

### **返回参数**

| 参数名        | 类型         | 说明                                                         |
| :------------ | :----------- | ------------------------------------------------------------ |
| errCode       | int          | 0成功，非0失败                                               |
| errMsg        | string       | 错误信息                                                     |
| successResult | json对象数组 | 获取的用户在线状态详细信息                                   |
| userID        | string       | 用户ID                                                       |
| status        | string       | 在线状态，目前只有offline和online两种                        |
| platform      | string       | 目前平台有"IOS"，"Android"，"Windows"，"OSX"，"Web"， "Linux" |



## **获取IM注册的所有用户(Uid)**

### **简要描述**

 - 管理员调用获取IM已经注册的所有用户的UID接口。

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

|   参数名    | 必选 |  类型  | 说明                                                         |
| :---------: | :--: | :----: | :----------------------------------------------------------- |
| operationID |  是  | string | 操作id，用随机字符串                                         |
|    token    |  是  | string | 注：放置于POST请求Header中，此token必须以APP管理员身份调用auth/user_token生成，具体参考[换取管理员IMToken]() |


### **返回示例**

  ```json
{
    "errCode": 0, 
    "errMsg": "", 
    "uidList": [
        "122", 
        "466"
    ]
}
  ```

###  **返回参数**

| 参数名  | 类型     | 说明                      |
| :------ | :------- | ------------------------- |
| errCode | int      | 0成功，非0失败            |
| errMsg  | string   | 错误信息                  |
| uidList | json数组 | 已经注册的所有用户Uid数组 |

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
    "userIDList":["18349115126","111","222","17396220460"]
}
  ```

### **请求参数**

|   参数名    | 必选 |  类型  | 说明                                                         |
| :---------: | :--: | :----: | :----------------------------------------------------------- |
| operationID |  是  | string | 操作id，用随机字符串  |                                       |
|    token    |  是  | string | 注：放置于POST请求Header中，此token必须以APP管理员身份调用auth/user_token生成，具体参考[换取管理员IMToken]() |
| userIDList |  是  | json字符串数组 | 需要check的用户Uid数组，单次数量不超过100 |      


### **返回示例**

  ```json
{
    "result": [
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
| result | json对象数组 | 每个用户的信息查询结果对象数组|
| accountStatus  | string   | 用户注册状态，registered代表已经注册， unregistered代表未注册                  |


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
    "senderNickName": "张三", 
    "senderFaceURL": "http://www.head.com", 
    "forceList": [
        "122", 
        "223"
    ], 
    "content": {
        "text": "nihao"
    }, 
    "contentType": 101, 
    "sessionType": 1
}
  ```

### **请求参数**

|     参数名     | 必选 |  类型  | 说明                                                         |
| :------------: | :--: | :----: | :----------------------------------------------------------- |
|  operationID   |  是  | string | 操作id，用随机字符串                                         |
|     token      |  是  | string | 注：放置于POST请求Header中，此token必须以APP管理员身份调用auth/user_token生成，具体参考[换取管理员IMToken]() |
|     sendID     |  是  | string | 发送者ID                                                     |
|     recvID     |  是  | string | 接收者ID，单聊为用户ID，如果是群聊，则为群ID                 |
| senderNickName |  否  | string | 发送者昵称|
| senderFaceURL  |  否  |  string  | 发送者头像|
|senderPlatformID|否|int|发送者平台号，模拟用户发送时填写， 1->IOS,2->Android,3->Windows,4->OSX,5->Web,5->MiniWeb,7->Linux|
|   forceList    |  否  | string[] | 当聊天类型为群聊时，使用@指定强推用户列表                    |
|    content     |  是  |  string  | 消息的具体内容，内部是json 对象，其他消息的详细字段请参考[消息类型](https://doc.rentsoft.cn/server_doc/server_doc.html#%E6%B6%88%E6%81%AF%E7%B1%BB%E5%9E%8B%E6%A0%BC%E5%BC%8F%E6%8F%8F%E8%BF%B0)格式描述文档 |
|  contentType   |  是  |   int    | 消息类型，101表示文本，102表示图片..详细参考[消息类型](https://doc.rentsoft.cn/server_doc/server_doc.html#%E6%B6%88%E6%81%AF%E7%B1%BB%E5%9E%8B%E6%A0%BC%E5%BC%8F%E6%8F%8F%E8%BF%B0)格式描述文档 |
|  sessionType   |  是  |   int    | 发送的消息是单聊还是群聊,单聊为1，群聊为2                    |
|isOnlineOnly|否|bool|改字段设置为true时候，发送的消息服务器不会存储，接收者在线才会收到并存储到本地，不在线该消息丢失，当消息的类型为113->typing时候，接收者本地也不会做存储|


### **返回示例**

  ```json
{
    "errCode": 0, 
    "errMsg": "", 
    "sendTime": 156454545565, 
    "msgID": "454dfddfjjfg"
}
  ```

###  **返回参数**

| 参数名   |  类型  | 说明                                   |
| :------- | :----: | -------------------------------------- |
| errCode  |  int   | 0成功，非0失败                         |
| errMsg   | string | 错误信息                               |
| sendTime |  int   | 消息发送的具体时间，具体为纳秒的时间戳 |
| msgID    | string | 消息的唯一ID                           |

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

|   参数名    | 必选 |    类型     | 说明                                               |
| :---------: | :--: | :---------: | :------------------------------------------------- |
|    data     |  是  | json string | 用户自定义的消息为json对象转换后的string           |
| description |  否  | json string | 扩展的描述信息为json对象转换后的string，可以不使用 |
|  extension  |  否  | json string | 扩展字段，暂时不使用                               |



