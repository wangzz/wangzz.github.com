---
title: CSS 长度单位
date: 2021-01-4 20:34:09
tags: [CSS]
---

未参考文档：https://www.w3.org/Style/Examples/007/units.zh_CN.html


## 基础概念

* pixel (Picture Element) 

`用于显示领域`。

`pix` 是 picture 的常用简写，加上单词 element 的前缀 `el` 就得到 `piexl`，中文翻译成像素，是图像显示的基本单位。

需要注意的是，`像素并不是个物理长度单位`，但是它和物理长度之间有换算关系，后面会讲到。

* ppi (Pixels Per Inch)

`用于显示领域`。

表示每英寸像素数目。显然 ppi 数值越高图像就能显示的越清晰。ppi 的计算公式为：

> ppi = 屏幕分辨率 / 屏幕宽度（单位 inch）

比如 iPhone 8 的屏幕分辨率是 750 * 1334，对应的屏幕宽度是 2.3 inch，则 iPhone8 的 ppi 为：

<!-- more -->

> 750 / 2.3 = 326 ppi

* pt

`用于打印领域`。

pt 又称 ‘点’，是目前最常用的排版单位，在中文排版中也称该单位为‘磅’，它与英寸及毫米的折算关系是 1pt = 1 / 72 inch = 0.3528mm。该单位经常被误认为等同于象素（pixel）单位，其实‘点’并不是‘象素’，它们之间的换算关系与屏幕或打印分辨率有关。仅在分辨率是72 dpi（dot per inch）时，1 pt才与1 pixel相同， 如果分辨率是 96 dpi，1 pt 等同与 1.333 (96 / 72) 象素单位。

* dpi (Dots Per Inch)

`用于打印领域`。

用于表示每英寸打印的墨点数目。

## iOS 中的 points 和物理像素的关系

iOS 开发中布局的单位是 points (pt)，这是个逻辑单位，`屏幕分辨率 = points * scale`，也就是说使用 points 布局的元素占用的实际像素宽度为：

> px = points * scale

iPhone 设备屏幕信息：

| 设备               | 屏幕尺寸 | 屏幕分辨率    | ppi    | points    | scale |
| ------------------ | -------- | ------------- | ------ | --------- | ----- |
| 2G/3G/3GS          | 3.5英寸  | 320*480px     | 163ppi | 320*480pt | 1X    |
| 4/4s               | 3.5英寸  | 640*960px     | 326ppi | 320*480pt | 2X    |
| 5/5S/5C/SE         | 4.0英寸  | 640*1136px    | 326ppi | 320*568pt | 2X    |
| 6/6S/7/8           | 4.7英寸  | 750*1334px    | 326ppi | 375*667pt | 2X    |
| 6+/6S+/7+/8+       | 5.5英寸  | 1242*2208px   | 401ppi | 414*736pt | 3X    |
| X/Xs/11 Pro        | 5.8英寸  | 1125*2436px   | 458ppi | 375*812pt | 3X    |
| Xr, 11             | 6.1英寸  | 828 × 1792px  | 326ppi | 414*896pt | 2x    |
| Xs Max/ 11 Pro Max | 6.5英寸  | 1242 × 2688px | 458ppi | 414*896pt | 3X    |

## 安卓中的 dp 和物理像素的关系

dp 或 dip : device independent pixels（设备独立像素），是安卓开发用的单位，1dp 表示在屏幕点密度为 160ppi 时 1px 长度。因为安卓设备屏幕众多不可能为每个屏幕单独开发，所以用下面的公式计算在不同屏幕上的像素数：

> px = dp * ( ppi / 160)

## CSS 长度单位

