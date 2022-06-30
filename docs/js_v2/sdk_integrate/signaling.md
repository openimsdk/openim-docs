#### SignalingManager（信令管理）

| 方法                   | 描述                     |
| ---------------------- | ------------------------ |
| setSignalingListener   | 信令监听                 |
| signalingInvite        | 邀请个人加入音视频       |
| signalingInviteInGroup | 邀请群里某些人加入音视频 |
| signalingAccept        | 同意某人音视频邀请       |
| signalingReject        | 拒绝某人音视频邀请       |
| signalingCancel        | 邀请者取消音视频通话     |
| signalingHungUp        | 挂断                     |



#### signalingInvite（邀请个人加入音视频通话）

```
SignalingCertificate sc = await OpenIM.iMManager.signalingManager.signalingInvite(
	info: null, // 信令对象SignalingInfo
);
```



#### signalingInviteInGroup（邀请群成员加入音视频通话)

```
SignalingCertificate sc = await OpenIM.iMManager.signalingManager.signalingInviteInGroup(
	info: null, // 信令对象SignalingInfo
);
```



#### signalingAccept（接受邀请）

```
SignalingCertificate sc = await OpenIM.iMManager.signalingManager.signalingAccept(
  info: null, // 信令对象SignalingInfo
);
```



#### signalingReject（拒绝邀请）

```
OpenIM.iMManager.signalingManager.signalingReject(
  info: null, // 信令对象SignalingInfo
);
```



- #### signalingCancel（取消）

```
OpenIM.iMManager.signalingManager.signalingCancel(
  info: null, // 信令对象SignalingInfo
);
```



#### signalingHungUp（挂断）

```
OpenIM.iMManager.signalingManager.signalingHungUp(
  info: null, // 信令对象SignalingInfo
);
```