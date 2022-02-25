## 注册新用户

### **简要描述**

 - 用户注册新账号时，AppServer 调用此在OpenIM系统中创建新用户。

### **请求URL**


 - `http://x.x.x.x:10000/auth/user_register`


### **请求方式**


 - `POST`

### **请求示例**

  ```json
 {
    "secret": "tuoyun",
    "platform": 1,
    "userID": "openIM1111",
    "nickname": "2222",
    "faceURL": "https://oss.com.cn/head", 
    "gender": 1,
    "phoneNumber": "18666667777",
    "birth":1640692941,
    "email": "xxxx@qq.com",
    "ex": "xxx",
    "operationID": "123111111"
}
  ```

### **请求参数**

|   参数名    |  类型  | 必选 | 说明               |
| :---------: | :----: | ---- | :----------------- |
|   secret    | string | 是   | OpenIM秘钥         |
|  platform   |  int   | 是   | 用户注册的平台类型 |
|   userID    | string | 是   | 用户 ID            |
|  nickname   | string | 是   | 用户昵称           |
|   faceURL   | string | 否   | 用户头像URL        |
|   gender    |  int   | 否   | 用户性别           |
| phoneNumber | string | 否   | 用户手机号码       |
|    birth    |  int   | 否   | 用户生日           |
|    email    | string | 否   | 邮箱地址           |
|     ex      | string | 否   | 扩展字段           |
| operationID | string | 是   | 操作ID             |

### **返回示例**

  ```json
{
    "errCode": 0,
    "errMsg": "",
    "data": {
        "userID": "openIM1111",
        "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVSUQiOiJvcGVuSU0xMTExIiwiUGxhdGZvcm0iOiJJT1MiLCJleHAiOjE2NDYyODAxMDQsIm5iZiI6MTY0NTY3NTMwNCwiaWF0IjoxNjQ1Njc1MzA0fQ.xhqmRBC3XpMwMQL2i3sRh6JArRZg1PFjFjRl9N1Kc9o",
        "expiredTime": 1646280104
    }
}
  ```

### **返回参数**

| 参数名      | 类型   | 说明                  |
| :---------- | :----- | --------------------- |
| errCode     | int    | 0成功，非0失败        |
| errMsg      | string | 错误信息              |
| userID      | string | 用户ID                |
| token       | string | 用户token             |
| expiredTime | int    | token过期时间戳（秒） |

## 获取用户token

### **简要描述**

AppServer调用此接口获取token，IMSDK在login时需传入token

### **请求URL**

-  ` http://x.x.x.x:10000/auth/user_token`


### **请求方式**

 -  `POST`

### **请求示例**

  ```json
 {
    "secret": "tuoyun",
    "platform": 1,
    "userID": "openIM1111",
    "operationID": "asdfasdfsadf"
}
  ```

### **请求参数**

|   参数名    | 类型   | 必选 | 说明               |
| :---------: | ------ | :--: | :----------------- |
|   secret    | string |  是  | OpenIM秘钥         |
|  platform   | int    |  是  | 用户登录的平台类型 |
|   userID    | string |  是  | 用户ID             |
| operationID | string |  是  | 操作ID             |

### **返回示例**

   ```json
{
    "errCode": 0,
    "errMsg": "",
    "data": {
        "userID": "openIM1111",
        "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVSUQiOiJvcGVuSU0xMTExIiwiUGxhdGZvcm0iOiJJT1MiLCJleHAiOjE2NDYyOTM2NTksIm5iZiI6MTY0NTY4ODg1OSwiaWF0IjoxNjQ1Njg4ODU5fQ.C5v6RS6yAPh0-4ZeQHmKon1rwC2GmZfc09xYoi67SOM",
        "expiredTime": 1646293659
    }
}
   ```

### **返回参数**

| 参数名      | 类型   | 说明                  |
| :---------- | :----- | --------------------- |
| errCode     | int    | 0成功，非0失败        |
| errMsg      | string | 错误信息              |
| userID      | string | 用户ID                |
| token       | string | 用户token             |
| expiredTime | int    | token过期时间戳（秒） |

