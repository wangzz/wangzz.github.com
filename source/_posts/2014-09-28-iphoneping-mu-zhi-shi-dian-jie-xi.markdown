---
layout: post
title: "iPhone屏幕知识点解析"
date: 2014-09-28 14:34:37 +0800
comments: true
categories: iOS
tags: [iPhone, iOS, iPhone6, iPhone6+, 屏幕]
keywords: iPhone, iOS, iPhone6, iPhone6+, 屏幕
---

![iphone5-6](/images/article7/iphone5-6.jpg)

## 一、屏幕相关知识点

#### 1、屏幕尺寸

在显示器世界里，屏幕尺寸都是由屏幕对角线长度表示的，单位是英寸。比如iPhone4的3.5寸屏就意味着屏幕对角线的长度是3.5英寸。

#### 2、分辨率

分辨率是任何一款手机产品最重要的参数之一。显示屏是由一个个像素组成的，分辨率可以简单理解成屏幕像素的数目。比如iPhone4的屏幕分辨率为640×960，就表示屏幕的横向有640个像素点，纵向有960个像素点。

<!-- more -->

#### 3、PPI

PPI（Pixels Per Inch）表示单位面积上的像素点数目。分辨率可以表示屏幕包含的像素数目，但要想描述屏幕的显示质量，还需要知道屏幕尺寸，最后算出单位面积上的像素点数目。显然PPI越高，屏幕显示效果越细腻。

PPI计算公式：

![PPI](/images/article7/PPI.jpg)

其中，X：长度像素数；Y：宽度像素数；Z：屏幕尺寸即对角线长度

#### 4、Points

可以简单理解成我们使用`UIKit`或 `Core Animation`处理界面元素时所用到的逻辑坐标系统。Points是在iOS4以后引入的，出现的目的是提供一种与设备无关的一致的输出效果。

苹果考虑到以后有可能推出不同分辨率屏幕的手机，如果开发者在界面布局的时候操纵像素，就会导致每种不同分辨率的设备都要有一份适配代码。比如在分辨率为320×480的iPhone3GS上，要画一条长度1英寸的线条，假设需要50个像素，即线条的长度设成50像素；但是在分辨率为640×960的iPhone4上，50像素所能表示的实际长度只有iPhone3GS的一半，即0.5英寸。因此开发者必须使用两套适配代码：在iPhone3GS上将线条长度设成50像素，在iPhone4上设成100像素。这还仅仅是两款设备，如果算上后来的iPhone5/5C/5S和iPhone6/6+，每种分辨率都来一套适配代码，开发者岂不是得疯掉？？

现在苹果使用了一套逻辑坐标系统来解决多分辨率屏幕适配问题，将屏幕上的每一个点都用以屏幕左上角为原点，横向为X轴，纵向为Y轴的坐标来表示（PS：并不是所有的框架默认坐标系统都是这样，比如`APPKit`中的`NSView`；当然开发者也可以将`UIKit`和 `Core Animation`的坐标系统改成以屏幕左下角为原点，但原理都是一样的。）。以iPhone3GS/4为例，他们的坐标系统中X和Y的最大值都分别是320和480。

有了逻辑坐标系统，想在分辨率不同的iPhone3GS/4画一条长度均为1英寸的线条就变成了这样：将线的长度设成50Points（假设1英寸对应那么多个Points），`UIKit`在屏幕上绘图的时候会判断屏幕分辨率，如果是iPhone3GS的320×480分辨率屏幕，会自动使用50像素绘制；如果是iPhone4的640×960分辨率，会自动使用100像素绘制。

这种机制使得在4寸屏幕的iPhone5出来之前，iOS开发者在设备屏幕适配上的工作量几乎为零（当然，需要准备两套图片），对此Android同行们早就口水直下三千尺了。后来随着iPhone屏幕尺寸的变化，逻辑坐标系统的取值范围也发生了变化，这才让iOS开发者有点事情可做。


#### 5、渲染比例（Scale）

