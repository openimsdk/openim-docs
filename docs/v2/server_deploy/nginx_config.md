在生产环境，建议使用https/wss，这个是OpenIM产品在生产环境下的nginx配置示例，可以参考使用，注意替换域名，证书和ip

```
 upstream  imserver{        
        server 127.0.0.1:10001;        
        #server 127.0.0.1:20001;        
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
        listen 50001;
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
                proxy_pass http://imserver;
            }
}


server {
        listen 50002;
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
                proxy_pass http://127.0.0.1:10002;
        }	
}


server {
        listen 50003;
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
                proxy_pass http://127.0.0.1:10003;
        }
}


server {
        listen 50004;
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
                proxy_pass http://127.0.0.1:10004;
        }
}


server {
        listen 50006;
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
                proxy_pass http://127.0.0.1:10006;
        }
}




server {
        listen 57880;
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
		listen 443;
        server_name storage-online.rentsoft.cn;
        ssl on;
        ssl_certificate /etc/nginx/conf.d/ssl/storage-online.rentsoft.cn_nginx/storage-online.rentsoft.cn_bundle.crt;
        ssl_certificate_key /etc/nginx/conf.d/ssl/storage-online.rentsoft.cn_nginx/storage-online.rentsoft.cn.key;
		ssl_session_timeout 5m;
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





