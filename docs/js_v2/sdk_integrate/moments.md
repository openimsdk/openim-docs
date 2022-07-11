# 朋友圈相关API

> 所有API中需要用到的`operationID`为随机字符串，通常用于定位问题使用，建议每一次API调用均采用唯一ID，可通过npm包uuid生成。<br/>存在callback的API，callback的回调参数格式为统一格式，errCode为0则代表操作成功，否则为失败。具体参考[此处说明]()。

| 方法                         | 描述                 |
| ---------------------------- | -------------------- |
| getWorkMomentsUnReadCount    | 获取当前登录用户资料 |
| getWorkMomentsNotification   | 修改当前登录用户资料 |
| clearWorkMomentsNotification |                      |




## getWorkMomentsUnReadCount

> 获取朋友圈未读消息总数

- Example:

  ```typescript
  openIM.getWorkMomentsUnReadCount(operationID,({data}) => {
  	...
  })
  ```

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 朋友圈未读消息总数 |



## getWorkMomentsNotification

> 获取朋友圈通知列表

- Example:

  ```typescript
  openIM.getWorkMomentsNotification(operationID,offset,count,({data}) => {
  	...
  })
  ```

- Parameters:

  | Name   | Type   | Required | Description        |
  | ------ | ------ | -------- | ------------------ |
  | offset | number | true     | 分页偏移量         |
  | count  | number | true     | 分页时一页拉取总数 |

- CallBack:

  | Name | Type   | Description          |
  | ---- | ------ | -------------------- |
  | data | string | 用户资料是否修改成功 |



## clearWorkMomentsNotification

> 清除朋友圈朋友圈通知列表

- Example:

  ```typescript
  openIM.clearWorkMomentsNotification(operationID,({data}) => {
  	...
  })
  ```

- CallBack:

  | Name | Type   | Description |
  | ---- | ------ | ----------- |
  | data | string | -           |



# 朋友圈相关回调

> 相关回调需要通过导入`globalEvent`进行监听，引入步骤参考[SDK引入]()。

| 事件                  | 描述               | 响应 |
| --------------------- | ------------------ | ---- |
| onRecvNewNotification | 朋友圈有新消息更新 | -    |