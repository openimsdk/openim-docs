## 用户个人信息对象

- type

  ```typescript
  export type FullUserItem = {
    birth: number;
    createTime: number;
    email: string;
    ex: string;
    faceURL: string;
    gender: number;
    nickname: string;
    phoneNumber: string;
    userID: string;
  };
  ```
  
  | Name        | Type   | Description                    |
  | ----------- | ------ | ------------------------------ |
  | userID      | string | 用户id                         |
  | nickname    | string | 用户昵称                       |
  | faceURL     | string | 用户头像                       |
  | gender      | number | 用户性别 0:未知 1:女 2:男      |
  | phoneNumber | string | 用户手机号                     |
  | birth       | string | 用户生日                       |
  | email       | string | 用户邮箱地址                   |
  | ex          | string | 用户信息扩展字段对象Json字符串 |
  | createTime  | number | 创建时间                       |
  
  

## 消息对象

- type

  ```typescript
  export type MessageItem = {
    clientMsgID: string;
    serverMsgID: string;
    createTime: number;
    sendTime: number;
    sessionType: SessionType;
    sendID: string;
    recvID: string;
    msgFrom: number;
    contentType: MessageType;
    platformID: Platform;
    senderNickname: string;
    senderFaceUrl: string;
    groupID: string;
    content: string;
    seq: number;
    isRead: boolean;
    status: MessageStatus;
    offlinePush: OfflinePush;
    attachedInfo: string;
    attachedInfoElem: AttachedInfoElem;
    ex: string;
    pictureElem: PictureElem;
    soundElem: SoundElem;
    videoElem: VideoElem;
    fileElem: FileElem;
    faceElem: FaceElem;
    mergeElem: MergeElem;
    atElem: AtElem;
    locationElem: LocationElem;
    customElem: CustomElem;
    quoteElem: QuoteElem;
    notificationElem: NotificationElem;
  };
  
  export type AtElem = {
      text:       string;
      atUserList: string[]|null;
      isAtSelf:   boolean;
  }
  
  export type CustomElem = {
      data:        string;
      description: string;
      extension:   string;
  }
  
  export type FileElem = {
      filePath:  string;
      uuid:      string;
      sourceUrl: string;
      fileName:  string;
      fileSize:  number;
  }
  
  export type LocationElem = {
      description: string;
      longitude:   number;
      latitude:    number;
  }
  
  export type MergeElem = {
      title:        string;
      abstractList: string[]|null;
      multiMessage: string[]|null;
  }
  
  export type PictureElem = {
      sourcePath:      string;
      sourcePicture:   Picture;
      bigPicture:      Picture;
      snapshotPicture: Picture;
  }
  
  export type Picture = {
      uuid:   string;
      type:   string;
      size:   number;
      width:  number;
      height: number;
      url:    string;
  }
  
  export type QuoteElem = {
      quoteMessage: string[];
  }
  
  export type SoundElem = {
      uuid:      string;
      soundPath: string;
      sourceUrl: string;
      dataSize:  number;
      duration:  number;
  }
  
  export type VideoElem = {
      videoPath:      string;
      videoUUID:      string;
      videoUrl:       string;
      videoType:      string;
      videoSize:      number;
      duration:       number;
      snapshotPath:   string;
      snapshotUUID:   string;
      snapshotSize:   number;
      snapshotUrl:    string;
      snapshotWidth:  number;
      snapshotHeight: number;
  }
  
  export type FaceElem = {
    index: number;
    data: string;
  };
  
  export type AttachedInfoElem = {
    groupHasReadInfo: GroupHasReadInfo;
    isPrivateChat: boolean;
    hasReadTime: number;
    notSenderNotificationPush: boolean;
  };
  
  export type GroupHasReadInfo = {
    hasReadCount: number;
    hasReadUserIDList: string[];
  };
  
  export type NotificationElem = {
    detail: string;
    defaultTips: string;
  }
  
  export type OfflinePush = {
    title: string;
    desc: string;
    ex: string;
    iOSPushSound: string;
    iOSBadgeCount: boolean;
  }
  ```



### Message

