# 初始化

初始化SDK的listener（OnInitSDKListener）回调是在调用login方法后才开始进行。

```objc
  /* 初始化
 * @param platform 平台
 * @param apiAddr    SDK的api地。如http:xxx:10000
 * @param wsAddr     SDK的web socket地址。如： ws:xxx:17778
 * @param dataDir    数据存储路径，默认documents
 * @param logLevel   默认6
 * @param oss        默认cos，minio填写'minio'
 */
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths.firstObject stringByAppendingString:@"/"];
    
    BOOL initSuccess = [OIMManager.manager initSDK:iOS
                                           apiAdrr:@"xxxx:10000"
                                            wsAddr:@"xxxx:17778"
                                           dataDir:path
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

# 切换到前台

```objc
    [OIMManager.manager wakeUpWithOnSuccess:^(NSString * _Nullable data) {
        
    } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        
    }];
```

# SDK监听回调
```objc
/// IMSDK 主核心回调
@protocol OIMSDKListener <NSObject>
@optional
/*
 *  SDK 正在连接到服务器
 */
- (void)onConnecting;

/*
 * SDK 已经成功连接到服务器
 */
- (void)onConnectSuccess;

/*
 * SDK 连接服务器失败
 */
- (void)onConnectFailed:(NSInteger)code err:(NSString*)err;

/*
 * 当前用户被踢下线，此时可以 UI 提示用户
 */
- (void)onKickedOffline;

/*
 * 在线时票据过期：此时您需要生成新的 UserToken 并再次重新登录。
 */
- (void)onUserTokenExpired;

@end
```

- 初始化监听回调事件

| event              | 说明          |
| ------------------ | ------------- |
| onConnectFailed    | 连接失败      |
| onConnectSuccess   | 连接成功      |
| onConnecting       | 连接中        |
| onKickedOffline    | 被踢下线      |
| onSelfInfoUpdated  | 修改个人信息  |
| onUserTokenExpired | 账号token过期 |
