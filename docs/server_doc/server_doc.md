# **服务器API**

服务器端API是由OpenIM后端提供的一系列HTTP(s)接口，用于业务系统和IM对接。比如以APP管理员的身份导入好友、创建群组、发送消息等。

## **注册新用户**

### **简要描述**

 - 用户注册调用 AppServer，AppServer 调用 IMServer（auth/user_register）创建新用户。管理员需要调用注册接口获取自己管理员token，然后利用管理员token调用其他的服务器API

### **请求URL**


 - `http://x.x.x.x:10000/auth/user_register`


### **请求方式**


 - `POST`

### **请求示例**

  ```json
 {
  "secret": "tuoyun", 
  "platform": 1, 
  "uid": "d5645454517", 
  "name": "张三", 
  "icon": "https:oss.com.cn/head", 
  "gender": 1, 
  "mobile": "17812457845", 
  "birth": "1998.12.15", 
  "email": "xxxx@qq.com", 
  "ex": "xxx"
 }
  ```

### **请求参数**

|  参数名  | 必选 |  类型  | 说明                                                         |
| :------: | :--: | :----: | :----------------------------------------------------------- |
|  secret  |  是  | string | AppServer 请求 IMToken 用到的秘钥，最大长度 32 字符，必须保证 AppServer 和 IMServer 秘钥一致， secret 泄露有风险，最好保存在用户服务器端 |
| platform |  是  |  int   | 平台类型 iOS 1, Android 2, Windows 3, OSX 4, WEB 5, 小程序 6，linux 7 |
|   uid    |  是  | string | 用户 ID，最大长度 64 字符，必须保证一个 APP 内唯一,如果是管理员注册则需要填写和IM服务器配置config.yaml的appmanageruid保持一致，可以自行修改配置文件中的appmanageruid |
|   name   |  是  | string | 用户昵称，最大长度 64 字符，可设置为空字符串                 |
|   icon   |  否  | string | 用户头像，最大长度 1024 字节，可设置为空字符串               |
|  gender  |  否  |  int   | 用户性别，0 表示未知，1 表示男，2 女表示女，其它会报参数错误 |
|  mobile  |  否  | string | 用户 mobile，最大长度 32 字符，非中国大陆手机号码需要填写国家代码(如美国：+1-xxxxxxxxxx)或地区代码(如香港：+852-xxxxxxxx)，可设置为空字符串 |
|  birth   |  否  | string | 用户生日，最大长度 16 字符，可设置为空字符串                 |
|  email   |  否  | string | 用户 email，最大长度 64 字符，可设置为空字符串               |
|    ex    |  否  | string | 用户名片扩展字段，最大长度 1024 字符，用户可自行扩展，建议封装成 JSON 字符串，也可以设置为空字符串 |

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

| 参数名      | 类型   | 说明            |
| :---------- | :----- | --------------- |
| errCode     | int    | 0成功，非0失败  |
| errMsg      | string | 错误信息        |
| uid         | string | 注册用户的Uid   |
| token       | string | 生成的用户token |
| expiredTime | int    | 过期时间戳      |

## **换取 IMToken**

### **简要描述**

  AppServer 通过调用 IMServer（auth/user_token）创建或刷新 token，AppClientSDK 在连接 IMServer 时需要填入 token，IMServer 会校验 token 有效性。

### **请求URL**

-  ` http://x.x.x.x:10000/auth/user_token`


### **请求方式**

 -  `POST`

  ### **请求示例**

  ```json
 {
  "secret": "tuoyun", 
  "platform": 1, 
  "uid": "d5645454517"
 }
  ```

### **请求参数**

|  参数名  | 必选 |  类型  | 说明                                                         |
| :------: | :--: | :----: | :----------------------------------------------------------- |
|  secret  |  是  | string | AppServer 请求 IMToken 用到的秘钥，最大长度 32 字符，必须保证 AppServer 和 IMServer 秘钥一致， secret 泄露有风险，最好保存在用户服务器端 |
| platform |  是  |  int   | 平台类型 iOS 1, Android 2, Windows 3, OSX 4, WEB 5, 小程序 6，linux 7 |
|   uid    |  是  | string | 用户 ID，最大长度 64 字符，必须保证一个 APP 内唯一。 如果是管理员注册则需要填写和IM服务器配置config.yaml的appmanageruid保持一致，可以自行修改配置文件中的appmanageruid |

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

| 参数名      | 类型   | 说明            |
| :---------- | :----- | --------------- |
| errCode     | int    | 0成功，非0失败  |
| errMsg      | string | 错误信息        |
| uid         | string | 注册用户的Uid   |
| token       | string | 生成的用户token |
| expiredTime | int    | 过期时间戳      |

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
| token        | 是   | string | 从header中获取，此token必须以APP管理员身份调用auth/user_token生成 |
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
| token       | 是   | string   | 从header中获取，此token必须以APP管理员身份调用auth/user_token生成 |
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
| token       | 是   | string   | 从header中获取，此token必须以APP管理员身份调用auth/user_token生成 |
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

