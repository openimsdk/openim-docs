#### UserManager（用户信息管理）

| 方法            | 描述                     |
| --------------- | ------------------------ |
| setUserListener | 当前登录用户信息变更监听 |
| getUsersInfo    | 根据userID获取用户资料   |
| getSelfUserInfo | 获取当前登录用户资料     |
| setSelfInfo     | 修改当前登录用户资料     |



#### OnUserListener（用户信息监听）

| 方法              | 描述                     |
| ----------------- | ------------------------ |
| onSelfInfoUpdated | 当前登录用户资料变更回调 |



#### getUsersInfo（根据用户ID批量获取用户信息）

```
OpenIM.iMManager.userManager.getUsersInfo(
      uidList: [], // 用户ID集合
   ).then((userInfoList) {
      // 用户信息列表
  });
```



#### getSelfUserInfo（获取当前登录用户的资料）

```
 OpenIM.iMManager.userManager.getSelfUserInfo().then((userInfo){
      // 返回当前登录用户的资料
  });
```



#### setSelfInfo（修改当前用登录户资料）

会触发当用户的onSelfInfoUpdated回调，以及好友的onFriendInfoChanged、onConversationChanged回调。

```
  OpenIM.iMManager.userManager.setSelfInfo(
      nickname: '',  // 昵称
      faceURL: '',  // 头像
      gender: 0,  // 性别: 男1，女0
      phoneNumber: '', // 手机号
      email: '', //邮箱
      birth: 0,  //生日
      ex: '',  // 其他信息
    );
```

