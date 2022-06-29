## 好友管理相关接口

OpenIM提供好友关系托管，比如好友申请，同意，以及好友获取等，OpenIM在客户端本地存储好友关系，并结合消息通知机制，按需调用后台接口，确保本地和服务端数据一致。同时利用监听机制，把数据变化通过异步回调传达调用方。OpenIM在收发消息时，默认不检查好友关系，您可以在配置文件中自行修改。OpenIM好友关系是双向关系，A添加B为好友后，则A在B的好友列表中，B也在A的好友列表中，A删除B，仅仅只是删除A的好友列表，而B的好友列表不受影响。同样，黑名单也类似。

| SDK                            | 描述                                                     |
| :----------------------------- | :------------------------------------------------------- |
| [GetDesignatedFriendsInfo]     | 获取指定好友的信息                                       |
| [GetFriendList]                | 获取所有的好友列表                                       |
| [SearchFriends]                | 通过关键词搜索好友                                       |
| [CheckFriend]                  | 检查是否好友关系                                         |
| [AddFriend]                    | 发起添加好友请求                                         |
| [SetFriendRemark]              | 设置好友备注                                             |
| [DeleteFriend]                 | 删除好友（单向删除）                                     |
| [GetRecvFriendApplicationList] | 获取我收到的添加好友申请列表                             |
| [GetSendFriendApplicationList] | 获取我发起的的添加好友申请列表                           |
| [AcceptFriendApplication]      | 同意好友申请                                             |
| [RefuseFriendApplication]      | 拒绝好友申请                                             |
| [SetFriendListener]            | 设置好友、黑名单相关监听，用于UI层实时感知数据变化并刷新 |

## 监听说明

好友监听器的作用：调用方设置好友监听，好友关系的变化会通过OpenIM消息机制实时同步到需要感知的在线用户，包括用户的其他端，调用方根据回调事件做相关的数据处理。

比如用户B在Android端添加用户A为好友，用户A（所有在线的终端）收到B的好友申请，则A调用GetRecvFriendApplicationList获取收到的好友申请列表，刷新界面。同时，用户B在线其他的终端比如PC端也会收到通知，B调用GetSendFriendApplicationList获取发起的好友申请列表，刷新B发出的好友申请列表。

当然也可以利用回调的参数信息，做增量处理，而不用获取全量的好友申请列表。

以用户B申请添加用户A为例

| 好友及黑名单监听              | 描述                                                 |
| :---------------------------- | :--------------------------------------------------- |
| [OnFriendApplicationAdded]    | 好友申请列表增加，主动发起者和被动添加者会收到       |
| [OnFriendApplicationDeleted]  | 好友申请列表删除，主动删除者会收到                   |
| [OnFriendApplicationAccepted] | 好友申请被同意，主动发起者和被动添加者会收到         |
| [OnFriendApplicationRejected] | 好友申请被拒绝，主动发起者和被动添加者会收到         |
| [OnFriendAdded]               | 好友增加，用户好友增加时会收到                       |
| [OnFriendDeleted]             | 好友删除，用户好友减少时会收到                       |
| [OnFriendInfoChanged]         | 好友信息改变，用户好友信息（比如昵称等）改变时会收到 |
| [OnBlackAdded]                | 黑名单增加，用户黑名单增加时会收到                   |
| [OnBlackDeleted]              | 黑名单移除，用户黑名单减少时会收到                   |