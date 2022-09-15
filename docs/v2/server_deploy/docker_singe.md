# Docker部署-初次部署
```
docker部署简要说明,docker是一种虚拟容器化技术,用于支持创建和使用容器并与外部环境隔离,使用docker能够快速高效搭建起服务器。
```
## 搭建环境说明
```
OpenIM使用的组件包含MQ和各种数据库组件,保证系统当前可用内存在2G及以上,官方使用docker版本为20.10.14,docker-compose版本为1.24.1,如果用户的系统没有安装docker以及docker-compose可以参照docker以及docker-compose环境搭建。
```

## 一键部署

如果确定是首次安装，可以直接采用如下命令完成1-4步

``` 
git clone https://github.com/OpenIMSDK/Open-IM-Server.git --recursive; cd Open-IM-Server/script ; chmod +x *.sh ; ./env_check.sh;cd .. ; docker-compose up -d;cd script ; ./docker_check_service.sh
```

## 1.克隆 

```
git clone https://github.com/OpenIMSDK/Open-IM-Server.git --recursive（注:如果服务器网络不好,或者没有vpn代理无法获取github代码,可以自行前往该地址,获取最新tag代码并上传到服务器）
```

## 2.检测环境

```
cd Open-IM-Server/script ; chmod +x *.sh ; ./env_check.sh
```

![环境监测](../../images/docker_deploy_env.png)

目前仅支持Linux系统，并且保证当前可用内存在2G以上，系统才能正常运转。在生产环境中，建议可用内存在4G以上。

## 3.拉取&启动

```
cd .. ; docker-compose up -d
```

## 4.检查

```
cd script ; ./docker_check_service.sh
```

**![检测进程](../../images/docker_deploy_suc.png)**

如图所示，表示正常启动。

## 5.IM开放端口

| IM端口    | 说明                                    | 操作                                |
| --------- | --------------------------------------- | ----------------------------------- |
| TCP:10001（之前的17778端口） | ws协议，消息端口，比如消息发送，推送等。  | 端口放行或nginx反向代理，关闭防火墙 |
| TCP:10002（之前的10000端口）| api端口，比如用户、好友、群组等接口。     | 端口放行或nginx反向代理，关闭防火墙 |
| TCP:10003（之前的30000端口）| ws协议，针对jssdk的专用端口。           | 端口放行或nginx反向代理，关闭防火墙 |
| TCP:10004（之前的42233端口）| demo使用的用户注册登录端口。            | 端口放行或nginx反向代理，关闭防火墙 |
| TCP:10005（之前的9000端口）| 选择minio存储时需要开通。(openIM的demo默认使用minio存储) | 端口放行或nginx反向代理，关闭防火墙 |
| TCP:10006（之前的8000端口）| 管理后台api端口，需要管理后台服务时开通。 | 端口放行或nginx反向代理，关闭防火墙 |
| TCP:10007 | 数据统计端口 | 端口放行或nginx反向代理，关闭防火墙 |

注：如果使用nginx做反向代理，则只需要开放443端口即可。至此openIM的服务器已经搭建完毕，可通过[下载体验app修改IP](https://doc.rentsoft.cn/#/v2/validation/app)的方式访问验证。

# Docker部署-更新镜像
```
docker更新镜像说明: openIM发布新的镜像后，会更新项目文件，其中有两个重要文件，config/config.yaml、docker-compose文件会更新，用户如果修改过这两个文件，在使用git pull可能会有冲突，需要自行备份，然后比对，解决冲突，重新放置到项目目录中。
```

## 一键更新

如果本地配置没有任何修改，可以直接采用如下命令完成1-5步

```
docker-compose down ; git checkout main -f ; git pull -f ; docker-compose pull;chmod +x script/*.sh ; docker-compose up -d; cd script ; ./docker_check_service.sh
```

## 1.关闭服务

```
cd Open-IM-Server ; docker-compose down
```
## 2.备份修改过的文件
```
一般是config/config.yaml文件,可将其重命名为config_bak.yaml
```
## 3.拉取最新配置文件和脚本文件

```
git pull
```
## 4.修改配置文件冲突
```
一般是config/config.yaml文件冲突，将备份文件config_bak.yaml和新版本config.yaml比对合并
```
## 5.拉取新的镜像

```
docker-compose pull
```

## 6.重新启动服务

```
chmod +x script/*.sh ; docker-compose up -d
```

## 7.检查

```
cd script ; ./docker_check_service.sh
```

# 注意事项

## 1.系统和环境

目前只支持Linux系统，其他系统请修改脚本。

可用内存在2G以上，请调用./env_check.sh检测。

## 2.更新

在git pull时，确保拉取了最新的配置（包含config文件新版本增加的配置以及docker-compose文件中新docker镜像版本号），特别是对于改动了本地配置文件的开发者，需自行备份文件，解决冲突。

## 3.build

尽量不要混合启动，自行build，然后通过docker-compose启动会存在问题。因为docker映射，导致本地二进制文件、配置文件不一致，造成混乱。

## 4.OpenIM测试服务

IP：121.37.25.71/

请大家自己的真实的手机号测试，如果和其他人重复，会被踢下线。

