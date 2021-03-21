---
title: 关于 console 你需要知道的
date: 2021-03-15 20:26:45
tags: [JavaScript]
---

## 概述

console 的功能主要在于控制台打印，它可以打印任何字符、对象、甚至 DOM 元素和系统信息，下面一一介绍。

### console.log( ) | info( ) | debug( ) | warn( ) | error( )

直接打印字符，区别在于展示形态的不同：

<img width=400 src="https://img.alicdn.com/tfs/TB1xZ_WveH2gK0jSZFEXXcqMpXa-1492-566.png">

新版 chrome 控制台可以将打印信息分类：

<!-- more -->

<img width=200 src="https://img.alicdn.com/tfs/TB1fZ2Vvhn1gK0jSZKPXXXvUXXa-420-446.png">

`log()` 与 `info()` 都对应 `info`，`warn()` 对应 `warnings`，`error()` 对应 `errors`，而 `debug()` 对应 `verbose`，因此建议在合适的场景使用合适的打印习惯，这样排查问题时也可以有针对性的筛选。

比如调试信息可以用 `console.debug` 仅在调试环境下输出，调试者即便开启了调试参数也不会影响正常 `info` 的查看，因为调试信息都输出在 `verbose` 中。

### 使用占位符

- %o — 对象
- %s — 字符串
- %d — 数字

如下所示，可通过占位符在一行中插入不同类型的值：

<img width=400 src="https://img.alicdn.com/tfs/TB1GtL3vlr0gK0jSZFnXXbRRXXa-1840-504.png">

### 添加 CSS 样式

- %c - 样式

<img width=400 src="https://img.alicdn.com/tfs/TB1eK23vlr0gK0jSZFnXXbRRXXa-1832-978.png">

可以总结出，**console 支持输出复杂的内容，其输出能力堪比 HTML，但输入能力太弱，仅为字符串，因此采用了占位符 + 多入参修饰的设计模式解决这个问题。**

### console.dir( )

按 JSON 模式输出。笔者在这里也补充一句：`console.log()` 会自动判断类型，如果内容是 DOM 属性，则输出 DOM 树，但 `console.dir` 会强制以 JSON 模式输出，用在 DOM 对象时可强制转换为 JSON 输出。

<img width=400 src="https://img.alicdn.com/tfs/TB1KQY1vbj1gK0jSZFuXXcrHpXa-922-302.png">

### 输出 HTML 元素

按照 HTML ELements 结构输出：

<img width=400 src="https://img.alicdn.com/tfs/TB1mZ61va61gK0jSZFlXXXDKFXa-920-255.png">

这种输出结构和 Elements 打印形式是一致的，如果要看详细属性，可以使用 `console.dir()`。

### console.table

在控制台打印一个表格，属于功能增强。虽然仅文本也可以在控制台打印出漂亮的表格，但浏览器调试控制台的功能更强大，`console.table` 只是其富文本能力的一个体现。

<img width=400 src="https://img.alicdn.com/tfs/TB1WldouKbviK0jSZFNXXaApXXa-928-742.png">

### console.group( ) & console.groupEnd( )

接下来是另一个富文本能力，按分组输出：

<img width=400 src="https://img.alicdn.com/tfs/TB1UV6UvXY7gK0jSZKzXXaikpXa-919-377.png">

这种带有副作用的 API 显然是为方便阅读而设计的，然而在需要输出大量动态结构化数据的场景下，还需要进行结构转换，是比较麻烦的地方。

### console.count( )

`count()` 用来打印调用次数，一般用在循环或递归函数中。接收一个 `label` 参数以定制输出，默认直接输出 `1 2 3` 数字。

<img width=400 src="https://img.alicdn.com/tfs/TB1ELLVveL2gK0jSZPhXXahvXXa-917-500.png">

### console.assert( )

`console` 版断言工具，当且仅当第一个参数值为 `false` 时才打印第二个参数作为输出。

<img width=400 src="https://img.alicdn.com/tfs/TB1HEDUvfb2gK0jSZK9XXaEgFXa-1842-548.png">

这种输出结果为 error，所以也可被 `console.error` + 代码级别断言所取代。

### console.trace( )

打印此时的调用栈，在打印辅助调试信息时非常有用。

<img width=400 src="https://img.alicdn.com/tfs/TB1Jh_YvkL0gK0jSZFAXXcA9pXa-1840-1096.png">

### console.time( )

打印代码执行时间，性能优化和监控场景比较常见。

<img width=400 src="https://img.alicdn.com/tfs/TB1wAT2vbj1gK0jSZFuXXcrHpXa-1612-524.png">

### console.memory

打印内存使用情况。

<img width=400 src="https://img.alicdn.com/tfs/TB1tPHYvkL0gK0jSZFAXXcA9pXa-1842-440.png">

### console.clear( )

清空控制台输出。

## 总结

`console` 提供了如此多的输出规范，其实也是在变相制定开发规范，毕竟离开发者最近的就是调试控制台，如果你的项目打印规范与标准规范有差异，那么调试时信息看起来就会很别扭。

可以看到，大部分开源库都良好的遵循了这套规范，比如三方库绝不会输出 `log()`，而且将错误、警告与调试信息正确分开，并尽量少的用 CSS 样式、分组、`table` 等功能，因为这些功能干扰性较强，不能保证所有用户都可接受。

相对的，项目源码就比较适合使用一些醒目的自定义规范，只要这套规则能被很好的执行起来。

## 参考文档

* [Mastering JS console.log like a Pro](https://medium.com/javascript-in-plain-english/mastering-js-console-log-like-a-pro-1c634e6393f9)