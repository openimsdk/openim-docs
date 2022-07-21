# 好友相关API

| 方法                         | 描述                                             |
| ---------------------------- | ------------------------------------------------ |
| addFriend                    | 发送好友请求                                     |
| getRecvFriendApplicationList | 获取当前用户收到的好友申请                       |
| getSendFriendApplicationList | 获取当前用户发出的好友申请                       |
| acceptFriendApplication      | 接受好友请求                                     |
| refuseFriendApplication      | 拒绝好友请求                                     |
| getFriendList                | 获取好友列表，返回的列表包含了已拉入黑名单的好友 |
| getDesignatedFriendsInfo     | 获取指定好友信息                                 |
| setFriendRemark              | 设置好友备注                                     |
| checkFriend                  | 检查是否为好友                                   |
| getBlacklist                 | 获取黑名单列表                                   |
| addBlack                     | 加入黑名单                                       |
| removeBlack                  | 从黑名单中移除                                   |
| deleteFriend                 | 删除好友                                         |
| searchFriends                | 在好友列表中进行搜索                             |

## addFriend

> 发起添加好友申请。

- Example:

  ```js
  const options:AddFriendParams = {
    toUserID:"",
    reqMsg:""
  }
  openIM.addFriend(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:

  | Name     | Type   | Required | Description  |
  | -------- | ------ | -------- | ------------ |
  | toUserID | string | true     | 用户ID       |
  | reqMsg   | string | true     | 申请验证信息 |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 发送请求成功或失败 |


## getRecvFriendApplicationList

> 获取收到的好友请求列表。

- Example:

  ```js
  openIM.getRecvFriendApplicationList().then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- CallBack:

  | Name | Type   | Description                |
  | ---- | ------ | -------------------------- |
  | data | string | 好友请求对象列表json字符串 |



## getSendFriendApplicationList

> 获取发出的好友请求列表。

