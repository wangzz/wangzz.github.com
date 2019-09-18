---
layout: post
title: "iOS 定位权限那些事"
date: 2019-09-18 10:02:48 +0800
comments: true
categories: iOS
tags: [iOS, CoreLocation, 定位]
keywords: iOS, CoreLocation, 定位
---

## 一、定位权限分类

#### 1、Always

在 iOS 8 之前的系统中，我们不需要单独调用任何接口，默认就是，也只有 `Always` 定位权限。

在 iOS 8 和之后的系统中，要想申请 `Always` 权限，需要手动调用下面的方法：

```objective-c
- (void)requestAlwaysAuthorization API_AVAILABLE(ios(8.0)) API_UNAVAILABLE(macos) API_UNAVAILABLE(tvos);
```

另外 `Always` 权限要求必须在 plist 里有对应配置（具体配置项在 `系统定位权限弹框` 一节里有介绍），否则调用该方法也不起作用。

通过此方法申请的定位权限在前台、后台都能够使用定位数据，但 App 应该视情况在不需要的时候主动关闭定位，以节省电量。

<!-- more -->

#### 2、WhenInUse (iOS 8+ 才有)

iOS 8 之前的系统没有该权限，iOS 8 和之后的系统要想申请 `WhenInUse` 权限，需要手动调用下面的方法：

```objective-c
- (void)requestWhenInUseAuthorization API_AVAILABLE(ios(8.0)) API_UNAVAILABLE(macos);
```

`WhenInUse` 权限要求必须在 plist 里配置 ` NSLocationWhenInUseUsageDescription`，否则调用该方法不起作用。

 通过此方法申请的定位权限，默认情况下， App 只有在前台时才能使用定位数据，如果在后台想使用定位数据，需要将 `allowsBackgroundLocationUpdates` 属性设置成 YES，后面会有说明。

## 二、系统定位权限弹框

#### 1、以下情况系统会弹出定位权限弹框

* 定位权限状态是 `NotDetermined` 时通过 `requestWhenInUseAuthorization` 申请定位权限，弹框样式如图：

  <img src="images/location/1.jpeg" style="zoom:80%;" />

* 定位权限状态是 `NotDetermined` 时通过 `requestAlwaysAuthorization` 申请定位权限，弹框样式如图：

  <img src="images/location/3.jpeg" style="zoom:80%;" />

* 通过 `requestWhenInUseAuthorization` 申请并获得了 `WhenInUse` 定位权限后，`第一次` ( 注意是第一次) 通过 `requestAlwaysAuthorization` 申请定位权限，弹框样式如图：

  <img src="images/location/2.jpeg" style="zoom:80%;" />

## 三、系统定位服务设置项中的定位权限列表

#### 1、`WhenInUse` （iOS 8+）

当 plist 中只设置了 `NSLocationWhenInUseUsageDescription` (iOS 8+ 才支持) 时，系统定位服务设置中的定位权限列表中就只会显示 `永不` 、`使用应用期间` 两项，如下图所示：

<img src="images/location/5.jpeg" style="zoom:80%;" />

#### 2、`Always` 

不同版本的系统，在 plist 里配置 `Always` 权限的 key 不太一样，具体如下：

* iOS 7 及之前

`NSLocationUsageDescription`，配置后系统设置里会显示 `永不` 、`始终` 两个选项

* iOS 8-10 

`NSLocationAlwaysUsageDescription`， 配置后系统里会显示  `永不` 、`始终` 两个选项，如果同时也配了 `NSLocationWhenInUseUsageDescription`，则会显示  `永不` 、`使用应用期间` 、`始终`   三项

* iOS 11+ 

`NSLocationAlwaysAndWhenInUseUsageDescription` ，配置后系统里就会显示 `永不` 、`使用应用期间` 、`始终`  三项，而无论配没配过 `NSLocationWhenInUseUsageDescription`，如下图所示：

<img src="images/location/6.jpeg" style="zoom:80%;" />

用户可以随时在系统设置中更改每个 App 获得的定位权限。

另外，不管你申请的是哪种权限，都以用户在系统设置中给你的权限为准。比如你 App 启动时通过 `requestWhenInUseAuthorization` 申请了 `WhenInUse` 权限，但用户后来到系统设置里给你改成了 `Always` 权限；哪怕你代码里下次启动时仍然调用的是 `requestWhenInUseAuthorization`  ，但你启动后可以使用的仍然是 `Always` 权限。



## 四、其它重要属性

## 1、pausesLocationUpdatesAutomatically

```objective-c
@property(assign, nonatomic) BOOL pausesLocationUpdatesAutomatically API_AVAILABLE(ios(6.0)) API_UNAVAILABLE(macos) API_UNAVAILABLE(watchos, tvos);
```

