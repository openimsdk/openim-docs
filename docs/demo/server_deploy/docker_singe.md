# Docker部署-初次部署

## 服务器配置

> Linux系统，当前可用内存2G及以上

## 安装docker

要求docker版本1.13以上，docker-compose版本1.22以上

## 一键部署

如果确定是首次安装，可以直接采用如下命令完成1-4步

``` 
git clone https://github.com/OpenIMSDK/Open-IM-Server.git --recursive; cd Open-IM-Server/script ; chmod +x *.sh ; ./env_check.sh;cd .. ; docker-compose up -d;cd script ; ./docker_check_service.sh
```

## 1.克隆 

```
git clone https://github.com/OpenIMSDK/Open-IM-Server.git --recursive
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

## 5.端口开放

需要开通外网端口(TCP)：17778（消息，必须开），10000（API，必须开）， 30000（jssdk专用，需要才开）， 42233 （短信验证码端口，需要才开），25（邮箱验证码端口，需要才开）

如果check成功，但是端口连接不上，一般是端口开放或者防火墙问题导致。

当然也可以不开通以上端口，而通过nginx做转发。

# docker部署-更新镜像

## 一键更新

如果本地配置没有任何修改，可以直接采用如下命令完成1-5步

```
docker-compose down ; git checkout main -f ; git pull -f ; docker-compose pull;chmod +x script/*.sh ; docker-compose up -d; cd script ; ./docker_check_service.sh
```

## 1.关闭服务

```
cd Open-IM-Server ; docker-compose down
```

## 2.拉取最新配置文件和脚本文件

```
git pull
```

## 3.拉取新的镜像

```
docker-compose pull
```

## 4.重新启动服务

```
chmod +x script/*.sh ; docker-compose up -d
```

## 5.检查

```
cd script ; ./docker_check_service.sh
```

# 注意事项

## 1.系统和环境

目前只支持Linux系统，其他系统请修改脚本。

可用内存在2G以上，请调用./env_check.sh检测。

## 2.更新

在git pull时，确保拉取了最新的配置，特别是对于改动了本地配置文件的开发者，需重点关注。

## 3.build

尽量不要混合启动，自行build，然后通过docker-compose启动会存在问题。因为docker映射，导致本地二进制文件、配置文件不一致，造成混乱。

## 4.OpenIM测试服务

IP：121.37.25.71/

请大家自己的真实的手机号测试，如果和其他人重复，会被踢下线。
