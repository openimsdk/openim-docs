# OpenIM 在windows下面的编译和部署

## 版本软件
git

## 编译软件
### golang安装
用途：编译源代码

官方网站: https://go.dev/

推荐版本: 1.17.*

下载链接：https://go.dev/dl/go1.17.11.windows-amd64.msi

(1.18版本没有测试过，可以的话，可以上1.18版本的)

安装部署：默认安装，过程略略略

环境配置:
1. 增加一个 GOPROXY配置: https://goproxy.cn,direct
```
REM 用管理员权限执行命令行
setX GOPROXY https://goproxy.cn,direct /M
```

#### golang的gcc支持
用途： 代码中用了cgo，需要用gcc来支持。
两种方案,任选其一:

1.TMD-GCC 

网址： http://tdm-gcc.tdragon.net/download

安装过程 略略略

2.MinGW  

网址: https://sourceforge.net/projects/mingw-w64/files/

安装过程 略略略

### java(jre)安装

用途：底层软件zookeeper + kafka需要java的支持

官方网站: https://www.java.com/zh-CN/

推荐版本：1.18

下载地址: https://www.java.com/zh-CN/download/

安装过程: 默认安装，过程略略略

## 基础软件

### etcd
用途： 微服务的服务发现等作用

官方网站:https://etcd.io/

推荐版本:最新稳定版本(目前3.5)

下载地址:https://github.com/etcd-io/etcd/releases/download/v3.5.4/etcd-v3.5.4-windows-amd64.zip

tree %etcd%
```
 |-bin[目录]
 |-|- etcd.exe
 |-|- etcdctl.exe
 |-|- etcdutl.exe
 |-etcd.cmd [新加]
 |-data[目录]
```
启动命令:
etcd.cmd 启动etcd的脚本,内容如下
```
%cd%/bin/etcd.exe --name etcd0 --data-dir %cd%/data --listen-client-urls http://0.0.0.0:2379 --advertise-client-urls http://0.0.0.0:2379 --listen-peer-urls http://0.0.0.0:2380 --initial-advertise-peer-urls http://0.0.0.0:2380 --initial-cluster etcd0=http://0.0.0.0:2380 --initial-cluster-token tkn --initial-cluster-state new 
```
### minio
用途： 自建文件存储

腾讯云 或者 阿里云 使用者(土豪，请收下我的膝盖) 可以忽略此部分。

官方网站:https://min.io/

源码编译:
```
git clone https://github.com/minio/minio.git
cd minio
git checkout RELEASE.2022-06-30T20-58-09Z
go mod tidy
go build
```
启动：
```
SET MINIO_ROOT_USER=minio
SET MINIO_ROOT_PASSWORD=OpenIMOpenIM
%cd%/minio.exe server %cd%/data/ --console-address ":9999" --address ":10005"
```
上面设置了minio的用户名以及密码，建议修改，密码长度8位+，不然没法启动
### mysql

官方网站: http://www.mysql.com

推荐版本: 5.7 

官方下载

安装过程：在安装过程中需要指定数据库密码。后面需要用到。

启动 
> net start mysql

停止
>net stop mysql
### mongodb

官方网址:https://www.mongodb.com/

推荐版本: 版本 4.0

官方下载：https://fastdl.mongodb.org/win32/mongodb-win32-x86_64-2008plus-ssl-4.0.28-signed.msi

安装过程：略

启动:
> net start mongodb

停止：
> net stop mongodb

### redis

官方网址：https://redis.io/

推荐版本:最新

下载地址：官方没有提供windows下载，可以在github上面自行搜索。

非官方windows下载：https://github.com/zkteco-home/redis-windows

启动：
net start redis

停止:
net stop redis

### kafka

官方网址:https://kafka.apache.org/

推荐版本：2.13-2.8.1 版本

官方下载：https://archive.apache.org/dist/kafka/2.8.1/kafka_2.13-2.8.1.tgz

启动
```
cd %kafka%
bin\windows\zookeeper-server-start.cmd config\zookeeper.properties
bin\windows\kafka-server-start.cmd config\kafka.properties
```
--------------
## OpenIM在windows编译
上脚本
>%Open-Im-Server%/script/windows_build_all_service.cmd

