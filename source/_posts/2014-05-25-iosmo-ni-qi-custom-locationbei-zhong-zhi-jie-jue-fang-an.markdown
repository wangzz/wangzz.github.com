---
layout: post
title: "iOS模拟器Custom Location被重置解决方案"
date: 2014-05-25 17:29:18 +0800
comments: true
categories: XcodeSettings
tags: [XcodeSettings, iOS simulato, custom location]
keywords: XcodeSettings, iOS simulato, custom location
description: iOS模拟器Custom Location被重置解决方案

---

##问题说明

在做地图类应用时，经常需要用到位置模拟功能。iOS模拟器提供了该功能，我们可以写入指定的经纬度，选中模拟器后，按照以下菜单层次进入即可设置：

```
Debug --> Location --> Custom Location
```
但是该功能存在的问题是设置完经纬度每次重新run程序，或者重启模拟器的时候都有可能使之前设置的Location状态从`Custom Location`变成`None`，导致设置的经纬度信息无效。

因此经常需要重新选择`Custom Location`，对于每天需要run程序n次的我们来说苦不堪言...

##解决方案

好在Xcode的target设置项中提供了设置位置信息的方法，允许我们使用GPX文件来设置自定义位置信息，步骤如下：

* 获取GPX文件

GPX（GPS eXchange Format, GPS交换格式)是一个XML格式,为应用软件设计的通用GPS数据格式。它可以用来描述路点、轨迹、路程。（来自[维基百科](http://zh.wikipedia.org/wiki/GPX)）

我们可以通过第三方网站：[gpx-poi.com/](http://gpx-poi.com/)来生成一个GPX文件，生成过程也很方便：

在网站左上角拖动地图到指定位置，鼠标单击后会出现一个红色标注，同时地图下方会显示出标注的经纬度数据；

点击地图下方的`Update`按钮就能将经纬度信息更新到界面右侧的位置信息描述表格中；

然后将界面拉到底部，填写GPX文件名称，选择操作系统型号；

点击`Create`按钮即可生成一个XML格式的GPX文件，再点击`Download`按钮即可将文件下载到本地。

* 导入GPX文件

在Xcode中选中指定target，按以下菜单层次进入：

```
Edite Scheme -->  Options -->  Default Location -->  Add GPX File to Project
```
（此时必须保证`Allow Location Simulation`选项是选中的，该设置项默认选中。）

如图所示：

<img src="/images/article3/default_location.png" width="703" height="475">

即可将刚才生成并下载到本地的GPX文件添加到工程里。从此以后不管是重新run程序还是重启模拟器都可以在程序启动的时候定到位。

不过这种做法有个缺点，我在实际使用的时候发现设置完`Default Location`以后，真机的位置信息也会被更改成设置的位置！！！还请记得在软件发布时删除该设置项。


##参考文档

* [iOS Simulator Reverts Location Setting](http://stackoverflow.com/questions/19719276/ios-simulator-reverts-location-setting)


