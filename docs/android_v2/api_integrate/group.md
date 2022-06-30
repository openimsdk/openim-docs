#### GroupManager（组/群关系管理）

| 方法                         | 描述                                     |
| ---------------------------- | ---------------------------------------- |
| setGroupListener             | 组关系监听                               |
| inviteUserToGroup            | 邀请进组，直接进组无需同意               |
| kickGroupMember              | 移除组成员                               |
| getGroupMembersInfo          | 查询组成员资料                           |
| getGroupMemberList           | 分页获取组成员列表                       |
| getJoinedGroupList           | 查询已加入的组列表                       |
| createGroup                  | 创建一个组                               |
| setGroupInfo                 | 编辑组资料                               |
| getGroupsInfo                | 查询组信息                               |
| joinGroup                    | 申请加入组，需要通过管理员/群组同意。    |
| quitGroup                    | 退出组                                   |
| transferGroupOwner           | 转移组拥有者权限                         |
| getRecvGroupApplicationList  | 作为群主或者管理员，收到的群成员入群申请 |
| getSendGroupApplicationList  | 获取自己发出的入群申请记录               |
| acceptGroupApplication       | 管理员或者群主同意某人进入某群           |
| refuseGroupApplication       | 管理员或者群主拒绝某人进入某群           |
| dismissGroup                 | 解散群                                   |
| changeGroupMute              | 开启群禁言，所有群成员禁止发言           |
| changeGroupMemberMute        | 禁言群成员                               |
| setGroupMemberNickname       | 设置群成员昵称                           |
| searchGroups                 | 查询群                                   |



#### inviteUserToGroup（邀请进组）

直接进组无需同意。

被邀请者收到OnJoinedGroupAdded

群成员（不包括被邀请者）收到OnGroupMemberAdded 

```
    /**
     * 邀请进群
     *
     * @param groupId 群组ID
     * @param uidList 被邀请的用户id列表
     * @param reason  邀请说明
     * @param base    callback List<{@link GroupInviteResult}>>
     */
    public void inviteUserToGroup(OnBase<List<GroupInviteResult>> base, String groupId, List<String> uidList, String reason) 
```



#### kickGroupMember（移除组成员）

被踢者收到OnJoinedGroupDeleted

群成员收到OnGroupMemberDeleted 

```
    /**
     * 踢出群
     *
     * @param groupId 群组ID
     * @param uidList 被踢出群的用户id列表
     * @param reason  说明
     * @param base    callback List<{@link GroupInviteResult}>>
     */
    public void kickGroupMember(OnBase<List<GroupInviteResult>> base, String groupId, List<String> uidList, String reason)
```



#### getGroupMembersInfo（查询组成员信息）

```
    /**
     * 批量获取群成员信息
     *
     * @param groupId 群组ID
     * @param uidList 群成员ID集合
     * @param base    callback List<{@link GroupMembersInfo}>
     **/
    public void getGroupMembersInfo(OnBase<List<GroupMembersInfo>> base, String groupId, List<String> uidList)
```



#### getGroupMemberList（组成员列表）

```
    /**
     * 获取群成员
     *
     * @param groupId 群组ID
     * @param filter  过滤成员 1普通成员, 2群主，3管理员，0所有
     * @param offset  偏移量
     * @param count   每页数量
     */
    public void getGroupMemberList(OnBase<List<GroupMembersInfo>> base, String groupId, int filter, int offset, int count)
```



#### getJoinedGroupList（获取已加入的群组）

```
    /**
     * 获取已加入的群列表
     *
     * @param base callback List<{@link GroupInfo}></>
     */
    public void getJoinedGroupList(OnBase<List<GroupInfo>> base)
```




#### createGroup（创建组）

初始成员收到OnJoinedGroupAdded

```
    /**
     * 创建群
     *
     * @param groupName    群名称
     * @param faceURL      群icon
     * @param notification 群公告
     * @param introduction 群简介
     * @param groupType
     * @param ex           其他信息
     * @param list         List<{@link GroupMemberRole}> 创建群是选择的成员. setRole：0:普通成员 2:管理员；1：群主
     */
    public void createGroup(OnBase<GroupInfo> base, String groupName, String faceURL, String notification, String introduction, int groupType, String ex, List<GroupMemberRole> list) 
```



#### setGroupInfo（修改组信息）

群成员收到OnGroupInfoChanged

```
    /**
     * 设置或更新群资料
     *
     * @param groupID      群ID
     * @param groupName    群名称
     * @param faceURL      群icon
     * @param notification 群公告
     * @param introduction 群简介
     * @param ex           其他信息
     * @param base         callback String
     */
    public void setGroupInfo(OnBase<String> base, String groupID, String groupName, String faceURL, String notification, String introduction, String ex)
```



