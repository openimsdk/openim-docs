
### 常见问题

1. 提醒: 在调用sdk相关API返回“resource loading is not complete”
    如果出现该问题，需在login的callback以后调用其它API。

2. 提醒：“target has transitive dependencies that include statically linked binaries”？
    如果在 pod 过程中出现该错误，是因为 TUIKit 使用到了第三方静态库，需要在 podfile 中注释掉 use_frameworks!。
    如果在某种情况下，需要使用use_frameworks!，则请使用 cocoapods 1.9.0及以上版本进行 pod install，并修改为：
    ```ruby
        use_frameworks! :linkage => :static
    ```
    如果您使用的是 swift，请将头文件引用改成 @import 模块名形式引用。
