---
title: 跨域资源共享CORS
date: 2021-01-09 13:31:26
tags: [CORS]
---

## 简介

#### CORS

CORS （Cross-Origin Resource Sharing，跨域资源共享）是 `HTTP 的一部分`。它由一系列传输的HTTP头组成，这些HTTP头决定浏览器是否阻止前端 JavaScript 代码获取跨域请求的响应。

所谓的跨域，就是看网站的域名和网站中请求的资源对应服务器域名是否同源，同源的定义见后文。

<!-- more -->

#### 浏览器为什么要限制跨域

1995年，同源政策由 Netscape 公司引入浏览器。目前，所有浏览器都实行这个政策。最初，它的含义是指，A 网页设置的 Cookie，B 网页不能打开，除非这两个网页“同源”。

同源政策的目的，是为了保证用户信息的安全，防止恶意的网站窃取数据。设想这样一种情况：A 网站是一家银行，用户登录以后，又去浏览其他网站。如果其他网站可以读取 A 网站的 Cookie，会发生什么？

随着互联网的发展，“同源政策”越来越严格。目前，如果非同源，共有三种行为受到限制

* Cookie、LocalStorage 和 IndexedDB 无法读取

* 无法获取 DOM

* AJAX 请求无效（可以发送，但浏览器会拒绝接受响应）

跨域安全吗？参考：[When is it safe to enable CORS?](https://stackoverflow.com/a/9726921)

## 同源的定义

如果两个 URL 的 protocol、port (如果有指定的话)和 host 都相同的话，则这两个 URL 是同源。

示例：

| URL                                             | 结果 | 原因                             |
| ----------------------------------------------- | ---- | -------------------------------- |
| http://store.company.com/dir2/other.html        | 同源 | 只有路径不同                     |
| http://store.company.com/dir/inner/another.html | 同源 | 只有路径不同                     |
| https://store.company.com/secure.html           | 失败 | 协议不同                         |
| http://store.company.com:81/dir/etc.html        | 失败 | 端口不同 ( http:// 默认端口是80) |
| http://news.company.com/dir/other.html          | 失败 | 主机不同                         |

## 什么情况会遇到 CORS

以下场景发起 HTTP 请求时会受跨域策略影响：

* XMLHttpRequest 或 Fetch 发起的跨源 HTTP 请求。

* Web 字体 (CSS 中通过 @font-face 使用跨源字体资源)，因此，网站就可以发布 TrueType 字体资源，并只允许已授权网站进行跨站调用。

* WebGL 贴图

* 使用 drawImage 将 Images/video 画面绘制到 canvas

## 跨域相关 Header

#### Request Header

* Origin

表明预检请求或实际请求的源站

* Access-Control-Request-Method

用于预检请求，作用是告诉服务器实际请求的 HTTP 方法。

* Access-Control-Request-Headers

用于预检请求，作用是将实际请求所携带的 Header 字段告诉服务器

#### Response Header

* Access-Control-Allow-Origin

表示服务器允许请求的域，可以指定特定域，也可以用 * 通配符允许所有的域。

```
Access-Control-Allow-Origin: <origin> | *
```

* Access-Control-Expose-Headers

在跨源访问时，XMLHttpRequest对象的 getResponseHeader() 方法只能拿到一些最基本的响应头，Cache-Control、Content-Language、Content-Type、Expires、Last-Modified、Pragma，如果要访问其他头，则需要服务器设置本响应头。

```
Access-Control-Expose-Headers: X-My-Custom-Header, X-Another-Custom-Header
```

这样浏览器就能够通过 getResponseHeader 访问X-My-Custom-Header和 X-Another-Custom-Header 响应头了。

* Access-Control-Max-Age

指定预请求的结果能被缓存多久

```
Access-Control-Max-Age: <delta-seconds>
```

* Access-Control-Allow-Credentials

指定了当浏览器的 credentials 设置为 true 时是否允许浏览器读取 response 的内容。当用在对 preflight 预检测请求的响应中时，它指定了实际的请求是否可以使用 credentials

* Access-Control-Allow-Methods

用于预检请求的响应，表明实际请求中允许使用的 HTTP 方法

* Access-Control-Allow-Headers

用于预检请求的响应，表明实际请求中允许携带的 Header

## 跨域预检请求

#### 简单请求

满足以下条件的请求不会触发 CORS 预检，被称为 `简单请求`：

* 使用下列方法之一：
```
GET
HEAD
POST
```

* 除了被用户代理自动设置的首部字段（例如 Connection ，User-Agent）和在 Fetch 规范中定义为 `禁用首部名称` 的其他首部，允许人为设置的字段为 Fetch 规范定义的 `对 CORS 安全的首部字段集合`。该集合为：

```
Accept
Accept-Language
Content-Language
Content-Type （需要注意额外的限制）
DPR
Downlink
Save-Data
Viewport-Width
Width
```

* Content-Type 的值仅限于下列三者之一：

```
text/plain
multipart/form-data
application/x-www-form-urlencoded
```

* 请求中的任意XMLHttpRequestUpload 

对象均没有注册任何事件监听器；XMLHttpRequestUpload 对象可以使用 XMLHttpRequest.upload 属性访问。

* 请求中没有使用 ReadableStream 对象。

#### 预检请求（preflight request）

除了简单请求以外的都属于 `需要预检的请求`。在真正发起请求之前，浏览器会先发一个 `OPTIONS` 预检请求给服务器，以获知服务器是否允许实际请求。

`预检请求` 的使用，可以避免跨域请求对服务器的用户数据产生未预期的影响。

一个 `预检请求` 示例：

```
Request URL: https://abc.com
Request Method: OPTIONS
Status Code: 200 OK
Remote Address: 123.11.11.11:22
Referrer Policy: no-referrer-when-downgrade

Access-Control-Request-Headers: content-type
Access-Control-Request-Method: POST
Origin: https://abc.com
Referer: https://def.html
Sec-Fetch-Mode: cors
User-Agent: Mozilla/5.0 (Linux; Android 10; PDHM00 Build/QKQ1.191222.002; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/77.0.3865.120 MQQBrowser/6.2 TBS/045410 Mobile Safari/537.36
```


## 参考文档

* [浏览器的同源策略](https://developer.mozilla.org/zh-CN/docs/Web/Security/Same-origin_policy)

* [跨源资源共享（CORS）](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Access_control_CORS)

* [When is it safe to enable CORS?](https://stackoverflow.com/a/9726921)