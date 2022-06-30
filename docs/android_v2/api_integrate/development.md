#### 直接下载app

![Android](https://www.pgyer.com/app/qrcode/OpenIM-Android)



#### 下载源代码

 git clone https://github.com/OpenIMSDK/Open-IM-Android-Demo.git



#### 依赖说明

```
 implementation project(':OUICore') 必要模块
 implementation project(':OUIConversation') 会话相关模块
 implementation project(':OUIGroup') 群组相关模块
 implementation project(':OUIContact') 联系人相关模块
```
#### 开发环境要求
```
Android Studio 3.6.1
Gradle-5.1.1
Android Gradle Plugin Version-3.4.0
android x库
```

#### 开发配置
```
minSdk     : 21
targetSdk  : 32
compileSdk : 32
abiFilters : ['armeabi-v7a', 'arm64-v8a']
```

##### 代码架构
项目采用MVVM+模块化开发，解耦高、业务独立、代码分离、可以方便快捷集成你需要的功能。

