---
layout: post
title: "WWDC2014之App Extensions学习笔记"
date: 2014-06-23 19:55:29 +0800
comments: true 
categories: WWDC2014
tags: [WWDC2014, iOS, framework, App Extensions]
keywords: WWDC2014, iOS, framework, App Extensions
description: WWDC2014之App Extensions学习笔记

---

![wwdc_banner_promo](/images/article5/wwdc_banner_promo.jpg)


##一、关于App Extensions

`extension`是iOS8新开放的一种对几个固定系统区域的扩展机制，它可以在一定程度上弥补iOS的沙盒机制对应用间通信的限制。

`extension`的出现，为用户提供了在其它应用中使用我们应用提供的服务的便捷方式，比如用户可以在`Today`的`widgets`中查看应用展示的简略信息，而不用再进到我们的应用中，这将是一种全新的用户体验；但是，extension的出现可能会减少用户启动应用的次数，同时还会增大开发者的工作量。


<!-- more -->

####几个关键词

* extension point
系统中支持`extension`的区域，`extension`的类别也是据此区分的，iOS上共有`Today`、`Share`、`Action`、`Photo Editing`、`Storage Provider`、`Custom keyboard`几种，其中`Today`中的`extension`又被称为`widget`。

每种`extension point`的使用方式和适合干的活都不一样，因此不存在通用的`extension`。

* app extension
即为本文所说的`extension`。`extension`并不是一个独立的app，它有一个包含在app bundle中的独立bundle，`extension`的bundle后缀名是`.appex`。其生命周期也和普通app不同，这些后文将会详述。

`extension`不能单独存在，必须有一个包含它的`containing app`。

另外，`extension`需要用户手动激活，不同的`extension`激活方式也不同，比如：
比如Today中的widget需要在Today中激活和关闭；`Custom keyboard`需要在设置中进行相关设置；`Photo Editing`需要在使用照片时在照片管理器中激活或关闭；`Storage Provider`可以在选择文件时出现；`Share`和`Action`可以在任何应用里被激活，但前提是开发者需要设置`Activation Rules`，以确定`extension`需要在合适出现。

* containing app
尽管苹果开放了extension，但是在iOS中extension并不能单独存在，要想提交到AppStore，必须将extension包含在一个app中提交，并且app的实现部分不能为空,这个包含extension的app就叫`containing app`。

extension会随着`containing app`的安装而安装，同时随着`containing app`的卸载而卸载。

* host app
能够调起`extension`的app被称为`host app`，比如`widget`的`host app`就是`Today`。

##二、extension和containing app、host app

####2.1 extension和host app

`extension`和`host app`之间可以通过extensionContext属性直接通信，该属性是新增加的UIViewController类别：

```objective-c
@interface UIViewController(NSExtensionAdditions) <NSExtensionRequestHandling>

// Returns the extension context. Also acts as a convenience method for a view controller to check if it participating in an extension request.
@property (nonatomic,readonly,retain) NSExtensionContext *extensionContext NS_AVAILABLE_IOS(8_0);

@end
```

实际上`extension`和`host app`之间是通过IPC（interprocess communication）实现的，只是苹果把调用接口高度抽象了，我们并不需要关注那么底层的东西。

####2.2 containing app和host app

他们之间没有任何直接关系，也从来不需要通信。

####2.3 extension和containing app 

这二者之间的关系最复杂，纠纠缠缠扯不清关系。

* 不能直接通信

首先，尽管`extension`的bundle是放在`containing app`的bundle中，但是他们是两个完全独立的进程，之间不能直接通信。不过`extension`可以通过openURL的方式启动`containing app`（当然也能启动其它app），不过必须通过extensionContext借助`host app`来实现：

```objective-c
//通过openURL的方式启动Containing APP
- (void)openURLContainingAPP
{
    [self.extensionContext openURL:[NSURL URLWithString:@"appextension://123"]
                 completionHandler:^(BOOL success) {
                     NSLog(@"open url result:%d",success);
                 }];
}

```

`extension`中是无法直接使用openURL的。

* 可以共享`Shared resources`

`extension`和`containing app`可以共同读写一个被称为`Shared resources`的存储区域，这是通过`App Groups`实现的，后文将会详述。


