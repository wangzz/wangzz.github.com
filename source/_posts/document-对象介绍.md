---
title: document 对象介绍
date: 2021-01-13 12:48:54
tags: [DOM]
---

## 介绍

文档节点隶属于 window 对象，表示整个页面文档，是文档的根节点。浏览器中有 html、xml 和 svg 三种类型的文档，分别对应三种类型的文档节点。文档节点没有父节点。在 html 文档中，文档节点有两个子节点，分别是 html 元素节点（仅指 <html> 标签的 dom 化节点）和文档类型节点。在 Javascript 中，document 不是一个普通的 JS 内置对象，而是 dom 的核心对象。

document 的继承关系：

EventTarget <- Node <- document

<!-- more -->

## 属性

* document.documentElement 

document.documentElement 是一个元素节点，指向文档中的<html>标签。

* document.body 

document.body 是一个元素节点，指向文档中的<body>标签。

* document.doctype 

document.doctype 是一个元素节点，指向文档中的 <!DOCTYPE> 标签。ie8 及以下版本的浏览器不兼容，输出 null（因为叹号的原因 ie8 及以下版本的浏览器将其识别为注释节点）。

* document.head

document.head 是一个元素节点，指向文档中的 <head> 标签。ie8 及以下版本的浏览器不支持。

```
console.log(document.documentElement.nodeName); // "HTML"
console.log(document.body.nodeName);            // "BODY"
console.log(document.doctype.nodeName);         // "html"
console.log(document.head.nodeName);            // "HEAD"
```

* document.title 

document.title 属性值是 <title> 标签中的文本，可读可写。

* document.URL 

返回页面完整地址。

```
document.URL; //"https://www.baidu.com/s?ie=UTF-8&wd=%E7%99%BE%E5%BA%A6"
```

* document.domain 

返回页面的域名。

```
document.domain; //"www.baidu.com"
```

* document.referrer 

当前页面作为子页面，返回父页面的 url。如果没有父页面，返回 null。

URL、domain 和 referrer 三个属性的信息来自请求的HTTP头部。三个属性中，只有 domain 是可以设置的。但由于安全方面的限制，只能将 domain 设置为 URL 中包含的域。

```
console.log(document.URL);      //http://www.cnblogs.com/xiaohuochai/
console.log(document.domain);   //www.cnblogs.com
console.log(document.referrer); //http://home.cnblogs.com/followees/
```

* document.baseURI 

返回 <base> 标签中的 URL，如果没有设置 <base>，baseURL 属性值等于 URL 属性值。

```
<base href="http://www.baidu.com"> 
<script>
    console.log(document.baseURI);//'http://www.baidu.com/'
</script>
```

* document.charset 

返回文档中实际使用的字符集。

```
console.log(document.charset); // "UTF-8"
```

* document.documentMode 

返回当前文档模式。该属性只有 ie11 及以下版本的浏览器支持。

```
//IE11返回11，IE10返回10，IE9返回9，IE8返回8，IE7返回7，IE6返回6
//其他浏览器返回undefined
console.log(document.documentMode);
```

* document.lastModified 

返回当前文档最后修改的时间戳，返回结果为字符串类型。

```
console.log(document.lastModified); // "03/30/2019 20:00:58"
```

* document.anchors 

返回一个 HTMLCollection 集合，该集合包含文档中所有带 name 特性的 <a> 标签对应的元素节点。

```
<a href= "#" name="a1">a1</a>
<a href= "#" name="a2">a2</a>
<a href= "#" >3</a>
<script>
    console.log(document.anchors.length)//2
</script>
```

* document.links 

返回一个 HTMLCollection 集合，该集合包含文档中所有带 href 特性的 <a> 标签对应的元素节点。

```
<a href="#">1</a>
<a href="#">2</a>
<a>3</a>
<script>
    console.log(document.links.length)//2
</script>
```

* document.forms 

返回一个 HTMLCollection 集合，该集合包含文档中所有 <form> 标签对应的元素节点，与 document.getElementsByTagName("form") 结果相同。

```
<form action="#">1</form>
<form action="#">2</form>
<script>
    console.log(document.forms.length)//2
</script>
```

* document.images 

返回一个 HTMLCollection 集合，该集合包含文档中所有 <img> 标签对应的元素节点，与 document.getElementsByTagName('img') 结果相同。

```
<img src="#" alt="#">
<img src="#" alt="#">
<script>
    console.log(document.images.length)//2
</script>
```

## 方法

* document.write()

write() 和 writeln() 方法可以将数据打印到页面，参数为字符串类型，支持同时打印多个，可以解析 html 标签。其中 write() 方法会原样写入，而 writeln() 方法会在字符串两侧各加一个空格。

```
<button id="btn">内容</button>
<script>
    document.writeln('hello'); //"hello"
    document.write('world');   //"hello world"
</script>
document.write("1", "2", "3");   //"123"
document.writeln("4", "5", "6"); //"123 456"
```

open() 方法可以清除当前文档的所有节点，并打开一个新文档，新文档用 write() 或 writeln() 方法编写内容，最后用 close() 方法关闭文档输出流。一旦文档输出流关闭，当前文档就不能再被写入新内容，此时如果调用 write 或 writeIn 方法，会隐式调用 open 方法清空当前文档后再写入。如果在页面加载期间使用 write 或 writeIn 方法，不会清空当前文档 ，会直接在文档流末尾写入。

```
//相当于'123'又把'1'覆盖了
document.open();
document.write('1');
document.close();
document.write('123');
```

## 参考文档

* [dom节点的概念、基本属性和基本类型](https://blog.csdn.net/weixin_42472040/article/details/88841675)