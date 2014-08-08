---
layout: post
title: "屏幕旋转学习笔记"
date: 2014-08-08 09:39:04 +0800
comments: true
categories: iOS
tags: [device orientation, iOS, interface orientation, 屏幕旋转]
keywords: device orientation, iOS, interface orientation, 屏幕旋转
description: 屏幕旋转学习笔记

---


##一、两种orientation

首先需要区分两种orientation

####1、device orientation

设备的物理方向

####2、interface orientation

界面显示的方向

这两种orientation并不一定保持一致，比如app只支持竖屏，无论手机怎么旋转（即无论device orientation取什么值），对应的app仍然只有一个竖屏的值（即interface orientation只有一个竖屏的值）。

我们面临的屏幕旋转问题其实就是device orientation改变的时候如何处理对应的interface orientation。

<!-- more -->

##二、相关枚举定义
 
####1、iOS5和之前版本（后文均简称iOS5）：

```
typedef NS_ENUM(NSInteger, UIInterfaceOrientation) {
    UIInterfaceOrientationPortrait           = UIDeviceOrientationPortrait,
    UIInterfaceOrientationPortraitUpsideDown = UIDeviceOrientationPortraitUpsideDown,
    UIInterfaceOrientationLandscapeLeft      = UIDeviceOrientationLandscapeRight,
    UIInterfaceOrientationLandscapeRight     = UIDeviceOrientationLandscapeLeft
};
```

####2、iOS6和之后版本（后文均简称iOS6）又新增了：

```
typedef NS_OPTIONS(NSUInteger, UIInterfaceOrientationMask) {
    UIInterfaceOrientationMaskPortrait = (1 << UIInterfaceOrientationPortrait),
    UIInterfaceOrientationMaskLandscapeLeft = (1 << UIInterfaceOrientationLandscapeLeft),
    UIInterfaceOrientationMaskLandscapeRight = (1 << UIInterfaceOrientationLandscapeRight),
    UIInterfaceOrientationMaskPortraitUpsideDown = (1 << UIInterfaceOrientationPortraitUpsideDown),
    UIInterfaceOrientationMaskLandscape = (UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight),
    UIInterfaceOrientationMaskAll = (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskPortraitUpsideDown),
    UIInterfaceOrientationMaskAllButUpsideDown = (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight),
};
```


iOS6使用`NS_OPTIONS`的方式重新定义了UIInterfaceOrientationMaskPortrait、UIInterfaceOrientationMaskLandscapeLeft、UIInterfaceOrientationMaskLandscapeRight、UIInterfaceOrientationMaskPortraitUpsideDown几种基础枚举，这就意味着能以组合的方式更加方便的使用这些枚举值。

##三、相关方法

####1、iOS5中控制屏幕旋转的方法：

```
// Applications should use supportedInterfaceOrientations and/or shouldAutorotate..
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation NS_DEPRECATED_IOS(2_0, 6_0);
```
如果打算支持toInterfaceOrientation对应的方向就返回YES，否则返回NO。


####2、iOS6中控制屏幕旋转相关方法：

```
// New Autorotation support.
- (BOOL)shouldAutorotate NS_AVAILABLE_IOS(6_0);
- (NSUInteger)supportedInterfaceOrientations NS_AVAILABLE_IOS(6_0);
// Returns interface orientation masks.
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation NS_AVAILABLE_IOS(6_0);

```

第一个方法决定是否支持多方向旋转屏，如果返回NO则后面的两个方法都不会再被调用，而且只会支持默认的UIInterfaceOrientationMaskPortrait方向；

第二个方法直接返回支持的旋转方向；

第三个方法返回最优先显示的屏幕方向，比如同时支持Portrait和Landscape方向，但想优先显示Landscape方向，那软件启动的时候就会先显示Landscape，在手机切换旋转方向的时候仍然可以在Portrait和Landscape之间切换；


####3、attemptRotationToDeviceOrientation方法

从iOS5开始有了这个新方法：

