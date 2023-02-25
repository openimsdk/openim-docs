# OpenIM部署文档

## 一、**准备工作**

| 注意事项                            | 详细说明                                                     |
| ----------------------------------- | ------------------------------------------------------------ |
| 运行环境                            | linux系统即可， Ubuntu 7.5.0-3ubuntu1~18.04最优，root用户    |
| 图片视频文件存储                    | 支持cos/MinIO                                                |
| https/wss协议                       | 1. 需申请域名或者子域名（web im端登录注册及im 服务端使用）建议：web.xx.xx <br>2. 若使用MinIO作为对象存储，建议：storage.xx.xx <br>3. 管理后台子域名，建议：admin.xx.xx 4. 部署nginx，并配置证书。 |
| 离线推送（app被杀死或未启动时推送） | 国内申请申请厂商通道以及个推，建议提前申请；海外申请firebase； |
| 苹果开发者账号                      | 如需打包、上架，请自行申请账号                               |
| 手机验证码服务                      | 请自行申请阿里云，建议提前申请                               |
| 消息加密存储                        | 需购买消息加密插件                                           |
| 组织架构                            | 需购买组织架构模块                                           |
| 机器资源                            | 如果用户量小于10万，可用单机部署，8C 16G 5Mb 1T普通磁盘即可  |
| logo                                | 1024 x 1024png                                               |
| 软著                                | 如需上架国内市场，提前准备软著                               |
| 管理后台                            | 需购买                                                       |
| go/git/docker/docker-compose        | 具体参考：https://doc.rentsoft.cn/#/component/docker         |

## 二、**docker-compose一键部署**

先准备go/git/docker/docker-compose，具体参考：https://doc.rentsoft.cn/#/component/docker

单机环境下的组件部署，可以通过docker-compose一键部署，先选择某个大磁盘目录，然后依次输入如下命令：

```
git clone https://github.com/OpenIMSDK/Open-IM-Server.git --recursive;
```

进入Open-IM-Server项目后

1.修改.env 

```
USER=root #不用修改  
PASSWORD=openIM123  #建议修改复杂密码 不能包括 @#之类特殊符号 且至少要8位，仅对redis mysql mongo三个组件密码生效
ENDPOINT=http://127.0.0.1:10005 #使用minio发图片视频文件需要填写 外网ip:10005或者用域名storage.xx.xx
DATA_DIR=./  #指定大磁盘目录
```

2.修改IM配置

config/usualConfig.yaml只需要修改以下信息，组件密码根据.env自动生成。如果未申请个推可以先略过。

```
tokenpolicy:
  accessSecret: "open_im_server" #token生成相关 建议修改
  accessExpire: 90 #token过期时间（天） 默认即可

messageverify:
  friendVerify: false #发送消息是否验证好友关系 false表示不验证好友关系

push:
  getui: #个推离线推送设置
    pushUrl: "https://restapi.getui.com/v2/$appId"
    masterSecret: ""  #需添加
    appKey: ""  #需添加
    enable: false  #true启动个推推送
```

3.修改业务配置

修改docker-compose_cfg/config.yaml，如果未申请阿里云短信可以先略过，默认验证码为666666，且图片存储采用minio

```
chat:
  codeTTL: 300 #短信验证码有效时间(秒)
  superVerificationCode: 666666  #未配置阿里云短信服务时采用此通用验证码
  alismsverify: #阿里云短信配置，在阿里云申请成功后修改以下四项
    accessKeyId:  #为空时采用superCode
    accessKeySecret: 
    signName: 
    verificationCodeTemplateCode: 

oss: #如果用minio存储，则不用修改
  tempDir: enterprise-temp # 临时密钥上传的目录
  dataDir: enterprise-data # 最终存放目录
  aliyun:
    endpoint: https://oss-cn-chengdu.aliyuncs.com
    accessKeyID: ""
    accessKeySecret: ""
    bucket: ""
  tencent:
    BucketURL: ""
    serviceURL: https://cos.COS_REGION.myqcloud.com
    secretID: ""
    secretKey: ""
    sessionToken: ""
    bucket: ""
  use: "minio" #如果 aliyun 或者 tencent，则修改对应配置项
```

4.初始化部署并启动

```
chmod +x install_im_server.sh;
./install_im_server.sh;
```

如果执行过install_im_server.sh，则config/usualConfig.yaml根据.env的配置已经修改完成了，且组件也安装完毕，ETCD 2. MySQL 3. MongoDB 4. Redis 5. Kafka 6. Minio（注：如果使用三方云服务器存储媒体文件可不搭建） 

可能存在的问题：如果非首次安装，可能env密码不能生效，如果数据不重要，先docker-compose down ; rm -rf components再执行以上步骤，需要注意的是app需要重新安装。

5.检查服务

```
cd script;
./docker_check_service.sh
```

## 三、开源版**Open-IM-Server 源码编译**

