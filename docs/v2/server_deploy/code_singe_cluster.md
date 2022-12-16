# OpenIM集群（非k8s）部署文档

自行部署etcd/zookeeper/mysql/kafka/mongo/redis集群，可以根据此性能评估服务器需求。

以下是针对一台华为云主机s3的压测数据：8核16G内存，普通磁盘（非SSD）
（一）单聊压测数据：
1.1 同时在线及压测客户端数量：1万
1.2 每秒钟发送消息量：2300条；
1.3 从发送到对方接收平均消息延时：5秒
（二）群聊压测数据：
2.1 群成员数量：1万人
2.2 同时在线人数：1千人
2.3 每秒发送消息量：500条；
2.4 从发送到对方接收平均消息延时：6秒

## 组件集群说明

| 组件      | 说明                                                         | 版本  |官方参考文档链接|
| --------- | ------------------------------------------------------------ | ----- |-----------------------|
| etcd      | 建议三台，可复用                                             | 3.5.0 |待更新|
| zookeeper | 建议三台，可复用                                             | 3.7.1 |待更新|
| mysql     | 主从两条，可复用                                             | 5.7   |待更新|
| kafka     | 建议三台，可复用。以2台8核16G IM Server为例说明topic分区设置，"ws2ms_chat"  8分区，"msg_to_mongo" 8分区，"ms2ps_chat" 10分区 | 3.2.0 |待更新|
| mongo     | 建议2台以上，可复用。每个cache限制0.5G；多个数据分片副本集，1个mongos副本集，1个config副本集 | 5.0   |待更新|
| redis     | 建议2台以上，可复用。每个内存限制10G， 淘汰策略volatile-ttl  | 6.2.5 |[redis集群部署文档](https://blog.csdn.net/programor_guo/article/details/126794745?spm=1001.2014.3001.5502)|
| MinIO | 建议2台以上，可复用 |  |[](./minio.md)|





## IM Server集群部署

#### （1）下载代码及编译

```
git clone https://github.com/OpenIMSDK/Open-IM-Server.git --recursive
cd Open-IM-server/script
chmod +x *.sh
./batch_build_all_service.sh 
出现all services build success表示所有模块编译成功
```

#### （2）修改组件信息

```
kafka:
  ws2mschat:
    addr: [ 127.0.0.1:9092, 127.0.0.2:9092, 127.0.0.3:9092 ] #
    topic: "ws2ms_chat" open_im_msg写入，open_im_msg_transfer消费后新消息入库redis和kafka "msg_to_mongo" 、 "ms2ps_chat"
  ws2mschatoffline:
    addr: [  127.0.0.1:9092, 127.0.0.2:9092, 127.0.0.3:9092 ] #kafka配置，默认即可
    topic: "ws2ms_chat_offline" 不再使用
  msgtomongo:
    addr: [  127.0.0.1:9092, 127.0.0.2:9092, 127.0.0.3:9092 ] #kafka配置，默认即可
    topic: "msg_to_mongo"  open_im_msg_transfer消费历史消息入库mongo
  ms2pschat:
    addr: [  127.0.0.1:9092, 127.0.0.2:9092, 127.0.0.3:9092 ] #kafka配置，默认即可
    topic: "ms2ps_chat"  open_im_push消费，推送消息到open_im_msg_gateway

etcd:
  etcdSchema: openim  #默认即可
  etcdAddr: [ 127.0.0.1:2379, 127.0.0.2:2379, 127.0.0.3:2379] #etcd集群

mysql:
  dbMysqlAddress: [ 127.0.0.1:13306,  127.0.0.2:13306] #mysql主备
  
mongo:
  dbAddress: [127.0.0.1:37017, 127.0.0.2:37017, 127.0.0.3:37017]  #使用分片集群时为mongos地址

redis:
  dbAddress: [ 127.0.0.1:16379, 127.0.0.2:16379, 127.0.0.3:16379 ] #redis集群
  
rpcRegisterIP:#不要填写

```

#### （3）调整进程数

open_im_msg 6个，open_im_push 5个

```
openImMessagePort: [ 10130, 10131, 10132, 10133, 10134,10135 ] #open_im_msg 配置6个端口则启动6个进程
openImPushPort: [ 10170, 10171, 10172, 10173, 10174 ] #open_im_push 配置5个端口则启动5个进程
```

open_im_msg_transfer 4个

```
修改script/path_info.cfg
msg_transfer_name="open_im_msg_transfer"
msg_transfer_binary_root="../bin/"
msg_transfer_source_root="../cmd/open_im_msg_transfer/"
msg_transfer_service_num=4
```

#### （4）复制Open-IM-Server到其他服务器

```
scp -r Open-IM-Server root@127.0.0.2:/data
```



#### （5）启动

```
cd script
./start_all.sh 
```



## nginx配置示例

https/wss配置；负载均衡配置；以IM Server两台 127.0.0.1 127.0.0.2 ， nginx部署在其他服务器为例。

注意域名 替换ip 域名以及证书

```
 upstream  msg_gatway_imserver{      
        server 127.0.0.1:10001;       
        server 127.0.0.2:10001;        
    }
	
	 upstream  api_imserver{      
        server 127.0.0.1:10002;        
        server 127.0.0.2:10002;        
    }
	
	 upstream  jssdk_imserver{      
        server 127.0.0.1:10003;        
        server 127.0.0.2:10003;        
    }
	
	
	upstream  demo_imserver{      
        server 127.0.0.1:10004;        
        server 127.0.0.2:10004;        
    }
	
	upstream  cms_imserver{      
        server 127.0.0.1:10006;        
        server 127.0.0.2:10006;        
    }
	
server {
        listen 443;
        server_name open-im-online.rentsoft.cn;

        ssl on;
        ssl_certificate /etc/nginx/conf.d/ssl/open-im-online.rentsoft.cn.crt;
        ssl_certificate_key /etc/nginx/conf.d/ssl/open-im-online.rentsoft.cn.key;

        ssl_session_timeout 5m;
		gzip on;
		gzip_min_length 1k;
		gzip_buffers 4 16k;
		gzip_comp_level 2;
		gzip_types text/plain application/javascript application/x-javascript text/css application/xml text/javascript application/x-httpd-php image/jpeg image/gif image/png;
		gzip_vary off;
		gzip_disable "MSIE [1-6]\.";

        error_page 405 =200 $uri;
        location / {
                proxy_set_header Host $host;
                proxy_set_header X-Real-Ip $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
                proxy_set_header X-NginX-Proxy true;
                root /data/online/Pc-Web-Demo/build/;
                index index.html;
                try_files $uri $uri/ /index.html;
        }
		location /admin {
                proxy_set_header Host $host;
                proxy_set_header X-Real-Ip $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
				
                proxy_set_header X-NginX-Proxy true;
				# root /data/online/Open-IM-Admin/build/;
				alias /data/online/Open-IM-Admin/build/;
                index index.html;
                try_files $uri $uri/admin/ /admin/index.html;
        }
}
server {
        listen 80;
        server_name open-im-online.rentsoft.cn;
        rewrite ^(.*)$ https://${server_name}$1 permanent;
}

server {
        listen 10001;
        server_name open-im-online.rentsoft.cn;
        ssl on;
        ssl_certificate /etc/nginx/conf.d/ssl/open-im-online.rentsoft.cn.crt;
        ssl_certificate_key /etc/nginx/conf.d/ssl/open-im-online.rentsoft.cn.key;
        ssl_session_timeout 5m;

        gzip on;
        gzip_min_length 1k;
        gzip_buffers 4 16k;
        gzip_comp_level 2;
        gzip_types text/plain application/javascript application/x-javascript text/css application/xml text/javascript application/x-httpd-php image/jpeg image/gif image/png;
        gzip_vary off;
        gzip_disable "MSIE [1-6]\.";
        location / {
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "Upgrade";
                proxy_set_header X-real-ip $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
                proxy_pass http://msg_gatway_imserver;
            }
}


server {
        listen 10002;
        server_name open-im-online.rentsoft.cn;
        ssl on;
        ssl_certificate /etc/nginx/conf.d/ssl/open-im-online.rentsoft.cn.crt;
        ssl_certificate_key /etc/nginx/conf.d/ssl/open-im-online.rentsoft.cn.key;
        ssl_session_timeout 5m;

        gzip on;
        gzip_min_length 1k;
        gzip_buffers 4 16k;
        gzip_comp_level 2;
        gzip_types text/plain application/javascript application/x-javascript text/css application/xml text/javascript application/x-httpd-php image/jpeg image/gif image/png;
        gzip_vary off;
        gzip_disable "MSIE [1-6]\.";

        location / {
				proxy_http_version 1.1;
                proxy_set_header X-real-ip $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
                proxy_pass http://api_imserver;
        }
		

}


server {
        listen 10003;
        server_name open-im-online.rentsoft.cn;
        ssl on;
        ssl_certificate /etc/nginx/conf.d/ssl/open-im-online.rentsoft.cn.crt;
        ssl_certificate_key /etc/nginx/conf.d/ssl/open-im-online.rentsoft.cn.key;
        ssl_session_timeout 5m;

        gzip on;
        gzip_min_length 1k;
        gzip_buffers 4 16k;
        gzip_comp_level 2;
        gzip_types text/plain application/javascript application/x-javascript text/css application/xml text/javascript application/x-httpd-php image/jpeg image/gif image/png;
        gzip_vary off;
        gzip_disable "MSIE [1-6]\.";
        location / {
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "Upgrade";
                proxy_set_header X-real-ip $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
                 proxy_pass http://jssdk_imserver;
        }
}


server {
        listen 10004;
        server_name open-im-online.rentsoft.cn;
        ssl on;
        ssl_certificate /etc/nginx/conf.d/ssl/open-im-online.rentsoft.cn.crt;
        ssl_certificate_key /etc/nginx/conf.d/ssl/open-im-online.rentsoft.cn.key;
        ssl_session_timeout 5m;

        gzip on;
        gzip_min_length 1k;
        gzip_buffers 4 16k;
        gzip_comp_level 2;
        gzip_types text/plain application/javascript application/x-javascript text/css application/xml text/javascript application/x-httpd-php image/jpeg image/gif image/png;
        gzip_vary off;
        gzip_disable "MSIE [1-6]\.";
        location / {
			    proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "Upgrade";
                proxy_set_header X-real-ip $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
                proxy_pass http://demo_imserver;
        }
		

}


server {
        listen 10006;
        server_name open-im-online.rentsoft.cn;
        ssl on;
        ssl_certificate /etc/nginx/conf.d/ssl/open-im-online.rentsoft.cn.crt;
        ssl_certificate_key /etc/nginx/conf.d/ssl/open-im-online.rentsoft.cn.key;
        ssl_session_timeout 5m;

        gzip on;
        gzip_min_length 1k;
        gzip_buffers 4 16k;
        gzip_comp_level 2;
        gzip_types text/plain application/javascript application/x-javascript text/css application/xml text/javascript application/x-httpd-php image/jpeg image/gif image/png;
        gzip_vary off;
        gzip_disable "MSIE [1-6]\.";
        location / {
			    proxy_http_version 1.1;
                proxy_set_header X-real-ip $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
                proxy_pass http://cms_imserver;
        }
}




server {
        listen 7880;
        server_name open-im-online.rentsoft.cn;
        ssl on;
        ssl_certificate /etc/nginx/conf.d/ssl/open-im-online.rentsoft.cn.crt;
        ssl_certificate_key /etc/nginx/conf.d/ssl/open-im-online.rentsoft.cn.key;
        ssl_session_timeout 5m;

        gzip on;
        gzip_min_length 1k;
        gzip_buffers 4 16k;
        gzip_comp_level 2;
        gzip_types text/plain application/javascript application/x-javascript text/css application/xml text/javascript application/x-httpd-php image/jpeg image/gif image/png;
        gzip_vary off;
        gzip_disable "MSIE [1-6]\.";
        location / {
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "Upgrade";
                proxy_set_header X-real-ip $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
                proxy_pass http://127.0.0.1:7880;
        }
}




upstream storage {
    server 127.0.0.1:10005;
}

server {
  #      listen 443;
   #     server_name storage-online.rentsoft.cn;
    #    ssl on
     #   ssl_certificate /etc/nginx/conf.d/ssl/storage-online.rentsoft.cn_bundle.crt;
      #  ssl_certificate_key /etc/nginx/conf.d/ssl/storage-online.rentsoft.cn.key; 
        ssl_session_timeout 5m;

 listen 443;
        server_name storage-online.rentsoft.cn;

        ssl on;
        ssl_certificate /etc/nginx/conf.d/ssl/storage-online.rentsoft.cn_nginx/storage-online.rentsoft.cn_bundle.crt;
        ssl_certificate_key /etc/nginx/conf.d/ssl/storage-online.rentsoft.cn_nginx/storage-online.rentsoft.cn.key;


        gzip on;
        gzip_min_length 1k;
        gzip_buffers 4 16k;
        gzip_comp_level 2;
        gzip_types text/plain application/javascript application/x-javascript text/css application/xml text/javascript application/x-httpd-php image/jpeg image/gif image/png;
        gzip_vary off;
        gzip_disable "MSIE [1-6]\.";

    location / {
            proxy_pass http://127.0.0.1:10005/;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header Host $http_host;
            proxy_http_version 1.1;
            client_max_body_size 8000M;

    }
}

```





