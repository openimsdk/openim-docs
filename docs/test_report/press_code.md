# OpenIM压测程序介绍

## 压测前准备

```
（一）服务端配置调整 config/config.yaml 以8核16G为例
（1）openImMessagePort: [ 10130, 10131, 10132, 10133, 10134,10135 ]
（2）openImPushPort: [ 10170, 10171, 10172, 10173 ]
（3）remainLogLevel: 3
（4）chatpersistencemysql: false
 (5) dbMaxOpenConns: 100
  dbMaxIdleConns: 10
  dbMaxLifeTime: 5

（二）调整path_info.cfg中msg_transfer_service_num=4

（三）kafka分区调整
（1）设置ws2ms_chat为8个分区 msg_transfer_service_num的2倍
（2）设置msg_to_mongo为8个分区 msg_transfer_service_num的2倍
（3）设置ms2ps_chat为8个分区 openImMessagePort的2倍

（四）mysql服务端设置最大连接数为2000

```

## 注意事项

```
（1）由于需要本地处理sqlite读写，检测程序建议设置2个客户端，发送消息休眠100毫秒；
（2）注意压测客户端和服务端的网络带宽；
（3）如果客户端和服务端同一台机器，注意压测程序cpu占用；
```



## 单聊压测程序

```
仓库地址 
https://github.com/OpenIMSDK/Open-IM-SDK-Core/tree/v2.3.0release/single_test
代码说明 
press_open_im.go 压测消息发送，但发送者不校验是否完成接收到 
msg_delay_open_im.go 检测消息发送和接收，在大压力情况下，消息的可靠性和时延测试
使用说明 
（1）修改../test/config.go TESTIP和SECRET
（2）go build press_open_im.go
./press_open_im -sn 10000 -mn 1000 -t 100
参数sn 10000表示：启动10000个压测客户端；
参数mn 1000表示：每个客户端发送消息数量为1000条；
参数t  100表示：每次发送一条消息后，休眠100毫秒；如果是1万客户端，算起来大概是每秒钟发送10万条消息；
（3）go build msg_delay_open_im.go
./msg_delay_open_im -sn 2 -mn 1000 -t 100
参数sn 2 表示：启动2个客户端消息收发检测；
参数mn 1000表示：每个客户端发送1000条消息；
参数t 100表示：每次发送一条消息，休眠100毫秒；
```

### 压测程序使用示例

```
./press_open_im -sn 100 -mn 100000 -t 100
出现[send msg begin ] 表示初始化完成，开始发送消息
此时再启动可靠性及消息时延测试：
./msg_delay_open_im -sn 2 -mn 1000 -t 100
```

### 服务端统计日志查看

```
tail -f OpenIM.log.all.2022-08-30  |grep "msg_gateway sendMsgCount"
system stat  msg_gateway 60 second recv to msg_gateway sendMsgCount 45267  
表示一分钟收到45267条
```

### 消息时延检测查看

```
minCostTime:  729 ms, maxCostTime:  6332 ms, average cost time:  3295 ms 发送2000条数据 从发送到对方收到，平均时延是3.2秒
CheckReliabilityResult ok, exit 表示发出去的所有消息，对方都能精确收到
```



## 群聊压测程序

```
仓库地址 
https://github.com/OpenIMSDK/Open-IM-SDK-Core/tree/v2.3.0release/work_group_test
代码说明 
create_work_group_open_im.go 创建测试群
press_open_im.go 压测消息发送，但发送者不校验是否完成接收到 
msg_delay_open_im.go 检测消息发送和接收，在大压力情况下，消息的可靠性和时延测试
使用说明 
（1）修改../test/config.go TESTIP和SECRET
（2）go build create_work_group_open_im.go
./create_work_group_open_im  -gmn 10
参数gmn表示：创建群成员为10的测试群，实际会创建13个成员。
（3）go build press_open_im.go
./press_open_im -gid 1510503557 -sn 10 -mn 1000 -t 100 
参数gid 1510503557 表示：压测群聊groupID
参数sn 10表示：压测客户端数量，要小于等于群成员数
参数mn 1000表示：每个客户端发送消息数量为1000条；
参数t 100表示：每次发送一条消息，休眠100毫秒；
（4）go build msg_delay_open_im.go

./msg_delay_open_im -gid 1510503557 -mn 100 -t 100

参数gid 1510503557 表示：压测群聊groupID
参数mn 100表示：每个客户端发送消息数量为100条；
参数t 100表示每次发送一条消息，休眠100毫秒；

```

### 压测程序使用示例

```
./create_work_group_open_im -gmn 10
出现[[CREATE GROUP  {"errCode":0,"errMsg":"","data":{"creatorUserID":"openIM123456","groupID":"3144245614","groupName":"Group Chat","groupType":2,"memberCount":13,"ownerUserID":"openIM123456"}} ] 表示创建群聊成功，记录groupID 3144245614

启动压测程序：
./press_open_im -gid 3144245614 -sn 10 -mn 1000 -t 100 
此时再启动可靠性及消息时延测试：
./msg_delay_open_im -gid 3144245614 -mn 100 -t 100
```

### 服务端统计日志查看

```
tail -f OpenIM.log.all.2022-08-30  |grep "msg_gateway sendMsgCount"
system stat  msg_gateway 60 second recv to msg_gateway sendMsgCount 45267  
表示一分钟收到45267条
```

### 消息时延检测查看

```
minCostTime:  594 ms, maxCostTime:  5181 ms, average cost time:  2930 ms  发送2000条数据 从发送群聊到对方收到，平均时延是3.2秒
CheckReliabilityResult ok, exit   表示发出去的所有群聊消息，对方都能精确收到。
```



