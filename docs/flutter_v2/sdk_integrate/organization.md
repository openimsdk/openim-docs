#### OrganizationManager（组织架构管理）

| 方法                    | 描述                                           |
| ----------------------- | ---------------------------------------------- |
| setOrganizationListener | 组织架构发生变化回调                           |
| getSubDept              | 获取子部门列表，返回当前部门下的一级子部门     |
| getDeptMember           | 获取部门下的成员列表，返回当前部门下的一级成员 |
| getUserInDept           | 获取成员所在的部门                             |
| getDeptMemberAndSubDept | 获取部门下的子部门跟员工                       |
| getDeptInfo             | 查询部门信息                                   |
| searchOrganization      | 搜索组织人员                                   |



#### OnOrganizationListener（组织架构监听）

| 方法                  | 描述             |
| --------------------- | ---------------- |
| onOrganizationUpdated | 组织架构发生变化 |



#### getSubDept（获取子部门列表，返回当前部门下的一级子部门）

```
var list = await OpenIM.iMManager.organizationManager.getSubDept(
  departmentID: '', // 部门id
  offset: 0, // 开始下标
  count: 40, // 每页大小
);
```



- #### getDeptMember（获取部门下的成员列表，返回当前部门下的一级成员）

```
var list = await OpenIM.iMManager.organizationManager.getDeptMember(
	departmentID: '', // 部门id
	offset: 0, // 开始下标
	count: 40, // 每页大小
);
```



#### getUserInDept（获取成员所在的部门）

```
var list = await OpenIM.iMManager.organizationManager.getUserInDept(
	userID: '', // 成员id
);
```



#### getDeptMemberAndSubDept（获取部门下的子部门跟员工）

```
var detail = await OpenIM.iMManager.organizationManager.getDeptMemberAndSubDept(
	departmentID: '', // 部门id
);
```



#### getDeptInfo（查询部门信息）

```
var info = await OpenIM.iMManager.organizationManager.getDeptInfo(
  departmentID: '', // 部门id
);
```



#### searchOrganization（搜索组织人员）

```
var result = await OpenIM.iMManager.organizationManager.searchOrganization(
  keyWord: searchCtrl.text.trim(),
  isSearchUserName: true, // 搜索结果包含用户名
  isSearchEnglishName: true, // 是否包含英文名
  isSearchPosition: true, // 包含职位
  offset: offset, // 分页开始下标
  count: count, // 默认页面大小
);
```