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
| uploadImage      | 上传图片到服务器                              |

#### initSDK（初始化SDK）

```
OpenIM.iMManager.initSDK(
    platform: 0, // 平台，参照IMPlatform类,
    apiAddr: "", // SDK的API接口地址。如：http://xxx:10000
    wsAddr: "",  // SDK的web socket地址。如： ws://xxx:17778
    dataDir: "", // 数据存储路径。如：var apath =(await getApplicationDocumentsDirectory()).path
    objectStorage: 'cos', // 图片服务器默认'cos'
    logLevel: 6, // 日志等级，默认值6
    listener: OnConnectListener(
      onConnectSuccess: () {
        // 已经成功连接到服务器
      },
      onConnecting: () {
        // 正在连接到服务器，适合在 UI 上展示“正在连接”状态。
      },
      onConnectFailed: (code, errorMsg) {
        // 连接服务器失败，可以提示用户当前网络连接不可用
      },
      onUserSigExpired: () {
        // 登录票据已经过期，请使用新签发的 UserSig 进行登录。
      },
      onKickedOffline: () {
        // 当前用户被踢下线，此时可以 UI 提示用户“您已经在其他端登录了当前账号，是否重新登录？”
      },
    ),
  ).then((value){
      if(value == true){
        // 初始化成功
      }
  });
```



#### login（登录）

```
OpenIM.iMManager.login(
      uid: "", // uid来自于自身业务服务器
      token: "", // token需要业务服务器根据secret向OpenIM服务端交换获取
    ).then((userInfo) {
      // 返回当前登录用户的资料
    });
```



#### logout（ 登出）

```
 OpenIM.iMManager.logout().then((_){
      // 退出成功
 });
```



#### getLoginUserInfo（获取当前登录用户的资料）

```
OpenIM.iMManager.getLoginUserInfo().then((userInfo){
     // 当前登录用户的信息
 });
```



#### getLoginUserID（获取当前登录用户的ID）

```
 OpenIM.iMManager.getLoginUserID().then((userID){
     // 当前登录用户的ID
  });
```