| Name           | Type         | Description |
| -------------- | ------------ | ----------- |
| clientMsgID    | string       | 消息唯一ID |
| serverMsgID    | string       | 消息服务器ID |
| createTime     | number       | 消息创建时间 |
| sendTime       | number       | 消息发送时间 |
| sessionType    | SessionType | 会话类型  1:单聊 2:群聊 |
| sendID         | string       | 发送者ID |
| recvID         | string       | 接收者ID |
| msgFrom        | number       | 标识消息是用户级别还是系统级别  100:用户 200:系统 |
| contentType    | MessageType | 消息类型 |
| platformID     | Platform | 平台类型 1:ios 2:android 3:windows 4:osx 5:web 6:mini 7:linux |
| senderNickname | string       | 发送者昵称 |
| senderFaceUrl  | string       | 发送者头像 |
| groupID        | string       | 群聊ID |
| content        | string       | 消息内容 |
| seq            | number       | 消息唯一序列号 |
| isRead         | bool         | 是否已读 |
| status         | MessageStatus | 消息状态 1:发送中 2:发送成功 3:发送失败 4:已删除 5:已撤回 |
| offlinePush | OfflinePush | 离线推送配置 |
| attachedInfo | string | 扩展信息 |
| attachedInfoElem | AttachedInfoElem | 扩展信息详情 |
| ex | string | 扩展字段 |
| pictureElem    | PictureElem  | 图片信息结构 |
| soundElem      | SoundElem    | 语音信息结构 |
| videoElem      | VideoElem    | 视频信息结构 |
| fileElem       | FileElem     | 文件信息结构 |
| faceElem | FaceElem | 标签信息结构 |
| mergeElem      | MergeElem    | 合并信息结构 |
| atElem         | AtElem       | @信息结构 |
| locationElem   | LocationElem | 位置信息结构 |
| customElem     | CustomElem   | 自定义信息结构 |
| quoteElem      | QuoteElem    | 引用消息结构 |
| notificationElem | NotificationElem | 通知消息结构 |



### PictureElem

| Name            | Type    | Description  |
| --------------- | ------- | ------------ |
| sourcePath      | string  | 本地资源地址 |
| sourcePicture   | Picture | 本地图片详情 |
| bigPicture      | Picture | 大图详情     |
| snapshotPicture | Picture | 缩略图详情   |



### Picture

| Name   | Type   | Description |
| ------ | ------ | ----------- |
| uuid   | string | 唯一ID      |
| type   | string | 图片类型    |
| size   | number | 图片大小    |
| width  | number | 图片宽度    |
| height | number | 图片高度    |
| url    | String | 图片oss地址 |



### SoundElem

| Name      | Type   | Description  |
| --------- | ------ | ------------ |
| uuid      | string | 唯一ID       |
| soundPath | string | 本地资源地址 |
| sourceUrl | string | oss地址      |
| dataSize  | number | 音频大小     |
| duration  | number | 音频时长     |



### VideoElem

| Name           | Type   | Description      |
| -------------- | ------ | ---------------- |
| videoPath      | string | 视频本地资源地址 |
| videoUUID      | string | 视频唯一ID       |
| videoUrl       | string | 视频oss地址      |
| videoType      | string | 视频类型         |
| videoSize      | number | 视频大小         |
| duration       | number | 视频时长         |
| snapshotPath   | string | 视频快照本地地址 |
| snapshotUUID   | string | 视频快照唯一ID   |
| snapshotSize   | number | 视频快照大小     |
| snapshotUrl    | string | 视频快照oss地址  |
| snapshotWidth  | number | 视频快照宽度     |
| snapshotHeight | number | 视频快照高度     |



### FileElem

| Name      | Type   | Description      |
| --------- | ------ | ---------------- |
| filePath  | string | 文件本地资源地址 |
| uuid      | string | 唯一ID           |
| sourceUrl | string | oss地址          |
| fileName  | string | 文件名称         |
| fileSize  | number | 文件大小         |



### AttachedInfoElem

| Name                      | Type             | Description        |
| ------------------------- | ---------------- | ------------------ |
| groupHasReadInfo          | GroupHasReadInfo | 群消息已读信息     |
| isPrivateChat             | string           | 是否为阅后即焚消息 |
| hasReadTime               | string           | 消息已读时间       |
| notSenderNotificationPush | string           | 是否不需要进行推送 |



### GroupHasReadInfo

| Name              | Type     | Description          |
| ----------------- | -------- | -------------------- |
| hasReadCount      | Number   | 群消息已读人数       |
| hasReadUserIDList | string[] | 群消息已读用户ID数组 |



### MergeElem

| Name         | Type        | Description |
| ------------ | ----------- | ----------- |
| title        | string      | 合并消息标题 |
| abstractList | array&#124;null | 摘要列表 |
| multiMessage | array&#124;null | 合并消息列表 |



### AtElem

| Name       | Type        | Description |
| ---------- | ----------- | ----------- |
| text       | string      | 文本消息 |
| atUserList | array&#124;null | @用户ID列表 |
| isAtSelf   | bool        | 是否@自己 |



### LocationElem

| Name        | Type   | Description |
| ----------- | ------ | ----------- |
| description | String | 描述        |
| longitude   | number | 经度        |
| latitude    | number | 纬度        |



### CustomElem

| Name        | Type   | Description              |
| ----------- | ------ | ------------------------ |
| data        | string | 自定义消息json字符串     |
| extension   | string | 自定义消息扩展json字符串 |
| description | string | 描述                     |