- Example:

  ```js
  openIM.getSendFriendApplicationList().then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- CallBack:

  | Name | Type   | Description                |
  | ---- | ------ | -------------------------- |
  | data | string | 好友请求对象列表json字符串 |

  

## acceptFriendApplication

> 接受好友请求。

- Example:

  ```js
  const options:AccessFriendParams = {
    toUserID:"",
    handleMsg:""
  }
  openIM.acceptFriendApplication(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name      | Type   | Required | Description |
| --------- | ------ | -------- | ----------- |
| toUserID  | string | true     | 申请者ID    |
| handleMsg | string | true     | 回复消息    |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 接受成功或失败描述 |

  

## refuseFriendApplication

> 拒绝好友请求。

- Example:

  ```js
  const options:AccessFriendParams = {
    toUserID:"",
    handleMsg:""
  }
  openIM.refuseFriendApplication(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name      | Type   | Required | Description |
| --------- | ------ | -------- | ----------- |
| toUserID  | string | true     | 申请者ID    |
| handleMsg | string | true     | 回复消息    |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 拒绝成功或失败描述 |

## getFriendList

> 获取好友列表。

- Example:

  ```js
  openIM.getFriendList().then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- CallBack:

  | Name | Type   | Description                    |
  | ---- | ------ | ------------------------------ |
  | data | string | [好友对象]()对象列表json字符串 |

  

## getDesignatedFriendsInfo

> 获取指定好友信息。

- Example:

  ```js
  const options = ["xxx"]
  openIM.getDesignatedFriendsInfo(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:

  | Name    | Type     | Required | Description |
  | ------- | -------- | -------- | ----------- |
  | options | string[] | true     | 好友ID数组  |

- CallBack:

  | Name | Type   | Description                    |
  | ---- | ------ | ------------------------------ |
  | data | string | [好友信息]()对象列表json字符串 |

  

## setFriendRemark

> 设置好友备注信息。

- Example:

  ```js
  const options:RemarkFriendParams = {
    toUserID:"",
    remark:""
  }
  openIM.setFriendRemark(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:

  | Name     | Type   | Required | Description |
  | -------- | ------ | -------- | ----------- |
  | toUserID | string | true     | 用户ID      |
  | remark   | string | true     | 备注        |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 设置成功或失败描述 |

  

## checkFriend

> 检查与用户间是否有好友关系。

- Example:

  ```js
  const options = ["xxx"]
  openIM.checkFriend(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:

  | Name    | Type     | Required | Description |
  | ------- | -------- | -------- | ----------- |
  | options | string[] | true     | 用户ID数组  |

- CallBack:

  | Name | Type   | Description                |
  | ---- | ------ | -------------------------- |
  | data | string | 好友关系对象列表json字符串 |

  

## deleteFriend

> 从好友列表中删除用户。

- Example:

  ```js
  openIM.deleteFriend(userID).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:

  | Name   | Type   | Required | Description |
  | ------ | ------ | -------- | ----------- |
  | userID | string | true     | 好友用户ID  |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 删除成功或失败描述 |

  

## getBlackList

> 获取黑名单列表。

- Example:

  ```js
  openIM.getBlackList().then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- CallBack:


| Name | Type   | Description                                    |
| ---- | ------ | ---------------------------------------------- |
| data | string | 被拉入黑名单的[黑名单用户对象]()列表json字符串 |




## addBlack

> 将用户添加到黑名单。

- Example:

  ```js
  openIM.addBlack(userID).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name | Type   | Required | Description |
| ---- | ------ | ----------- | ----------- |
| userID  | string | true | 用户ID      |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 添加成功或失败描述 |

  

## removeBlack

> 从黑名单移除用户。

- Example:

  ```js
  openIM.removeBlack(userID).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:


| Name | Type   | Required | Description |
| ---- | ------ | ----------- | ----------- |
| userID  | string | true | 用户ID      |

- CallBack:


| Name | Type   | Description        |
| ---- | ------ | ------------------ |
| data | string | 移除成功或失败描述 |



## deleteFriend

> 从好友列表中删除用户。

- Example:

  ```js
  openIM.deleteFriend(userID).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:

  | Name   | Type   | Required | Description |
  | ------ | ------ | -------- | ----------- |
  | userID | string | true     | 好友用户ID  |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 删除成功或失败描述 |




## searchFriends

> 在好友列表中搜索。

- Example:

  ```js
  const options = {
    keywordList: ["xx"];
    isSearchUserID: true;
    isSearchNickname: true;
    isSearchRemark: true;
  }
  openIM.searchFriends(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:

  | Name             | Type     | Required | Description      |
  | ---------------- | -------- | -------- | ---------------- |
  | keywordList      | string[] | true     | 好友用户ID数组   |
  | isSearchUserID   | boolean  | true     | 是否搜索用户ID   |
  | isSearchNickname | boolean  | true     | 是否搜索好友昵称 |
  | isSearchRemark   | boolean  | true     | 是否搜索好友备注 |

- CallBack:

  | Name | Type   | Description                      |
  | ---- | ------ | -------------------------------- |
  | data | string | 符合条件的好友信息列表json字符串 |





  

# 用户相关回调

> 所有事件相关常量均封装在SDK的`CbEvents`中，可直接进行引入使用。

| 事件                        | 描述                         | 响应             |
| --------------------------- | ---------------------------- | ---------------- |
| OnBlackAdded                | 有用户被添加到黑名单         | 新增的黑名单信息 |
| OnBlackDeleted              | 从黑名单中移除了某个用户     | 移除的黑名单信息 |
| OnFriendApplicationAccepted | 收到或发出的好友请求被接受   | 被接受的好友申请 |
| OnFriendApplicationRejected | 收到或发出的好友请求被拒绝   | 被拒绝的好友申请 |
| OnFriendApplicationAdded    | 收到或发出的好友请求列表增加 | 新增的好友申请   |
| OnFriendApplicationDeleted  | 收到或发出的好友请求列表减少 | 被移除的好友申请 |
| OnFriendInfoChanged         | 好友信息更新                 | 更新后的好友信息 |
| OnFriendAdded               | 好友列表增加                 | 新增的好友信息   |
| OnFriendDeleted             | 好友列表减少                 | 减少的好友信息   |