## Open-IM是什么 

Open-IM是由IM技术专家打造的**开源**的即时通讯组件。Open-IM包括IM服务端和客户端SDK，实现了高性能、轻量级、易扩展等重要特性。开发者通过集成Open-IM组件，并私有化部署服务端，可以将即时通讯、实时网络能力快速集成到自身应用中，并确保业务数据的安全性和私密性。

## Open-IM包括哪些模块

## （一）客户端

（1） golang实现的跨平台的SDK：[Open-IM-SDK-Core](https://github.com/OpenIMSDK/Open-IM-SDK-Core) ，开发者不需要关心

（2）在[Open-IM-SDK-Core](https://github.com/OpenIMSDK/Open-IM-SDK-Core) 基础上生成的iOS版本SDK：[Open-IM-SDK-iOS ](https://github.com/OpenIMSDK/Open-IM-SDK-iOS) ，供开发者引用

（3）在[Open-IM-SDK-Core](https://github.com/OpenIMSDK/Open-IM-SDK-Core) 基础上生成的Android版本SDK：[Open-IM-SDK-Android](https://github.com/OpenIMSDK/Open-IM-SDK-Android)，供开发者引用

（4）在[Open-IM-SDK-iOS](https://github.com/OpenIMSDK/Open-IM-SDK-iOS)、[Open-IM-SDK-Android](https://github.com/OpenIMSDK/Open-IM-SDK-Android)生成的Flutter版本SDK：[Open-IM-SDK-Flutter](https://github.com/OpenIMSDK/Open-IM-SDK-Flutter) ，供开发者引用

（5）在[Open-IM-SDK-iOS](https://github.com/OpenIMSDK/Open-IM-SDK-iOS)、[Open-IM-SDK-Android](https://github.com/OpenIMSDK/Open-IM-SDK-Android)生成的uni-app版本SDK：[Open-IM-SDK-Uniapp](https://github.com/OpenIMSDK/Open-IM-SDK-Uniapp)，供开发者引用

（6）基于[Open-IM-SDK-iOS](https://github.com/OpenIMSDK/Open-IM-SDK-iOS)开发的、供开发者参考的iOS Demo：[Open-IM-iOS-Demo](https://github.com/OpenIMSDK/Open-IM-iOS-Demo) ，供开发者参考

（7）基于[Open-IM-SDK-Android](https://github.com/OpenIMSDK/Open-IM-SDK-Android)开发的Android Demo：[Open-IM-Android-Demo](https://github.com/OpenIMSDK/Open-IM-Android-Demo) ，供开发者参考

（8）基于[Open-IM-SDK-Flutter](https://github.com/OpenIMSDK/Open-IM-SDK-Flutter)开发的Flutter Demo：[Open-IM-Flutter-Demo](https://github.com/OpenIMSDK/Open-IM-Flutter-Demo) ，供开发者参考

（9）基于[Open-IM-SDK-Uniapp](https://github.com/OpenIMSDK/Open-IM-SDK-Uniapp)开发的uni-app Demo：[Open-IM-Uniapp-Demo](https://github.com/OpenIMSDK/Open-IM-Uniapp-Demo)，供开发者参考

## （二）服务端

（1）纯golang实现的服务端 [Open-IM-Server](https://github.com/OpenIMSDK/Open-IM-Server)

（2）docker镜像：open-im-server

## （三）管理后台

包含统计报表、用户管理等运营管理系统：**Open-IM-Admin**

## Open-IM有什么特色

**(1) IMSDK开源永久免费**

代码开源，包括IMSDK客户端和IMServer服务端，由IM技术专家打造，并邀请全球技术极客参与建设。

**(2) 易扩展**

服务端采用golang实现，首创“一切皆消息”的通讯模型，轻松实现自定义消息和扩展功能。

**(3) 专业技术服务**

每个技术人员都承担技术客服的角色，强化社区，不提工单，及时解答。

**(4) 高性能**

借鉴并优化通讯架构，抽象在线消息、离线消息、历史消息存储模型，分层治理架构，支持集群部署。

**(5) 安全**

IMSDK代码全部开源，服务端私有化部署，数据自我掌控。未来加入全球最安全的signal端到端加密协议。

**(6) 全平台支持**

支持Android、iOS原生开发，支持Flutter、uni-app跨端开发，支持小程序、React等所有主流web前端技术框架， PC支持Electron，Flutter、iOS、uni-app已有成熟demo可以体验。

开发者可以使用Open-IM替代市场上各种IM云服务，除了降低成本，还赋予开发者更多的灵活性和自主性。我们通过开源的方式，邀请全球技术极客来参与Open-IM建设，使每位开发者都能免费使用最优秀的IM组件，让每个app都具备即时通讯能力。

## 市场现有产品的痛点

自互联网诞生以来，即时通讯平台就一直存在。从世界范围来看，WhatsApp、Facebook、 微信、Telegram是领先的消息平台，用户主要使用这些平台与家人和朋友保持联系。随着互联网的发展，人与人之间的沟通是刚需，无处不在，几乎所有的APP都集成IM功能，从社交、游戏、到生活中的方方面面，打车、找房等。可以说IM作为一种通讯能力，已经成为互联网上的基础设施，成为许多APP不可或缺的功能。

如何让APP具备IM功能，一般有如下三种解决方案：

第一：自研。IM是一个看起来门槛很低的项目，网上有很多所谓的IM开发教程，甚至很多毕业生的毕业设计也是做一个IM系统。由于这个误解，很多企业主或者项目经理盲目乐观组建3-5个人的IM团队，历时一年半载，最后只完成了一个demo版本。由于架构设计不合理，demo版本存在消息丢失、系统异常等bug，远远达不到商业化的要求。

第二：使用IM云服务商的SDK。很多企业自研IM这条路走不通，IM云服务商看到了商业机会，通过提供IM SDK和API的方式，让开发者简单集成IM功能。当然这里也存在明显的问题。（1）成本问题：企业每年额外支付上万乃至数十万的云服务费用，是个不小的成本；（2）数据隐私问题：企业的用户数据、聊天记录等核心数据存储在IM云服务商，如何保证数据的安全性是个极大挑战；（3）需求定制问题：IM需求多样化，IM功能只能由IM云服务商通过SDK的形式提供给大家使用，对于一些定制化的需求，是否支持，什么时候实现，都是个未知数；（4）云服务商绑架问题：一旦使用IM云服务，形成捆绑关系，迁移成本高，受制于人。

第三：使用开源IM。github上IM开源项目不少，但开发者却很难使用，主要有几点原因（1）个人项目居多，虽然有些项目也有几k star，但近几年都无人维护，真正的商业化产品不敢使用；（2）大部分项目不是IM技术专业团队完成的，技术实力和技术架构存疑，也没有经过大项目和海量用户检验；（3）只开源服务端或者客户端，只开源某一端，需要开发者实现另外一端，研发成本同样不小，另外，开源项目大部分都是以单独的聊天产品开源，开发者如何把IM集成到自身app中，同样存在大量的修改和适配成本。（4）部分开源项目免费版功能缺失，商业版收费。

## Open-IM优势

**（1）IM技术专家打造，多年IM从业经验**。优秀的技术架构，经受过海量用户检验；

**（2）完整组件，一键部署，轻松集成。**客户端提炼成方便集成的SDK，服务端通过docker一键部署，运营管理系统展示后台数据；

**（3）IMSDK全开源，不存在任何闭源收费版本**。增加开源社区的参与积极性，产生黏性、惯性、认同感、归属感以及忠诚度，引入更多技术极客，进一步完善OpenIM；

**（4）开源免费，给初创企业每年节省上万费用**。对于使用IM云服务的企业，每年可以节省上万乃至数十万费用；

**（5）私有化部署，无任何关联**。开发者一键部署Open-IM在自家服务器上，完全摆脱了对第三方的依赖，数据隐私可控、有保障；

**（6）方便定制，采用“一切皆消息”的通讯模型。**代码开源，对于自定义需求，开发者可以修改客户端代码轻松实现；

**（7）高性能、微服务、集群化。**系统具备平行扩展能力，支持服务注册、服务发现。满足初创企业简单一键部署需求，同时也满足中大型企业集群化部署需求。

**（8）收取技术服务费，打造长远、健康的商业模式。**对于开发者来说，可以免费使用我们全部技术和代码。对于高标准的开发者，可以订阅我们的技术服务，我们为之提供更专业的技术服务、故障排查、SDK二次开发咨询和私有化安装部署服务。

