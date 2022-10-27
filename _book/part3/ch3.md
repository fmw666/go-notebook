# gRPC & 服务发现

## gRPC

gRPC 是什么可以用官网的一句话来概括：

***"A high-performance, open-source universal RPC framework"***

+ 多语言：语言中立，支持多种语言

+ 轻量级、高性能：序列化支持 PB（Protocol Buffer）和 JSON，PB 是一种语言无关的高性能序列化框架。

+ 可插拔

+ IDL：基于文件定义服务，通过 proto3 工具生成指定语言的数据结构、服务端接口以及客户端 Stub。

+ 设计理念

+ 移动端：基于标准的 HTTP/2 设计，支持双向流、消息头压缩、单 TCP 的多路复用、服务端推送等特性，这些特性使得 gRPC 在移动端设备上更加省电和节省网络流量。
