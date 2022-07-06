#### 信令相关API

| 方法                   | 描述                     |
| ---------------------- | ------------------------ |
| signalingInvite        | 邀请个人加入音视频       |
| signalingInviteInGroup | 邀请群里某些人加入音视频 |
| signalingAccept        | 同意某人音视频邀请       |
| signalingReject        | 拒绝某人音视频邀请       |
| signalingCancel        | 邀请者取消音视频通话     |
| signalingHungUp        | 挂断                     |



## signalingInvite

> 单人邀请进行音视频通话，接收方会收到`OnReceiveNewInvitation`回调

- Example:

  ```js
  const options:RtcInvite = {
    inviterUserID: "selfID",
    inviteeUserIDList: ["otherID"],
    groupID: "",
    roomID: "",
    timeout: 30,
    mediaType: "video",
    sessionType: SessionType.Single,
    platformID: 5,
  }
  openIM.signalingInvite(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:

  | Name              | Type         | Required | Description                                                  |
  | ----------------- | ------------ | -------- | ------------------------------------------------------------ |
  | inviterUserID     | string       | true     | 邀请人ID，及当前登录用户ID                                   |
  | inviteeUserIDList | string[]     | true     | 被邀请者ID数组                                               |
  | groupID           | string       | true     | 群聊ID，单人邀请时传""                                       |
  | roomID            | string       | true     | 房间ID，随机字符串，传""时由服务端生成                       |
  | timeout           | Number       | true     | 超时时间，若邀请在超时时间内未被处理，发起者会收到`OnInvitationTimeout`回调 |
  | mediaType         | audio\|video | true     | 通话类型，即 语音或者视频                                    |
  | sessionType       | SessionType  | true     | 单人音视频邀请还是群内多人音视频邀请                         |
  | platformID        | Platform     | true     | 当前登录平台号                                               |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 音视频服务连接配置 |




## signalingInviteInGroup

> 群内邀请多人进行音视频通话，所选接收成员会收到`OnReceiveNewInvitation`回调

- Example:

  ```js
  const options:RtcInvite = {
    inviterUserID: "selfID",
    inviteeUserIDList: ["otherID1","otherID2"],
    groupID: "groupID",
    roomID: "roomID",
    timeout: 30,
    mediaType: "video",
    sessionType: SessionType.Group,
    platformID: 5,
  }
  openIM.signalingInviteInGroup(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:

  | Name              | Type         | Required | Description                                                  |
  | ----------------- | ------------ | -------- | ------------------------------------------------------------ |
  | inviterUserID     | string       | true     | 邀请人ID，及当前登录用户ID                                   |
  | inviteeUserIDList | string[]     | true     | 被邀请者ID数组，群成员ID                                     |
  | groupID           | string       | true     | 群聊ID，发去邀请的群聊ID                                     |
  | roomID            | string       | true     | 房间ID，随机字符串，传""时由服务端生成                       |
  | timeout           | Number       | true     | 超时时间，若邀请在超时时间内未被处理，发起者会收到`OnInvitationTimeout`回调 |
  | mediaType         | audio\|video | true     | 通话类型，即 语音或者视频                                    |
  | sessionType       | SessionType  | true     | 单人音视频邀请还是群内多人音视频邀请                         |
  | platformID        | Platform     | true     | 当前登录平台号                                               |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 音视频服务连接配置 |

  

## signalingAccept

> 在收到`OnReceiveNewInvitation`回调后，接受某个音视频请求，接受后发起者会收到`OnInviteeAccepted`回调

- Example:

  ```js
  const options:RtcActionParams = {
    opUserID: "selfID",
    invitation: RtcInvite
  }
  openIM.signalingAccept(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:

  | Name       | Type      | Required | Description                                                |
  | ---------- | --------- | -------- | ---------------------------------------------------------- |
  | opUserID   | string    | true     | 接受人ID，及当前登录用户ID                                 |
  | invitation | RtcInvite | true     | 音视频邀请信息结构体，通过监听`OnReceiveNewInvitation`获取 |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 音视频服务连接配置 |

  

## signalingReject

> 在收到`OnReceiveNewInvitation`回调后，拒绝某个音视频请求，拒绝后发起者会收到`OnInviteeRejected`回调

- Example:

  ```js
  const options:RtcActionParams = {
    opUserID: "selfID",
    invitation: RtcInvite
  }
  openIM.signalingReject(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:

  | Name       | Type      | Required | Description                                                |
  | ---------- | --------- | -------- | ---------------------------------------------------------- |
  | opUserID   | string    | true     | 接受人ID，及当前登录用户ID                                 |
  | invitation | RtcInvite | true     | 音视频邀请信息结构体，通过监听`OnReceiveNewInvitation`获取 |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 操作成功或失败描述 |

  

## signalingCancel

> 在发起邀请后试图取消本次邀请，接收方会收到`OnInvitationCancelled`回调

- Example:

  ```js
  const options:RtcActionParams = {
    opUserID: "selfID",
    invitation: RtcInvite
  }
  openIM.signalingCancel(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:

  | Name       | Type      | Required | Description                                                |
  | ---------- | --------- | -------- | ---------------------------------------------------------- |
  | opUserID   | string    | true     | 接受人ID，及当前登录用户ID                                 |
  | invitation | RtcInvite | true     | 音视频邀请信息结构体，通过监听`OnReceiveNewInvitation`获取 |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 操作成功或失败描述 |

  

## signalingHungUp

> 在通话中试图结束通话，通话的其他人员会收到`OnHangUp`回调

- Example:

  ```js
  const options:RtcActionParams = {
    opUserID: "selfID",
    invitation: RtcInvite
  }
  openIM.signalingHungUp(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:

  | Name       | Type      | Required | Description                                                |
  | ---------- | --------- | -------- | ---------------------------------------------------------- |
  | opUserID   | string    | true     | 接受人ID，及当前登录用户ID                                 |
  | invitation | RtcInvite | true     | 音视频邀请信息结构体，通过监听`OnReceiveNewInvitation`获取 |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 操作成功或失败描述 |

  

# 信令相关回调

> 所有事件相关常量均封装在SDK的`CbEvents`中，可直接进行引入使用。

| 事件                          | 描述                                   | 响应                   |
| ----------------------------- | -------------------------------------- | ---------------------- |
| onRecvNewMessage              | 收到新消息                             | 新消息结构体json字符串 |
| onRecvNewMessages             | 收到新消息（开启批量推送时）           | 新消息数组json字符串   |
| onRecvMessageRevoked          | 有消息被撤回                           | 被撤回的消息ID         |
| onRecvC2CReadReceipt          | 收到单聊已读回执，即有人读了发出的消息 | 消息ID列表             |
| onRecvGroupMessageReadReceipt | 收到群聊已读回执，即有人读了发出的消息 | 消息ID列表             |