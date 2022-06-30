#### FriendshipManager（好友关系管理）

| 方法                         | 描述                                               |
| ---------------------------- | -------------------------------------------------- |
| setFriendshipListener        | 好友关系监听                                       |
| getFriendsInfo               | 查询好友信息                                       |
| addFriend                    | 发送一个好友请求，需要对方调用同意申请才能成为好友 |
| getRecvFriendApplicationList | 获取别人加我为好友的申请                           |
| getSendFriendApplicationList | 获取我发出的好友申请                               |
| getFriendList                | 获取好友列表，返回的列表包含了已拉入黑名单的好友   |
| setFriendRemark              | 设置好友备注                                       |
| addBlacklist                 | 加入黑名单                                         |
| getBlacklist                 | 获取黑名单列表                                     |
| removeBlacklist              | 从黑名单移除                                       |
| checkFriend                  | 检查友好关系                                       |
| deleteFriend                 | 删除好友                                           |
| acceptFriendApplication      | 接受好友请求                                       |
| refuseFriendApplication      | 拒绝好友请求                                       |
| searchFriends                | 查好友                                             |



#### OnFriendshipListener（好友关系监听）

| 方法                        | 描述                       |
| --------------------------- | -------------------------- |
| onFriendApplicationRejected | 发出或收到的好友申请被拒绝 |
| onFriendApplicationDeleted  | 发出或收到的好友申请被删除 |
| onFriendApplicationAdded    | 发出或收到的好友申请被添加 |
| onFriendApplicationAccepted | 发出或收到的好友申请已同意 |
| onFriendAdded               | 好友被添加                 |
| onFriendDeleted             | 好友被删除                 |
| onFriendInfoChanged         | 朋友的资料发生变化         |
| onBlacklistDeleted          | 从黑名单删除               |
| onBlacklistAdded            | 拉入黑名单                 |



#### getFriendsInfo（根据userID查询好友资料）

```
 OpenIM.iMManager.friendshipManager.getFriendsInfo(
      uidList: [], // userId列表
    ).then((list) {
      // List<UserInfo>
 });
```



#### addFriend（发起好友申请）

主动申请者收到OnFriendApplicationAdded

被添加者收到OnFriendApplicationAdded 

```
 OpenIM.iMManager.friendshipManager.addFriend(
      uid: "", // 用户id
      reason: '', // 发起好友申请的描述信息
 ).then((_) {
    // 成功
 }).catchError((_){
 		// 失败
 });
```



#### checkFriend（检查是否是好友）

```
OpenIM.iMManager.friendshipManager.checkFriend(
      uidList: [], // userID 列表
  ).then((list) {
      // List<FriendshipInfo>
 });
```



#### deleteFriend（删除好友）

操作者收到OnFriendDeleted

```
OpenIM.iMManager.friendshipManager.deleteFriend(
    uid: '', // userID
 ).then((_) {
    // 成功
 }).catchError((_){
    // 失败
 });
```



#### setFriendRemark（好友备注设置）

操作者收到OnFriendInfoChanged

```
 OpenIM.iMManager.friendshipManager.setFriendRemark(
      uid: '', // 好友userID
      remark: '', // 备注名
 ).then((_) {
    // 成功
 }).catchError((_){
    // 失败
 });
```



#### getFriendList（好友列表）

返回的数据里包含已拉入黑名单的好友，可以根据isBlacklist字段筛选。

```
OpenIM.iMManager.friendshipManager.getFriendList().then((list){
      //  List<UserInfo> 好友信息列表
});
```



#### getRecvFriendApplicationList（收到的好友申请）

```
 OpenIM.iMManager.friendshipManager.getRecvFriendApplicationList().then((list) {
      // List<FriendApplicationInfo> 申请列表
 });
```



#### getSendFriendApplicationList（发出的好友申请）

```
OpenIM.iMManager.friendshipManager.getSendFriendApplicationList().then((list){
      // List<FriendApplicationInfo> 申请列表
 });
```



#### addBlacklist（拉黑好友）

操作者收到OnBlackAdded

```
 OpenIM.iMManager.friendshipManager.addBlacklist(
      uid: "", // 好友userID
 ).then((_) {
    // 成功
 }).catchError((_){
 		// 失败
 });
```



#### getBlacklist（黑名单）

```
OpenIM.iMManager.friendshipManager.getBlacklist().then((list){
      // List<UserInfo>
   });
```



#### removeBlacklist（移除黑名单）

操作者收到OnBlackDeleted

```
OpenIM.iMManager.friendshipManager.removeBlacklist(
      uid: "", // userID
 ).then((_) {
    // 成功
 }).catchError((_){
    // 失败
 });
```



#### acceptFriendApplication（接受好友申请）

操作者收到OnFriendApplicationAccepted、OnFriendAdded

申请者收到OnFriendApplicationAccepted、OnFriendAdded

```
OpenIM.iMManager.friendshipManager.acceptFriendApplication(
      uid: "", // userID
      handleMsg: '', // 备注信息
 ).then((_) {
    // 成功
 }).catchError((_){
    // 失败
 });
```



#### refuseFriendApplication（拒绝好友申请）

操作者收到OnFriendApplicationRejected

申请者收到OnFriendApplicationRejected 

```
 OpenIM.iMManager.friendshipManager.refuseFriendApplication(
      uid: "", // userID
      handleMsg: '', // 备注信息
 ).then((_) {
    // 成功
 }).catchError((_){
 		// 失败
 });
```



#### searchFriends（搜索好友）

```
var list = await OpenIM.iMManager.friendshipManager.searchFriends(
      keywordList: [searchCtrl.text.trim()],//关键词
      isSearchNickname: true,//按昵称查找
      isSearchRemark: true,//按备注查找
 );
```