- APP管理员使用户A、B成为好友

### **请求URL**

- `http://x.x.x.x:10000/friend/import_friend`

### **请求方式**

- POST

### **请求示例 **

```
{
	"uid":"21979710c3fe454d",
	"operationID": "1111111222",
	"ownerUid" : "f732156059eeb5d0"
}
```

### **请求参数**

| 参数名      | 必选 | 类型   | 说明                                                         |
| :---------- | :--- | :----- | ------------------------------------------------------------ |
| uid         | 是   | string | A用户uid                                                     |
| operationID | 是   | string | 操作id，用随机字符串                                         |
| ownerUid    | 是   | string | B用户uid                                                     |
| token       | 是   | string | 从header中获取，此token必须以APP管理员身份调用auth/user_token生成 |

### **返回示例**

```
{
    "errCode": 0,
    "errMsg": ""
}
```

### **返回参数说明**

| 参数名  | 类型   | 说明           |
| :------ | :----- | -------------- |
| errCode | int    | 0成功，非0失败 |
| errMsg  | string | 错误信息       |



## 加入黑名单

### **简要描述**

- APP管理员包uid添加到ownerUid的黑名单中

### **请求URL**

- `http://x.x.x.x:10000/friend/add_blacklist`

### **请求方式**

- POST

### 请求示例

```
{	"uid":"21979710c3fe454d",	"operationID": "1111111222",	"ownerUid" : "f732156059eeb5d0"}
```

### **请求参数**

| 参数名      | 必选 | 类型   | 说明                                                         |
| :---------- | :--- | :----- | ------------------------------------------------------------ |
| uid         | 是   | string | 被拉黑的用户id                                               |
| operationID | 是   | string | 操作id，用随机字符串                                         |
| token       | 是   | string | 从header中获取，此token必须以APP管理员身份调用auth/user_token生成 |
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
	"uid":"21979710c3fe454d",
	"operationID": "1111111222",
	"name":"sssssssssskkkkk"
}
```

### **请求参数**

| 参数名      | 必选 | 类型   | 说明                                                         |
| :---------- | :--- | :----- | ------------------------------------------------------------ |
| token       | 是   | string | 从header中获取，此token必须以APP管理员身份调用auth/user_token生成 |
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
|     token     |  是  |  string  | 注：放置于POST请求Header中，此token必须以APP管理员身份调用auth/user_token生成 |
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
    "uidList":["123","3434"]
}
  ```

### **请求参数**

|   参数名    | 必选 |   类型   | 说明                                                         |
| :---------: | :--: | :------: | :----------------------------------------------------------- |
| operationID |  是  |  string  | 操作id，用随机字符串                                         |
|    token    |  是  |  string  | 注：放置于POST请求Header中，此token必须以APP管理员身份调用auth/user_token生成 |
|   uidList   |  是  | json数组 | 需要获取详细信息的用户Uid数组                                |


### **返回示例**

  ```json
{
    "errCode": 0,
    "errMsg": ""，
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
|    token    |  是  | string | 注：放置于POST请求Header中，此token必须以APP管理员身份调用auth/user_token生成 |


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

## **发送单聊群聊消息**

### **简要描述**

 - 管理员通过后台接口发送单聊群聊消息。

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

|     参数名     | 必选 |   类型   | 说明                                                         |
| :------------: | :--: | :------: | :----------------------------------------------------------- |
|  operationID   |  是  |  string  | 操作id，用随机字符串                                         |
|     token      |  是  |  string  | 注：放置于POST请求Header中，此token必须以APP管理员身份调用auth/user_token生成 |
|     sendID     |  是  |  string  | 发送者ID                                                     |
|     recvID     |  是  |  string  | 接收者ID，单聊为用户ID，如果是群聊，则为群ID                 |
| senderNickName |  否  |  string  | 发送者昵称                                                   |
| senderFaceURL  |  否  |  string  | 发送者头像                                                   |
|   forceList    |  否  | string[] | 当聊天类型为群聊时，使用@指定强推用户列表                    |
|    content     |  是  |  string  | 消息的具体内容，内部是json 对象，其他消息的详细字段请参考[消息类型](https://doc.rentsoft.cn/server_doc/server_doc.html#%E6%B6%88%E6%81%AF%E7%B1%BB%E5%9E%8B%E6%A0%BC%E5%BC%8F%E6%8F%8F%E8%BF%B0)格式描述文档 |
|  contentType   |  是  |   int    | 消息类型，101表示文本，102表示图片..详细参考[消息类型](https://doc.rentsoft.cn/server_doc/server_doc.html#%E6%B6%88%E6%81%AF%E7%B1%BB%E5%9E%8B%E6%A0%BC%E5%BC%8F%E6%8F%8F%E8%BF%B0)格式描述文档 |
|  sessionType   |  是  |   int    | 发送的消息是单聊还是群聊,单聊为1，群聊为2                    |


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



