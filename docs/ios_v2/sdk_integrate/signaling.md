#### SignalingManager（信令管理）

| 方法                   | 描述                     |
| ---------------------- | ------------------------ |
| setSignalingListener   | 信令监听                 |
| addSignalingListener   | 信令监听                 |
| signalingInvite        | 邀请个人加入音视频       |
| signalingInviteInGroup | 邀请群里某些人加入音视频 |
| signalingAccept        | 同意某人音视频邀请       |
| signalingReject        | 拒绝某人音视频邀请       |
| signalingCancel        | 邀请者取消音视频通话     |
| signalingHungUp        | 挂断                     |



#### OnSignalingListener（信令监听）

| 方法                           | 描述                               |
| ------------------------------ | ---------------------------------- |
| onReceiveNewInvitation         | 被邀请者收到：音视频通话邀请       |
| onInviteeRejected              | 邀请者收到：被邀请者拒绝音视频通话 |
| onInviteeAccepted              | 邀请者收到：被邀请者同意音视频通话 |
| onInvitationTimeout            | 邀请者收到：被邀请者超时未接通     |
| onInvitationCancelled          | 被邀请者收到：邀请者取消音视频通话 |
| onInviteeAcceptedByOtherDevice | 被邀请者收到：邀请被其他设备接受   |
| onInviteeRejectedByOtherDevice | 被邀请者收到：邀请被其他设备拒绝   |
| onHangup                       | 对方挂断                           |



#### signalingInvite（邀请个人加入音视频通话）

```
    
    OIMInvitationInfo *info = [OIMInvitationInfo new]; // 如需更多设置，请查看头文件
    info.inviteeUserIDList = @[]; // 被邀请人
    info.timeout = 30; // 默认30秒
    info.mediaType = isVideo ? "video" : "audio"

    [OIMManager.manager signalingInvite:info
                        offlinePushInfo:nil
                              onSuccess:^(OIMInvitationResultInfo * _Nullable result) {
        
    } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        
    }];

```



#### signalingInviteInGroup（邀请群成员加入音视频通话)

```
    OIMInvitationInfo *info = [OIMInvitationInfo new];
    info.inviteeUserIDList = @[];
    info.groupID = @"" // group id 必须填
    info.timeout = 30;
    info.mediaType = isVideo ? "video" : "audio"

    [OIMManager.manager signalingInvite:info
                        offlinePushInfo:nil
                              onSuccess:^(OIMInvitationResultInfo * _Nullable result) {
        
    } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        
    }];
```



#### signalingAccept（接受邀请）

```
    [OIMManager.manager signalingAccept:nil // 信令对象OIMInvitationInfo
                              onSuccess:^(OIMInvitationResultInfo * _Nullable result) {
        
    } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        
    }];
```



#### signalingReject（拒绝邀请）

```
    [OIMManager.manager signalingReject:nil // 信令对象OIMInvitationInfo
                              onSuccess:^(OIMInvitationResultInfo * _Nullable result) {
        
    } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        
    }];
```



- #### signalingCancel（取消）

```
    [OIMManager.manager signalingCancel:nil // 信令对象OIMInvitationInfo
                              onSuccess:^(OIMInvitationResultInfo * _Nullable result) {
        
    } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        
    }];
```



#### signalingHungUp（挂断）

```
    [OIMManager.manager signalingHungUp:nil // 信令对象OIMInvitationInfo
                              onSuccess:^(OIMInvitationResultInfo * _Nullable result) {
        
    } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        
    }];
```
