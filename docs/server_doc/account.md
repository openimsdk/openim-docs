# **注册新用户**

## **简要描述**

 - 用户注册新账号时，AppServer 调用此api在OpenIM系统中创建新用户。

## **请求URL**


 - `http://x.x.x.x:10000/auth/user_register`


## **请求方式**


 - `POST`

## **请求示例**

  ```json
 {
    "secret": "tuoyun",
    "platform": 1,
    "userID": "openIM1111",
    "nickname": "2222",
    "faceUrl": "https://oss.com.cn/head", 
    "gender": 1,
    "phoneNum": "18666667777",
    "birth":1640692941,
    "email": "xxxx@qq.com",
    "ex": "xxx",
    "operationID": "123111111"
}
  ```

## **请求参数说明详见**

|   参数名    | 必选 | 说明 |
| :---------: | :--: | :--- |
|   secret    |  是  |      |
|  platform   |  是  |      |
|   userID    |  是  |      |
| operationID |  是  |      |

## **返回示例**

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

  ## **返回参数**说明详见

# **获取 token**

## **简要描述**

AppServer调用此api获取token，IMSDK在login时需传入token，调用管理员相关api，也需要通过此接口获取管理员token。

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

|   参数名    | 必选 | 说明 |
| :---------: | :--: | :--- |
|   secret    |  是  |      |
|  platform   |  是  |      |
|   userID    |  是  |      |
| operationID |  是  |      |

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

## **获取用户在线状态**

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

|   参数名    | 必选 | 说明 |
| :---------: | :--: | :--- |
| operationID |  是  |      |
| userIDList  |  是  |      |


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

| 参数名               | 类型     | 说明                                                         |
| :------------------- | :------- | ------------------------------------------------------------ |
| detailPlatformStatus | json数组 | 用户在哪几个平台在线                                         |
| status               | string   | 在线状态，目前只有offline和online两种                        |
| platform             | string   | 目前平台有"IOS"，"Android"，"Windows"，"OSX"，"Web"， "Linux" |

