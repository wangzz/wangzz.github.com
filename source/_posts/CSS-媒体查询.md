---
title: CSS 媒体查询
date: 2021-01-07 13:37:53
tags: [CSS]
---

媒体查询（Media queries）被用于根据设备的大致类型（如打印设备与带屏幕的设备）或者特定的特征和设备参数（例如屏幕分辨率和浏览器视窗宽度）来修改网站或应用程序的样式。

## 媒体类型

媒体类型（Media types）用于描述设备的一般类别。除非使用 not 或 only 逻辑操作符，媒体类型是可选的，默认是 all 类型。

* all

适用于所有设备。

* print

适用于在打印预览模式下在屏幕上查看的分页材料和文档。（有关特定于这些格式的格式问题的信息，请参阅分页媒体。）

* screen

主要用于屏幕。

<!-- more -->

* speech

主要用于语音合成器。

> 注意：此外还有些被废弃的媒体类型：tty、tv、projection、handheld、braille、embossed、aural

## 媒体特性

媒体特性（Media features）描述了 user agent、输出设备，或是浏览环境的具体特征。媒体特性表达式是完全可选的，它负责测试这些特性或特征是否存在、值为多少。每条媒体特性表达式都必须`用括号括起来`。

| 名称                              | 简介                                                         | 备注                                  |
| --------------------------------- | ------------------------------------------------------------ | ------------------------------------- |
| any-hover                         | 是否有任何可用的输入机制允许用户（将鼠标等）悬停在元素上？   | 在 Media Queries Level 4 中被添加。   |
| any-pointer                       | 可用的输入机制中是否有任何指针设备，如果有，它的精度如何？   | 在 Media Queries Level 4 中被添加。   |
| aspect-ratio                      | 视窗（viewport）的宽高比                                     |                                       |
| color                             | 输出设备每个像素的比特值，常见的有 8、16、32 位。如果设备不支持输出彩色，则该值为 0 |                                       |
| color-gamut                       | 用户代理和输出设备大致程度上支持的色域                       | 在 Media Queries Level 4 中被添加。   |
| color-index                       | 输出设备的颜色查询表（color lookup table）中的条目数量，如果设备不使用颜色查询表，则该值为 0 |                                       |
| display-mode                      | 应用程序的显示模式，如web app的manifest中的display 成员所指定 | 在 Web App Manifest spec被定义.       |
| forced-colors                     | 检测是user agent否限制调色板                                 | 在 Media Queries Level 5 中被添加。   |
| grid                              | 输出设备使用网格屏幕还是点阵屏幕？                           |                                       |
| height                            | 视窗（viewport）的高度                                       |                                       |
| hover                             | 主要输入模式是否允许用户在元素上悬停                         | 在 Media Queries Level 4 中被添加。   |
| inverted-colors                   | user agent或者底层操作系统是否反转了颜色                     | 在 Media Queries Level 5 中被添加。   |
| light-level                       | 环境光亮度                                                   | 在 Media Queries Level 5 中被添加。   |
| monochrome                        | 输出设备单色帧缓冲区中每个像素的位深度。如果设备并非黑白屏幕，则该值为 0 |                                       |
| orientation                       | 视窗（viewport）的旋转方向                                   |                                       |
| overflow-block                    | 输出设备如何处理沿块轴溢出视窗(viewport)的内容               | 在 Media Queries Level 4 中被添加。   |
| overflow-inline                   | 沿内联轴溢出视窗(viewport)的内容是否可以滚动？               | 在 Media Queries Level 4 中被添加。   |
| pointer                           | 主要输入机制是一个指针设备吗？如果是，它的精度如何？         | 在 Media Queries Level 4 中被添加。   |
| prefers-color-scheme              | 探测用户倾向于选择亮色还是暗色的配色方案                     | 在 Media Queries Level 5 中被添加。   |
| prefers-contrast                  | 探测用户是否有向系统要求提高或降低相近颜色之间的对比度       | 在 Media Queries Level 5 中被添加。   |
| prefers-reduced-motion            | 用户是否希望页面上出现更少的动态效果                         | 在 Media Queries Level 5 中被添加。   |
| prefers-reduced-transparency      | 用户是否倾向于选择更低的透明度                               | 在 Media Queries Level 5 中被添加。   |
| resolution                        | 输出设备的像素密度（分辨率）                                 |                                       |
| scan                              | 输出设备的扫描过程（适用于电视等）                           |                                       |
| scripting                         | 探测脚本（例如 JavaScript）是否可用                          | 在 Media Queries Level 5 中被添加。   |
| update                            | 输出设备更新内容的渲染结果的频率                             | 在 Media Queries Level 4 中被添加。   |
| width                             | 视窗（viewport）的宽度，包括纵向滚动条的宽度                 |                                       |
| device-aspect-ratio（Deprecated） | 输出设备的宽高比                                             | 已在 Media Queries Level 4 中被弃用。 |
| device-height（Deprecated）       | 输出设备渲染表面（如屏幕）的高度                             | 已在 Media Queries Level 4 中被弃用。 |
| device-width（Deprecated）        | 输出设备渲染表面（如屏幕）的宽度                             | 已在 Media Queries Level 4 中被弃用。 |


