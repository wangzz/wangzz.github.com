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

<p><img src="https://raw.githubusercontent.com/fggeraissate/FFCalendar/master/FFCalendar/FFCalendars/Util/Images/YearlyCalendar.png" width="320" height="480"></p>

* [wh-app-ios](https://github.com/WhiteHouse/wh-app-ios)

美国白宫（WhiteHouse）的官方app，听起来很高大上哈

* [ruby-china-for-ios](https://github.com/ruby-china/ruby-china-for-ios)

Ruby China的官方app

* [cheddar-ios](https://github.com/nothingmagical/cheddar-ios)

一款不错的日程管理软件，Appstore上能下载

<p><img src="https://github.com/wangzz/wangzz.github.com/blob/master/images/cheddar-ios-screen-short.jpeg?raw=true" width="320" height="480"></p>


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

这样就能成功生成Xcode工程文件了，不过需要通过`ViewfinderGyp.xcodeproj`文件打开工程。



##Xcode插件

 * [cocoapods-xcode-plugin](https://github.com/kattrali/cocoapods-xcode-plugin)

用于在Xcode中管理CocoaPods依赖库

<p><img src="/images/article1/plugin_cocoapods_menu.png" width="560" height="390"></p>


 * [XAlign](https://github.com/qfish/XAlign)

方便实现代码对其功能，使代码风格统一

<img src="/images/article1/plugin_align.gif" width="560" height="460">

* [XcodeBoost](https://github.com/fortinmike/XcodeBoost)

一个辅助代码编辑插件。支持高亮选中、批量选中方法和方法名、根据选中的方法批量生成方法声明、高亮正则搜索等功能。


* [Injection for Xcode](https://github.com/johnno1962/injectionforxcode)

一个神奇的Xcode 插件，能让应用在运行的时候做出的小的改变立马体现效果，而不需要重新编译。。。

* [Alcatraz](https://github.com/supermarin/Alcatraz)

以图形化界面管理Xcode插件的插件。

<img src="/images/article1/plugin_alcatraz.png" width="560" height="650">

* [KSImageNamed-Xcode](https://github.com/ksuther/KSImageNamed-Xcode)

当输入`[NSImage imageNamed:` 或者`[UIImage imageNamed:`时，会自动补全工程中可用的图片名称，同时能提供选中图片的预览。

<img src="/images/article1/plugin_image_named.gif" width="516" height="220">



##工具

 * [Xtrace](https://github.com/johnno1962/Xtrace)

能详细打印出一个某个方法被调用的堆栈，方便调试时定位问题

<img src="/images/article1/tool_xtrace.png" width="560" height="460">

 * [RMConnecter](https://github.com/realmacsoftware/RMConnecter)

在上传AppStore时需要填写app的描述信息，此软件能很方便的填写这些信息。

<img src="/images/article1/tool_rnconnecter.png" width="580" height="500">

* [xctool](https://github.com/facebook/xctool)

facebook出的自动编译工具，不像xcodebuild，它能够整洁的打印出日志

<img src="/images/article1/tool_xctool.gif" width="584" height="414">

* [iOS-Universal-Framework](https://github.com/kstenerud/iOS-Universal-Framework)

用于生成兼容armv6/armv7/i386 `framework`的Xcode工程模版：

<img src="/images/article1/tool_framework.png" width="584" height="414">


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

* [SearchCoreTest](https://github.com/kewenya/SearchCoreTest)

一个联系人搜索库，支持的搜索方式包括：用户名汉字、拼音及模糊搜索，号码搜索，最重要的是支持T9搜索，做过通讯录类应用的同学都懂的。我在项目里用过，很赞。

* [XMPPFramework](https://github.com/robbiehanson/XMPPFramework)

应该是XMPP协议Objective-C实现的最好版本，小型开发者想做IM应用的好选择，使用起来也很方便。


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

![JDStatusBarNotification](https://github.com/wangzz/wangzz.github.com/blob/master/images/article1/styles.png?raw=true)


* [SphereView](https://github.com/heroims/SphereView)

一个球形3D标签，能够放大、缩小、拖动、点击、自动旋转。效果挺玄的，就是感觉有点卡，还有一定的优化空间。下图截了一个静态图片:

![SphereView](https://github.com/wangzz/wangzz.github.com/blob/master/images/article1/SphereView.png?raw=true)


* [RESideMenu](https://github.com/romaonthego/RESideMenu)

iOS7风格的侧滑菜单，支持左右双向侧滑：

![RESideMenu](/images/article1/RESideMenu.gif)

* [GCDiscreetNotificationView](https://github.com/gcamp/GCDiscreetNotificationView)

一种在view的顶部弹出并会自动消失的通知类view，是toast的一种变形。目前[开源中国](http://git.oschina.net/oschina/iphone-app)的项目正在用该view。


* [CLProgressHUD](https://github.com/cleexiang/CLProgressHUD)

大麦网iOS客户端工程师开源的一个HUD view，

<img src="/images/article1/view_clprogresshud.gif" width="320" height="480">

* [REMenu](https://github.com/romaonthego/REMenu)

自定义的下拉菜单

<img src="/images/article1/view_remenu.gif" width="320" height="480">

