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
    /**
     * 邀请个人加入音视频
     * @param base
     * @param info 信令对象
     */
    public void signalingInvite(OnBase<SignalingCertificate> base, SignalingInfo info)
```



#### signalingInviteInGroup（邀请群成员加入音视频通话)

```
    /**
     * 邀请群里某些人加入音视频
     * @param info 信令对象
     */
    public void signalingInviteInGroup(OnBase<SignalingCertificate> base, SignalingInfo info)
);
```



#### signalingAccept（接受邀请）

```
    /**
     * 同意某人音视频邀请
     * @param info 信令对象
     */
    public void signalingAccept(OnBase<SignalingCertificate> base, SignalingInfo info) 
```



#### signalingReject（拒绝邀请）

```
    /**
     * 拒绝某人音视频邀请
     * @param info 信令对象
     */
    public void signalingReject(OnBase<SignalingCertificate> base, SignalingInfo info)
```



- #### signalingCancel（取消）

```
    /**
     * 邀请者取消音视频通话
	 * @param info 信令对象
     */
    public void signalingCancel(OnBase<SignalingCertificate> base, SignalingInfo info) 
```



#### signalingHungUp（挂断）

```
    /**
     * 挂断
 	 * @param info 信令对象
     */
    public void signalingHungUp(OnBase<SignalingCertificate> base, SignalingInfo info)
```