MDN 里关于 [CSS 长度单位](https://developer.mozilla.org/zh-CN/docs/Learn/CSS/Building_blocks/Values_and_units) 的介绍如下：

* 绝对长度单位

| 单位 | 名称                                | 等价换算            |
| ---- | ----------------------------------- | ------------------- |
| cm   | 厘米（Centimeters）                 | 1cm = 96px/2.54     |
| mm   | 毫米（Millimeters）                 | 1mm = 1/10th of 1cm |
| Q    | 四分之一毫米（Quarter-millimeters） | 1Q = 1/40th of 1cm  |
| in   | 英寸（Inches）                      | 1in = 2.54cm = 96px |
| pc   | 十二点活字（Picas）                 | 1pc = 1/16th of 1in |
| pt   | 点（Points）                        | 1pt = 1/72th of 1in |
| px   | 像素（Pixels）                      | 1px = 1/96th of 1in |

我对这里的 pt 和 px 同 inch 的转换关系其实是存疑的，它们和 inch 的转换关系在显示领域是要由 ppi 决定的，不指定 ppi 就计算二者关系的行为都是耍流氓！

* 相对长度单位

| 单位 | 相对于                                                       |
| ---- | ------------------------------------------------------------ |
| em   | 在 font-size 中使用是相对于父元素的字体大小，在其他属性中使用是相对于自身的字体大小，如 width |
| ex   | 字符 “x” 的高度                                              |
| ch   | 数字 “0” 的宽度                                              |
| rem  | 根元素（root element）的字体大小                             |
| lh   | 元素的 line-height                                           |
| vw   | 视窗（viewport）宽度的 1%                                    |
| vh   | 视窗（viewport）高度的 1%                                    |
| vmin | vw 和 vh 中较小那个尺寸的 1%                                 |
| vmax | vw 和 vh 中较大那个尺寸的 1%                                 |

## H5 可视宽度

可视宽度意味着在这个宽度内做布局都是可视的，超出可视宽度部分只有滑动或缩放后才可见。

可视宽度可以通过 `document.documentElement.clientWidth` 获取，单位是 `CSS 像素(px)`。

可视素宽度由 viewport 决定，而 viewport 默认宽度是由浏览器厂商定义好的，默认值如下：

| 浏览器          | 默认宽度 |
| --------------- | -------- |
| iPhone          | 980      |
| iPad            | 980      |
| Android Sumsung | 980      |
| Android HTC     | 980      |
| Chrome          | 980      |
| Opera Presto    | 980      |
| BlackBerry      | 1024     |
| IE              | 1024     |

我们可以通过如下方式修改 viewport 宽度：

```
<head>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no">
</head>
```

当 WebView 容器宽度和设备的屏幕宽度一致时，可以用上述代码将 viewport 宽度设置成屏幕宽度。对应的 `viewport 实际高度 = viewport 宽度 / WebView 容器宽度 * WebView 容器高度`。

## CSS 像素和设备物理像素的关系

和 iOS 中的 points 类似，CSS 像素也是个逻辑单位，和设备的物理像素并不是一回事。

* CSS 像素和物理像素关系

二者换算关系如下：

> 物理像素 = 屏幕分辨率 / H5 可视宽度 * CSS 像素 

由于 `屏幕分辨率 = points * scale` 因此上面的公式也可以写成：

> 物理像素 = points * scale / H5 可视宽度 * CSS 像素 

比如 iPhone 8 屏幕分辨率是 `750 * 1334` ，即宽度是 750 像素；H5 可视宽度是默认值 980 像素的时候，CSS 像素 100px 在 iPhone 8 上实际对应的物理像素为：

> 750 / 980 * 100 = 77 px

* 推荐做法

从上面的公式可见，当 points 和 H5 可视宽度相同时，CSS 像素和物理像素的关系就变成了：

> 物理像素 = scale * CSS 像素

其中的 scale 在 H5 里就是 `window.devicePixelRatio`。

可见，当 WebView 容器的宽度和 H5 可视宽度一致时，CSS 像素的含义跟 iOS 布局里的 `points` 是一模一样的。

## 物理宽度

物理像素展现在屏幕上后，用户看到的实际物理宽度计算公式为：

> 物理宽度 = 物理像素 / 屏幕 ppi = scale * CSS 像素 / 屏幕 ppi

由此可见，当我们在 H5 里设置一个标签的宽度是 100 px 时，在不同设备上，用户看到的实际大小可能不一样，会而根据设备的 scale 和 ppi 不同而不同。

## 参考文档

* [A pixel is not a pixel is not a pixel](https://www.quirksmode.org/blog/archives/2010/04/a_pixel_is_not.html)

* [CSS的值与单位](https://developer.mozilla.org/zh-CN/docs/Learn/CSS/Building_blocks/Values_and_units)

* [Window.devicePixelRatio](https://developer.mozilla.org/zh-CN/docs/Web/API/Window/devicePixelRatio)

* [移动前端开发之viewport,devicePixelRatio的深入理解](https://www.jianshu.com/p/413a25b2c503)

* [移动设备屏幕信息查询](http://screensiz.es/)

* [iPhone 屏幕信息](https://www.paintcodeapp.com/news)

* [第二话——什么是 dp、pt、sp？](https://zhuanlan.zhihu.com/p/26481853)

* [dp的定义原理和dpi,ppi,px,pt,sp之间的区别](https://blog.csdn.net/xx326664162/article/details/48007855)