三者间的关系可以通过官网给的两张图片形象地说明：

![detailed_communication](/images/article5/detailed_communication.png)

![app_extensions_container_restrictions](/images/article5/app_extensions_container_restrictions.png)

* `containing app`能够控制`extension`的出现和隐藏

通过以下代码，`containing app`可以让`extension`出现或隐藏（当然`extension`也可以让自己隐藏）：

```objective-c
//让隐藏的插件重新显示
- (void)showTodayExtension
{
    [[NCWidgetController widgetController] setHasContent:YES forWidgetWithBundleIdentifier:@"com.wangzz.app.extension"];
}

//隐藏插件
- (void)hiddeTodayExtension
{
    [[NCWidgetController widgetController] setHasContent:NO forWidgetWithBundleIdentifier:@"com.wangzz.app.extension"];
}
```

##三、App Groups

这是iOS8新开放的功能，在OS X上早就可用了。它主要用于同一group下的app共享同一份读写空间，以实现数据共享。

`extension`和`containing app`共同读写一份数据是很合理的需求，比如系统的股市应用，widget和app中都需要展示几个公司的股票数据，这就可以通过`App Groups`实现。

####3.1 功能开启

为了便于后续操作，请先确保你的开发者账号在Xcode上处于登录状态。

* 在app中开启

`App Groups`位于：

```
TARGETS-->AppExtensionDemo-->Capabilities-->App Groups
```

找到以后，将`App Groups`右上角的开关打开，然后选择添加groups，比如我的是group.wangzz，当然这是为了测试随便起得名字，正规点得命名规则应该是：group.com.company.app。

添加成功以后如下图所示：

![app_group](/images/article5/app_group.png)

* 在`extension`中开启

我创建的是widget，target名称为TodayExtension，对应的`App Groups`位于：

```
TARGETS-->TodayExtension-->Capabilities-->App Groups
```
开启方式和app中一样，需要注意的是必须保证这里地`App Groups`名称和app中的相同，即为group.wangzz。

##四、`extension`和`containing app`数据共享

`app group`给我们提供了同一group内app可以共同读写的区域，可以通过以下方式实现数据共享：

####4.1 通过NSUserDefaults共享数据

* 存数据

通过以下方式向NSUserDefaults中保存数据：

```objective-c
- (void)saveTextByNSUserDefaults
{
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.wangzz"];
    [shared setObject:_textField.text forKey:@"wangzz"];
    [shared synchronize];
}
    
```

需要注意的是：

1.保存数据的时候必须指明group id；

2.而且要注意NSUserDefaults能够处理的数据只能是可plist化的对象，详情见[Property List Programming Guide](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/PropertyLists/AboutPropertyLists/AboutPropertyLists.html)。

3.为了防止出现数据同步问题，不要忘记调用`[shared synchronize];`

* 读数据

对应的读取数据方式：

```objective-c
- (NSString *)readDataFromNSUserDefaults
{
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.wangzz"];
    NSString *value = [shared valueForKey:@"wangzz"];
    
    return value;
}
```

####4.2 通过NSFileManager共享数据

NSFileManager在iOS7提供了containerURLForSecurityApplicationGroupIdentifier方法，可以用来实现app group共享数据。

* 保存数据

```objective-c
- (BOOL)saveTextByNSFileManager
{
    NSError *err = nil;
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.wangzz"];
    containerURL = [containerURL URLByAppendingPathComponent:@"Library/Caches/good"];

    NSString *value = _textField.text;
    BOOL result = [value writeToURL:containerURL atomically:YES encoding:NSUTF8StringEncoding error:&err];
    if (!result) {
        NSLog(@"%@",err);
    } else {
        NSLog(@"save value:%@ success.",value);
    }
    
    return result;
}

```

* 读数据

```objective-c

- (NSString *)readTextByNSFileManager
{
    NSError *err = nil;
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.wangzz"];
    containerURL = [containerURL URLByAppendingPathComponent:@"Library/Caches/good"];
    NSString *value = [NSString stringWithContentsOfURL:containerURL encoding:NSUTF8StringEncoding error:&err];
    
    return value;
}
```

在这里我试着保存和读取的是字符串数据，但读写SQlite我相信也是没问题的。

* 数据同步

