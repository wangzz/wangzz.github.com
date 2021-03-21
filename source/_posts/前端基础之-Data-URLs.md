---
title: 前端基础之 Data URLs
date: 2021-01-18 21:59:39
tags: [前端]
---

## 简介

Data URLs 是前缀为data：协议的URL，其允许内容创建者向文档中嵌入小文件。

## 语法

> data:①[<mime type>]②[;charset=<charset>]③[;<encoding>]④,<encoded data>⑤

* 第①部分data： 协议头，它标识这个内容为一个 data URI 资源。
* 第②部分MIME 类型（可选项）：浏览器通常使用MIME类型（而不是文件扩展名）来确定如何处理文档；因此服务器设置正确以将正确的MIME类型附加到响应对象的头部是非常重要的。MIME类型对大小写不敏感，但是传统写法都是小写。

<!-- more -->

| 类型        | 描述                                             | 示例（语法：type/subtype 类型/子类型）                       |
| ----------- | ------------------------------------------------ | ------------------------------------------------------------ |
| text        | 表明文件是普通文件，理论上是人类可读的           | text/plain，text/html，text/css，text/javascript             |
| image       | 表明文件某种是图像文件，gif动态图也属于image类型 | image/gif，image/png，image/jpeg，image/bmp，image/webp，image/x-icon，image/vnd.microsoft.icon |
| audio       | 表明文件是某种音频文件                           | audio/midi，audio/mpeg，audio/webm，audio/ogg，audio/wav     |
| video       | 表明文件是某种视频文件                           | video/webm，video/ogg                                        |
| application | 表明文件是某种二进制数据                         | application/octet-stream，application/pkcs12，application/vnd.mspowerpoint，application/xhtml+xml，application/xml，application/pdf |

* 第③部分 [;charset=<charset>](可选项)： 源文本的字符集编码方式，默认编码是 charset=US-ASCII, 即数据部分的每个字符都会自动编码为 %xx

* 第④部分 [;<encoding>] ： 数据编码方式（默认US-ASCII，BASE64两种）

* 第⑤部分 ,<encoded data> ： 编码后的数据


## Data URLs 的利弊

#### 优点

* 减少 HTTP 请求

* 当访问外部资源很麻烦或受限时（比如服务器 ip 被墙）

* 当图片是在服务器端用程序动态生成，每个访问用户显示的都不同时

* 当图片的体积太小，占用一个 HTTP 会话不值得时

* 没有图片更新要重新上传，还要清理缓存的问题

#### 缺点

* Base64 编码的数据体积通常是原数据的体积 4/3，也就是 Data URL 形式的图片会比二进制格式的图片体积大 1/3

* Data URLs 形式的图片不会被浏览器缓存，这意味着每次访问页面时都被下载一次。

* 增加了 CSS 文件的尺寸

* 存在IE678兼容性问题

* 不适合 lazy loading

* 不利于维护

* 移动端不宜使用（解码耗 CPU）

## 应用实例

* 在 HTML 的 Img 标签中使用

```
<img src="data:image/x-icon;base64,AAABAAEAEBAAAAAAAABoBQAAF..." />
```

* 在 CSS 的 background-image 属性中使用

```
.image {
    width:100px;
    height:100px;
    background-image:url(data:image/x-icon;base64,AAABAAEAEBAAAAAAAABoBQAAF...);
}
```

* 在 HTML 的 CSS 链接处使用

```
<link rel="stylesheet" type="text/css" href="data:text/css;base64,LyogKioqKiogVGVtcGxhdGUgKioq..." />
```

* 在 HTML 的 javaScript 链接处使用

```
<script src="data:text/javascript;base64,LyogKioqKiogVGVtcGxhdGUgKioq..." type="text/javascript"></script>
```

* 直接在浏览器的地址栏中输入进行访问

在浏览器中输入以下的 Url，会得到一个加粗的 "Hello, world!"。也就是说，data: 后面的数据直接用做网页的内容，而不是网页的地址：

```
data:text/html,<html><body><p><b>Hello, world!</b></p></body></html>
```

## 参考文档

* [Data URI详细介绍](https://juejin.im/post/6844903940690018312)