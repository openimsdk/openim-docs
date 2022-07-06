# 信令相关API

| 方法                                | 描述                             |
| ----------------------------------- | -------------------------------- |
| getSubDepartment                    | 获取某个部门子部门列表           |
| getDepartmentMember                 | 获取某个部门部门成员             |
| getUserInDepartment                 | 获取用户所在部门                 |
| getDepartmentMemberAndSubDepartment | 获取某个部门子部门和部门人员列表 |
| getDepartmentInfo                   | 获取某个部门信息                 |
| searchOrganization                  | 在组织架构中搜索                 |



## getSubDepartment

> 获取某个部门下子部门列表

- Example:

  ```js
  const options:GetSubDepParams = {
    departmentID: "",
    offset: 0,
    count: 20
  }
  openIM.getSubDepartment(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:

  | Name         | Type   | Required | Description                  |
  | ------------ | ------ | -------- | ---------------------------- |
  | departmentID | string | true     | 部门ID，传""时获取根部门信息 |
  | offset       | number | true     | 分页偏移量                   |
  | count        | number | true     | 一页获取的数量               |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 部门列表json字符串 |



## getUserInDepartment

> 获取某个用户所在部门信息

- Example:

  ```js
  openIM.getUserInDepartment(userID).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:

  | Name   | Type   | Required | Description |
  | ------ | ------ | -------- | ----------- |
  | userID | string | true     | 用户ID      |

- CallBack:

  | Name | Type   | Description                |
  | ---- | ------ | -------------------------- |
  | data | string | 用户所在部门信息json字符串 |



## getDepartmentMemberAndSubDepartment

> 获取某个部门下子部门列表和部门成员列表

- Example:

  ```js
  openIM.getDepartmentMemberAndSubDepartment(departmentID).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:

  | Name         | Type   | Required | Description                  |
  | ------------ | ------ | -------- | ---------------------------- |
  | departmentID | string | true     | 部门ID，传""时获取根部门信息 |

- CallBack:

  | Name | Type   | Description              |
  | ---- | ------ | ------------------------ |
  | data | string | 部门和成员列表json字符串 |



## getDepartmentInfo

> 获取某个部门详细信息

- Example:

  ```js
  openIM.getDepartmentInfo(departmentID).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:

  | Name         | Type   | Required | Description                  |
  | ------------ | ------ | -------- | ---------------------------- |
  | departmentID | string | true     | 部门ID，传""时获取根部门信息 |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 部门信息json字符串 |



## searchOrganization

> 在组织架构内搜索

- Example:

  ```js
  const searchObj:SearchInputType = {
    keyWord: "",
    isSearchUserName: true,
    isSearchEnglishName: false,
    isSearchPosition: false,
    isSearchUserID: false,
    isSearchMobile: false,
    isSearchEmail: false,
    isSearchTelephone: false,
  }
  const options:SearchInOrzParams = {
    input: searchObj,
    offset: 0,
    count: 20
  }
  openIM.searchOrganization(options).then(({ data })=>{
    ...
  }).catch(err=>{
    ...
  })
  ```

- Parameters:

  | Name                | Type    | Required | Description          |
  | ------------------- | ------- | -------- | -------------------- |
  | keyWord             | string  | true     | 搜素关键词           |
  | isSearchUserName    | boolean | true     | 是否搜索用户昵称     |
  | isSearchEnglishName | boolean | true     | 是否搜索用户英文昵称 |
  | isSearchPosition    | boolean | true     | 是否搜索职位         |
  | isSearchUserID      | boolean | true     | 是否搜索用户ID       |
  | isSearchMobile      | boolean | true     | 是否搜索手机号       |
  | isSearchEmail       | boolean | true     | 是否搜索email        |
  | isSearchTelephone   | boolean | true     | 是否搜索Telephone    |
  | offset              | number  | true     | 分页偏移量           |
  | count               | number  | true     | 一页获取的数量       |

- CallBack:

  | Name | Type   | Description        |
  | ---- | ------ | ------------------ |
  | data | string | 搜索结果json字符串 |







# 信令相关回调

> 所有事件相关常量均封装在SDK的`CbEvents`中，可直接进行引入使用。

| 事件                           | 描述                     | 响应             |
| ------------------------------ | ------------------------ | ---------------- |
| OnReceiveNewInvitation         | 收到音视频通话请求       | 音视频邀请信息   |
| OnInviteeAccepted              | 发出的请求被同意         | 被同意详情       |
| OnInviteeRejected              | 发出的请求被拒绝         | 被拒绝详情       |
| OnInvitationCancelled          | 收到的请求被对方取消了   | 被取消的邀请信息 |
| OnHangUp                       | 房间中有其他成员挂断     | 被挂断信息详情   |
| OnInvitationTimeout            | 发出的请求超时了         | 超时的请求信息   |
| OnInviteeAcceptedByOtherDevice | 请求在其他设备上被接受了 | -                |
| OnInviteeRejectedByOtherDevice | 请求在其他设备上被拒绝了 | -                |