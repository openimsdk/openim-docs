OpenIM系统会使用使用的第三方服务包括对象存储，离线推送(配置文件在项目的config/config.yaml文件中)

短信验证码仅仅在demo中使用，可自行替换，或者采用默认超级验证码666666

### 1、对象存储服务（用于图片、视频、语音...文件的上传）

目前支持的三种对象存储服务（三选一即可）:

- 腾讯云cos: （腾讯云对象存储服务，前往腾讯云注册账号获取相应密钥信息）

- minio:（私有化对象存储服务器，openIM系统默认携带该组件启动，端口为10005，用户的媒体文件都会存储到minio中，需要服务器有足够存储空间以及带宽，保证上传和下载速度）

- 阿里云oss:（阿里云对象存储服务，前往阿里云注册账号获取相应密钥信息）

  ```
  #对象存储服务，以下配置二选一，目前支持两种，腾讯云和minio，二者配置好其中一种即可（如果使用minio参考https://doc.rentsoft.cn/#/qa/minio搭建minio服务器）
  credential: #腾讯cos，发送图片、视频、文件时需要，请自行申请后替换，必须修改
    tencent:
      appID:  
      region:  
      bucket:  
      secretID:  
      secretKey:  
    minio: #MinIO 发送图片、视频、文件时需要，请自行申请后替换，必须修改。 客户端初始化InitSDK，中 object_storage参数为minio
      bucket: openim # 存储内容桶
      appBucket: app # 存储app的桶
      location: us-east-1
      endpoint: http://127.0.0.1:10005 #minio外网ip 这个ip是给客户端访问的
      endpointInner: http://127.0.0.1:10005 #minio内网地址 如果im server 可以通过内网访问到 minio就可以填写
      endpointInnerEnable: true #是否启用minio内网地址 启用可以让桶初始化，IM server连接minio走内网地址访问
      accessKeyID: user12345
      secretAccessKey: key12345
    ali: # ali oss
      regionID:  
      accessKeyID: ""
      accessKeySecret: ""
      stsEndpoint:  
      ossEndpoint:  
      bucket:  
      finalHost:  
      stsDurationSeconds:  
      OssRoleArn:  
  ```

  

### 2、离线推送服务（用于用户不在线时的推送通知）

目前支持两种离线推送服务(二选一即可)：

- 极光推送：(极光离线推送服务，前往极光推送注册账号获取相应密钥信息)

- 个推推送:（个推离线推送服务，前往个推推送注册账号获取相应密钥信息）

  ```
  ## 推送只能开启一个 enable代表开启
  push:
    tpns: #腾讯推送，暂未测试 暂不要使用
      ios:
        accessID:  
        secretKey:  
      android:
        accessID: 111
        secretKey: 111
      enable: false
    jpns: #极光推送 在极光后台申请后，修改以下四项，必须修改
      appKey:  
      masterSecret:  
      pushUrl:  
      pushIntent:  
      enable: true
    getui:  #个推推送
      pushUrl:  
      masterSecret:  
      appKey:  
      intent:  
      enable: false
  ```

  ### 3、短信验证码服务（用于demo中发送短信验证码使用，不需要demo服务的可忽略）

  ```
  #是否启动demo，如果自身没有账号体系，设置为true
  demoswitch: true
  demo:
    listenIP: 0.0.0.0
    #demo对外服务端口，默认即可，需要开放此端口或做nginx转发
    openImDemoPort: [ 10004 ]
    alismsverify: #阿里云短信配置，在阿里云申请成功后修改以下四项，enable为true则必须修改，阿里云为默认短信验证方式
      accessKeyId:  
      accessKeySecret:  
      signName:  术
      verificationCodeTemplateCode:  
      enable: true
    superCode: 666666 #超级验证码，建议修改掉，收不到短信验证码时可以用此替代
    #  second
    codeTTL: 300
  ```

  

