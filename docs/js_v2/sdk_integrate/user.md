# 用户信息相关API

| 方法            | 描述                   |
| --------------- | ---------------------- |
| getUsersInfo    | 根据userID获取用户资料 |
| getSelfUserInfo | 获取当前登录用户资料   |
| setSelfInfo     | 修改当前登录用户资料   |



## getUsersInfo

> 根据用户ID获取用户资料，可批量获取。

- Example:

  ```js
  const userIDList = ["1f8e0d51d335301d"]
  openIM.getUsersInfo(userIDList).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:

  | Name       | Type     | Required | Description |
  | ---------- | -------- | -------- | ----------- |
  | userIDList | string[] | true     | 用户ID数组  |


- CallBack:

  | Name | Type   | Description                    |
  | ---- | ------ | ------------------------------ |
  | data | string | [用户信息对象]()列表Json字符串 |


## getSelfUserInfo

> 获取当前登录用户资料。

- Example:

  ```typescript
  openIM.getSelfUserInfo().then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- CallBack:

  | Name | Type   | Description                            |
  | ---- | ------ | -------------------------------------- |
  | data | string | 当前登录[用户个人信息对象]()Json字符串 |



## setSelfInfo

> 修改当前用户资料。

- Example:

  ```typescript
  const selfInfo:PartialUserItem = {
    userID:"1234",
    nickname: "blooming",//用户昵称
    faceURL: "xxx.com",//头像URL
    gender:1,//性别，0未知，1男，2女
    phoneNumber:"123",//用户手机号
    birth:1642584426,//用户生日
    email:"123@qq.com",//用户邮箱
    ex:"ex"//用户扩展信息
  }
  openIM.setSelfInfo(selfInfo).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:

  | Name        | Type   | Required | Description           |
  | ----------- | ------ | -------- | --------------------- |
  | userID      | string | true     | 用户ID                |
  | nickname    | string | false    | 用户昵称              |
  | faceURL     | string | false    | 用户头像              |
  | gender      | number | false    | 性别：0未知，1男，2女 |
  | phoneNumber | string | false    | 手机号                |
  | birth       | number | false    | 出生日期（时间戳）    |
  | email       | string | false    | 邮箱地址              |
  | ex          | string | false    | 扩展字段              |

- CallBack:

  | Name | Type   | Description          |
  | ---- | ------ | -------------------- |
  | data | string | 用户资料是否修改成功 |



# 用户相关回调

> 所有事件相关常量均封装在SDK的`CbEvents`中，可直接进行引入使用。

| 事件              | 描述                     | 响应                       |
| ----------------- | ------------------------ | -------------------------- |
| OnSelfInfoUpdated | 当前登录用户个人信息改变 | 用户个人信息对象json字符串 |