1. 安装[Go环境](https://golang.org/doc/install)。确保Go版本至少为1.15。
2. 下载源码到服务器

```shell
git clone https://github.com/OpenIMSDK/Open-IM-Server.git --recursive 
cd cmd/Open-IM-SDK-Core
git checkout main
```

3. 设置脚本权限

```shell
cd ../../script/
chmod +x *.sh
```

4. 编译源码

```shell
./batch_build_all_service.sh
```

出现all services build success表示编译成功

## 四、Open-IM-Server修改配置&启动服务

1. 修改配置

如果组件未自行安装，则先执行（二），如果要修改ip port等非常用信息，需要在config/config.yaml中修改。

2. 启动服务

```
cd script
./start_all.sh 
```

3. 检查服务

```
./check_all.sh
```

 出现all services launch success表示服务启动成功 

（二）（三）（四）操作完成后，实际上完成了混合部署模式，即docker部署组件，IM源码部署。

## 五、nginx配置参考

用业务申请的web.xx.xx/storage.xx.xx/admin.xx.xx分别替换open-im-ng-example.conf中web.rentsoft.cn /storage.rentsoft.cn/admin.rentsoft.cn三个域名及对应的证书

```
upstream im_msg_gateway{
            server 127.0.0.1:10001;        #IM消息服务器地址 根据部署情况可指定多台
            }
upstream im_api{
            server 127.0.0.1:10002;        #IM群组用户api服务器地址 根据部署情况可指定多台
            }
upstream im_jssdk_gateway{
            server 127.0.0.1:10003;        #IM jssdk服务器地址 根据部署情况可指定多台
            }
upstream im_demo{
            server 127.0.0.1:10004;        #IM demo登录注册服务器地址 根据部署情况可指定多台
            }
upstream storage {
            server 127.0.0.1:10005;                #MinIO服务器地址 暂时支持1台
            }
upstream im_admin{
            server 127.0.0.1:10006;        #IM admin服务器地址 根据部署情况可指定多台
            }
upstream im_grafana{
            server 127.0.0.1:10007;        #IM 统计服务器地址 docker-compose启动所在机器
            }
upstream im_chat{
            server 127.0.0.1:10008;        #IM 商业版登录注册服务器地址 根据部署情况可指定多台
            }
upstream im_complete_admin{
            server 127.0.0.1:10009;         #IM 商业版admin地址 根据部署情况可指定多台
            }
upstream im_organization{
            server 127.0.0.1:10010;        #IM 商业版组织架构服务器地址 根据部署情况可指定多台
            }
upstream im_open_rtc{
            server 127.0.0.1:7880;        #rtc 音视频通话 服务器地址 根据部署情况可指定多台
            }

server {
        listen 443;
        server_name web.rentsoft.cn;   #1 web im 端 域名

        ssl on;
        ssl_certificate /etc/nginx/conf.d/ssl/web.rentsoft.cn.crt; #2 证书
        ssl_certificate_key /etc/nginx/conf.d/ssl/web.rentsoft.cn.key; #3 证书
        ssl_session_timeout 5m;
		gzip on;
		gzip_min_length 1k;
		gzip_buffers 4 16k;
		gzip_comp_level 2;
		gzip_types text/plain application/javascript application/x-javascript text/css application/xml text/javascript application/x-httpd-php image/jpeg image/gif image/png application/wasm;
		gzip_vary off;
		gzip_disable "MSIE [1-6]\.";
        error_page 405 =200 $uri;

	default_type application/wasm;
        location /{ #web demo
                proxy_set_header Host $host;
                proxy_set_header X-Real-Ip $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
                proxy_set_header X-NginX-Proxy true;
                root /data1/online/Pc-Web-Demo/build/; # web im静态资源存放路径
                index index.html;
                try_files $uri $uri/ /index.html;
        }
        location /msg_gateway { #10001 ws
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "Upgrade";
                proxy_set_header X-real-ip $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
                proxy_pass http://im_msg_gateway/;
        }
        location ^~/api/ { #10002 api
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "Upgrade";
                proxy_set_header X-real-ip $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
                proxy_pass http://im_api/;
               }
        location /jssdk_gateway { #10003 jssdk
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "Upgrade";
                proxy_set_header X-real-ip $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
                proxy_pass http://im_jssdk_gateway/;
               }
        location ^~/demo/ { # 10004 demo
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "Upgrade";
                proxy_set_header X-real-ip $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
                proxy_pass http://im_demo/;
               }
        location ^~/admin/ { #10006 admin
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "Upgrade";
                proxy_set_header X-real-ip $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
                proxy_pass http://im_admin/;
               }
        location ^~/grafana/ { #10007  prometheus
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "Upgrade";
                proxy_set_header X-real-ip $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
                proxy_pass http://im_grafana/;
               }
        location ^~/chat/ { #10008 chat login
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "Upgrade";
                proxy_set_header X-real-ip $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
                proxy_pass http://im_chat/;
               }
        location ^~/complete_admin/ { #10009  admin
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "Upgrade";
                proxy_set_header X-real-ip $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
                proxy_pass http://im_complete_admin/;
               }
        location ^~/organization/ { #10010 organization
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "Upgrade";
                proxy_set_header X-real-ip $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
                proxy_pass http://im_organization/;
               }
        location ^~/open_rtc/ {  #7880 rtc
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "Upgrade";
                proxy_set_header X-real-ip $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
                proxy_pass http://im_open_rtc/;
              }
}

server {
        listen 80;
        server_name web.rentsoft.cn ; #1 web im 端 域名
        rewrite ^(.*)$ https://${server_name}$1 permanent;
}

server {
        ssl_session_timeout 5m;
	listen 443;
        server_name storage.rentsoft.cn; #1 MinIO存储域名
        ssl on;
        ssl_certificate /etc/nginx/conf.d/ssl/storage.rentsoft.cn.crt; #证书
        ssl_certificate_key /etc/nginx/conf.d/ssl/storage.rentsoft.cn.key;    #证书
        gzip on;
        gzip_min_length 1k;
        gzip_buffers 4 16k;
        gzip_comp_level 2;
        gzip_types text/plain application/javascript application/x-javascript text/css application/xml text/javascript application/x-httpd-php image/jpeg image/gif image/png;
        gzip_vary off;
        gzip_disable "MSIE [1-6]\.";
    location / {
            proxy_pass http://storage;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header Host $http_host;
            proxy_http_version 1.1;
            client_max_body_size 8000M;
    }
}


server {
        listen 443;
        server_name admin.rentsoft.cn; #后台管理域名
        ssl on;
        ssl_certificate /etc/nginx/conf.d/ssl/admin.rentsoft.cn.crt; # 证书
        ssl_certificate_key /etc/nginx/conf.d/ssl/admin.rentsoft.cn.key; #证书
        ssl_session_timeout 5m;
        gzip on;
        gzip_min_length 1k;
        gzip_buffers 4 16k;
        gzip_comp_level 2;
        gzip_types text/plain application/javascript application/x-javascript text/css application/xml text/javascript application/x-httpd-php image/jpeg image/gif image/png;
        gzip_vary off;
        gzip_disable "MSIE [1-6]\.";
        location / {
                proxy_set_header Host $host;
                proxy_set_header X-Real-Ip $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
                proxy_set_header X-NginX-Proxy true;
                root /data1/online/Open-IM-Admin/dist/; #管理后台web静态资源存放路径
                index index.html;
                try_files $uri $uri/ /index.html;
        }
}

server {
        listen 80;
        server_name admin.rentsoft.cn; #管理后台 域名
        rewrite ^(.*)$ https://${server_name}$1 permanent;
}


```

# 六、端口开放及访问路由

## IM

如果按照（五）做了nginx配置，仅开放443和80端口即可。如果未配置nginx，则开发10001-10010端口即可，需要注意的时候访问路径有调整，具体查看下表的对应关系。

| IM端口    | 说明               | 访问说明                           | 对应关系                                           |
| --------- | ------------------ | ---------------------------------- | -------------------------------------------------- |
| TCP:10001 | IM ws消息          | 在域名和路由之间增加msg_gateway    | wss://test.xx.xx/msg_gateway->ws://ip:10001        |
| TCP:10002 | IM api             | 在域名和路由之间增加api            | https://test.xx.xx/api->http://ip:10002            |
| TCP:10003 | ws端口 jssdk的专用 | 在域名和路由之间增加jssdk_gateway  | wss://test.xx.xx/jssdk_gateway->ws://ip:10003      |
| TCP:10004 | demo注册登录       | 在域名和路由之间增加demo           | https://test.xx.xx/demo->http://ip:10004           |
| TCP:10005 | minio存储时        |                                    |                                                    |
| TCP:10006 | IM 后台管理        | 在域名和路由之间增加admin          | https://test.xx.xx/admin->http://ip:10006          |
| TCP:10007 | 数据统计           |                                    |                                                    |
| TCP:10008 | 商业版业务         | 在域名和路由之间增加chat           | https://test.xx.xx/chat->http://ip:10008           |
| TCP:10009 | 商业版管理后台     | 在域名和路由之间增加complete_admin | https://test.xx.xx/complete_admin->http://ip:10009 |
| TCP:10010 | 商业版组织架构     | 在域名和路由之间增加organization   | https://test.xx.xx/organization->http://ip:10010   |
|           |                    |                                    |                                                    |

##  音视频通话（付费用户才有）

| RTC端口   | 说明       | 操作                                   |
| --------- | ---------- | -------------------------------------- |
| TCP: 7880 | 音视频通话 | wss://web.xx.xx/open_rtc->ws://ip:7880 |
| TCP: 7881 | 音视频通话 | 直接开通端口，不走nginx反向代理        |
| UDP: 7882 | 音视频通话 | 直接开通端口，不走nginx反向代理        |

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 