两个应用共同读取同一份数据，就会引发数据同步问题。WWDC2014的视频中建议使用NSFileCoordination实现普通文件的读写同步，而数据库可以使用CoreData,Sqlite也支持同步。


##五、`extension`和`containing app`代码共享

和数据共享类似，`extension`和`containing app`很自然地会有一些业务逻辑上可以共用的代码，这时可以通过iOS8中刚开放使用的framework实现。苹果在[App Extension Programming Guide](https://developer.apple.com/library/prerelease/ios/documentation/General/Conceptual/ExtensibilityPG/ExtensionScenarios.html#//apple_ref/doc/uid/TP40014214-CH21-SW1)中 `Sharing Code with Your Containing App`是这样描述的：

>
In iOS 8.0 and later, you can use an embedded framework to share code between your extension and its containing app. For example, if you develop image-processing code that you want both your Photo Editing extension and its containing app to share, you can put the code into a framework and embed it in both targets.
>

即将framework分别嵌入到`extension`和`containing app`的target中实现代码共享。但这样岂不是需要分别要将framework分别copy到`extension`和`containing app`的main bundle中？

参考`extension`和`containing app`数据共享，我试想能不能将framework只保存一份放在`app group`区域？

####5.1 copy framework到`app group`

在app首次启动的时候将framework放到`app group`区域：

```objective-c

- (BOOL)copyFrameworkFromMainBundleToAppGroup
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *err = nil;
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.wangzz"];
    NSString *sorPath = [NSString stringWithFormat:@"%@/Dylib.framework",[[NSBundle mainBundle] bundlePath]];
    NSString *desPath = [NSString stringWithFormat:@"%@/Library/Caches/Dylib.framework",containerURL.path];
    
    BOOL removeResult = [manager removeItemAtPath:desPath error:&err];
    if (!removeResult) {
        NSLog(@"%@",err);
    } else {
        NSLog(@"remove success.");
    }
    
    BOOL copyResult = [[NSFileManager defaultManager] copyItemAtPath:sorPath toPath:desPath error:&err];
    if (!copyResult) {
        NSLog(@"%@",err);
    } else {
        NSLog(@"copy success.");
    }

    return copyResult;
}
```

####5.2 使用framework：

```objective-c
- (BOOL)loadFrameworkInAppGroup
{
    NSError *err = nil;
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.wangzz"];
    NSString *desPath = [NSString stringWithFormat:@"%@/Library/Caches/Dylib.framework",containerURL.path];
    NSBundle *bundle = [NSBundle bundleWithPath:desPath];
    BOOL result = [bundle loadAndReturnError:&err];
    if (result) {
        Class root = NSClassFromString(@"Person");
        if (root) {
            Person *person = [[root alloc] init];
            if (person) {
                [person run];
            }
        }
    } else {
        NSLog(@"%@",err);
    }
    
    return result;
}

```


经过测试，竟然能够加载成功。

需要说明的是，这里只是说那么用是可以成功加载framework，但还面临不少问题，比如如果用户在启动app之前去使用`extension`，这时framework还没有copy过去，怎么处理；另外iOS的机制或者苹果的审核是否允许这样使用等。

在一切确定下来之前还是乖乖按文档中的方式使用吧。


##六、生命周期

`extension`和普通app的最大区别之一是生命周期。

* 开始

在用户通过`host app`点击`extension`时，系统就会实例化`extension`应用，这是生命周期的开始。

* 执行任务

在`extension`启动以后，开始执行它的使命。

* 终止

在用户取消任务，或者任务执行结束，或者开启了一个长时后台任务时，系统会将其杀掉。

由此可见，`extension`就是为了任务而生！

下图来自官方文档，它将生命周期划分的更详细：

![app_extensions_lifecycle](/images/article5/app_extensions_lifecycle.png)

通过打印日志发现，`Today`中的`widget`在将`Today`切换到`全部`或者`未读通知时`都会被杀掉。

##七、 调试

`extension`和普通app的调试方式差不多，开始调试前先选中`extension`对应的target，点击run，就会弹出下图所示选择框：

![extension_debug](/images/article5/extension_debug.png)

需要选择一个`host app`，这里选择`Today`。

然后即可和普通app一样调试了，不过我在实际使用过程中，发现有各种奇怪的事情，比如NSLog无法在控制台输出，应该是bug吧。

##八、 iOS8应用文件系统

发现iOS8的文件系统发生了变化，新的文件系统将可执行文件（即原来的.app文件）从沙盒中移到了另外一个地方，这样感觉更合理。

* 测试代码

下述代码用于打印`app group`路径、应用的可执行文件路径、对应的Documents路径：

```objective-c

- (void)logAppPath
{
    //app group路径
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.wangzz"];
    NSLog(@"app group:\n%@",containerURL.path);
    
    //打印可执行文件路径
    NSLog(@"bundle:\n%@",[[NSBundle mainBundle] bundlePath]);
    
    //打印documents
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSLog(@"documents:\n%@",path);
}
```

* `containing app`执行结果

```
2014-06-23 19:35:03.944 AppExtensionDemo[7471:365131] app group:
/private/var/mobile/Containers/Shared/AppGroup/89CCBFB1-CA5E-4C7F-80CB-A3EB9E841816
2014-06-23 19:35:03.946 AppExtensionDemo[7471:365131] bundle:
/private/var/mobile/Containers/Bundle/Application/1AC73797-A3BB-4BDE-A647-3D083DA6871A/AppExtensionDemo.app
2014-06-23 19:35:03.948 AppExtensionDemo[7471:365131] documents:
/var/mobile/Containers/Data/Application/E5E6E516-0163-4754-9D10-A5F6C33A6261/Documents
```

* `extension`执行结果

```
Jun 23 19:37:49 autonavis-iPad com.foogry.AppExtensionDemo.TodayExtension[7638] <Warning>: app group:
	/private/var/mobile/Containers/Shared/AppGroup/89CCBFB1-CA5E-4C7F-80CB-A3EB9E841816
Jun 23 19:37:49 autonavis-iPad com.foogry.AppExtensionDemo.TodayExtension[7638] <Warning>: bundle:
	/private/var/mobile/Containers/Bundle/Application/596717B7-7CB8-4F53-BCD4-380F34ABD30F/AppExtensionDemo.app/PlugIns/com.foogry.AppExtensionDemo.TodayExtension.appex
Jun 23 19:37:49 autonavis-iPad com.foogry.AppExtensionDemo.TodayExtension[7638] <Warning>: documents:
	/var/mobile/Containers/Data/PluginKitPlugin/57581433-3DBD-4930-971F-78D30C150E8A/Documents
```

由此可见，不管是`extension`还是`containing app`，他们的可执行文件和保存数据的目录都是分开存放的，即所有app的可执行文件都放在一个大目录下，保存数据的目录保存在另一个大目录下，同样，AppGroup放在另一个大目录下。

##说明

* 本文用到的demo已经上传到github上。

* 文中可能有理解有误的地方，欢迎指出。

##参考文档

* [App Extension Programming Guide](https://developer.apple.com/library/prerelease/ios/documentation/General/Conceptual/ExtensibilityPG/index.html#//apple_ref/doc/uid/TP40014214-CH20-SW1)

* [Crash Course In iOS 8 Widgets](http://blog.waynehartman.com/)

* [Notification Center Framework Reference](https://developer.apple.com/library/prerelease/ios/documentation/NotificationCenter/Reference/NotificationCenter_Framework/index.html#//apple_ref/doc/uid/TP40014443)

* [iOS 8 Release Notes](https://developer.apple.com/library/prerelease/ios/releasenotes/General/RN-iOSSDK-8.0/)

* [Entitlement Key Reference](https://developer.apple.com/library/prerelease/ios/documentation/Miscellaneous/Reference/EntitlementKeyReference/Chapters/EnablingAppSandbox.html#//apple_ref/doc/uid/TP40011195-CH4-SW19)

* [苹果的插件生态系统，开发者的新世界](http://www.pingwest.com/apples-new-extension-eco-system/)

* [iOS 8 Extensions: Apple’s Plan for a Powerful App Ecosystem](http://www.macstories.net/stories/ios-8-extensions-apples-plan-for-a-powerful-app-ecosystem/)

* [Property List Programming Guide](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/PropertyLists/AboutPropertyLists/AboutPropertyLists.html)