默认值是 YES。当值为 YES 时，如果用户位置长时间不变化，系统就会将定位停掉。系统将定位停掉以后，会通过下述回调告诉我们：

```objective-c
- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager;
```

在这个回调里，我们可以开启用户区域变化的监听，当用户离开当前区域后，重新开启定位；或者也可以立即以低定位精度重启定位，当发现用户位置变化后，再以高精度启动定位。以上是两种在尽量省电的前提下使用定位的方式，一些对定位数据依赖不高的场景可以使用，但像驾车导航类的应用，还是乖乖将 `pausesLocationUpdatesAutomatically` 设置成 NO 吧。

另外，当系统自动停止定位后，我们又手动重新开启定位时，系统会调用下面的回调，以告诉我们定位被恢复了：

```objective-c
- (void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager;
```

## 2、allowsBackgroundLocationUpdates

```objective-c
@property(assign, nonatomic) BOOL allowsBackgroundLocationUpdates API_AVAILABLE(ios(9.0), watchos(4.0)) API_UNAVAILABLE(macos) API_UNAVAILABLE(tvos);
```

这是个 iOS 9 才支持的 API，默认值是 NO。

* 在 iOS 7 及之前系统中，只有 `Always` 权限，前后台都能正常定位；

* 到了 iOS 8 系统，如果申请的是 `WhenInUse` 权限，App 切后台后也能正常定位，只是会在屏幕顶部出现定位的提示蓝条；
* 到了 iOS 9 及更新的系统，如果申请的是  `WhenInUse` 权限，App 切后台后默认就不能定位。当将 `allowsBackgroundLocationUpdates` 设置成 YES 后，才能在后台定位，同时在后台定位时会像 iOS 8 一样在屏幕顶部出现定位的提示蓝条；

定位提示蓝条如下图所示：

<img src="images/location/4.jpeg" style="zoom:80%;" />

## 3、showsBackgroundLocationIndicator

```objective-c
@property(assign, nonatomic) BOOL showsBackgroundLocationIndicator API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(macos) API_UNAVAILABLE(watchos, tvos);
```

这是个 iOS 11 才支持，默认值为 NO，是个专门给 `Always` 权限使用的属性。

前面说过， `WhenInUse` 权限当 `allowsBackgroundLocationUpdates`  为 YES，且 App 在后台使用定位时，系统会在设备顶部显示正在使用定位的蓝条。当权限为  `Always` 时，如果 `showsBackgroundLocationIndicator` 为 YES 时，那么系统就会为我们展示一个同款蓝条。

## 五、关于 iOS 13

iOS 13 的 `CoreLocation` 做了比较大的改变，所以单独拿出来说下。

#### 1、定位权限变动

在 iOS 13 系统，申请 `WhenInUse` 或 `Always` 权限时，系统都会先弹出来下面的弹框让用户选择：

<img src="images/location/7.jpeg" style="zoom:80%;" />

* 用户选择 `Allow While In Use`

如果用户选择 `Allow While In Use` ，我们的 App 会获得 `WhenInUse` 权限。

如果之前申请的是  `WhenInUse`  权限，那么就跟 iOS 13 之前版本的系统表现没什么区别；

如果之前申请的是 ` Always` 权限，当我们的 App 在后台使用位置信息时，系统就会在未来的某个时间（目前我重现过的时机是切后台锁屏后，再解锁屏幕时）再弹出一个弹框询问用户是继续给我们的 App  `WhenInUse` 权限，还是切换成 `Always` 权限，如下图所示：

<img src="images/location/8.jpeg" style="zoom:80%;" />

也就是说，iOS 13 中，我们没法直接向用户要 `Always` 权限了，必须要经过一个二次确认。

别急，更蛋疼的还在后面。

* 用户选择 `Allow Once`

iOS 13 提出了 `Temporary authorization` 的概念。当用户选择 `Allow Once` 后，我们的 App 就获得了 `Temporary authorization` ，也就是临时权限。该权限有以下特点：

实际的权限类型是：`WhenInUse`；

App 重启后，定位权限会重新变成 `NotDetermined`，下次开启定位时再申请定位权限会重新弹框让用户确认；

#### 2、系统设置中的定位权限列表

如果是用 Xcode 11 编译出来的应用，在 iOS 13 的系统定位权限设置列表里会多出一个下次询问的选项：

<img src="images/location/10.png" style="zoom:80%;" />

#### 3、定位蓝条

iOS 13 系统如果当前是 `WhenInUse` 权限、 `allowsBackgroundLocationUpdates` 为 YES，且应用在后台时，屏幕顶部的定位蓝条视觉调整成了下图的样式：

<img src="images/location/9.png" style="zoom:80%;" />