---
layout: post
title: "WWDC2014之iOS使用动态库"
date: 2014-06-12 19:27:57 +0800
comments: true
categories: WWDC2014
tags: [WWDC2014, iOS, framework, 动态库]
keywords: WWDC2014, iOS, framework, 动态库
description: WWDC2014之iOS使用动态库

---

## 苹果的开放态度

WWDC2014上发布的`Xcode6 beta`版有了不少更新，其中令我惊讶的一个是苹果在iOS上开放了动态库，在`Xcode6 Beta`版的更新文档中是这样描述的：

>
Frameworks for iOS. iOS developers can now create dynamic frameworks. Frameworks are a collection of code and resources to encapsulate functionality that is valuable across multiple projects. Frameworks work perfectly with extensions, sharing logic that can be used by both the main application, and the bundled extensions.
>

详情见官方文档[New Features in Xcode 6 Beta](https://developer.apple.com/library/prerelease/ios/documentation/DeveloperTools/Conceptual/WhatsNewXcode/Articles/xcode_6_0.html)。

framework是Cocoa/Cocoa Touch程序中使用的一种资源打包方式，可以将将代码文件、头文件、资源文件、说明文档等集中在一起，方便开发者使用，作为一名Cocoa/Cocoa Touch程序员每天都要跟各种各样的Framework打交道。Cocoa/Cocoa Touch开发框架本身提供了大量的Framework，比如Foundation.framework/UIKit.framework/AppKit.framework等。需要注意的是，这些framework无一例外都是动态库。

<!-- more -->

但残忍的是，Cocoa Touch上并不允许我们使用自己创建的framework。不过由于framework是一种优秀的资源打包方式，拥有无穷智慧的程序员们便想出了以framework的形式打包静态库的招数，因此我们平时看到的第三方发布的framework无一例外都是静态库，真正的动态库是上不了AppStore的。

WWDC2014给我的一个很大感触是苹果对iOS的开放态度：允许使用动态库、允许第三方键盘、`App Extension`等等，这些在之前是想都不敢想的事。



## iOS上动态库可以做什么

和静态库在编译时和app代码链接并打进同一个二进制包中不同，动态库可以在运行时手动加载，这样就可以做很多事情，比如：

* 共享可执行文件

在其它大部分平台上，动态库都可以用于不同应用间共享，这就大大节省了内存。从目前来看，iOS仍然不允许进程间共享动态库，即iOS上的动态库只能是私有的，因为我们仍然不能将动态库文件放置在除了自身沙盒以外的其它任何地方。

不过iOS8上开放了`App Extension`功能，可以为一个应用创建插件，这样主app和插件之间共享动态库还是可行的。

2014-6-23修正：

经[@唐巧_boy](http://weibo.com/tangqiaoboy?topnav=1&wvr=5&topsug=1)提醒，sandbox会验证动态库的签名，所以如果是动态从服务器更新的动态库，是签名不了的，因此应用插件化、软件版本实时模块升级等功能在iOS上无法实现。

## 创建动态库

####1、创建动态库

* 创建工程文件

在下图所示界面能够找到Cocoa Touch动态库的创建入口：

![framework](/images/article4/cocoa_touch_framework.png)

跟随指引一步步操作即可创建一个新的动态库工程，我的工程名字叫Dylib，Xcode会同时创建一个和工程target同名的.h文件，比如我的就是Dylib.h。

* 向工程中添加文件

接下来就可以在工程中随意添加文件了。我在其中新建了一个名为Person的测试类，提供的接口如下：

```objective-c

@interface Person : NSObject

- (void)run;

@end

```

对应的实现部分：

```objective-c

@implementation Person

- (void)run
{
    NSLog(@"let's run.");
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"The Second Alert" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"done", nil];
    [alert show];
}

@end

```

* 设置开放的头文件

一个库里面可以后很多的代码，但是我们需要设置能够提供给外界使用的接口，可以通过Target-->Build Phases-->Headers来设置，如下图所示：

![header](/images/article4/header.png)

我们只需将希望开放的头文件放到Public列表中即可，比如我开放了`Dylib.h`和`Person.h`两个头文件，在生成的framework的Header目录下就可以看到这两个头文件，如下图所示：

![public_header](/images/article4/public_header.png)

一切完成，Run以后就能成功生成framework文件了。


####2、通用动态库

经过第一步我们只是创建了一个动态库文件，但是和静态库类似，该动态库并同时不支持真机和模拟器，可以通过以下步骤创建通用动态库：

* 创建Aggregate Target

按下图所示，在动态库工程中添加一个类型为Aggregate的target:

![aggregate](/images/article4/aggregate.png)

按提示一步步操作即可，我给`Aggregate`的Target的命名是`CommonDylib`。

* 设置Target Dependencies

按以下路径设置`CommonDylib`对应的`Target Dependencies`:

```
TARGETS-->CommonDylib-->Build Phases-->Target Dependencies
```
将真正的动态库Dylib Target添加到其中。

* 添加Run Script

按以下路径为`CommonDylib`添加`Run Script`:

```
TARGETS-->CommonDylib-->Build Phases-->Run Script
```

添加的脚本为：

```
# Sets the target folders and the final framework product.
FMK_NAME=${PROJECT_NAME}

# Install dir will be the final output to the framework.
# The following line create it in the root folder of the current project.
INSTALL_DIR=${SRCROOT}/Products/${FMK_NAME}.framework

# Working dir will be deleted after the framework creation.
WRK_DIR=build
DEVICE_DIR=${WRK_DIR}/Release-iphoneos/${FMK_NAME}.framework
SIMULATOR_DIR=${WRK_DIR}/Release-iphonesimulator/${FMK_NAME}.framework

# -configuration ${CONFIGURATION} 
# Clean and Building both architectures.
xcodebuild -configuration "Release" -target "${FMK_NAME}" -sdk iphoneos clean build
xcodebuild -configuration "Release" -target "${FMK_NAME}" -sdk iphonesimulator clean build

# Cleaning the oldest.
if [ -d "${INSTALL_DIR}" ]
then
rm -rf "${INSTALL_DIR}"
fi

mkdir -p "${INSTALL_DIR}"

cp -R "${DEVICE_DIR}/" "${INSTALL_DIR}/"

# Uses the Lipo Tool to merge both binary files (i386 + armv6/armv7) into one Universal final product.
lipo -create "${DEVICE_DIR}/${FMK_NAME}" "${SIMULATOR_DIR}/${FMK_NAME}" -output "${INSTALL_DIR}/${FMK_NAME}"

rm -r "${WRK_DIR}"

```

添加以后的效果如图所示：

![commonlib_setting](/images/article4/commonlib_setting.png)


该脚本是我根据一篇文章中介绍的脚本改写的，感谢[原文作者](http://blog.sina.com.cn/s/blog_407fb5bc01013v6s.html)。

脚本的主要功能是：

1.分别编译生成真机和模拟器使用的framework；
2.使用lipo命令将其合并成一个通用framework；
3.最后将生成的通用framework放置在工程根目录下新建的Products目录下。

如果一切顺利，对`CommonDylib` target执行run操作以后就能生成一个如图所示的通用framework文件了：

![products](/images/article4/products.png)


## 使用动态库

####添加动态库到工程文件

经过以上步骤的努力，生成了最终需要的framework文件，为了演示动态库的使用，新建了一个名为`FrameworkDemo`的工程。通过以下方式将刚生成的framework添加到工程中：

```
Targets-->Build Phases-->Link Binary With Libraries
```

同时设置将framework作为资源文件拷贝到Bundle中：

```
Targets-->Build Phases-->Copy Bundle Resources
```

如图所示：

![framework_demo_setting](/images/article4/framework_demo_setting.png)


仅仅这样做是不够的，还需要为动态库添加链接依赖。

####自动链接动态库

添加完动态库后，如果希望动态库在软件启动时自动链接，可以通过以下方式设置动态库依赖路径：

```
Targets-->Build Setting-->Linking-->Runpath Search Paths
```

由于向工程中添加动态库时，将动态库设置了Copy Bundle Resources，因此就可以将`Runpath Search Paths`路径依赖设置为main bundle，即沙盒中的FrameworkDemo.app目录，向`Runpath Search Paths`中添加下述内容：

```
@executable_path/
```

如图所示：

![run_search_path](/images/article4/run_search_path.png)


其中的`@executable_path/`表示可执行文件所在路径，即沙盒中的.app目录，注意不要漏掉最后的`/`。

如果你将动态库放到了沙盒中的其他目录，只需要添加对应路径的依赖就可以了。


####需要的时候链接动态库

动态库的另一个重要特性就是`即插即用`性，我们可以选择在需要的时候再加载动态库。

* 更改设置

如果不希望在软件一启动就加载动态库，需要将

```
Targets-->Build Phases-->Link Binary With Libraries
```

中`Dylib.framework`对应的Status由默认的`Required`改成`Optional`；或者更干脆的，将`Dylib.framework`从`Link Binary With Libraries`列表中删除即可。

* 使用dlopen加载动态库

以`Dylib.framework`为例，动态库中真正的可执行代码为`Dylib.framework/Dylib`文件，因此使用dlopen时如果仅仅指定加载动态库的路径为`Dylib.framework`是没法成功加载的。

示例代码如下：

```objective-c

- (IBAction)onDlopenLoadAtPathAction1:(id)sender
{
    NSString *documentsPath = [NSString stringWithFormat:@"%@/Documents/Dylib.framework/Dylib",NSHomeDirectory()];
    [self dlopenLoadDylibWithPath:documentsPath];
}

- (void)dlopenLoadDylibWithPath:(NSString *)path
{
    libHandle = NULL;
    libHandle = dlopen([path cStringUsingEncoding:NSUTF8StringEncoding], RTLD_NOW);
    if (libHandle == NULL) {
        char *error = dlerror();
        NSLog(@"dlopen error: %s", error);
    } else {
        NSLog(@"dlopen load framework success.");
    }
}
```

以dlopen方式使用动态库不知道是否能通过苹果审核。

* 使用NSBundle加载动态库

也可以使用NSBundle来加载动态库，实现代码如下：

```objective-c

- (IBAction)onBundleLoadAtPathAction1:(id)sender
{
    NSString *documentsPath = [NSString stringWithFormat:@"%@/Documents/Dylib.framework",NSHomeDirectory()];
    [self bundleLoadDylibWithPath:documentsPath];
}

- (void)bundleLoadDylibWithPath:(NSString *)path
{
    _libPath = path;
    NSError *err = nil;
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    if ([bundle loadAndReturnError:&err]) {
        NSLog(@"bundle load framework success.");
    } else {
        NSLog(@"bundle load framework err:%@",err);
    }
}

```

####使用动态库中代码

通过上述任一一种方式加载的动态库后，就可以使用动态库中的代码文件了，以`Dylib.framework`中的`Person`类的使用为例：

```objective-c
- (IBAction)onTriggerButtonAction:(id)sender
{
    Class rootClass = NSClassFromString(@"Person");
    if (rootClass) {
        id object = [[rootClass alloc] init];
        [(Person *)object run];
    }
}

```

注意，如果直接通过下属方式初始化`Person`类是不成功的：

```objective-c
- (IBAction)onTriggerButtonAction:(id)sender
{
    Person *object = [[Person alloc] init];
    if (object) {
       [object run];
    }
}

```


## 监测动态库的加载和移除

我们可以通过下述方式，为动态库的加载和移除添加监听回调：

```objective-c

+ (void)load
{
	_dyld_register_func_for_add_image(&image_added);
	_dyld_register_func_for_remove_image(&image_removed);
}

```

github上有一个完整的[示例代码](https://github.com/ddeville/ImageLogger)，

从这里看出，原来就算空白工程软件启动的时候也会加载多达一百二十多个动态库，如果这些都是静态库，那该有多可怕！！


## Demo

本文使用的例子已经上传到[github](https://github.com/wangzz/Demo/tree/master/FrameworkDemo)上，需要的朋友请自取。

另外，本文对某些东西可能有理解错误的地方，还请指出。

##参考文档：

* [Framework Programming Guide](https://developer.apple.com/library/prerelease/ios/documentation/MacOSX/Conceptual/BPFrameworks/Frameworks.html#//apple_ref/doc/uid/10000183-SW1)

* [OS X Man Pages](https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/dyld.1.html)

* [New Features in Xcode 6 Beta](https://developer.apple.com/library/prerelease/ios/documentation/DeveloperTools/Conceptual/WhatsNewXcode/Articles/xcode_6_0.html)

* [ImageLogger](https://github.com/ddeville/ImageLogger)

* [Dynamic Linking](http://realmacsoftware.com/blog/dynamic-linking?utm_campaign=iOS_Dev_Weekly_Issue_140&utm_medium=email&utm_source=iOS%2BDev%2BWeekly)

* [Dynamic loading](http://en.wikipedia.org/wiki/Dynamic_loading#Mac_OS_X)

* [Integrating Reveal with your iOS app](http://support.revealapp.com/kb/getting-started/integrating-reveal-with-your-ios-app#dynamic-library-integration)

* [IOS Framework制作全攻略](http://blog.sina.com.cn/s/blog_407fb5bc01013v6s.html)

* [Build Settings中的变量@rpath,@loader_path,@executable_path](http://www.tanhao.me/pieces/1361.html)

* [深入浅出Cocoa之Framework](http://www.cocoachina.com/newbie/basic/2012/0516/4255.html)

* [linux中静态库和动态库的区别和汇总](http://blog.sina.com.cn/s/blog_a843a8850101rv9k.html)