### QuoteElem

| Name         | Type        | Description |
| ------------ | ----------- | ----------- |
| quoteMessage | string&#124;null | 引用消息 |



### NotificationElem

| Name        | Type   | Description  |
| ----------- | ------ | ------------ |
| detail      | string | 通知详细信息 |
| defaultTips | string | 通知默认提示 |



## 会话对象

- Type

  ```typescript
  export type ConversationItem = {
   	conversationID: string;
    conversationType: SessionType;
    userID: string;
    groupID: string;
    showName: string;
    faceURL: string;
    recvMsgOpt: OptType;
    unreadCount: number;
    groupAtType: GroupAtType;
    latestMsg: string;
    latestMsgSendTime: number;
    draftText: string;
    draftTextTime: number;
    isPinned: boolean;
    isNotInGroup: boolean;
    isPrivateChat: boolean;
    attachedInfo: string;
    ex: string;
  };
  
  ```



| Name              | Type        | Description                                                  |
| ----------------- | ----------- | ------------------------------------------------------------ |
| conversationID    | string      | 会话ID                                                       |
| conversationType  | number      | 会话类型  1:单聊 2:群聊                                      |
| userID            | string      | 会话对象用户ID                                               |
| groupID           | string      | 会话群聊ID                                                   |
| showName          | string      | 会话对象(用户或群聊)名称                                     |
| faceURL           | string      | 用户头像或群聊头像                                           |
| recvMsgOpt        | OptType     | 接收消息选项：<br>0:在线正常接收消息，离线时进行推送<br>1:不会接收到消息<br>2:在线正常接收消息，离线不会有推送 |
| unreadCount       | number      | 未读消息数量                                                 |
| groupAtType       | GroupAtType | 群聊强提醒类型                                               |
| latestMsg         | string      | 最后一条消息 [消息对象]()json字符串                          |
| latestMsgSendTime | number      | 最后一条消息发送时间(ns)                                     |
| draftText         | string      | 会话草稿                                                     |
| draftTextTime     | number      | 会话草稿设置时间                                             |
| isPinned          | number      | 是否置顶                                                     |
| isNotInGroup      | boolean     | 是否已不再该群                                               |
| isPrivateChat     | boolean     | 是否已开启阅后即焚                                           |
| attachedInfo      | string      | 预留字段                                                     |
| ex                | string      | 扩展字段                                                     |





## 用户信息对象

- type

  > 通过[getDesignatedFriendsInfo]()获取用户信息时，如果是好友将返回friendInfo，若同时为黑名单，则返回friendInfo和blackInfo。若不是好友，则需要另行调用[getUsersInfo](),此时仅返回publicInfo。
  >
  > 直接调用[getUsersInfo]()获取用户信息时，如果是好友将返回friendInfo与publicInfo，不是好友仅返回publicInfo。
  
  ```typescript
  export type TotalUserStruct = {
    blackInfo: BlackItem | null;
    friendInfo: FriendItem | null;
    publicInfo: PublicUserItem | null;
  };
  export type PublicUserItem = {
    gender: number;
    nickname: string;
    userID: string;
    faceURL: string;
  };
  export type FriendItem = {
    addSource: number;
    birth: number;
    createTime: number;
    email: string;
    ex: string;
    faceURL: string;
    userID: string;
    gender: number;
    nickname: string;
    operatorUserID: string;
    ownerUserID: string;
    phoneNumber: string;
    remark: string;
  };
  export type BlackItem = {
    addSource: number;
    userID: string;
    createTime: number;
    ex: string;
    faceURL: string;
    gender: number;
    nickname: string;
    operatorUserID: string;
    ownerUserID: string;
  };
  ```
  
  

| Name          | Type   | Description      |
| ------------- | ------ | ---------------- |
| userID           | string | 用户ID           |
| nickname      | string | 用户名称         |
| faceURL   | string | 用户头像         |
| gender        | number | 用户性别         |
| phoneNumber | string | 用户手机号       |
| birth         | string | 用户出生日期     |
| email         | string | 用户邮箱号       |
| ex            | string | 用户信息扩展字段 |
| remark | string | 好友备注         |
| addSource | number | 添加来源 |
| createTime | number | 成为好友时间 |



## 群组信息对象

- type

  ```typescript
  export type GroupItem = {
    groupID: string;
    groupName: string;
    notification: string;
    introduction: string;
    faceURL: string;
    ownerUserID: string;
    createTime: number;
    memberCount: number;
    status: GroupStatus;
    creatorUserID: string;
    groupType: number;
    needVerification: GroupVerificationType;
    ex: string;
  };
  ```
  
  

