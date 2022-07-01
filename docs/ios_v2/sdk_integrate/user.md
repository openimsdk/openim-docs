#### UserManager（用户信息管理）

| 方法            | 描述                     |
| --------------- | ------------------------ |
| setUserListener | 当前登录用户信息变更监听 |
| getUsersInfo    | 根据userID获取用户资料   |
| getSelfUserInfo | 获取当前登录用户资料     |
| setSelfInfo     | 修改当前登录用户资料     |



#### getUsersInfo（根据用户ID批量获取用户信息）

```
        [OIMManager.manager getUsersInfo:@[] // 用户ID数组
                               onSuccess:^(NSArray<OIMUserInfo *> * _Nullable userInfos) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];

```



#### getSelfUserInfo（获取当前登录用户的资料）

```
        [OIMManager.manager getSelfInfoWithOnSuccess:^(OIMUserInfo * _Nullable userInfo) {

        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### setSelfInfo（修改当前用登录户资料）

会触发当用户的onSelfInfoUpdated回调，以及好友的onFriendInfoChanged、onConversationChanged回调。

```
        OIMUserInfo *info = [OIMUserInfo new];
        info.nickname = @"nickname";
        info.email = @"xx@xx.com";
        info.faceURL = @"xxxx";
        
        [OIMManager.manager setSelfInfo:info
                              onSuccess:^(NSString * _Nullable data) {
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        }];

```

