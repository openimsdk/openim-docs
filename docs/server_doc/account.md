## **注册新用户**

### **简要描述**

 - 用户注册调用 AppServer，AppServer 调用 IMServer（auth/user_register）创建新用户。

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
|   uid    |  是  | string | 用户 ID，最大长度 64 字符，必须保证一个 APP 内唯一           |
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
|   uid    |  是  | string | 用户 ID，最大长度 64 字符，必须保证一个 APP 内唯一。         |

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

## **获取用户在线状态**

### **简要描述**

 -   AppServer通过调用获取用户在线状态接口可以获取多个用户在线状态。

### **请求URL**


 - `http://x.x.x.x:10000/user/get_users_online_status


### **请求方式**


 - `POST`

### **请求示例**

  ```json
{
    "operationID": "545454", 
    "userIDList": [
        "18349115126", 
        "45", 
        "17396220460", 
        "sadsdf"
    ], 
    "secret": "tuoyun"
}
  ```

### **请求参数**

|   参数名    | 必选 |   类型   | 说明                                                         |
| :---------: | :--: | :------: | :----------------------------------------------------------- |
| operationID |  是  |  string  | 操作id，用随机字符串                                         |
|   secret    |  是  |  string  | AppServer 请求 IMToken 用到的秘钥，最大长度 32 字符，必须保证 AppServer 和 IMServer 秘钥一致， secret 泄露有风险，最好保存在用户服务器端 |
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

