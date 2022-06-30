##### 1，demo对应的flutter版本是？

答：stable分支3.0.1

##### 2，支持哪些平台？

答：因为sdk的原因demo目前只能运行在android跟ios设备上

##### 3，android安装包debug可以运行但release启动白屏？

答：flutter的release包默认是开启了混淆，可以使用命令：flutter build release --no -shrink，如果此命令无效可如下操作

在android/build.gradle配置的release配置加入以下配置

```
release {
    minifyEnabled false
    useProguard false
    shrinkResources false
}
```

##### 4，代码必须混淆怎么办？

答：在混淆规则里加入以下规则

```
-keep class io.openim.**{*;}
-keep class open_im_sdk.**{*;}
-keep class open_im_sdk_callback.**{*;}
```

##### 5，android安装包不能安装在模拟器上？

答：因为Demo去掉了某些cpu架构，如果你想运行在模拟器上请按以下方式：

在android/build.gradle配置加入

```
ndk {
    abiFilters "arm64-v8a", "armeabi-v7a", "armeabi", "x86", "x86_64"
}
```

##### 6，ios构建release包报错

答：请将cup架构设置为arm64，然后依次如下操作

- flutter clean
- flutter pub get
- cd ios
- pod install
- 连接真机后运行Archive

![ios cpu](https://user-images.githubusercontent.com/7018230/155913400-6231329a-aee9-4082-8d24-a25baad55261.png)

##### 7，ios运行的最低版本号？

答：13.0

##### 8，图片服务器支持哪些？

答：图片服务器目前有cos（腾讯云），minio（自搭建），oss（阿里云）可选，在调用initSDK方法的时候，objectStorage传值“cos”，“monio或”oss“就可以实现图片服务器设置。
