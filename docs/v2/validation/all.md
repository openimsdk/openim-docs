# 快速体验

## （1）安装golang/docker-compose/git

[](https://doc.rentsoft.cn/#/component/docker)

注意：建议使用docker版本为20.10.14, docker-compose版本为1.24.1

## （2）docker-compose一键部署服务端

```
git clone https://github.com/OpenIMSDK/Open-IM-Server.git --recursive; cd Open-IM-Server/script ; chmod +x *.sh ; ./env_check.sh;cd .. ; docker-compose up -d;cd script ; ./docker_check_service.sh
```

确保能访问github

## （2）修改配置文件

打开服务端config/config.yaml

```
minio: #MinIO 发送图片、视频、文件时需要，请自行申请后替换，必须修改。 客户端初始化InitSDK，
    endpoint: http://127.0.0.1:10005 #用服务器外网ip替换127.0.0.1
```

重启  

```
 docker-compose up -d;cd script ; ./docker_check_service.sh
```

## （3）开放端口

[OpenIM开放端口说明](https://doc.rentsoft.cn/#/v2/server_deploy/docker_singe?id=_5im%e5%bc%80%e6%94%be%e7%ab%af%e5%8f%a3)

## （4）客户端修改ip

[app验证](https://doc.rentsoft.cn/#/v2/validation/app)

