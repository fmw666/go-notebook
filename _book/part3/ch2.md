# 微服务设计

## API Gateway

我们进行了 SOA 服务化的架构演进，按照垂直功能进行了拆分，对外暴露了一批微服务，但是因为缺乏统的出口面临了不少困难：

+ 客户端到微服务直接通信，强耦合。

+ 需要多次请求，客户端聚合数据，工作量巨大，延迟高。

+ 协议不利于统一，各个部门间有差异，需要端来兼容。

+ 面向“端”的 API 适配，耦合到了内部服务。

+ 多终端兼容逻辑复杂，每个服务都需要处理。

+ 统一逻辑无法收敛，比如安全认证、限流。

我们新增了一个 app-interface 用于统一的协议出口，在服务内进行大量的 dataset join，按照业务场景来设计粗粒度的 API，给后续服务的演进带来的很多优势：

+ 轻量交互：协议精简、聚合。

+ 差异服务：数据裁剪以及聚合、针对终端定制化 API。

+ 动态升级：原有系统兼容升级，更新服务而非协议。

+ 通效率提升，协作模式演进为移动业务+网关小组。

> BFF（Backend for Frontend）可以认为是一种适配服务，将后端的微服务进行适配（主要包括聚合裁剪和格式适配等逻辑），向无线端设备暴露友好和统一的 API，方便无线设备接入访问后端服务。

最致命的一个问题是整个 app-interface 属于 single point of failure，严重代码缺陷或者流量洪峰可能引发集群宕机。

跨横切面(Cross-Cutting Concerns)的功能，需要协调更新框架升级发版(路由、认证、限流、安全)，因此全部上沉，引入了 API Gateway，把业务集成度高的 BFF 层和通用功能服务层 APIGateway 进行了分层处理。

> 在新的架构中，网关承担了重要的角色，它是解耦拆分和后续升级迁移的利器。在网关的配合下，单块 BFF 实现了解耦拆分，各业务线团队可以独立开发和交付各自的微服务，研发效率大大提升。另外，把跨横切面逻辑从 BFF 剥离到网关上去以后，BFF 的开发入员可以更加专注业务逻辑交付，实现了架构上的关注分离(Separation of Concerns)。

我们业务流量实际为:

移动端-> API Gateway -> BFF -> Mircoservice，在 FE Web 业务中，BFF 可以是 nodejs 来做服务端渲染(SSR, Server-Side Rendering)，注意这里忽略了上游的 CDN、4/7 层 负载均衡（ELD）。
