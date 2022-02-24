# OpenIM字段说明

|    参数名    |   类型   | 最大字符串长度限制 | 说明                                                         | 取值范围                                                     |
| :----------: | :------: | ------------------ | :----------------------------------------------------------- | ------------------------------------------------------------ |
|    secret    |  string  | 32                 | OpenIM秘钥，服务端配置文件config.yaml的secret字段，注意安全保存 | 字符串即可                                                   |
|   platform   |   int    |                    | 用户登录或注册的平台类型                                     | iOS 1, Android 2, Windows 3, OSX 4, WEB 5, 小程序 6，linux 7 |
|    userID    |  string  | 64                 | 用户 ID，必须保证IM内唯一                                    | 字符串即可                                                   |
|   nickname   |  string  | 255                | 用户昵称或者群昵称                                           | 字符串即可                                                   |
|   faceURL    |  string  | 255                | 用户头像或者群头像url，根据上下文理解                        |                                                              |
|    gender    |   int    |                    | 用户性别                                                     | 1 表示男，2 表示女                                           |
| phoneNumber  |  string  | 32                 | 用户手机号码，包括地区，(如香港：+852-xxxxxxxx)，            |                                                              |
|    birth     |  uint32  |                    | 用户生日，Unix时间戳（秒）                                   |                                                              |
|    email     |  string  | 64                 | 邮箱地址                                                     |                                                              |
|      ex      |  string  | 1024               | 扩展字段，用户可自行扩展，建议封装成 JSON 字符串             |                                                              |
| operationID  |  string  |                    | 操作ID，保持唯一，建议用当前时间微秒+随机数                  |                                                              |
| expiredTime  |   int    |                    | 过期时间，单位（秒）                                         |                                                              |
|  roleLevel   |   int    |                    | 群内成员类型                                                 | 1普通成员，2群主，3管理员                                    |
|  groupType   |   int    |                    | 群类型                                                       | 目前统一填0                                                  |
| ownerUserID  |  string  | 64                 | 群主UserID                                                   |                                                              |
|  groupName   |  string  | 255                | 群名称                                                       |                                                              |
| notification |  string  | 255                | 群公告                                                       |                                                              |
| introduction |  string  | 255                | 群介绍                                                       |                                                              |
|  memberList  | json数组 |                    | 成员列表                                                     |                                                              |
|    reason    |  string  | 64                 | 原因，比如踢人等原因                                         |                                                              |
|    token     |  string  |                    | 调用api时设置到请求header中                                  |                                                              |
|  userIDList  | json数组 |                    | 用户的userID列表                                             |                                                              |







