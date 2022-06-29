#### 1，添加依赖到yaml

       flutter_openim_sdk: latest

SDK版本号参考：https://pub.flutter-io.cn/packages/flutter_openim_sdk

#### 2，导入包

      import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';

#### 3，初始化

#### 4，设置监听器

#### 5，登录



#### 注：

1，SDK只能初始化一次。

2，在登录前必须设置各监听器， 如：好友监听，组监听，会话监听，消息监听等。

3，在做登录登出操作时的后续操作必须等待sdk回调结束后做下一步操作。

