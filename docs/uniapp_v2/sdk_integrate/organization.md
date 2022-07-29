# 组织架构相关API

> 所有API中需要用到的`operationID`为随机字符串，通常用于定位问题使用，建议每一次API调用均采用唯一ID，可通过npm包uuid生成。<br/>存在callback的API，callback的回调参数格式为统一格式，errCode为0则代表操作成功，否则为失败。具体参考[此处说明]()。

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
  openIM.getSubDepartment(operationID,departmentID,offset,count,({ data })=>{
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



## getDepartmentMember

> 获取某个部门下成员列表

- Example:

  ```js
  openIM.getDepartmentMember(operationID,departmentID,offset,count,({ data })=>{
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
  openIM.getUserInDepartment(operationID,userID,({ data })=>{
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
  openIM.getDepartmentMemberAndSubDepartment(operationID,departmentID,({ data })=>{
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
  openIM.getDepartmentInfo(operationID,departmentID,({ data })=>{
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
  const options = {
    keyWord: "",
    isSearchUserName: true,
    isSearchEnglishName: false,
    isSearchPosition: false,
    isSearchUserID: false,
    isSearchMobile: false,
    isSearchEmail: false,
    isSearchTelephone: false,
  }
  openIM.searchOrganization(operationID,options,offset,count,({ data })=>{
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







# 组织架构相关回调

> 相关回调需要通过导入`globalEvent`进行监听，引入步骤参考[SDK引入]()。

| 事件                  | 描述                 | 响应 |
| --------------------- | -------------------- | ---- |
| onOrganizationUpdated | 组织架构中信息有变动 | -    |