```
SET ROOT=%cd%
echo %ROOT%
mkdir %ROOT%\..\bin\
cd ..\cmd\open_im_api\ && go build -ldflags="-w -s" && move open_im_api.exe %ROOT%\..\bin\
cd ..\..\cmd\open_im_cms_api\ && go build -ldflags="-w -s" && move open_im_cms_api.exe %ROOT%\..\bin\
cd ..\..\cmd\open_im_demo\ && go build -ldflags="-w -s" && move open_im_demo.exe %ROOT%\..\bin\
cd ..\..\cmd\open_im_msg_gateway\ && go build -ldflags="-w -s" && move open_im_msg_gateway.exe %ROOT%\..\bin\
cd ..\..\cmd\open_im_msg_transfer\ && go build -ldflags="-w -s" && move open_im_msg_transfer.exe %ROOT%\..\bin\
cd ..\..\cmd\open_im_push\ && go build -ldflags="-w -s" && move open_im_push.exe %ROOT%\..\bin\
cd ..\..\cmd\rpc\open_im_admin_cms\&& go build -ldflags="-w -s" && move open_im_admin_cms.exe %ROOT%\..\bin\
cd ..\..\..\cmd\rpc\open_im_auth\&& go build -ldflags="-w -s" && move open_im_auth.exe %ROOT%\..\bin\
cd ..\..\..\cmd\rpc\open_im_cache\&& go build -ldflags="-w -s" && move open_im_cache.exe %ROOT%\..\bin\
cd ..\..\..\cmd\rpc\open_im_conversation\&& go build -ldflags="-w -s" && move open_im_conversation.exe %ROOT%\..\bin\
cd ..\..\..\cmd\rpc\open_im_friend\&& go build -ldflags="-w -s" && move open_im_friend.exe %ROOT%\..\bin\
cd ..\..\..\cmd\rpc\open_im_group\&& go build -ldflags="-w -s" && move open_im_group.exe %ROOT%\..\bin\
cd ..\..\..\cmd\rpc\open_im_message_cms\&& go build -ldflags="-w -s" && move open_im_message_cms.exe %ROOT%\..\bin\
cd ..\..\..\cmd\rpc\open_im_msg\&& go build -ldflags="-w -s" && move open_im_msg.exe %ROOT%\..\bin\
cd ..\..\..\cmd\rpc\open_im_office\&& go build -ldflags="-w -s" && move open_im_office.exe %ROOT%\..\bin\
cd ..\..\..\cmd\rpc\open_im_organization\&& go build -ldflags="-w -s" && move open_im_organization.exe %ROOT%\..\bin\
cd ..\..\..\cmd\rpc\open_im_statistics\&& go build -ldflags="-w -s" && move open_im_statistics.exe %ROOT%\..\bin\
cd ..\..\..\cmd\rpc\open_im_user\&& go build -ldflags="-w -s" && move open_im_user.exe %ROOT%\..\bin\
cd ..\..\..\\cmd\Open-IM-SDK-Core\ws_wrapper\cmd\&& go build -ldflags="-w -s" open_im_sdk_server.go && move open_im_sdk_server.exe %ROOT%\..\bin\
cd %ROOT%
```
先编译一波，完成之后，会在 %Open-IM-Server%/bin/目录下面有对应的exe程序生成。没有的可以看一下日志。 

PS:可以重复执行

## 修改对应的配置
这一步的针对 %Open-Im-Server%/config/config.yaml 文件对应的服务端口跟 帐号+密码 一一对应修改。

## 启动基础软件

MYSQL，ETCD，Mongodb，Redis，Zookeeper，kafka，Minio。

## OpenIM在windows下启动

>%Open-Im-Server%/script/windows_start_all_service.cmd

```
SET ROOT=%cd%
cd %ROOT%\..\bin\
start cmd /C .\open_im_api.exe -port 10002
start cmd /C .\open_im_cms_api.exe -port 10006
start cmd /C .\open_im_user.exe -port 10110
start cmd /C .\open_im_friend.exe -port 10120
start cmd /C .\open_im_group.exe -port 10150
start cmd /C .\open_im_auth.exe -port 10160
start cmd /C .\open_im_admin_cms.exe -port 10200
start cmd /C .\open_im_message_cms.exe -port 10190
start cmd /C .\open_im_statistics.exe -port 10180
start cmd /C .\open_im_msg.exe -port 10130
start cmd /C .\open_im_office.exe -port 10210
start cmd /C .\open_im_organization.exe -port 10220
start cmd /C .\open_im_conversation.exe -port 10230
start cmd /C .\open_im_cache.exe -port 10240
start cmd /C .\open_im_push.exe -port 10170
start cmd /C .\open_im_msg_transfer.exe
start cmd /C .\open_im_sdk_server.exe -openIM_api_port 10002 -openIM_ws_port 10001 -sdk_ws_port 10003 -openIM_log_level 6
start cmd /C .\open_im_msg_gateway.exe -rpc_port 10140 -ws_port 10001
start cmd /C .\open_im_demo.exe -port 10004
cd %ROOT%
```

## windows进程查看

> tasklist |findstr "open_im"

如果没有完全启动成功，可以看下 logs下对应的日志。

## Windows下的防火墙策略
直接上脚本吧
```
REM 用管理员权限执行命令行,作用开启防火墙
netsh advfirewall firewall add rule name=OpenIM dir=in action=allow protocol=tcp localport=10000,10001,10002,10003,10004,10005,10006
```