#### getGroupsInfo（根据id查询组信息）

```
    /**
     * 批量获取群资料
     *
     * @param gidList 群ID集合
     * @param base    callback List<{@link GroupInfo}>
     */
    public void getGroupsInfo(OnBase<List<GroupInfo>> base, List<String> gidList)
```



#### joinGroup（申请入群组）

需要通过管理员同意。

申请者收到OnGroupApplicationAdded

群主+管理员收到OnGroupApplicationAdded 

```
    /**
     * 申请加入群组
     *
     * @param gid    群组ID
     * @param reason 请求原因
     * @param base   callback String
     */
    public void joinGroup(OnBase<String> base, String gid, String reason)
```



#### quitGroup（退出组）

退出者收到OnJoinedGroupDeleted

群成员收到OnGroupMemberDeleted

```
   /**
     * 退群
     *
     * @param gid  群组ID
     * @param base callback String
     */
    public void quitGroup(OnBase<String> base, String gid) 
```



#### transferGroupOwner（群转让）

```
    /**
     * 转让群主
     *
     * @param gid  群组ID
     * @param uid  新拥有者（群主）id
     * @param base callback String
     */
    public void transferGroupOwner(OnBase<String> base, String gid, String uid)
```



#### getRecvGroupApplicationList（收到的入群申请）

作为群主或者管理员，获取收到的群成员申请进群列表。

```
    /**
     * 收到群申请列表
     *
     * @param base callback {@link GroupApplicationInfo}
     */
    public void getRecvGroupApplicationList(OnBase<List<GroupApplicationInfo>> base)
```



#### getSendGroupApplicationList（发出的入群申请）

```
    /**
     * 发出群申请列表
     *
     * @param base callback {@link GroupApplicationInfo}
     */
    public void getSendGroupApplicationList(OnBase<List<GroupApplicationInfo>> base)
```



#### acceptGroupApplication（接受入群申请）

申请者收到OnJoinedGroupAdded  OnGroupApplicationAccepted

群成员（不包括申请者）收到OnGroupMemberAdded

审批者（群主或者管理员）收到OnGroupMemberAdded OnGroupApplicationAccepted

```
    /**
     * 接受入群申请
     *
     * @param gid       群ID
     * @param uid       申请入群的用户ID
     * @param handleMsg 说明
     * @param base      callback String
     */
    public void acceptGroupApplication(OnBase<String> base, String gid, String uid, String handleMsg)
```



#### refuseGroupApplication（拒绝入群申请）

申请者收到OnGroupApplicationRejected

审批者（群主或者管理员）收到OnGroupApplicationRejected 

```
    /**
     * 拒绝入群申请
     *
     * @param gid       群ID
     * @param uid       申请入群的用户ID
     * @param handleMsg 说明
     * @param base      callback String
     */
    public void refuseGroupApplication(OnBase<String> base, String gid, String uid, String handleMsg)
```



#### dismissGroup（解散群）

```
    /**
     * 解散群
     *
     * @param gid 群ID
     */
    public void dismissGroup(OnBase<String> base, String gid)
```



#### changeGroupMute（开启群禁言）

```
    /**
     * 开启群禁言
     *
     * @param gid  群ID
     * @param mute true开启
     */
    public void changeGroupMute(OnBase<String> base, String gid, boolean mute)
```



#### changeGroupMemberMute（对群成员禁言)

```
    /**
     * 禁言群成员
     *
     * @param gid     群ID
     * @param uid     群成员userID
     * @param seconds 禁言时间s
     */
    public void changeGroupMemberMute(OnBase<String> base, String gid, String uid, long seconds)
```



#### setGroupMemberNickname（修改成员组昵称）

```
    /**
     * 修改所在群的昵称
     *
     * @param gid           群ID
     * @param uid           群成员userID
     * @param groupNickname 群内显示名称
     */
    public void setGroupMemberNickname(OnBase<String> base, String gid, String uid, String groupNickname)
```



#### searchGroups（搜索群）

```
    /**
     * 根据关键词搜索群组
     * 群ID跟群名二者互斥
     *
     * @param keywordList       关键词
     * @param isSearchGroupID   是通过群组id进行查询
     * @param isSearchGroupName 是通过群名称查询
     */
    public void searchGroups(OnBase<List<GroupInfo>> base, List<String> keywordList, boolean isSearchGroupID, boolean isSearchGroupName) 
```


