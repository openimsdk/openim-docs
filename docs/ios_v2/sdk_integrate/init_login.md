### IMManager（初始化管理）

| 方法             | 描述                                          |
| ---------------- | --------------------------------------------- |
| initSDK          | 初始化SDK                                     |
| unInitSDK        | 反初始化SDK                                   |
| login            | 登录                                          |
| logout           | 登出                                          |
| getLoginStatus   | 获取登录状态                                  |
| getLoginUserID   | 登录者用户ID                                  |
| getLoginUserInfo | 登录者用户资料                                |
| wakeUp           | 唤醒socket通信（当app从后台回到前台恢复通信） |

#### initSDK（初始化SDK）

objectStorage：图片服务器有cos（腾讯云），minio，oss（阿里云）可选

```
  /* 初始化
 * @param apiAddr       SDK的api地。如http://xxx:10002
 * @param wsAddr        SDK的web socket地址。如： ws://xxx:10001
 * @param dataDir       数据存储路径，默认/Documents
 * @param logLevel      默认6
 * @param objectStorage 默认cos，minio填写'minio'
 */
  BOOL initSuccess = [OIMManager.manager initSDKWithApiAdrr:API_ADDRESS
                                                       wsAddr:WS_ADDRESS
                                                      dataDir:nil
                                                     logLevel:6
                                                objectStorage:nil
                                                 onConnecting:^{
        
        NSLog(@"\nconnecting");
    } onConnectFailure:^(NSInteger code, NSString * _Nullable msg) {
        NSLog(@"\n connect failure");
    } onConnectSuccess:^{
        NSLog(@"\nconnect success");
    } onKickedOffline:^{
        NSLog(@"\nkicked offline");
    } onUserTokenExpired:^{
        NSLog(@"\nuser token expired");
    }];
    
    NSLog(@"初始化成功与否：%d", initSuccess);

```



#### login（登录）

```
        [OIMManager.manager login:@"" // uid来自于自身业务服务器
                            token:@""  // token需要业务服务器向OpenIM服务端交换获取
                        onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];

```



#### logout（ 登出）

```
        [OIMManager.manager login:@"" // uid来自于自身业务服务器
                            token:@""  // token需要业务服务器根据secret向OpenIM服务端交换获取
                        onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];

```



#### getLoginUserInfo（获取当前登录状态）

```
        [OIMManager.manager getLoginStatus];
```



#### getLoginUserInfo（获取当前登录用户的资料）

```
        [OIMManager.manager getSelfInfoWithOnSuccess:^(OIMUserInfo * _Nullable userInfo) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];
```



#### getLoginUserID（获取当前登录用户的ID）

```
        [OIMManager.manager getLoginUid];

```

#### wakeUp（app从后台回到前台）

```
    [OIMManager.manager wakeUpWithOnSuccess:^(NSString * _Nullable data) {
        
    } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        
    }];

```

