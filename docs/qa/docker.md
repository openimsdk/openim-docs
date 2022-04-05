## 1.golang环境安装
```bash
wget -c https://dl.google.com/go/go1.17.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
```
# 2. docker
## 安装
```bash
curl -sSL https://get.daocloud.io/docker | sh
```
或者
```bash
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
```
## 启动、停止

### systemctl 方式

重启docker服务

```
sudo systemctl restart docker
```

 关闭docker

```
sudo systemctl stop docker
```

### service 方式

重启docker服务

```bash
 sudo service docker restart
```

 关闭docker

```bash
 sudo service docker stop
```

# 3. docker-compose安装

```bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

```bash
chmod +x /usr/local/bin/docker-compose
```

# 4. 安装git
```
ubuntu系统上执行 apt install git
```

