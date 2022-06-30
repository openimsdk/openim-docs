#### WorkMomentsManager（朋友圈管理）

| 方法                         | 描述                   |
| ---------------------------- | ---------------------- |
| setWorkMomentsListener       | 朋友圈信息发送变化通知 |
| getWorkMomentsUnReadCount    | 获取朋友圈未读消息总数 |
| getWorkMomentsNotification   | 获取通知列表           |
| clearWorkMomentsNotification | 清除通知列表           |



#### getWorkMomentsUnReadCount（获取朋友圈未读消息总数）

```
    public void getWorkMomentsUnReadCount(OnBase<String> base) 
```



#### getWorkMomentsNotification（获取朋友圈通知列表）

```

    /**
     * @param base
     * @param offset 开始下标
     * @param count 每页大小
     */
    public void getWorkMomentsNotification(OnBase<List<WorkMomentsInfo>> base, long offset, long count)
```



#### clearWorkMomentsNotification（清除朋友圈通知列表）

```
    public void clearWorkMomentsNotification(OnBase<String> base)
```