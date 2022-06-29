#### WorkMomentsManager（朋友圈管理）

| 方法                         | 描述                   |
| ---------------------------- | ---------------------- |
| setWorkMomentsListener       | 朋友圈信息发送变化通知 |
| getWorkMomentsUnReadCount    | 获取朋友圈未读消息总数 |
| getWorkMomentsNotification   | 获取通知列表           |
| clearWorkMomentsNotification | 清除通知列表           |



#### getWorkMomentsUnReadCount（获取朋友圈未读消息总数）

```
var count = await OpenIM.iMManager.workMomentsManager.getWorkMomentsUnReadCount();
```



#### getWorkMomentsNotification（获取朋友圈通知列表）

```
var list = await OpenIM.iMManager.workMomentsManager.getWorkMomentsNotification(
  offset:0,//开始下标
  count:40,//每页大小
);
```



#### clearWorkMomentsNotification（清除朋友圈通知列表）

```
OpenIM.iMManager.workMomentsManager.clearWorkMomentsNotification();
```