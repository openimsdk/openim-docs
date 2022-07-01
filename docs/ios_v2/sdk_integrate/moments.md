#### WorkMomentsManager（朋友圈管理）

| 方法                         | 描述                   |
| ---------------------------- | ---------------------- |
| setWorkMomentsListener       | 朋友圈信息发送变化通知 |
| addWorkMomentsListener       | 朋友圈信息发送变化通知 |
| getWorkMomentsUnReadCount    | 获取朋友圈未读消息总数 |
| getWorkMomentsNotification   | 获取通知列表           |
| clearWorkMomentsNotification | 清除通知列表           |



#### OnWorkMomentsListener（朋友圈监听）

| 方法                  | 描述               |
| --------------------- | ------------------ |
| onRecvNewNotification | 朋友圈有新消息更新 |


#### getWorkMomentsUnReadCount（获取朋友圈未读消息总数）

```
    [OIMManager.manager getWorkMomentsUnReadCountWithOnSuccess:^(NSInteger number) {
        
    } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        
    }];
```



#### getWorkMomentsNotification（获取朋友圈通知列表）

```
    [OIMManager.manager getWorkMomentsNotificationWithOffset:0
                                                       count:100
                                                   onSuccess:^(NSArray<OIMMomentsInfo *> * _Nullable items) {
        
    } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        
    }];
```



#### clearWorkMomentsNotification（清除朋友圈通知列表）

```
    [OIMManager.manager clearWorkMomentsNotificationWithOnSuccess:^(NSString * _Nullable data) {
        
    } onFailure:^(NSInteger code, NSString * _Nullable msg) {
        
    }];
```