```
// call this method when your return value from shouldAutorotateToInterfaceOrientation: changes
// if the current interface orientation does not match the current device orientation, a rotation may occur provided all relevant view controllers now return YES from shouldAutorotateToInterfaceOrientation:
+ (void)attemptRotationToDeviceOrientation NS_AVAILABLE_IOS(5_0);
```

该方法的使用场景是interface orientation和device orientation不一致，但希望通过重新指定interface orientation的值，立即实现二者一致；如果这时只是更改了支持的interface orientation的值，没有调用attemptRotationToDeviceOrientation，那么下次device orientation变化的时候才会实现二者一致，关键点在于能不能立即实现。

举个例子：

假设当前的interface orientation只支持Portrait，如果device orientation变成Landscape，那么interface orientation仍然显示Portrait；

如果这时我们希望interface orientation也变成和device orientation一致的Landscape，以iOS6为例，需要先将supportedInterfaceOrientations的返回值改成Landscape，然后调用attemptRotationToDeviceOrientation方法，系统会重新询问支持的interface orientation，已达到立即更改当前interface orientation的目的。


##四、如何决定interface orientation

####1、全局控制

Info.plist文件中，有一个`Supported interface orientations`，可以配置整个应用的屏幕方向，此处为全局控制。


####2、UIWindow

iOS6的UIApplicationDelegate提供了下述方法，能够指定 UIWindow 中的界面的屏幕方向：

```
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window  NS_AVAILABLE_IOS(6_0);
```
该方法默认值为Info.plist中配置的`Supported interface orientations`项的值。

iOS中通常只有一个window，所以此处的控制也可以视为全局控制。

####3、controller

只有以下两种情况：

* 当前controller是window的rootViewController
* 当前controller是modal模式的

时，orientations相关方法才会起作用（才会被调用），当前controller及其所有的childViewController都在此作用范围内。

####4、最终支持的屏幕方向

前面所述的3种控制规则的交集就是一个controller的最终支持的方向；

如果最终的交集为空，在iOS6以后会抛出`UIApplicationInvalidInterfaceOrientationException`崩溃异常。


##四、强制屏幕旋转

如果interface和device方向不一样，想强制将interface旋转成device的方向，可以通过attemptRotationToDeviceOrientation实现，但是如果想将interface强制旋转成任一指定方向，该方式就无能为力了。

不过聪明的开发者们总能想到解决方式：

####1、私有方法

```
[[UIDevice currentDevice] setOrientation:UIInterfaceOrientationPortrait];
```
但是现在苹果已经将该方法私有化了，越狱开发的同学可以试试。


####2、旋转view的transform

也可以通过旋转view的transform属性达到强制旋转屏幕方向的目的，但个人感觉这不是靠谱的思路，可能会带来某些诡异的问题。


####3、主动触发orientation机制


要是能主动触发系统的orientation机制，调用orientation相关方法，使新设置的orientation值起作用就好了。这样只要提前设置好想要支持的orientation，然后主动触发orientation机制，便能实现将interface orientation旋转至任意方向的目的。

万能的[stackoverflow](http://stackoverflow.com/a/14445888/2293677)上提供了一种主动触发的方式：

在iOS4和iOS6以后：

```
UIViewController *vc = [[UIViewController alloc]init];
[self presentModalViewController:vc animated:NO];
[self dismissModalViewControllerAnimated:NO];
[vc release];
```

iOS5中：

```
UIWindow *window = [[UIApplication sharedApplication] keyWindow];
UIView *view = [window.subviews objectAtIndex:0];
[view removeFromSuperview];
[window addSubview:view];
```
这种方式会触发UIKit重新调用controller的orientation相关方法，以达到在device方向不变的情况下改变interface方向的目的。

虽然不优雅，但却能解决问题，凑合吧。。


PS：

话说iOS8中的屏幕旋转相关方法又变化了，表示适配起来很蛋疼。。。


##五、参考文档

* [How to force a UIViewController to Portait orientation in iOS 6](http://stackoverflow.com/a/14445888/2293677)
* [IOS Orientation, 想怎么转就怎么转](http://www.cnblogs.com/jhzhu/p/3480885.html)
* [iOS 屏幕方向那点事儿](http://zhenby.com/blog/2013/08/20/talk-ios-orientation/)