| Name             | Type                  | Description    |
| ---------------- | --------------------- | -------------- |
| groupID          | string                | 群组ID         |
| groupName        | string                | 群组名称       |
| notification     | string                | 群公告         |
| introduction     | string                | 群介绍         |
| faceURL          | string                | 群头像         |
| ex               | string                | 群信息扩展字段 |
| ownerId          | string                | 群主ID         |
| createTime       | number                | 群组创建时间   |
| memberCount      | number                | 群成员总数     |
| needVerification | GroupVerificationType | 入群验证规则   |



## 群成员信息对象

- type

  ```typescript
  export type GroupMemberItem = {
    groupID: string;
    userID: string;
    nickname: string;
    faceURL: string;
    roleLevel: GroupRole;
    muteEndTime: number;
    joinTime: number;
    joinSource: number;
    operatorUserID: string;
    ex: string;
  };
  ```
  
  

| Name           | Type   | Description                                |
| -------------- | ------ | ------------------------------------------ |
| groupID        | string | 群组ID                                     |
| userID         | string | 群成员ID                                   |
| nickname       | string | 群成员昵称                                 |
| faceURL        | string | 群成员头像                                 |
| roleLevel      | string | 群成员等级 1普通 2群主 3管理员             |
| muteEndTime    | number | 禁言结束时间戳  大于当前时间即处于禁言状态 |
| joinTime       | number | 加入时间                                   |
| joinSource     | number | 加入方式                                   |
| operatorUserID | number | 操作者ID                                   |
| ex             | string | 扩展字段                                   |



## 好友申请对象

- type

  ```typescript
  export type FriendApplicationItem = {
    createTime: number;
    ex: string;
    fromFaceURL: string;
    fromGender: number;
    fromNickname: string;
    fromUserID: string;
    handleMsg: string;
    handleResult: number;
    handleTime: number;
    handlerUserID: string;
    reqMsg: string;
    toFaceURL: string;
    toGender: number;
    toNickname: string;
    toUserID: string;
  };
  ```

  

| Name          | Type   | Description  |
| ------------- | ------ | ------------ |
| createTime    | number | 创建时间     |
| ex            | string | 扩展字段     |
| fromFaceURL   | string | 申请者头像   |
| fromGender    | number | 申请者性别   |
| fromNickname  | string | 申请者昵称   |
| fromUserID    | string | 申请者用户ID |
| handleMsg     | string | 回复信息     |
| handleResult  | number | 处理状态     |
| handleTime    | number | 处理时间     |
| handlerUserID | string | 处理者ID     |
| reqMsg        | string | 申请信息     |
| toFaceURL     | string | 接收者头像   |
| toGender      | number | 接收者性别   |
| toNickname    | string | 接收者昵称   |
| toUserID      | string | 接收者ID     |



## 入群申请对象

- type

  ```typescript
  export type GroupApplicationItem = {
    createTime: number;
    creatorUserID: string;
    ex: string;
    gender: number;
    groupFaceURL: string;
    groupID: string;
    groupName: string;
    groupType: number;
    handleResult: number;
    handleUserID: string;
    handledMsg: string;
    handledTime: number;
    introduction: string;
    memberCount: number;
    nickname: string;
    notification: string;
    ownerUserID: string;
    reqMsg: string;
    reqTime: number;
    status: number;
    userFaceURL: string;
    userID: string;
  };
  ```

  

| Name          | Type   | Description  |
| ------------- | ------ | ------------ |
| createTime    | number | 创建时间     |
| creatorUserID | string | 创建者ID     |
| ex            | string | 扩展字段     |
| gender        | number | 申请者性别   |
| groupFaceURL  | string | 群头像       |
| groupID       | string | 群ID         |
| groupName     | string | 群名         |
| groupType     | number | 群类型       |
| handleResult  | number | 处理状态     |
| handleUserID  | string | 处理者ID     |
| handledMsg    | string | 处理原因     |
| handledTime   | number | 处理时间     |
| introduction  | string | 群介绍       |
| memberCount   | number | 群成员数     |
| nickname      | string | 申请者昵称   |
| notification  | string | 群公告       |
| ownerUserID   | string | 群主ID       |
| reqMsg        | string | 入群申请信息 |
| reqTime       | number | 申请时间     |
| status        | number | 群状态       |
| userFaceURL   | string | 申请者头像   |
| userID        | string | 申请者ID     |



## Promise 返回参数

- type

  ```typescript
  export type WsResponse = {
    event: RequestFunc;
    errCode: number;
    errMsg: string;
    data: any;
    operationID: string;
  };
  
  ```

  

| Name        | Type        | Description         |
| ----------- | ----------- | ------------------- |
| event       | RequestFunc | 事件(方法标识)      |
| errCode     | number      | 错误码，0为正确返回 |
| errMsg      | string      | 错误描述信息        |
| data        | any         | 返回参数            |
| operationID | string      | 操作唯一ID          |