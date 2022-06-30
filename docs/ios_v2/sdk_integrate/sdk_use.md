#### 1，目前采用cocoapds获取sdk，添加依赖到Podfile：

       pod 'OpenIMSDK'

SDK版本参考：https://github.com/OpenIMSDK/Open-IM-SDK-iOS.git

#### 2，引入模块

      @import OpenIMSDK;

#### 3，初始化

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


#### 4，登录

```
    [OIMManager.manager login:LOGIN_USER_ID
                            token:LOGIN_USER_TOKEN
                        onSuccess:^(NSString * _Nullable data) {

    } onFailure:^(NSInteger code, NSString * _Nullable msg) {

    }];
```



#### 注：

1，SDK只能初始化一次。

2，其他api调用必须保证登录回调成功后操作。
