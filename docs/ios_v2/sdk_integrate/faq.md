
### 常见问题

1. 提醒: 在调用sdk相关API返回“resource loading is not complete”
    如果出现该问题，需在login的callback以后调用其它API。

2. 提醒：“target has transitive dependencies that include statically linked binaries”？
    如果在 pod 过程中出现该错误，是因为 UIKit 使用到了第三方静态库，需要在 podfile 中注释掉 use_frameworks!。
    如果在某种情况下，需要使用use_frameworks!，则请使用 cocoapods 1.9.0及以上版本进行 pod install，并修改为：
    ```ruby
        use_frameworks! :linkage => :static
    ```
    如果您使用的是 swift，请将头文件引用改成 @import 模块名形式引用。
3. 提醒：有开发者发现，目前M1芯片build会出现报错，添加arm64后正常，真机去掉arm64正常。
![WeChat53896c52f31d22703d323db7aacfeba7](https://user-images.githubusercontent.com/99468005/177078181-7c7614b6-4282-4f1f-bf4a-e7af105ec4b6.png)
4. 提醒：有开发者发现，报错“找不到xxx模块”,做如下操作可解决：
    ```ruby
    pod deintegrate；
    Clean(Command + K)；
    pod install/update
    ```
