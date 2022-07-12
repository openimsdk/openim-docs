#### 1.页面初始化

初始化网页时获取app数据，如登录token等。

```
// 页面加载是调用
window.addEventListener("flutterInAppWebViewPlatformReady", function(event) {
			// 获取登录凭证，返回结果：{"userID":"","token":""}
      window.flutter_inappwebview.callHandler('getLoginCertificate').then(function(result) {
        // print to the console the data coming
        // from the Flutter side.
        console.log(JSON.stringify(result));
 });
});
```



#### 2.获取设备信息

```
function getDeviceInfo(){
  window.flutter_inappwebview.callHandler('getDeviceInfo')
      .then(function(result) {
        // print to the console the data coming
        // from the Flutter side.
        console.log(JSON.stringify(result));
  });
}
```



#### 3.获取当前app语言

```
function getAppLanguage(){
 // 返回结果：zh:中文，en:英文, defualt:跟随系统
  window.flutter_inappwebview.callHandler('getAppLanguage')
      .then(function(result) {
        // print to the console the data coming
        // from the Flutter side.
        console.log(JSON.stringify(result));
    });
}
```



#### 4.显示原生样式对话框

```
function showDialog(){
	// true 确认，false 取消
  window.flutter_inappwebview.callHandler('showDialog',{'title':'原生对话框','rightBtnText':'确认','leftBtnText':'取消'}).then(function(result){
        // print to the console the data coming
        // from the Flutter side.
        console.log(JSON.stringify(result));
  });
}
```



#### 5.原生toast

```
function showToast(){
  window.flutter_inappwebview.callHandler('showToast','编辑完成!');
}
```



#### 6.获取登录用户信息

```
function getLoginUserInfo(){
	// 返回 UserInfo的Map结构
  window.flutter_inappwebview.callHandler('getLoginUserInfo')
      .then(function(result) {
        // print to the console the data coming
        // from the Flutter side.
       console.log(JSON.stringify(result));
  });
}
```



#### 7.查看用户信息

```
function viewUserInfo(){
  var userID = "来自IM的用户ID";
  window.flutter_inappwebview.callHandler('viewUserInfo',{'userID':userID});
}
```



#### 8.发起群聊

```
// 参数 {"groupType":0,members:[]} ，不传默认打开联系人选择页。
// groupType群类型：参照flutter SDK。members：初始时成员列表。
function createGroupChat(){
   window.flutter_inappwebview.callHandler('createGroupChat');
}
```



#### 9.去聊天

```
// 先查询用户信息，然后发起聊天。如果存在用户信息则直接调用toChat发起聊天
function toChat(){
  var userID = ”用户ID“;
  // 根据用户id查询资料
  window.flutter_inappwebview.callHandler('getUserInfo',userID).then(function(result) {
        // print to the console the data coming
        // from the Flutter side.
       // console.log(result[0].nickname);
       // console.log(JSON.stringify(result));
       var userID = result[0].userID;
       var nickname = result[0].nickname;
       var faceURL = result[0].faceURL;
       // 发起聊天 群聊天 传递groupID,个人聊天传递userID
       window.flutter_inappwebview.callHandler('toChat',{'userID':userID,'nickname':nickname,'faceURL':faceURL,'sessionType':1});
  });
}
```



#### 10.选择组织架构人员

```
function selectOrganizationMember(){
		// 返回 List<DeptMemberInfo> 的List<Map>形式 具体字段参考flutter SDK
   window.flutter_inappwebview.callHandler('selectOrganizationMember').then(function(result) {
        // print to the console the data coming
        // from the Flutter side.
        console.log(JSON.stringify(result));
   });
}
```



#### 11.选择文件

```
function selectFile(input){
   //获取第一个文件对象 （如果有多张时可使用循环files数组改变多个<img>的 src值）
  var file = input.files[0];
  //判断当前是否支持使用FileReader
  if(window.FileReader){
   //创建读取文件的对象
   var fr = new FileReader();
   //以读取文件字符串的方式读取文件 但是不能直接读取file 
   //因为文件的内容是存在file对象下面的files数组中的
   //该方法结束后图片会以data:URL格式的字符串（base64编码）存储在fr对象的result中
   fr.readAsDataURL(file);
   fr.onloadend = function(){
    document.getElementById("image").src = fr.result;
   }
  }
}
```



#### 12.选择相册或相机获取照片并上传

```
 function openPhotoSheet(){
    //参数 {'crop':'是否裁剪','toUrl':'是否上传返回url'}， 不传默认都为true
    //返回结果 {'path': path, 'url': url}
      window.flutter_inappwebview.callHandler('openPhotoSheet').then(function(result) {
       // print to the console the data coming
       // from the Flutter side.
        console.log(JSON.stringify(result));
        console.log(result.path);
        console.log(result.url);
        document.getElementById("avatar").src = 'file:///'+ result.path;
       });          
 }
```



#### 13.存储数据

```
function setStorage(){
	 var data ="";//json字符串
   window.flutter_inappwebview.callHandler('setStorage',data);
}
```



#### 14.获取缓存数据

```
function getStorage(){
	// 返回存储的json字符串
   window.flutter_inappwebview.callHandler('getStorage').then(function(result) {
         // print to the console the data coming
         // from the Flutter side.
         console.log(JSON.stringify(result));
  });
}
```



#### 15.删除缓存 

```
function deleteStorage(){
   window.flutter_inappwebview.callHandler('deleteStorage');
}
```



#### 16.html页面使用原生标题栏

```
// 参数 ： {'isClose':'无历史路径后是否关闭页面','result':'关闭后返回的数据'}
// 不传值默认当无历史路径后直接关闭页面
function goBack(){
   window.flutter_inappwebview.callHandler('goBack');
}
```



## 其他待补充