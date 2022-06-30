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


#### 泛型回调接口（所有方法都会回调此接口）

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

#### getFriendsInfo（根据userID查询好友资料）

```
    /**
     * 根据用户id，批量查询好友资料
     *
     * @param uidList 好友id集合
     * @param base    callback List<{@link UserInfo}>
     */
    public void getFriendsInfo(OnBase<List<UserInfo>> base, List<String> uidList)
```



#### addFriend（发起好友申请）

主动申请者收到OnFriendApplicationAdded

被添加者收到OnFriendApplicationAdded 

```
    /**
     * 发送好友申请
     *
     * @param uid        对方userID
     * @param reqMessage 请求消息
     * @param base       callback String
     */
    public void addFriend(OnBase<String> base, String uid, String reqMessage)
```



#### checkFriend（检查是否是好友）

```
    /**
     * 根据用户id检查好友关系
     *
     * @param uidList 用户ID列表
     * @param base    callback List<{@link UserInfo}>
     */
    public void checkFriend(OnBase<List<FriendshipInfo>> base, List<String> uidList)
```



#### deleteFriend（删除好友）

操作者收到OnFriendDeleted

```
    /**
     * 删除好友
     *
     * @param uid  用户ID
     * @param base callback String
     */
    public void deleteFriend(OnBase<String> base, String uid)
```



#### setFriendRemark（好友备注设置）

操作者收到OnFriendInfoChanged

```
    /**
     * 修改好友资料
     *
     * @param uid    用户id
     * @param remark 备注名
     * @param base   callback String
     */
    public void setFriendRemark(OnBase<String> base, String uid, String remark)
```



#### getFriendList（好友列表）

返回的数据里包含已拉入黑名单的好友，可以根据isBlacklist字段筛选。

```
   /**
     * 好友列表
     * 返回的好友里包含了已拉入黑名单的好友
     * 需要根据字段isInBlackList做筛选，isInBlackList==1 已拉入黑名单
     *
     * @param base callback List<{@link UserInfo}>
     */
    public void getFriendList(OnBase<List<UserInfo>> base)
```



#### getRecvFriendApplicationList（收到的好友申请）

```
    /**
     * 收到好友申请列表
     *
     * @param base callback List<{@link UserInfo}>
     */
    public void getRecvFriendApplicationList(OnBase<List<FriendApplicationInfo>> base)
```



#### getSendFriendApplicationList（发出的好友申请）

```
    /**
     * 发出好友申请列表
     *
     * @param base callback List<{@link UserInfo}>
     */
    public void getSendFriendApplicationList(OnBase<List<FriendApplicationInfo>> base)
```



#### addBlacklist（拉黑好友）

操作者收到OnBlackAdded

```
    /**
     * 加入黑名单
     *
     * @param uid  用户ID
     * @param base callback String
     */
    public void addBlacklist(OnBase<String> base, String uid)
```



#### getBlacklist（黑名单）

```
    /**
     * 黑名单
     *
     * @param base callback List<{@link UserInfo}>
     */
    public void getBlacklist(OnBase<List<UserInfo>> base) 
```



#### removeBlacklist（移除黑名单）

操作者收到OnBlackDeleted

```
    /**
     * 从黑名单删除
     *
     * @param uid  用户ID
     * @param base callback String
     */
    public void removeBlacklist(OnBase<String> base, String uid) 
```



#### acceptFriendApplication（接受好友申请）

操作者收到OnFriendApplicationAccepted、OnFriendAdded

申请者收到OnFriendApplicationAccepted、OnFriendAdded

```
    /**
     * 接受好友请求
     *
     * @param uid       用户ID
     * @param handleMsg 处理信息
     * @param base      callback String
     */
    public void acceptFriendApplication(OnBase<String> base, String uid, String handleMsg) 
```



#### refuseFriendApplication（拒绝好友申请）

操作者收到OnFriendApplicationRejected

申请者收到OnFriendApplicationRejected 

```
    /**
     * 拒绝好友申请
     *
     * @param uid       用户ID
     * @param handleMsg 处理信息
     * @param base      callback String
     */
    public void refuseFriendApplication(OnBase<String> base, String uid, String handleMsg)
```

