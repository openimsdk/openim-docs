# 引入SDK，并对SDK进行实例化

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



# Electron还需要在子进程中启动上一步编译出的可执行文件

- 引入方式

  ```typescript
  ...
  ```

  

  

# 在需要使用的地方引入`openIM`并调用对应方法即可

  ```typescript
  import openIM from 'xxx'
  
  const sendMsgDemo = async () => {
    const textStr = "hello open im";
  	const { data } = await openIM.createTextMsg(dataStr);
  	const params = {
  	  recvID: "xxx",
  	  groupID: "",
  	  message: data,
  	};
  	openIM.sendMessage(params);
  }
  
  //You can listen to the message sending status and handle it in the callback function
  const msgListener = () => {
    openIM.on(CbEvents.OnRecvNewMessage,data => {
      //new message...
    })
  }
  ```

  
