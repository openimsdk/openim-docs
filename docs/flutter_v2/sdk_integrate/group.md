# 群组管理相关接口

OpenIM目前群组特性：新进入用户无法查看进群前的历史消息。

| SDK                                  | 描述                                             |
| :----------------------------------- | :----------------------------------------------- |
| [CreateGroup]                        | 创建群                                           |
| [JoinGroup]                          | 申请加入群，如果群进群方式为直接进群，则直接进群 |
| [QuitGroup]                          | 主动退群                                         |
| [DismissGroup]                       | 解散群                                           |
| [ChangeGroupMute]                    | 对群禁言/取消禁言                                |
| [ChangeGroupMemberMute]              | 对群成员禁言/取消禁言                            |
| [SetGroupMemberRoleLevel]            | 设置群成员等级（普通成员/管理员）                |
| [GetJoinedGroupList]                 | 获取加入的群列表                                 |
| [GetGroupsInfo]                      | 获取群信息                                       |
| [SearchGroups]                       | 搜索群                                           |
| [SetGroupInfo]                       | 设置群信息                                       |
| [GetGroupMemberList]                 | 获取群成员里列表                                 |
| [GetGroupMemberListByJoinTimeFilter] | 获取群成员里列表，按照时间过滤                   |
| [GetGroupMembersInfo]                | 获取指定的群成员信息                             |
| [KickGroupMember]                    | 把群成员踢出群                                   |
| [TransferGroupOwner]                 | 转让群主                                         |
| [InviteUserToGroup]                  | 邀请某人进群                                     |
| [GetRecvGroupApplicationList]        | 获取收到的进群申请                               |
| [GetSendGroupApplicationList]        | 获取发起的进群申请                               |
| [AcceptGroupApplication]             | 同意某人进群                                     |
| [RefuseGroupApplication]             | 拒绝某人进群                                     |
| [SetGroupMemberNickname]             | 设置群成员昵称                                   |
| [SetGroupListener]                   | 设置群组监听器                                   |

群组监听器的作用：调用方设置群组监听，群组关系的变化会通过OpenIM消息机制实时同步到需要感知的在线用户，包括用户的其他端，调用方根据回调事件做相关的数据处理。

比如用户B进入某群，所有群成员都能实时收到，UI层把此用户加入某个群组，完成了群组成员的实时同步。

| 群组监听                     | 回调描述         |
| :--------------------------- | :--------------- |
| [OnJoinedGroupAdded]         | 加入群组新增     |
| [OnJoinedGroupDeleted]       | 加入群组减少     |
| [OnGroupMemberAdded]         | 群成员新增       |
| [OnGroupMemberDeleted]       | 群成员减少       |
| [OnGroupApplicationAdded]    | 进群申请列表新增 |
| [OnGroupApplicationDeleted]  | 进群申请列表删除 |
| [OnGroupInfoChanged]         | 群信息改变       |
| [OnGroupMemberInfoChanged]   | 群成员信息改变   |
| [OnGroupApplicationAccepted] | 申请进群被同意   |
| [OnGroupApplicationRejected] | 申请进群被拒绝   |



