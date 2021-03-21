---
title: HTML meta 标签
date: 2021-01-13 21:50:30
tags: [HTML]
---

## 简介

meta 标签在 W3C 上的解释为：

> The <meta> tag provides metadata about the HTML document. Metadata will not be displayed on the page, but will be machine parsable.
>
> Meta elements are typically used to specify page description, keywords, author of the document, last modified, and other metadata.

可以被用来：

> The metadata can be used by browsers (how to display content or reload page), search engines (keywords), or other web services

## 属性

#### charset

该属性声明了文档的字符编码，他的值对 `大小写不敏感`。

<!-- more -->

```
<meta charset='utf-8'>
```

#### name

该属性主要用于描述网页的信息属性的 key，与 name 对应的属性值由 content 指定，语法如下：

```
<meta name="属性" content="属性值">。
```

name 有以下常用属性：

* keywords

用于告诉搜索引擎，你网页的关键字。举例：

```
<meta name="keywords" content="这是个技术博客">
```

* description

用于告诉搜索引擎，你网站的主要内容。举例：

```
<meta name="description" content="这个网站都是关于前端的内容">
```

* viewport

这个概念较为复杂，后面会单独介绍。这个属性常用于设计移动端网页。举例：

```
<meta name="viewport" content="width=device-width, initial-scale=1">
```

* robots

用来告诉爬虫哪些页面需要索引，哪些页面不需要索引。content 的参数有 all、none、index、noindex、follow、nofollow，默认是 all。

具体参数如下：

```
none : 搜索引擎将忽略此网页，等价于noindex，nofollow。
noindex : 搜索引擎不索引此网页。
nofollow: 搜索引擎不继续通过此网页的链接索引搜索其它的网页。
all : 搜索引擎将索引此网页与继续通过此网页的链接索引，等价于index，follow。
index : 搜索引擎索引此网页。
follow : 搜索引擎继续通过此网页的链接索引搜索其它的网页。
```

举例：

```
<meta name="robots" content="none">
```

* author

用于标注网页作者，举例：

```
<meta name="author" content="Lxxyx,841380530@qq.com">
```

* generator

用于标明网页是什么软件做的，举例:

```
<meta name="generator" content="Sublime Text3">
```

* ncopyright

用于标注版权信息，举例：

```
<meta name="copyright" content="foogry">
```

* revisit-after

如果页面不是经常更新，为了减轻搜索引擎爬虫对服务器带来的压力，可以设置一个爬虫的重访时间。如果重访时间过短，爬虫将按它们定义的默认时间来访问。举例：

```
<meta name="revisit-after" content="7 days" >
```

* renderer

renderer 是为双核浏览器准备的，用于指定双核浏览器默认以何种方式渲染页面。比如说360浏览器。举例：

```
<meta name="renderer" content="webkit"> // 默认 webkit 内核
<meta name="renderer" content="ie-comp"> // 默认 IE 兼容模式
<meta name="renderer" content="ie-stand"> // 默认 IE 标准模式
```

#### http-equiv

http-equiv 的全拼是 http-equivalent，意思是相当于 http 的作用，用于定义 http 的参数。

meta 标签中 http-equiv 属性语法格式是：

```
<meta http-equiv="属性" content="属性值">
```

* content-Type

用于设定网页字符集，便于浏览器解析与渲染页面，举例：

```
<meta http-equiv="content-Type" content="text/html;charset=utf-8">  // 旧的 HTML 设置方式，不推荐
```

但在 HTML5 里推荐使用前面说过的 charset 来设置字符集：

```
<meta charset="utf-8"> // HTML5 设定网页字符集的方式，推荐使用 UTF-8
```

* X-UA-Compatible

用于告知浏览器以何种版本来渲染页面。一般都设置为最新模式，在各大框架中这个设置也很常见。举例：

```
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/> // 指定 IE 和 Chrome 使用最新版本渲染当前页面
```

* cache-control

> 用法一

指导浏览器如何缓存某个响应以及缓存多长时间。共有以下几种用法：

```
no-cache: 先发送请求，与服务器确认该资源是否被更改，如果未被更改，则使用缓存。

no-store: 不允许缓存，每次都要去服务器上，下载完整的响应。（安全措施）

public : 缓存所有响应，但并非必须。因为 max-age 也可以做到相同效果

private : 只为单个用户缓存，因此不允许任何中继进行缓存。（比如说 CDN 就不允许缓存 private 的响应）

maxage : 表示当前请求开始，该响应在多久内能被缓存和重用，而不去服务器重新请求。例如：max-age=60表示响应可以再缓存和重用 60 秒。
```

举例:

```
<meta http-equiv="cache-control" content="no-cache">
```

> 用法二 

用于禁止当前页面在移动端浏览时，被百度自动转码。虽然百度的本意是好的，但是转码效果很多时候却不尽人意。举例：

```
<meta http-equiv="Cache-Control" content="no-siteapp" />
```

* expires

用于设定网页的到期时间，过期后网页必须到服务器上重新传输。举例：

```
<meta http-equiv="expires" content="Sunday 26 October 2016 01:00 GMT" />
```

* refresh

网页将在设定的时间内，自动刷新并调向设定的网址。举例:

```
<meta http-equiv="refresh" content="2；URL=http://www.foogry.org/"> //意思是 2 秒后跳转向我的博客
```

* Set-Cookie

如果网页过期。那么这个网页存在本地的 cookies 也会被自动删除。格式为：

```
<meta http-equiv="Set-Cookie" content="name, date"> 
```

具体范例：

```
<meta http-equiv="Set-Cookie" content="User=Lxxyx; path=/; expires=Sunday, 10-Jan-16 10:00:00 GMT"> 
```

## 参考文档

* [<meta> tag](https://developer.mozilla.org/zh-CN/docs/Mobile/Viewport_meta_tag)

* [HTML meta标签总结与属性使用介绍](https://segmentfault.com/a/1190000004279791)