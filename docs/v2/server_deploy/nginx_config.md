在生产环境，建议使用https/wss，这个是OpenIM产品在生产环境下的nginx配置示例，可以参考使用，注意替换域名，证书和ip

```
server {
        listen 443;
        server_name open-im-test.rentsoft.cn;

        ssl on;
        ssl_certificate /etc/nginx/conf.d/ssl/open-im-test.rentsoft.cn.crt;
        ssl_certificate_key /etc/nginx/conf.d/ssl/open-im-test.rentsoft.cn.key;

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
                root /data/test/Pc-Web-Demo/build/;
                index index.html;
                try_files $uri $uri/ /index.html;
        }
	location /demo {
				proxy_http_version 1.1;
				proxy_set_header Upgrade $http_upgrade;    
				proxy_set_header Connection "Upgrade";    
				proxy_set_header X-real-ip $remote_addr;
				proxy_set_header X-Forwarded-For $remote_addr;
				proxy_pass http://x.x.x.x:10004;

	}
	location /jssdk_gateway {
				proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "Upgrade";
                proxy_set_header X-real-ip $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
                proxy_pass http://x.x.x.x::10003;
	}
	location /msg_gateway {
				proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "Upgrade";
                proxy_set_header X-real-ip $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
                proxy_pass http://x.x.x.x::10001;
	}
	location /rtc {
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "Upgrade";
                proxy_set_header X-real-ip $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
                proxy_pass http://x.x.x.x::7880;
        }
	location /user {
                proxy_http_version 1.1;
                proxy_set_header X-real-ip $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
                proxy_pass http://x.x.x.x::10002;

        }
		
	location /group {
                proxy_http_version 1.1;
                proxy_set_header X-real-ip $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
                proxy_pass http://x.x.x.x::10002;

        }
	location /manager {
                proxy_http_version 1.1;
                proxy_set_header X-real-ip $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
                proxy_pass http://x.x.x.x::10002;

        }
	 location /third {
                proxy_http_version 1.1;
                proxy_set_header X-real-ip $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
                proxy_pass http://x.x.x.x::10002;

        }
	location /cms {
                proxy_http_version 1.1;
                proxy_set_header X-real-ip $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
                proxy_pass http://x.x.x.x::10006;

        }
}

server {
        listen 80;
        server_name open-im-test.rentsoft.cn;
        rewrite ^(.*)$ https://${server_name}$1 permanent;
}

// minio nginx代理
server {
        listen 443;
        server_name storage.rentsoft.cn;

        ssl on;
        ssl_certificate /etc/nginx/conf.d/ssl/storage.rentsoft.cn_nginx/storage.rentsoft.cn_bundle.crt;
        ssl_certificate_key /etc/nginx/conf.d/ssl/storage.rentsoft.cn_nginx/storage.rentsoft.cn.key;

        ssl_session_timeout 5m;

        gzip on;
        gzip_min_length 1k;
        gzip_buffers 4 16k;
        gzip_comp_level 2;
        gzip_types text/plain application/javascript application/x-javascript text/css application/xml text/javascript application/x-httpd-php image/jpeg image/gif image/png;
        gzip_vary off;
        gzip_disable "MSIE [1-6]\.";

    location / {
        proxy_pass http://127.0.0.1:10005;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Host $http_host;
        proxy_http_version 1.1;
    }

}
```





