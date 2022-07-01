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

objectStorage：图片服务器有cos（腾讯云），minio，oss（阿里云）可选



#### 回调接口

```
public interface OnBase<T> {
    /**
     * 失败
     * @param code 错误码
     * @param error 错误信息
     */
    void onError(int code, String error);

    /**
     * 成功
     * @param data 返回的实体
     */
    void onSuccess(T data);
}
```

```
    /**
     * 初始化sdk
     * 注：在创建图片，语音，视频，文件等需要路径参数的消息体时，
     * 如果选择的是非全路径方法如：createSoundMessage（全路径方法为：createSoundMessageFromFullPath）,
     * 需要将文件自行拷贝到dbPath目录下，如果此时文件路径为 apath+"/sound/a.mp3"，则参数path的值为：/sound/a.mp3。
     * 如果选择的全路径方法，路径为你文件的实际路径不需要再拷贝。
     *
     * @param apiUrl        SDK的API接口地址。如：http:xxx:10000
     * @param wsUrl         SDK的web socket地址。如： ws:xxx:17778
     * @param storageDir    数据存储目录路径
     * @param logLevel      日志等级，如：6
     * @param objectStorage 图片上传配置 如：cos
     * @param listener      SDK初始化监听
     * @return boolean   true成功; false失败
     */
    public boolean initSDK(String apiUrl, String wsUrl, String storageDir, int logLevel, String objectStorage, OnConnListener listener) 


**
 * 只有在调用sdk的login方法后才开始回调
 */
public interface OnConnListener {

    /**
     * 连接服务器失败
     * 可以提示用户当前网络连接不可用
     */
    void onConnectFailed(long code, String error);

    /**
     * 已经成功连接到服务器
     */
    void onConnectSuccess();

    /**
     * 正在连接到服务器
     * 适合在 UI 上展示“正在连接”状态。
     */
    void onConnecting();

    /**
     * 当前用户被踢下线
     * 此时可以 UI 提示用户“您已经在其他端登录了当前账号，是否重新登录？”
     */
    void onKickedOffline();

    /**
     * 登录票据已经过期
     * 请使用新签发的 UserSig 进行登录。
     */
    void onUserTokenExpired();
}

```



#### login（登录）

```
    /**
     * 登录
     *
     * @param uid   用户id
     * @param token 用户token
     * @param base  callback String
     */
    public void login(OnBase<String> base, String uid, String token)
```



#### logout（ 登出）

```
    /**
     * 登出
     */
    public void logout(OnBase<String> base)
```



#### getLoginStatus（ 查询登录状态）

```
   /**
     * 查询登录状态
     */
    public long getLoginStatus()
```
### wakeUp（唤醒socket通信，当app从后台回到前台恢复通信）
   
```
   public void wakeUp(OnBase<String> base)
```

### uploadFile （上传图片到服务器  ）
```
    /**
     * 上传文件到服务器
     *
     * @param path 路径
     */
    public void uploadFile(OnFileUploadProgressListener listener, String path)
```
