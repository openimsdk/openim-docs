#### UserManager（用户信息管理）

| 方法            | 描述                     |
| --------------- | ------------------------ |
| setUserListener | 当前登录用户信息变更监听 |
| getUsersInfo    | 根据userID获取用户资料   |
| getSelfUserInfo | 获取当前登录用户资料     |
| setSelfInfo     | 修改当前登录用户资料     |



#### getUsersInfo（根据用户ID批量获取用户信息）

```
   /**
     * 根据uid 批量查询用户信息
     *
     * @param uidList 用户id列表
     * @param base    callback List<{@link UserInfo}>
     */
    public void getUsersInfo(OnBase<List<UserInfo>> base, List<String> uidList) 
```



#### getSelfUserInfo（获取当前登录用户的资料）

```
    /**
     * 获取当前用户信息
     */
    public void getSelfUserInfo(OnBase<UserInfo> base)
```



#### setSelfInfo（修改当前用登录户资料）

会触发当用户的onSelfInfoUpdated回调，以及好友的onFriendInfoChanged、onConversationChanged回调。

```
    /**
     * 修改资料
     *
     * @param nickname    名字
     * @param faceURL     头像
     * @param gender      性别
     * @param phoneNumber 手机号
     * @param birth       出生日期
     * @param email       邮箱
     * @param base        callback String
     */
    public void setSelfInfo(OnBase<String> base, String nickname, String faceURL, int gender, int appMangerLevel, String phoneNumber, long birth, String email, String ex) 
```