像素点数目和逻辑坐标点数目的比值，就是渲染比例（Scale）。更直观的说法是一个逻辑坐标点，需要用几个像素点来渲染。

iPhone3GS的逻辑坐标系统是320×480，分辨率是320×480，即每个坐标点对应一个像素，即Scale为1；iPhone4的逻辑坐标系统是320×480，分辨率是640×960，每个坐标点对应两个像素点，即Scale为2。

因此，为了适配iPhone6+的屏幕，以后又得曾加一份@3x分辨率的图片了。

#### 6、宽高比

屏幕宽度和高度的比例，也可以是分辨率的横向像素点数目和纵向像素点数目的比例，他们通常是一致的，一般用整数表示。

iPhone3GS/4/4S的宽高比2:3，iPhone5/5C/5S/6/6+的宽高比都是9:16。

当年iPhone5出来的时候，适配3.5寸屏幕的应用上下黑边的场景仍记忆犹新，用户体验很不好，虽然大部分应用都迅速的做了适配。还好苹果这次学聪明了，从4寸屏升级到iPhone6的4.7寸屏和iPhone6+的5.5寸屏，宽高比并没有变化。也就是说原来在iPhone5上运行的应用能够通过拉伸平滑过渡到iPhone6/6+上，可能会稍微有点模糊。不过比起3.5寸到4寸屏的升级来说已经好很多了。


## 二、说明

#### 1、历代iPhone屏幕参数

下面的一张图介绍了从iPhone4到iPhone6+的几代iPhone跟屏幕相关的几个关键参数：

![iPhone_display](/images/article7/iPhone_display.png)

需要说明的是，iPhone6+的逻辑坐标是414×736，渲染比例是3倍，因此对应的屏幕分辨率是1242×2208。但iPhone6+的实际屏幕分辨率是1080×1920，这时系统会把整体的显示内容做一个从新采样缩放，downsampling比例为1/1.15。

#### 2、老工程中的坐标系统

使用Xcode6之前版本的Xcode创建的工程，在iPhone6/6+上运行，得到的逻辑坐标都是和iPhone5/5C/5S屏幕相同的320*568。这样就做到从4寸到4.7寸和5.5寸屏幕的无缝升级，即使我们什么都不做，我们的老工程也能在iPhone6/6+上几乎完美的运行。当然因为等比例放大了，图片可能会有模糊或锯齿感。

要想让老工程的坐标系统恢复正常，可以通过为Target添加`LaunchImage`或者`Launch Screen File`来实现，如下图所示：

![LaunchFile](/images/article7/LaunchFile.png)

`LaunchImage`的方式需要在`Images.xcassets`里，删除旧的`LaunchImage`组，然后新建`LaunchImage`组，添加对应高分辨率的图片。对此，这里有一篇更详细的图文介绍：[How to Add a Launch Image for the iPhone 6](http://matthewpalmer.net/blog/2014/09/10/iphone-6-plus-launch-image-adaptive-mode/)。

其中`Launch Screen File`是Xcode6和iOS8新加的功能，它用一个xib文件来作为启动画面。App在旧版iOS启动时，该属性会被自动忽略，不会造成异常。

上面两种设置，只要启用任意一个即可让App进入高分辨率模式。鉴于现在不少App还需要兼容iOS5，而第一种方法在iOS5上可能有[bug](http://stackoverflow.com/questions/19220082/support-of-ios-5-0-icons-with-xcode-5)，所以这里推荐用第二种方法。


## 三、参考文档

* [Drawing and Printing Guide for iOS](https://developer.apple.com/library/ios/documentation/2DDrawing/Conceptual/DrawingPrintingios/GraphicsDrawingOverview/GraphicsDrawingOverview.html)
* [分辨率](http://baike.baidu.com/view/7687.htm)
* [大屏iPhone的适配](http://blog.ibireme.com/2014/09/16/adapted_to_iphone6/#rd?sukey=f3735aed1ca7f2658e86e2e18cb36d80fed889a7bdfd2d651a1aaef8f9941b691c71e4e8353e61cd57237e4cd0b3edc6#jtss-tsina)



