---
layout: post
title: "CocoaPods 详解之----更新篇"
date: 2016-03-23 10:50:29 +0800
comments: true
categories: iOS
tags: [CocoaPods, iOS, Cocoa, Trunk, 私有仓库]
keywords: CocoaPods, iOS, Cocoa, Trunk, 私有仓库
description: CocoaPods 详解之----更新篇
---

CocoaPods 大概是 2011 年出现的开源组件管理工具（目前已支持 Objective-C 和 Swift），近年来普及率越来越高，几乎已是所有 Cocoa 开源项目的标配。另外，很多大点的团队会用 CocoaPods 拆分工程，实现项目插件化。

博主曾在 2014 年写过 `CocoaPods 详解` 系列文章：[CocoaPods详解之----使用篇](http://blog.csdn.net/wzzvictory/article/details/18737437)、[CocoaPods详解之----进阶篇](http://blog.csdn.net/wzzvictory/article/details/19178709)、[CocoaPods详解之----制作篇](http://blog.csdn.net/wzzvictory/article/details/20067595)，简单介绍了从使用到亲手制作 CocoaPods 开源组件的过程。

然而随着时间的推移，CocoaPods 有些使用方式也发生了变化，比如组件提交方式等。本文将从 Trunk 和私有仓库两个方面介绍自己对 CocoaPods 的新认识。

<!-- more -->

## 一、Trunk 方式提交开源组件

从 CocoaPods 0.33 版本开始，CocoaPods 将组件的提交从 Pull requests 变成了自动化的 Trunk 方式。Trunk 提交方式有以下步骤：

### 1、向 Trunk 注册自己的电脑

首次使用 Trunk 时，需要注册自己的电脑：

```
# pod trunk register [E-mail] [User Name]
$ pod trunk register foggry@foggry.com "foggry"
```

执行命令以后，上述邮箱会收到一封验证邮件，按照邮件说明打开制定的链接，注册流程就完成了。

注册流程完成后，可以使用命令：

```
$ pod trunk me
```

可以检验注册结果，如果输出：

```
- Name:     foggry
- Email:    foggry@foggry.com
- Since:    May 19th, 2014 16:03
- Pods:     None
- Sessions:
- March 19th, 22:23 - July 25th, 22:26. IP: 10.1.1.1
```

则说明注册成功。

### 2、提交组件

准备好 podspec 文件后，首先要检查其合法性：

```
# Enter podspec path
$ pod lib lint
```

解决完错误和警告后，会显示以下内容：

```
-> FGMarqueeView (1.0.0)

FGMarqueeView passed validation.
```

这就说明验证可以提交了。

执行提交命令：

```
$ pod trunk push WZMarqueeView.podspec
```

如果顺利的话，会输出以下内容：

```
Updating spec repo `master`

Validating podspec
-> WZMarqueeView (2.0.0)

Updating spec repo `master`

- Data URL: https://raw.githubusercontent.com/CocoaPods/Specs/1f2d70d978843a29cbe17b2476ffed8204eea6ef/Specs/WZMarqueeView/2.0.0/WZMarqueeView.podspec.json
- Log messages:
- March 21st, 00:49: Push for `WZMarqueeView 2.0.0' initiated.
- March 21st, 00:49: Push for `WZMarqueeView 2.0.0' has been pushed (2.327208585 s).
```

仅需要这一条命令，开源组件就被推送到 CocoaPods 主仓库中了。可以执行以下命令验证下：

```
$ pod search WZMarqueeView
```

输出为：

```
-> WZMarqueeView (2.0.0)
A marquee view used on iOS.
pod 'WZMarqueeView', '~> 2.0.0'
- Homepage: https://github.com/wangzz/WZMarqueeView
- Source:   https://github.com/wangzz/WZMarqueeView.git
- Versions: 2.0.0, 1.0.0 [master repo]
```

说明组件 `WZMarqueeView ` 已经成功从 `1.0.0` 升级成了 `2.0.0` 版本。

### 3、其它说明

* 权限声明

在执行下述命令时：

```
$ pod trunk push WZMarqueeView.podspec
```

提示了以下错误：

```
Updating spec repo `master`

Validating podspec
-> WZMarqueeView (2.0.0)

[!] You are not allowed to push new versions for this pod.

```

原来，Trunk 要求只有组件所有者和开发者才能更新已有组件，而上例的组件 `WZMarqueeView ` 是 2014 年通过 Pull requests 方式上传到 CocoaPods 主仓库的，并没有声明过所有权。

随后，到 CocoaPods 指定的网页：[Claim your Pod](https://trunk.cocoapods.org/claims/new)上填写对应信息后，按照提示执行命令：

```
$ pod trunk info WZMarqueeView
```

看到执行结果：

```
WZMarqueeView
- Versions:
- 1.0.0 (2014-05-19 22:03:59 UTC)
- Owners:
- foggry <foggry@foggry.com>
```

组件的所有权已经变成了本人，此时再去执行 `trunk push` 命令时就正常了。

* 为组件添加其它所有者

一个组件可以通过以下命令，添加多个所有者（以邮箱为标识）：

```
# pod trunk add-owner [Module Name] [Owner E-mail]
$ pod trunk add-owner WZMarqueeView kyle@cocoapods.org
```

执行成功后，`kyle@cocoapods.org` 也变成了 `WZMarqueeView ` 的所有者。

* Pull requests 和 Trunk 对比

对于开发者来说，Pull requests 的操作过程十分繁琐，需要开源组件制作者先 fork 一份主仓库，然后将组件提交到 fork 后的仓库，再 Pull requests 给 CocoaPods 主仓库的维护者；

对 CocoaPods 主仓库的维护者来说，需要手工一个个处理主仓库的合并操作，通常第二天甚至需要更长时间 requests 才能被处理；

而 Trunk 方式，开发者只需要一条命令就能将组件上传到主仓库，并且 Trunk 方式是自动化的，几乎不再需要主仓库的维护者做任何工作，实时性更好。

另外，Trunk 增加了组件所有者的概念，非所有者无法提交组件的更新，这在一定程度上提高了 CocoaPods 的安全性。

## 二、创建私有 CocoaPods 仓库

目前所有支持 CocoaPods 的开源组件，都存储在 Github 上公共的 [CocoaPods Specs](https://github.com/CocoaPods/Specs.git) 仓库中，这种方式有以下缺点：

官方仓库过大，里面的绝大多数组件都不是我们需要的，你一定忘不了首次执行 `pod install` 操作时那无尽的等待；

不能实现私有化，作为一个相当好用的组件管理工具，很多团队都使用 CocoaPods 实现庞大项目的组件化，都放在公共仓库肯定不行。

这时就需要创建一个和 [CocoaPods Specs](https://github.com/CocoaPods/Specs.git) 类似的私有组件存储仓库。私有仓库可以存放在自家公司的 Git 服务器上，也可以放在各大支持私有仓库的 Git 平台上，下面以支持免费私有仓库的 [coding.net](https://coding.net)为例说明 CocoaPods 私有仓库的创建过程。

### 1、创建[coding.net](https://coding.net)私有仓库

按照 [coding.net](https://coding.net) 官网提示创建一个私有仓库即可。

### 2、本地初始化组件仓库

执行以下命令：

```
# pod repo add [Private Repo Name] [GitHub HTTPS clone URL]
$ pod repo add FGSpecs https://git.coding.net/foogry/FGSpecs.git
```

### 3、向仓库中添加组件

将事先准备好的组件添加到仓库中，组件可以存放在本地，也可以放在自家或网上的代码托管平台。执行以下命令：

```
# pod repo push [Private Repo Name] [Private podspec Path]
$ pod repo push FGSpecs ~/Desktop/FGMarqueeView.podspec
```

执行成功以后，会有以下输出：

```
Validating spec

-> FGMarqueeView (0.1.0)

Updating the `FGSpecs' repo

Already up-to-date.

Adding the spec to the `FGSpecs' repo

- [Fix] FGMarqueeView (0.1.0)

Pushing the `FGSpecs' repo

To git@git.coding.net:foogry/FGSpecs.git
e2ad499..31a1a8e  master -> master
```

至此，本地和代码托管平台上的私有仓库 FGSpecs 中就都已经添加了私有组件 FGMarqueeView。

### 4、使用私有仓库中的组件

Podfile 文件中默认情况下已经隐式使用 `source` 声明了 CocoaPods 的官方仓库。但使用私有组件，需要使用 `source` 关键字鲜显式声明组件所在仓库：

```
# Private Specs
source 'https://git.coding.net/foogry/FGSpecs.git'

# Public Specs
source 'https://github.com/CocoaPods/Specs.git'

pod 'FGMarqueeView', '~> 0.1.0'
pod 'SBJson', '~> 4.0.0'
```

其中，SBJson 组件是官方仓库的，FGMarqueeView 组件属于我们刚创建的私有仓库。

需要注意的是：

* 官方仓库的显式声明

尽管官方仓库会被隐式声明，如果同时使用了官方仓库和私有仓库，就需要同时声明二者。

* 仓库声明顺序性

先声明的仓库具有优先权。当先后引用的两个仓库中都包含同一个组件时，会使用先引用仓库中的，哪怕后引用的仓库中版本号更高。

### 5、直接使用私有组件

如果不想创建私有仓库，也可以在 Podfile 里直接引用私有组件（组件可以是本地的，也可以是托管在自家公司服务器或网上的代码托管平台上的），引用的同时还可以制定具体的 commit、branch 或者 tag，比如：

```
$ pod 'FGMarqueeView', :git => 'https://git.coding.net/foogry/FGMarqueeView.git', :commit => 'b4dc0ffee'
```

这种方式引用的组件在执行完 `pod install` 以后，会被添加在 Development Pods 目录下，而通过私有仓库或共有仓库方式引用的组件则会被添加在 Pods 目录下。

## 三、参考文档

* [CocoaPods Trunk](https://blog.cocoapods.org/CocoaPods-Trunk/#transition)

* [Getting setup with Trunk](https://guides.cocoapods.org/making/getting-setup-with-trunk.html)

* [Private Pods](https://guides.cocoapods.org/making/private-cocoapods.html)

* [Podfile Syntax Reference](https://guides.cocoapods.org/syntax/podfile.html#source)

