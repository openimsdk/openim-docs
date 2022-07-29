# 引入SDK

> [npm官方地址](https://www.npmjs.com/package/open-im-sdk)
>
> [SDK github地址](https://github.com/OpenIMSDK/Open-IM-SDK-Web)

## npm方式

  ```bash
npm install open-im-sdk
  ```

## CDN方式

```html
<script src="https://cdn.jsdelivr.net/npm/open-im-sdk"><script>
```

# 实例化SDK

## npm方式

```typescript
import { OpenIMSDK } from 'open-im-sdk'
  
const openIM = new OpenIMSDK();
  
export default openIM;
```

## CDN方式

```typescript
const openIM = new openImSdk.OpenIMSDK()
```



# 设置监听

> 所有事件相关常量均封装在SDK的`CbEvents`中，可直接进行引入使用。

```typescript
import { CbEvents } from 'open-im-sdk'

openIM.on(CbEvents.ONCONNECTFAILED,(data)=>{
  // 连接失败...
})
openIM.on(CbEvents.ONCONNECTSUCCESS,(data)=>{
  // 连接成功...
})
openIM.on(CbEvents.ONCONNECTING,(data)=>{
  // 连接中...
})
openIM.on(CbEvents.ONKICKEDOFFLINE,(data)=>{
  // 被踢下线...
})
openIM.on(CbEvents.ONUSERTOKENEXPIRED,(data)=>{
  // token过期...
})
```

# 登录

> 初始化并登录，使用用户ID(userID)和token登录，userID来自于自身业务服务器，token需要业务服务器根据secret向OpenIM服务端交换获取。url为OpenIM Server部署服务器的web server websocket地址。<br/>**注意1：**JSSDK ws连接端口为10003端口，与其他端SDK不同，请勿混淆。<br/>**注意2：**必须确保登录成功回调到达后才能调用其他API。

```typescript
const config: InitConfig = {
  userID: "userID",								// 用户ID
  token: "token",									// 用户token
  url: "ws://121.37.25.71:10003",	// jssdk server ws地址
  platformID: 5,									// 平台号
};
openIM.login(config).then(res => {
  console.log("login suc...");
}).catch(err => {
  console.log("login failed...");
})
```

