# k8s部署（实验性）
    支持 arm64 以及 x86架构 机器
## 安装视频
![video.html](//player.bilibili.com/player.html?aid=810473986&bvid=BV1j34y1x7jc&cid=568263466&page=1 ':include :type=iframe')

## 安装组件

> Open-IM-Server依赖五大开源组件：**Etcd**、**MySQL**、**MongoDB**、**Redis**、**Kafka**，在使用源码部署Open-IM-Server 前，请确保五大组件已安装。如果没有安装以上组件，建议使用上文的docker部署。

## ConfigMap
### openim配置文件
> 下载configmap模板进行修改 http://public.msypy.xyz/k8syamls/openim/latest/configmap.yaml

> 需要自行修改 `etcd`  `mysql` `mongo` `redis` `kafka` `credential` `log` `push` `manager` `secret` `multiloginpolicy` `tokenpolicy`

> ！！！！！！不要修改 `serverip`

```shell
#kubectl -n ${YourNamespace} apply -f http://public.msypy.xyz/k8syamls/openim/latest/configmap.yaml

kubectl -n ${YourNamespace} apply -f configmap.yaml
```
## StatefulSet
    工作负载和服务发现(ClusterIP)
```shell
kubectl -n ${YourNamespace} apply -f http://public.msypy.xyz/k8syamls/openim/latest/statefulsets/open_im_sdk_server.yaml
kubectl -n ${YourNamespace} apply -f http://public.msypy.xyz/k8syamls/openim/latest/statefulsets/open_im_push.yaml
kubectl -n ${YourNamespace} apply -f http://public.msypy.xyz/k8syamls/openim/latest/statefulsets/open_im_msg_transfer.yaml
kubectl -n ${YourNamespace} apply -f http://public.msypy.xyz/k8syamls/openim/latest/statefulsets/open_im_group.yaml
kubectl -n ${YourNamespace} apply -f http://public.msypy.xyz/k8syamls/openim/latest/statefulsets/open_im_admin_cms.yaml
kubectl -n ${YourNamespace} apply -f http://public.msypy.xyz/k8syamls/openim/latest/statefulsets/open_im_timer_task.yaml
kubectl -n ${YourNamespace} apply -f http://public.msypy.xyz/k8syamls/openim/latest/statefulsets/open_im_statistics.yaml
kubectl -n ${YourNamespace} apply -f http://public.msypy.xyz/k8syamls/openim/latest/statefulsets/open_im_msg.yaml
kubectl -n ${YourNamespace} apply -f http://public.msypy.xyz/k8syamls/openim/latest/statefulsets/open_im_friend.yaml
kubectl -n ${YourNamespace} apply -f http://public.msypy.xyz/k8syamls/openim/latest/statefulsets/open_im_demo.yaml
kubectl -n ${YourNamespace} apply -f http://public.msypy.xyz/k8syamls/openim/latest/statefulsets/open_im_auth.yaml
kubectl -n ${YourNamespace} apply -f http://public.msypy.xyz/k8syamls/openim/latest/statefulsets/open_im_msg_gateway.yaml
kubectl -n ${YourNamespace} apply -f http://public.msypy.xyz/k8syamls/openim/latest/statefulsets/open_im_message_cms.yaml
kubectl -n ${YourNamespace} apply -f http://public.msypy.xyz/k8syamls/openim/latest/statefulsets/open_im_api.yaml
kubectl -n ${YourNamespace} apply -f http://public.msypy.xyz/k8syamls/openim/latest/statefulsets/open_im_user.yaml
kubectl -n ${YourNamespace} apply -f http://public.msypy.xyz/k8syamls/openim/latest/statefulsets/open_im_cms_api.yaml
```

### Ingress
    具体域名  需要自己修改
```yaml
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  # 配置注解 支持websocket
  annotations:
    nginx.ingress.kubernetes.io/proxy-http-version: "1.1"
    nginx.ingress.kubernetes.io/proxy-read-timeout: "3600"
    nginx.ingress.kubernetes.io/proxy-send-timeout: "3600"
  name: sdk-server.openim.xxx.com
spec:
  rules:
  - host: sdk-server.openim.xxx.com
    http:
      paths:
      - backend:
          service:
            name: sdk-server
            port:
              number: 30000
        path: /
        pathType: Prefix
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    nginx.ingress.kubernetes.io/proxy-http-version: "1.1"
    nginx.ingress.kubernetes.io/proxy-read-timeout: "3600"
    nginx.ingress.kubernetes.io/proxy-send-timeout: "3600"
  name: msg-gateway.openim.xxx.com
spec:
  rules:
    - host: msg-gateway.openim.xxx.com
      http:
        paths:
          - backend:
              service:
                name: msg-gateway
                port:
                  number: 17778
            path: /
            pathType: Prefix
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: api.openim.xxx.com
spec:
  rules:
    - host: api.openim.xxx.com
      http:
        paths:
          - backend:
              service:
                name: api
                port:
                  number: 10000
            path: /
            pathType: Prefix
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: demo.openim.xxx.com
spec:
  rules:
    - host: demo.openim.xxx.com
      http:
        paths:
          - backend:
              service:
                name: demo
                port:
                  number: 42233
            path: /
            pathType: Prefix

```

## 测试
> 服务运行情况

![k9s.png](https://public.msypy.xyz/k8syamls/openim/latest/examples/k9s.png)

> 在线测试地址 http://121.37.25.71:23232/login

![config.png](https://public.msypy.xyz/k8syamls/openim/latest/examples/config.png)

> 聊天测试
![chat.png](https://public.msypy.xyz/k8syamls/openim/latest/examples/chat.png)

## TODO
- [ ] 日志采集
- [ ] 自动扩容
- [ ] 健康检查
- [ ] 配置管理 