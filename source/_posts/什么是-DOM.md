---
title: 什么是 DOM
date: 2021-01-11 13:46:47
tags: [DOM]
---

## 什么是 DOM

DOM（Document Object Model） 是 JavaScript 操作网页的接口，它的作用是将网页转为一个 JavaScript 对象，从而可以用脚本进行增删改查操作。

浏览器会根据 DOM 模型将结构化的文档（比如 HTML、XML）解析成一系列的节点，再由这些节点组成一个树状结构（DOM Tree）。

DOM 只是一个接口规范，可以用各种语言实现（比如 Python 也可以）。

<!-- more -->

## 节点

DOM 的最小组成单位叫节点（node）。文档的树状结构就是由不同类型的节点组成的。节点类型有 7 种：

* Document：整个文档树的顶层节点

* DocumentType：doctype 标签（比如 <!DOCTYPE html>）

* Element：网页的各种 HTML 标签（比如 <body>、<a> 等）

* Attr：网页元素的属性（比如 class="input"）

* Text：标签之间或标签包含的文本

* Comment：注释

* DocumentFragment：文档的片段

浏览器提供一个原生的节点类型 Node，上面的 7 种节点都继承了 Node，因此具有一些共同的属性和方法。

## DOM 对象模型

* 原型

![](https://p.pstatp.com/origin/ff7e00011b3162df5f1f)

## 参考文档

* [DOM 类的 UML 类图](http://wangyn.net/2016/10/25/dom_class_diagram.html)

* [JavaScript教程 - DOM](https://wangdoc.com/javascript/dom/index.html) 