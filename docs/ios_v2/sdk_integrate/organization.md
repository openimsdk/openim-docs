#### OrganizationManager（组织架构管理）

| 方法                    | 描述                                           |
| ----------------------- | ---------------------------------------------- |
| setOrganizationListener | 组织架构发生变化回调                           |
| addOrganizationListener | 组织架构发生变化回调                           |
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
        [OIMManager.manager getSubDepartment:@"" // 部门id
                                      offset:0
                                       count:100
                                   onSuccess:^(NSArray<OIMDepartmentInfo *> * _Nullable departmentList) {
    
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



- #### getDeptMember（获取部门下的成员列表，返回当前部门下的一级成员）

```
        [OIMManager.manager getDepartmentMember:@"" // 部门id
                                         offset:0
                                          count:100
                                      onSuccess:^(NSArray<OIMDepartmentMemberInfo *> * _Nullable members) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### getUserInDept（获取成员所在的部门）

```
        [OIMManager.manager getUserInDepartment:@"" // user id
                                      onSuccess:^(NSArray<OIMUserInDepartmentInfo *> * _Nullable members) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### getDeptMemberAndSubDept（获取部门下的子部门跟员工）

```
        [OIMManager.manager getDepartmentMemberAndSubDepartment:@"" // 部门id
                                                      onSuccess:^(OIMDepartmentMemberAndSubInfo * _Nullable items) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```



#### getDeptInfo（查询部门信息）

```
        [OIMManager.manager getDepartmentInfo:@"" // 部门id
                                    onSuccess:^(NSArray<OIMDepartmentInfo *> * _Nullable departmentList) {
            
        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];

```



#### searchOrganization（搜索组织人员）

```
        OIMSearchOrganizationParam *param = [OIMSearchOrganizationParam new]; // 更多搜索条件，查看头文件
        param.keyword = @"";
        param.isSearchUserName = YES;
        
        [OIMManager.manager searchOrganization:param
                                        offset:0
                                         count:100
                                     onSuccess:^(OIMDepartmentMemberAndSubInfo * _Nullable items) {

        } onFailure:^(NSInteger code, NSString * _Nullable msg) {

        }];
```
