# 信令相关API

> 所有API中需要用到的`operationID`为随机字符串，通常用于定位问题使用，建议每一次API调用均采用唯一ID，可通过npm包uuid生成。<br/>存在callback的API，callback的回调参数格式为统一格式，errCode为0则代表操作成功，否则为失败。具体参考[此处说明]()。

| 方法                   | 描述                     |
| ---------------------- | ------------------------ |
| signalingInvite        | 邀请个人加入音视频       |
| signalingInviteInGroup | 邀请群里某些人加入音视频 |
| signalingAccept        | 同意某人音视频邀请       |
| signalingReject        | 拒绝某人音视频邀请       |
| signalingCancel        | 邀请者取消音视频通话     |
| signalingHungUp        | 挂断                     |



## signalingInvite

> 单人邀请进行音视频通话，接收方会收到`onReceiveNewInvitation`回调

- Example:

  ```js
  const options = {
    inviterUserID: "selfID",
    inviteeUserIDList: ["otherID"],
    groupID: "",
    roomID: "",
    timeout: 30,
    mediaType: "video",
    sessionType: SessionType.Single,
    platformID: 5,
  }
  openIM.signalingInvite(operationID,options,({ data })=>{
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
  | timeout           | Number       | true     | 超时时间，若邀请在超时时间内未被处理，发起者会收到`onInvitationTimeout`回调 |
  | mediaType         | audio\|video | true     | 通话类型，即 语音或者视频                                    |
  | sessionType       | SessionType  | true     | 单人音视频邀请还是群内多人音视频邀请                         |
  | platformID        | Platform     | true     | 当前登录平台号                                               |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 音视频服务连接配置 |




## signalingInviteInGroup

> 群内邀请多人进行音视频通话，所选接收成员会收到`onReceiveNewInvitation`回调

- Example:

  ```js
  const options = {
    inviterUserID: "selfID",
    inviteeUserIDList: ["otherID1","otherID2"],
    groupID: "groupID",
    roomID: "roomID",
    timeout: 30,
    mediaType: "video",
    sessionType: SessionType.Group,
    platformID: 5,
  }
  openIM.signalingInviteInGroup(operationID,options,({ data })=>{
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
  | timeout           | Number       | true     | 超时时间，若邀请在超时时间内未被处理，发起者会收到`onInvitationTimeout`回调 |
  | mediaType         | audio\|video | true     | 通话类型，即 语音或者视频                                    |
  | sessionType       | SessionType  | true     | 单人音视频邀请还是群内多人音视频邀请                         |
  | platformID        | Platform     | true     | 当前登录平台号                                               |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 音视频服务连接配置 |

  

## signalingAccept

> 在收到`onReceiveNewInvitation`回调后，接受某个音视频请求，接受后发起者会收到`onInviteeAccepted`回调

- Example:

  ```js
  const options = {
    opUserID: "selfID",
    invitation: RtcInvite
  }
  openIM.signalingAccept(operationID,options,({ data })=>{
    ...
  })
  ```

- Parameters:

  | Name       | Type      | Required | Description                                                |
  | ---------- | --------- | -------- | ---------------------------------------------------------- |
  | opUserID   | string    | true     | 接受人ID，及当前登录用户ID                                 |
  | invitation | RtcInvite | true     | 音视频邀请信息结构体，通过监听`onReceiveNewInvitation`获取 |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 音视频服务连接配置 |

  

## signalingReject

> 在收到`onReceiveNewInvitation`回调后，拒绝某个音视频请求，拒绝后发起者会收到`onInviteeRejected`回调

- Example:

  ```js
  const options = {
    opUserID: "selfID",
    invitation: RtcInvite
  }
  openIM.signalingReject(operationID,options,({ data })=>{
    ...
  })
  ```

- Parameters:

  | Name       | Type      | Required | Description                                                |
  | ---------- | --------- | -------- | ---------------------------------------------------------- |
  | opUserID   | string    | true     | 接受人ID，及当前登录用户ID                                 |
  | invitation | RtcInvite | true     | 音视频邀请信息结构体，通过监听`onReceiveNewInvitation`获取 |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 操作成功或失败描述 |

  

## signalingCancel

> 在发起邀请后试图取消本次邀请，接收方会收到`onInvitationCancelled`回调

- Example:

  ```js
  const options = {
    opUserID: "selfID",
    invitation: RtcInvite
  }
  openIM.signalingCancel(operationID,options,({ data })=>{
    ...
  })
  ```

- Parameters:

  | Name       | Type      | Required | Description                                                |
  | ---------- | --------- | -------- | ---------------------------------------------------------- |
  | opUserID   | string    | true     | 接受人ID，及当前登录用户ID                                 |
  | invitation | RtcInvite | true     | 音视频邀请信息结构体，通过监听`onReceiveNewInvitation`获取 |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 操作成功或失败描述 |

  

## signalingHungUp

> 在通话中试图结束通话，通话的其他人员会收到`onHangUp`回调

- Example:

  ```js
  const options = {
    opUserID: "selfID",
    invitation: RtcInvite
  }
  openIM.signalingHungUp(operationID,options,({ data })=>{
    ...
  })
  ```

- Parameters:

  | Name       | Type      | Required | Description                                                |
  | ---------- | --------- | -------- | ---------------------------------------------------------- |
  | opUserID   | string    | true     | 接受人ID，及当前登录用户ID                                 |
  | invitation | RtcInvite | true     | 音视频邀请信息结构体，通过监听`onReceiveNewInvitation`获取 |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 操作成功或失败描述 |

  

# 信令相关回调

> 相关回调需要通过导入`globalEvent`进行监听，引入步骤参考[SDK引入]()。

| 事件                           | 描述                     | 响应             |
| ------------------------------ | ------------------------ | ---------------- |
| onReceiveNewInvitation         | 收到音视频通话请求       | 音视频邀请信息   |
| onInviteeAccepted              | 发出的请求被同意         | 被同意详情       |
| onInviteeRejected              | 发出的请求被拒绝         | 被拒绝详情       |
| onInvitationCancelled          | 收到的请求被对方取消了   | 被取消的邀请信息 |
| onHangUp                       | 房间中有其他成员挂断     | 被挂断信息详情   |
| onInvitationTimeout            | 发出的请求超时了         | 超时的请求信息   |
| onInviteeAcceptedByOtherDevice | 请求在其他设备上被接受了 | -                |
| onInviteeRejectedByOtherDevice | 请求在其他设备上被拒绝了 | -                |