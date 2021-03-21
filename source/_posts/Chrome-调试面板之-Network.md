---
title: Chrome 调试面板之--Network
date: 2021-03-21 23:44:00
tags: [Chrome]
---

## 一、Network 面板介绍

![](https://gitee.com/wangzz/pic/raw/master/network_panel.png)

其中：

* Controls 控制 Network 的外观和功能。
* Filters 控制 Requests Table 具体显示哪些内容。
* Overview 显示获取到资源的时间轴信息。
* Requests Table 按资源获取的前后顺序显示所有获取到的资源信息，点击资源名可以查看该资源的详细信息。
* Summary 显示总的请求数、数据传输量、加载时间信息。

<!-- more -->

## 二、Controls

* Record Network Log / Stop recording network log

开始/停止记录网络请求

* Clear

清空当前记录内容

* Filter

展开/收起 Filters 菜单

* Search

展开/收起 Search 菜单

* Preserve log

刷新界面时，保留/不保留上次网络请求记录

* Disable cache

禁用/不禁用网络缓存功能。当禁用时，每次界面刷新都跟首次打开界面的效果一样，可以方便优化首次进入界面的性能

* Trottling

模拟不同的网络条件

* Import HAR file

导入 HAR 格式的网络调试记录

* Export HAR file

将当前已记录的网络请求记录导出成 HAR 文件

## 三、Filters

* 筛选输入框

输入筛选词来筛选特定的请求，支持按以下内容筛选：

```
1、domain 
可以模糊、正则匹配

2、has-response-header 
response 中包含特定 header

3、is
可以使用 `is:running` 找到 `WebSocket` 资源

4、larger-than
筛选出大于特定尺寸的请求，单位是字节

5、method
通过 HTTP 方法筛选

6、mime-type
通过文件的 MIME 类型筛选。MIME 媒体类型（通常称为 Multipurpose Internet Mail Extensions 或 MIME 类型 ）是一种标准，用来表示文档、文件或字节流的性质和格式。

7、mixed-content
可以通过 mixed-content:all 筛选出全部的请求，也可以通过 mixed-content:displayed 筛选出当前展示的请求

8、scheme
通过 scheme:http 筛选出 http 请求，通过 scheme:https 筛选出 https 请求

9、set-cookie-domain
筛选通过 Set-Cookie 设置了 Domain 的请求

10、set-cookie-name
筛选通过 Set-Cookie 设置了 name 的请求

11、set-cookie-value
筛选通过 Set-Cookie 设置了 value 的请求

12、status-code
筛选特定 HTTP code 的请求
```

* Hide Data URLs

隐藏/不隐藏 Data URLs 类型的文件

* Filter requests by type

通过类型筛选请求，包含 XHR、JS、CSS、Img、Media、Font、Doc、WS(WebSocket)、Mainfest 以及其他 Other 

* Has blocked cookies

有/没有 blocked cookies

* Blocked Requests

有/没有 blocked 请求

## 四、Overview

以时间轴方式展示所有的请求

## 五、Requests Table

在 Requests Table 的 Header 上可以右键显示更多的列，默认显示以下列：

* Name 

请求或资源的文件名或唯一标识

* Status

HTTP 状态码

* Type

资源的 MIME 类型

* Initiator

请求发起者，共分以下几种：

> Parser：Chrome 的 HTML parser
> Redirect：HTTP 重定向
> Script：JavaScript 脚本
> Other：其它

* Size

请求 response 的 Header 和 body 大小之和

* Time

请求的全部耗时，包括请求发出到收到数据的总时间

* Waterfall

每个请求的可视化分解

## 六、Summary

* total number of requests

* total download size over network

* total resources loaded by the page

* DOMContentLoaded

* Load

## 七、timing breakdown 

请求耗时分解，共有以下阶段：

#### Resource Scheduling

* Queueing

排队中；有以下情况会导致请求排队：

> 1、有更高优先级的请求
> 2、每个域名已经建立了超过 6 个 TCP 连接（HTTP/1.0 或 HTTP/1.1 才有这个限制）
> 3、浏览器正在分配磁盘空间

#### Connection Start

* Stalled

停止；一个请求可能会因为导致 Queueing 的原因而导致 Stalled

解决 Queueing/Stalled 问题的方法：

> 1、如果必须使用 HTTP/1.0 或 HTTP/1.1 ，进行域名分片（domain sharding）来解决 6 个 TCP 连接的限制
> 2、使用 HTTP/2 以规避 6 个 TCP 连接的限制
> 3、删除或推迟发送不必要的请求

* DNS Lookup

DNS 寻找 IP 地址

* Initial connection

浏览器建立请求链接耗时，包括 TCP 握手/重试和 SSL 协商

* Proxy negotiation

与代理服务器协商请求

#### Request/Response

* Request sent

请求发送

* ServiceWorker Preparation

浏览器启动 ServiceWorker

* Request to ServiceWorker

请求正在发送给 ServiceWorker

* Waiting (TTFB)

浏览器正在等待 response 的第一个字节，TTFB 是 Time To First Byte 的缩写。这个耗时包括请求 1 个往返的延迟，以及服务器准备响应所用的时间。

可能导致 TTFB 的原因：

> 1、客户端和服务器的网络连接慢
> 2、服务器响应速度慢

对应的解决方案：

> 1、通过 CDN 优化客户端服务端网络连接慢问题
> 2、服务器优化响应速度

* Content Download

浏览器接收 response

* Receiving Push

浏览器正在接收 HTTP/2 的服务器 Push

* Reading Push

浏览器正在读取之前收到的 Push 数据

## 八、其它

* Use large request rows

选项开启后，会以双行的形式展示 size 列，其中上面深颜色的表示通过网络传输的大小，下面浅颜色的表示未经压缩的尺寸

![](https://gitee.com/wangzz/pic/raw/master/large_request_rows.png)

* Capture screenshots

选项开启后，会新增一个显示截图的面板。重新刷新网页就能看到界面截图：

![](https://gitee.com/wangzz/pic/raw/master/apture_screenshots.png)



## 九、参考文档

* [Chrome DevTools - Network Analysis Reference](https://developers.google.com/web/tools/chrome-devtools/network/reference)

* [使用chrome开发者工具中的network面板测量网站网络性能](https://www.cnblogs.com/xiaohuochai/p/9182165.html)