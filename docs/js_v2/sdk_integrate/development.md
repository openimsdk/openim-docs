# 在线测试
> web版本可[点击此处](http://121.5.182.23:23232)前往[在线测试](http://121.5.182.23:23232)。

## 双击左侧标题 <u>在线化办公</u>

![image-20220705104321389](../../images/web_config_click.png)

## 修改为自己服务器IP地址

> **注意**，该测试方式仅适合部署IM Server在**外网**时，若服务端部署在本地或内网环境，则无法通过此方式进行测试。

- 通过https+域名方式配置

  > nginx配置可参考[官方配置](https://doc.rentsoft.cn/#/v2/server_deploy/easy_deploy_new?id=%e4%ba%94%e3%80%81nginx%e9%85%8d%e7%bd%ae%e5%8f%82%e8%80%83),若根据官方模板进行配置，则仅需将下方域名部分`web.rentsoft.cn`替换为自己的域名，后缀如`/msg_gateway`等无需修改或删除。

  ![image-20220705103951167](../../images/web_config.png)

- 通过ip+端口方式配置

  > 直接通过docker一键部署方式并开放本机端口，则仅需将下方配置中的IP `121.5.182.23`改为自己服务器IP即可，无需修改端口号（如下示例）。

  ![image-20220705103951167](../../images/web_config_ip.png)



# 下载测试

## Electron应用下载

> 扫码或点击此处下载[window](https://qr02.cn/A82arJ)、[mac](https://qr02.cn/AeCvPV)，[更多前往](http://localhost:3000/#/demo/download_demo)

![image](../../images/electron_win.png)
![image](../../images/electron_mac.png)

## 修改为自己服务器IP地址

> 同上述在线测试步骤，打开配置页。此时IP**不限制为**外网IP，服务端部署在本地或内网环境，也可通过此方式进行测试。
>
> 配置信息参考下方，若未修改默认端口配置，则只需要将下方配置中IP改为自身服务端IP即可。
>
> **注意：**若在本地部署IM Server，IP不能使用127.0.0.1。需要使用192开头的IP地址



# 下载源代码

## git方式下载

```bash
git clone https://github.com/OpenIMSDK/Open-IM-PC-Web-Demo.git
```

## 修改为自己服务器IP地址

### Web配置

> 配置信息参考下方，若未修改默认端口配置，则只需要将下方配置中IP改为自身服务端IP即可，无需修改端口

![image-20220705111200505](../../images/web_config_dev.png)

## 运行项目

> **项目环境：**项目环境要求**Node版本14+**，**npm版本6+**。

1. 下载依赖

   ```bash
   npm install
   ```

2. 本地启动web调试

   ```bash
   npm run start:renderer
   ```

3. 本地启动electron调试

   ```bash
   npm run start:main
   ```

4. 打包web资源

   ```bash
   npm run build:renderer
   ```

5. 打包electron应用

   > **注意：**本命令默认同时打包win和mac下应用程序，但如果运行环境为win，则**不支持**跨端打包mac应用。

   ```bash
   npm run build:main
   ```

   



# 编译常见问题

1. demo运行环境要求？

   答：node版本14.x+   npm版本6.x+。

2. demo浏览器兼容性？

   答：目前未做针对性兼容，建议使用最新版本chrome浏览器进行调试开发。

3. electron依赖下载失败？

   答：国内下载资源容易失败，可以设置npm代理进行加速

   ```bash
   npm config set electron_mirror https://cdn.npm.taobao.org/dist/electron/
   ```

4. 'Draggable' cannot be used as a JSX component ？

   答：请将node_modules删除后使用npm拉取依赖。不要使用yarn等管理工具进行拉取。

5. electron应用支持哪些平台？

   答：目前已支持windows、mac，linux。

6. windows平台下打包electron应用失败？

   答：上述命令`npm run build:main`默认同时打包win和mac下应用程序，但如果运行环境为win，则**不支持**跨端打包mac应用。可以修改package.json中修改打包命令为`"build:main": "craco build && tsc -p electron && electron-builder --win"`，仅打包exe应用。
