# OpenIM字段说明

|    参数名    |  类型  | 最大字符串长度限制 | 说明                                                         | 取值范围                                                     |
| :----------: | :----: | ------------------ | :----------------------------------------------------------- | ------------------------------------------------------------ |
|    secret    | string | 32                 | OpenIM秘钥，服务端配置文件config.yaml的secret字段            | 字符串即可                                                   |
|  platformID  |  int   |                    | 用户登录时的终端类型                                         | iOS 1, Android 2, Windows 3, OSX 4, WEB 5, 小程序 6，linux 7 |
|    userID    | string | 64                 | 用户ID，必须保证IM内唯一                                     | 字符串即可                                                   |
|   nickname   | string | 255                | 昵称                                                         | 字符串即可                                                   |
|   faceURL    | string | 255                | 头像链接                                                     |                                                              |
|      ex      | string | 1024               | 扩展字段，可自行扩展，建议封装成 JSON 字符串                 |                                                              |
| operationID  | string |                    | 操作ID，用于定位问题，保持唯一，建议用当前时间和随机数       |                                                              |
| expiredTime  |  int   |                    | 过期时间，单位（秒）                                         |                                                              |
|  roleLevel   |  int   |                    | 群内成员角色                                                 | 1普通成员，2群主，3管理员                                    |
|  groupType   |  int   |                    | 群类型                                                       | 目前统一填0                                                  |
| ownerUserID  | string | 64                 | 群主用户ID                                                   |                                                              |
|  groupName   | string | 255                | 群名称                                                       |                                                              |
| notification | string | 255                | 群公告                                                       |                                                              |
| introduction | string | 255                | 群介绍                                                       |                                                              |
|    reason    | string | 64                 | 原因                                                         |                                                              |
|    token     | string |                    | OpenIM用户令牌，业务后台验证用户账号密码后，通过user_token来获取 |                                                              |