## 逻辑操作符

逻辑操作符（logical operators） not, and, 和 only 可用于联合构造复杂的媒体查询，您还可以通过用逗号分隔多个媒体查询，将它们组合为一个规则。

* and

and 操作符用于将多个媒体查询规则组合成单条媒体查询，当每个查询规则都为真时则该条媒体查询为真，它还用于将媒体功能与媒体类型结合在一起。

* not

not 运算符用于否定媒体查询，如果不满足这个条件则返回 true，否则返回 false。 如果出现在以逗号分隔的查询列表中，它将仅否定应用了该查询的特定查询。 如果使用 not 运算符，则还必须指定媒体类型。

> 注意：在Level 3中，not 关键字不能用于否定单个媒体功能表达式，而只能用于否定整个媒体查询。

* only

only 运算符仅在整个查询匹配时才用于应用样式，并且对于防止较早的浏览器应用所选样式很有用。 当不使用 only 时，旧版本的浏览器会将 `screen and (max-width: 500px)` 简单地解释为 screen，忽略查询的其余部分，并将其样式应用于所有屏幕。 如果使用 only 运算符，则还必须指定媒体类型。

* , (逗号)

逗号用于将多个媒体查询合并为一个规则。 逗号分隔列表中的每个查询都与其他查询分开处理。 因此，如果列表中的任何查询为 true，则整个 media 语句均返回 true。 换句话说，列表的行为类似于逻辑或 or 运算符。

## 媒体查询使用方式

* 通过 @media 和 @import at-rules 用 CSS 装饰样式

示例：

```
@import url('landscape.css') screen and (orientation:landscape);

@media only screen and (device-width: 384px) and (device-height: 640px) and
(-webkit-device-pixel-ratio: 3) {
    .title {
        max-height: 0.26rem;
    }
}
```

* 用 media= 属性为<style>, <link>, <source> 和其他HTML元素指定特定的媒体类型

示例:

```
<link rel="stylesheet" src="styles.css" media="screen" />

<style media="screen">
.box { height: 100px; width: 100px; background-color: lightblue;}    
</style>
```

> 注意： 即使媒体查询返回 false，带有媒体查询附加到其 <link> 标记的样式表仍将下载。 但是，除非查询结果变为 true，否则其内容将不适用。

* 使用 Window.matchMedia() 和 MediaQueryList.addListener() 方法来测试和监控媒体状态

window.matchMedia() 方法接受一个 mediaQuery 语句的字符串作为参数，返回一个 MediaQueryList 对象。该对象有 media 和 matches 两个属性：

```
media：返回所查询的mediaQuery语句字符串
matches：返回一个布尔值，表示当前环境是否匹配查询语句
```

示例：

```
let result = window.matchMedia('(min-width: 600px)');
console.log(result.media); //'(min-width: 600px)'
console.log(result.matches); // true

if (result.matches) {
  //
} else {
  //
}
```

> 注意：如果 window.matchMedia 无法解析 mediaQuery 参数，matches 属性返回的总是 false，而不是报错

window.matchMedia 方法返回的 MediaQueryList 对象有两个方法，用来监听事件：

```
addListener // 指定回调函数
removeListener // 移除回调函数
```

示例：

```
// 注意，只有 mediaQuery 查询结果发生变化时，才调用指定的回调函数
let mql = window.matchMedia("(min-width: 1000px)");
mqCallback(mql);
mql.addListener(mqCallback);
function mqCallback(mql) {
  if (mql.matches) {
    document.body.background = 'pink';
  } else {
    document.body.background = 'lightblue';
  }
}
```

> 注意：本页的例子使用 CSS @media 的方式来说明目的，但是对于所有类型的媒体查询，基本语法均相同。

## 参考文档

* [深入理解CSS Media媒体查询](https://www.cnblogs.com/xiaohuochai/p/5848612.html)

* [使用媒体查询](https://developer.mozilla.org/zh-CN/docs/Web/Guide/CSS/Media_queries)