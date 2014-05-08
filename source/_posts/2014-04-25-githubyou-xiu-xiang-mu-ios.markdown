---
layout: post
title: "github优秀开源项目大全-iOS"
date: 2014-04-25 17:45:33 +0800
comments: true
categories: opensource
tags: [octopress, 博客, github, 开源, iOS]
keywords: octopress, 博客, github, 开源, iOS, ChatSecure-iOS
description: github优秀开源项目大全-iOS
 
---

##前言

 1. 本文旨在搜集github上优秀的开源项目

 2. 本文搜集的项目都是用于iOS开发

 3. 本文会持续更新...


##完整客户端

 * [ioctocat](https://github.com/dennisreimann/)

github的iOS客户端，目前开源代码是V1版本，V2版本在appstore上可以下载

 * [ChatSecure-iOS](https://github.com/chrisballinger/ChatSecure-iOS)

使用XMPP协议的IM开源软件，很强大，在appstore上可以下载


<!-- more -->


 * [SegmentFault](https://github.com/gaosboy/iOSSF)

SegmentFault的官方iOS客户端

 * [OSChina-iOS](http://git.oschina.net/oschina/iphone-app)

开源中国社区oschina的官方iPhone客户端，appstore已上线。早期地址在[github](https://github.com/gaosboy/iOSSF)上,后来迁移到OSChina自己的代码托管平台.


* [FFCalendar](https://github.com/fggeraissate/FFCalendar)

实现了日历的基本功能，目前只支持iPad版本
![FFCalendar](https://raw.githubusercontent.com/fggeraissate/FFCalendar/master/FFCalendar/FFCalendars/Util/Images/YearlyCalendar.png)

* [wh-app-ios](https://github.com/WhiteHouse/wh-app-ios)

美国白宫（WhiteHouse）的官方app，听起来很高大上哈

* [ruby-china-for-ios](https://github.com/ruby-china/ruby-china-for-ios)

Ruby China的官方app

* [cheddar-ios](https://github.com/nothingmagical/cheddar-ios)

一款不错的日程管理软件，Appstore上能下载

![cheddar-ios](https://github.com/wangzz/wangzz.github.com/blob/master/images/cheddar-ios-screen-short.jpeg?raw=true)



* [twitterfon](https://github.com/jimpick/twitterfon)

第三方twitter客户端，不过作者上传后至今5年了都没更新过。。。


* [viewfinder](https://github.com/viewfinderco/viewfinder)

移动支付公司Square在其工程博客上宣布，基于Apache 2.0许可协议，开源了于去年12月初收购的照片管理和共享应用Viewfinder，包括Viewfinder服务器、Android和iOS应用在内的25万行代码已托管到GitHub上。
对此，Square工程师Peter Mattis在[工程博客](http://corner.squareup.com/2014/05/open-sourcing-viewfinder.html)上表示，Square之所以考虑到将Viewfinder的完整代码公之于众，是希望能够与人方便，让开发者在应用开发过程中可以加以利用或作为参考。尽管Square团队并没有为Viewfinder提供技术支持，也没有进行Bug修复，但此举还是赢得了满堂喝彩一致点赞。

Viewfinder包含了许多非常有趣的代码，对于开发者来说，绝对是大大的Surprise，主要如下：

	. Viewfinder服务器提供了一个拥有各种Amazon DynamoDB索引选项的结构化数据库架构。
	. 服务器还提供了数据库和协议层版本控制支持。
	. 在本地元数据存储方面，Viewfinder客户端使用LevelDB，相比CoreData，更易于使用，也相当便捷。
	. 内置可直接运行于移动设备上的全文本搜索引擎，支持联系人和图片搜索。
	. 使用GYP生成Xcode项目文件和Android构建文件。
	. 支持C++模板元编程，可使用C++11可变参数模板根据C++方法自动计算Java方法签名。

该段介绍出自[这里](http://www.pcbeta.com/viewnews-63336-1.html)。

viewfinder使用GYP生成Xcode的工程文件，生成方式如下：

首先要安装GYP，执行以下步骤：

```
$ svn checkout http://gyp.googlecode.com/svn/trunk/ gyp-read-only 
$ cd gyp-read-only 
$ ./setup.py build 
$ sudo ./setup.py install 

```
	
安装成功以后，再进入到clone下来的viewfineder源码目录，执行：

```
$ cd viewfinder/clients/ios
$ gyp --depth=. -DOS=ios -Iglobals.gypi ViewfinderGyp.gyp

```

这样就能成功生成Xcode工程文件了，然后需要通过`ViewfinderGyp.xcodeproj`文件打开工程。



##Xcode插件

 * [cocoapods-xcode-plugin](https://github.com/kattrali/cocoapods-xcode-plugin)

用于在Xcode中管理CocoaPods依赖库
![cocoapods-xcode-plugin](https://raw.githubusercontent.com/kattrali/cocoapods-xcode-plugin/master/menu.png)

 * [XAlign](https://github.com/qfish/XAlign)

方便实现代码对其功能，使代码风格统一
![XAlign](https://camo.githubusercontent.com/7973c0e352b1f91e3efe5b3550cff5df97f4589a/687474703a2f2f7166692e73682f58416c69676e2f696d616765732f657175616c2e676966)

##工具

 * [Xtrace](https://github.com/johnno1962/Xtrace)

能详细打印出一个某个方法被调用的堆栈，方便调试时定位问题
![Xtrace](https://camo.githubusercontent.com/c5b766f2e9646f5b909ac4e8d63cca6d4f2ff7fd/687474703a2f2f696e6a656374696f6e666f7278636f64652e6a6f686e686f6c6473776f7274682e636f6d2f787472616365632e706e673f666c7573683d32)

 * [RMConnecter](https://github.com/realmacsoftware/RMConnecter)

在上传AppStore时需要填写app的描述信息，此软件能很方便的填写这些信息。
![RMConnecter](https://github.com/realmacsoftware/RMConnecter/blob/master/Assets/screenshots.png?raw=true)

* [xctool](https://github.com/facebook/xctool)

facebook出的自动编译工具，不像xcodebuild，它能够整洁的打印出日志

![xctool](https://camo.githubusercontent.com/f4c5388651b83663ff811969c0e2099073c25484/68747470733a2f2f66706f747465725f7075626c69632e73332e616d617a6f6e6177732e636f6d2f7863746f6f6c2d7569636174616c6f672e676966)



##开发框架

* [pop](https://github.com/facebook/pop)

facebook那神奇的动画引擎，你懂得。。。

![pop](https://github.com/facebook/pop/blob/master/Images/pop.gif?raw=true)

* [KVOController](https://github.com/facebook/KVOController)

facebook出品，基于Cocoa的KVO开发，提供简单地使用方式，同时也是线程安全的。

* [Aspects](https://github.com/steipete/Aspects)

通过method swizzling技术，能够在一个类的现有方法执行之前或之后附加一个代码片段（以block方式），能极大的方便我们调试。

* [PSPDFKit](https://github.com/PSPDFKit/PSPDFKit-Demo)

十分强大的PDF开发框架，有异步加载、预览、编辑、加标注等很多功能


* [TEAChart](https://github.com/xhacker/TEAChart)

使用简单，功能强大的图表工具

![TEAChart](https://github.com/wangzz/wangzz.github.com/blob/master/images/TEAChart-screen-short.gif?raw=true)



##自定义view

 * [DZTableView](https://github.com/yishuiliunian/DZTableView)

仿照UITableView机制自己实现的一个自定义tableview，带有详细的说明文档


* [AMWaveTransition](https://github.com/andreamazz/AMWaveTransition)

很炫的带有表格的视图控制器切换效果，点击每个栏目会有限带有波浪效果的信息展示，类似于Facebook Paper

![AMWaveTransition](https://raw.githubusercontent.com/andreamazz/AMWaveTransition/master/screenshot.gif)


* [Shimmer](https://github.com/facebook/Shimmer)

又是facebook出的，可以让view展示波光粼粼的效果

![Shimmer](https://github.com/facebook/Shimmer/blob/master/shimmer.gif?raw=true)

* [PSTCollectionView](https://github.com/steipete/PSTCollectionView)

仿照系统的UICollectionView的API实现的collection view，支持ARC和iOS4.3+系统，可用于替代只能从iOS6开始支持的UICollectionView

* [JDStatusBarNotification](https://github.com/jaydee3/JDStatusBarNotification)

各种形式在状态栏展示信息，包括提示、进度等，展示格式和动画方式也有好几种。下图只是以静态方式展示其效果，更多详情请点击链接查看。



