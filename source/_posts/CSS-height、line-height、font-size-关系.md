---
title: CSS height、line-height、font-size 关系
date: 2021-03-5 13:36:01
tags: [CSS]
---

## font-size

下面这段代码 font-size 相同，不过 font-family 不一样：

```
<p>
    <span class="a">Ba</span>
    <span class="b">Ba</span>
    <span class="c">Ba</span>
</p>
```

```
p  { font-size: 100px }
.a { font-family: Helvetica }
.b { font-family: Gruppo    }
.c { font-family: Catamaran }
```

由此得到的 span 元素的实际高度各不相同：

<!-- more -->

![](https://gitee.com/wangzz/pic/raw/master/font-size1.png)

* 字体度量

字体度量包括 ascender、descender、capital height、x-height 等。

示意如图所示：

![](https://gitee.com/wangzz/pic/raw/master/font-size/1.jpg)

把 Catamaran 字体放到 FontForge 中，分析它的字体度量：

![](https://gitee.com/wangzz/pic/raw/master/font-size/2.png)

* content-area

从上图可见 Catamaran 字体的 ascender 是 1100，descender 是 540，line gap 是 0。

> 字体的实际渲染高度 = ascender + descender + line gap

所以 Catamaran 的实际渲染高度是 1100 + 540 + 0 = 1640px，如图所示：

![](https://gitee.com/wangzz/pic/raw/master/font-size/3.png)

而一个字体的实际渲染高度又被称为 `content-area`。

## line-height

line-height 和 content-area 的关系可以用下面的图说明：

![](https://gitee.com/wangzz/pic/raw/master/font-size/4.png)

line-height 和 content-area 高度的差异叫做 leading。leading 的一半会被加到 content-area 顶部，另一半会被加到底部。因此 `content-area 总是处于 line-height 的中间`。

当然 leading 的值可以是正的，也可以为负或零。leading 为负的效果如图所示：

![](https://gitee.com/wangzz/pic/raw/master/font-size/5.png)

## height

height 决定了一个标签实际展示的高度（可以认为 height 完全决定了 background-color 的展示区域）。

当 height 大于 line-height 时，会出现下图的效果：

![](https://gitee.com/wangzz/pic/raw/master/font-size/6.png)

height 小于 line-height 时，会出现下图的效果：

![](https://gitee.com/wangzz/pic/raw/master/font-size/7.png)

## 参考文档

* [深入理解 CSS：字体度量、line-height 和 vertical-align
](https://zhuanlan.zhihu.com/p/25808995)

* [fontforge](https://fontforge.org/en-US/)

* [fontforge 与字体设计](http://designwithfontforge.com/zh-CN/index.html)