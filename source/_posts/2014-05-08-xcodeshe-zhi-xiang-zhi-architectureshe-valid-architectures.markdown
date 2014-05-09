---
layout: post
title: "Xcode设置项之Architectures和Valid Architectures"
date: 2014-05-08 16:52:21 +0800
comments: true
categories: Xcode设置
tags: [Xcode, Xcode设置, Architectures, iOS]
keywords: Xcode, Xcode设置, Architectures, Valid Architectures, iOS

---

##iPhone指令集

本文所讲的内容都是围绕iPhone的指令集(想了解ARM指令集的同学请点击[这里](http://en.wikipedia.org/wiki/ARM_architecture))，现在先说说不同型号的iPhone都使用的是什么指令集：

```
ARMv8/ARM64 = iPhone 5s, iPad Air, Retina iPad Mini
ARMv7s = iPhone 5, iPhone 5c, iPad 4
ARMv7  = iPhone 3GS, iPhone 4, iPhone 4S, iPod 3G/4G/5G, iPad, iPad 2, iPad 3, iPad Mini  
ARMv6  = iPhone, iPhone 3G, iPod 1G/2G
```

##设置你想支持的指令集

Xcode中关于生成二进制包指令集相关的设置项有以下三个：

####Architectures

官方文档说明：

```
Space-separated list of identifiers. Specifies the architectures (ABIs, processor models) to which the binary is targeted. When this build setting specifies more than one architecture, the generated binary may contain object code for each of the specified architectures.
```

改变以选项指定了工程将被编译成支持哪些指令集，支持指令集是通过编译生成对应的二进制数据包实现的，如果支持的指令集数目有多个，就会编译出包含多个指令集代码的数据包，造成最终编译的包很大。


####Valid Architectures

官方文档说明：

```
Space-separated list of identifiers. Specifies the architectures for which the binary may be built. During the build, this list is intersected with the value of ARCHS build setting; the resulting list specifies the architectures the binary can run on. If the resulting architecture list is empty, the target generates no binary.
```

该编译项指定可能支持的指令集，****该列表和Architectures列表的交集，将是Xcode最终生成二进制包所支持的指令集****。

比如，你的`Valid Architectures`设置的支持arm指令集版本有：`armv7/armv7s/arm64`，对应的`Architectures`设置的支持arm指令集版本有：`armv7s`，这时Xcode只会生成一个`armv7s`指令集的二进制包。


####Build Active Architecture Only

官方文档说明：

```
Boolean value. Specifies whether the product includes only object code for the native architecture.
```
该编译项用于设置是否只编译当前使用的设备对应的arm指令集。

当该选项设置成YES时，你连上一个`armv7`指令集的设备，就算你的`Valid Architectures`和`Architectures`都设置成`armv7/armv7s/arm64`，还是依然只会生成一个`armv7`指令集的二进制包。

当然该选项起作用的前提是****你的Xcode必须成功连接了调试设备****。如果你没有任何活跃设备，即Xcode没有成功连接调试设备，就算该设置项设置成YES依然还会编译`Valid Architectures`和`Architectures`指定的二进制包。

通常情况下，该编译选项在Debug模式都设成YES，Release模式都设成NO。


##说明

* 指令集都是可以向下兼容的

	比如，你的设备是armv7s指令集，那么它也可以兼容运行比armv7s版本低的指令集：armv7、armv6

* xcode对armv6指令集的支持

	Xcode4.5起不再支持armv6，Xcode4.5的release notes中明确指出：

```
Changes
General: iOS

This version of Xcode does not generate armv6 binaries. 12282156
The minimum deployment target is iOS 4.3. 12282166
```


##如何选择支持的指令集

如果你的软件对安装包大小非常敏感，你可以减少安装包中的指令集数据包，而且这能达到立竿见影的效果。

我们的项目之前支持的指令集是armv7/armv7s，后来改成只支持armv7后，比原来小了10MB左右。目前AppStore上的一些知名应用，比如`百度地图`、`腾讯地图`通过反汇编工具查看后，也都只支持armv7指令集。

根据向下兼容原则，armv7指令集的应用是可以正常在支持armv7s/arm64指令集的机器上运行的。

不过对于armv7s/arm64指令集设备来说，使用运行armv7应用是会有一定的性能损失，不过这种损失有多大缺乏权威统计数据，个人认为是不会影响用户体验的。



##参考文档

* [ARM architecture](http://en.wikipedia.org/wiki/ARM_architecture)

* [Xcode Build Setting Reference](https://developer.apple.com/library/ios/documentation/DeveloperTools/Reference/XcodeBuildSettingRef/0-Introduction/introduction.html#//apple_ref/doc/uid/TP40003931-CH1-SW1)

* [xcode5 arm64](http://justsee.iteye.com/blog/2009954)

* [Xcode 4.5 Release Notes](https://developer.apple.com/library/mac/releasenotes/DeveloperTools/RN-Xcode/xc4_release_notes/xc4_release_notes.html#//apple_ref/doc/uid/TP40001051-CH3-SW174)


