---
layout: post
title: "手动内存管理转ARC项目实战"
date: 2014-10-13 16:10:05 +0800
comments: true
categories: iOS
tags: [ARC, iOS, MRC, 手动内存管理]
keywords: ARC, iOS, MRC, 手动内存管理
---

在ARC之前，iOS内存管理无论对资深级还是菜鸟级开发者来说都是一件很头疼的事。我参加过几个使用手动内存管理的项目，印象最深刻的是一个地图类应用，由于应用本身就非常耗内存，当时为了解决内存泄露问题，每周都安排有人值班用Instruments挨个跑功能，关键是每次都总能检查出来不少。其实不管是菜鸟级还是资深级开发者都避免不了写出内存泄露的代码，规则大家都懂，可是天知道什么时候手一抖就少写了个release？

好在项目决定转成ARC了，下面将自己转换的过程和中间遇到的问题写出来和大家共享，希望能减少大家解决同类问题的时间。

<!-- more -->

## 一、前言

#### 项目简介

需要转换的Objective-C文件数量：1000个左右。

开发工具：Xcode 6.0.1

#### 转换方式

我使用的是Xcode本身提供的ARC转换功能。当然你也可以手动手动转换，那不属于本文范畴，而且其工作量绝对能让你崩溃。

## 二、转换过程

#### 代码备份

在进行如此大规模的更改之前，一定要先进行代码备份：直接在本地将代码复制一份，或者记住更改前代码在VCS上的版本号。

#### 过滤无需转换的文件

找出项目中引用的仍使用手动内存管理的第三方库，或者某些你不希望转换的文件，对其添加`-fno-objc-arc`标记。

Xcode自动转换工具只针对Objective-C对象，只会处理`Objective-C/Objective-C++`即后缀名为`.m/.mm`的两种文件，因此其他的`C/C++`对应的`.c/.cpp`都无需理会。

#### 执行检查操作

使用Xcode转换工具入口如图所示：

![refactor](/images/article8/refactor.png)

点击`Convert to Objective-C ARC`后会进入检查操作入口，如图：

![check](/images/article8/check.png)

该步骤要选择哪些文件需要转换，如果前面将无需转换的文件都添加了`-fno-objc-arc`标记后，这里可以全选。

点击check按钮后Xcode会帮助我们检查代码中存在的不符合ARC使用规则的错误或警告，只有所有的错误都解决以后才能执行真正的转换操作。

#### 解决错误/告警

执行完check操作后，会给出提示：

![error](/images/article8/error.png)

三百多个错误，同时还有一千两百多个警告信息，都要哭了。。。

错误和警告的解决内容较多，后面会单独介绍。

#### 执行转换操作

解决完所有的error后，会弹出下述提示界面：

![notice](/images/article8/notice.png)

大意是Xcode将要将你的工程转换成使用ARC管理内存，所有更改的代码在真正更改之前会在一个review界面展示。同时所有的更改完成以后，Xcode会讲项目Target对应的工程设置的使用ARC设置（`Objective-C Automatic Reference Counting`）会被置成YES（上图右上角的警告标识就是在告诉我们项目已经支持ARC了，但工程中有文件还不支持）：

![use_arc](/images/article8/use_arc.png)

这时离成功就不远了，胜利在望！

点击next按钮后跳转到review界面，样式类似于使用Xcode提交SVN的确认提交界面，如下图所示：

![review](/images/article8/review.png)

该界面列出了所有需要有代码更改的文件，同时能够直接对比转换前和转换后的代码变化。为了稳妥起见，我选择了每个文件都点进去扫了一眼，这也给我们一次机会检查是否漏掉了不能转换的文件。确定一切无误以后，点击右下角的save按钮，一切就大功告成了！


## 错误/警告解决


#### 错误 

* ARC forbids synthesizing a property of an Objective-C object with unspecified ownership or storage attribute

![readonly_error](/images/article8/readonly_error.png)

property属性必须指定一个内存管理关键字，在属性定义处增加strong关键字即可。

* ARC forbids explicit message send of 'release'

![release_error](/images/article8/release_error.png)

这种情况通常是使用包含release的宏定义，将该宏和使用该宏的地方删除即可。

* Init methods must return a type related to the receiver type

![init_return_type](/images/article8/init_return_type.png)

错误原因是A类里的一个方法以init开头，而且返回的是B类型，好吧，乖乖改方法名。

* Cast of C pointer type 'ivPointer' (aka 'void *') to Objective-C pointer type 'iFlyTTSManager_old *' requires a bridged cast

![cast_pointer_objective-c](/images/article8/cast_pointer_objective-c.png)

这是`Toll-Free Bridging`转换问题，在ARC下根据情况使用对应的转换关键字就行了，后文会专门介绍。


#### 警告

解决警告的目的是消除警告处代码存在的隐患，既然Xcode给了提示，那么每一个警告信息都值得我们认真对待。

* Capturing `self` in this block is likely to lead to a retain cycle

![block_capturing_self](/images/article8/block_capturing_self.png)

这是典型的block循环引用问题，将block中的self改成使用指向self的weak指针即可。


* Using 'initWithArray:' with a literal is redundant

![literal_is_redundant](/images/article8/literal_is_redundant.png)

好吧，原来是没必要的alloc操作，直接按Xcode提示将alloc删除即可：

![literal_is_redundant_fix.png](/images/article8/literal_is_redundant_fix.png)

* Init methods must return a type related to the receiver type

![init_methods.png](/images/article8/init_methods.png)

原来是A类里的一个方法以init开头，而且返回的是B类型，好吧，乖乖改方法名。

* Property follows Cocoa naming convention for returning ‘owned’ objects

![property_follows.png](/images/article8/property_follows.png)

这是因为@property属性的命名以new开头了，可恶。。。修改方法是将对应的getter方法改成非new开头命名的：

![property_follows_fix.png](/images/article8/property_follows_fix.png)

ARC下方法名如果是以new/alloc/init等开头的，而且还不是类的初始化方法，就该小心了，要么报错，要么警告，原因你懂的。

* Block implicitly retains 'self'; explicitly mention 'self' to indicate this is intended behavior

![block_implicitly_retains.png](/images/article8/block_implicitly_retains.png)

意思是block中使用了self的实例变量_selectedModeMarkerView，因此block会隐式的retain住self。Xcode认为这可能会给开发者造成困惑，或者因此而因袭循环引用，所以警告我们要显示的在block中使用self，以达到block显示retain住self的目的。

该警告有两种改法：
①按照Xcode提示，改成self->_selectedModeMarkerView：

![block_implicitly_retains_fix1.png](/images/article8/block_implicitly_retains_fix1.png)

②直接将该警告关闭
警告名称为：`Implicit retain of ‘self’ within blocks`
对应的Clang关键字是：`-Wimplicit-retain-self`

![block_implicitly_retains_fix2.png](/images/article8/block_implicitly_retains_fix2.png)

* Weak property may be unpredictably set to nil 和 Weak property 'delegate' is accessed multiple times in this method but may be unpredictably set to nil; assign to a strong variable to keep the object alive

![weak_property_unpredictably.png](/images/article8/weak_property_unpredictably.png)

这是工程中数目最多的警告，这是因为所有的delegate属性都是weak的，Xcode默认开启了下图中的两个警告设置，将其关闭即可：

![weak_property_unpredictably_fix.png](/images/article8/weak_property_unpredictably_fix.png)

* Capturing 'self' strongly in this block is likely to lead to a retain cycle

![retain_cycle.png](/images/article8/retain_cycle.png)

这是明显的block导致循环引用内存泄露的情况，之前代码中坑啊！修改方案：

![retain_cycle_fix.png](/images/article8/retain_cycle_fix.png)

* Method parameter of type 'NSError *__autoreleasing *' with no explicit ownership

![autorelease_error.png](/images/article8/autorelease_error.png)

这种就不用说了，按警告中的提示添加`__autoreleasing`关键字即可。


以上列出的错误和警告只是数量较多的，还有很多其他就不在这里一一列举了。

另外，推荐  [Mattt Thompson](https://twitter.com/mattt) 大神关于Clang中几乎所有warning的名称和对应报错提示语的网站：[http://fuckingclangwarnings.com/](http://fuckingclangwarnings.com/)，以后解决warning类问题就简单多了！

## Xcode自动转换

#### 关键字转换

Xcode会自动将某些关键字自动转换成ARC的对应版本。

* retain自动转成strong，如图：

![retain_strong.png](/images/article8/retain_strong.png)

* assign关键字转成weak

修饰Objective-C对象或者id类型对象的assign关键字会被转成weak，如图：

![assign_weak.png](/images/article8/assign_weak.png)

但是修饰Int/bool等数值型变量的assign不会自动转换成weak，如图：

![assign_not_weak.png](/images/article8/assign_not_weak.png)


#### 关键字删除

和手动内存管理相关的几个关键字，比如：`release/retain/autorelease/super dealloc`等会被删除；

dealloc方法中如果除了release/super dealloc语句外，如果别的代码，dealloc方法会保留,如图：

![retain_dealloc.png](/images/article8/retain_dealloc.png)

如果没有整个方法都会被删除：

![delete_dealloc.png](/images/article8/delete_dealloc.png)

#### 关键字替换

* 在转换时__block关键字会被自动替换成__weak：

![block_weak.png](/images/article8/block_weak.png)

* @autoreleasepool

NSAutoreleasePool不支持ARC，会被替换成@autoreleasepool：

![autoreleasepool.png](/images/article8/autoreleasepool.png)


#### 关于被宏注释代码

* 使用宏定义的对象释放代码

宏定义如下所示：

```objective-c
#define RELEASE_SAFELY(__POINTER) { \
[(__POINTER) release]; (__POINTER) = nil; }
```
在执行ARC转换检查操作时，Xcode会在使用该宏的地方报错：

![release_error.png](/images/article8/release_error.png)

将该宏和使用该宏的地方删除即可。


* 被宏注释掉的代码，Xcode在转换时是不会处理的，如图：

![marco_arc.png](/images/article8/marco_arc.png)

PS：这是相当坑的一点，因为你根本预料不到工程中使用了多少宏，注释掉了多少代码。当你执行完转换操作，以为就大功告成的时候，却在某天因为一个宏的开启遇到了一堆新的转ARC不彻底的问题。这种问题也没招，只能遇到一个改一个了。


## ARC和block

不管是手动内存管理还是ARC，block循环引用导致的内存泄露都是一个令人头疼的问题。在MRC中，解决block循环引用只需要使用__block关键字，在ARC下解决与block的使用就略显复杂了：

#### __block关键字

* block内修改外部定义变量

和手动内存管理一样，ARC如果在block中需要修改block之外定义的变量需要使用`__block`关键字修饰，比如：

```objective-c
__block NSString *name = @"foggry";
self.expireCostLabel.completionBlock = ^(){
    name = @"wangzz";
};
```

上例中name变量需要在block中修改，因此必须使用__block关键字。

* __block在MRC和ARC中的区别

在ARC下的block中使用__block关键字修饰的对象时，block会retain该对象；而在MRC下却不会retain。关于这点在官方文档[Transitioning to ARC Release Notes](https://developer.apple.com/library/ios/releasenotes/objectivec/rn-transitioningtoarc/introduction/introduction.html)中有详细的描述：

>
In manual reference counting mode, __block id x; has the effect of not retaining x. 
In ARC mode, __block id x; defaults to retaining x (just like all other values). 
>

下面的代码不管在MRC还是ARC中`myController`对象都是有内存泄露的：

```objective-c
MyViewController *myController = [[MyViewController alloc] init…];
// ...
myController.completionHandler =  ^(NSInteger result) {
   [myController dismissViewControllerAnimated:YES completion:nil];
};
```

内存泄露问题在MRC中可以按如下方式更改：

```objective-c
MyViewController * __block myController = [[MyViewController alloc] init…];  
// ...  
myController.completionHandler =  ^(NSInteger result) {  
    [myController dismissViewControllerAnimated:YES completion:nil];  
}; 
```

然而在ARC中这么改就不行了。正如开始所说的那样，在ARC中`myController.completionHandler`的block会retain`myController`对象，使得内存泄露问题仍然存在！！

在ARC中该问题有两种解决方案，第一种：

```objective-c
MyViewController * __block myController = [[MyViewController alloc] init…];  
// ...  
myController.completionHandler =  ^(NSInteger result) {  
    [myController dismissViewControllerAnimated:YES completion:nil];  
    myController = nil;  
}; 
```
该方法在block中使用完myController时，是它指向nil。没有strong类型的指针指向myController指向的对象时，对象会被释放掉。

第二种种解决方案，直接使用__weak代替__block关键字：

```objective-c
MyViewController *myController = [[MyViewController alloc] init…];  
// ...  
MyViewController * __weak weakMyViewController = myController;  
myController.completionHandler =  ^(NSInteger result) {  
    [weakMyViewController dismissViewControllerAnimated:YES completion:nil];  
};
```
该方法直接避免了对block对myController对象的retain。

#### 存在循环引用关系

如果self直接或者间接的对block存在强引用，在block中又需要使用self关键字，此时self和block就存在循环引用的关系。此时必须使用__weak关键字定义一个指针指向self，在block中使用该指针来引用self：

```objective-c
MessageListController * __weak weakSelf = self;
self.messageLogic.loadMoreBlock = ^(IcarMessage * theMessage) {
    [weakSelf.tableView setPullTableIsLoadingMore:YES];
};
```

需要说明的是，尽管上例中weakSelf指针对self只是弱引用，但是self对block却是强引用，self的生命周期一定是长于block的，因此不用担心在block中使用weakSelf指针时，其指向的self会被释放掉。


#### 不存在循环引用关系

下面的例子：

```objective-c
MyViewController *myController = [[MyViewController alloc] init…];
// ...
MyViewController * __weak weakMyController = myController;
myController.completionHandler =  ^(NSInteger result) {
    MyViewController *strongMyController = weakMyController;
    if (strongMyController) {
        // ...
        [strongMyController dismissViewControllerAnimated:YES completion:nil];
        // ...
    }
    else {
        // Probably nothing...
    }
};
```

如前面所说，`myController.completionHandler`的block中不能直接使用`myController`对象，会造成内存泄露，因此需要先用一个weak的指针指向`myController`对象，然后在block中使用该weak指针。但是为了确保在block执行的时候`myController`对象没有被释放掉，就在block一开始的地方定义了一个临时的strong类型的指针`strongMyController`指向weak指针`weakMyController`，其实最终的结果就是block中对`myController`对象强引用了。在block执行完被销毁的时候，`strongMyController`指针变量会被销毁，其最终指向的`myController`对象因此也会被销毁。这样在使用一个对象的时候做就保证了该对象是存在的，使用完了再放弃该对象的所有权。


## ARC和Toll-Free Bridging

MRC下的`Toll-FreeBridging`不涉及内存管理的转移，Objective-C（后文简称OC）和Core Foundation（后文简称CF）各自管理各自的内存,相互之间可以直接交换使用，比如：

```objective-c
NSLocale *gbNSLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
CFLocaleRef gbCFLocale = (CFLocaleRef)gbNSLocale;
```

而在ARC下,事情就会变得复杂一些。因为ARC能够管理OC对象的内存,却不能管理CF对象,CF对象依然需要我们手动管理内存。在CF和OC之间bridge对象的时候,问题就出现了,编译器不知道该如何处理这个同时有OC指针和CF指针指向的对象。这时候,需要使用`__bridge`, `__bridge_retained`, `__bridge_transfer`等修饰符来告诉编译器该如何去做。

* __bridge

该关键字在桥接过程中不会增加被桥接对象的引用计数，比如：

```objective-c
CFStringRef cfString = CFStringCreateWithCString(kCFAllocatorDefault, "CFString", kCFStringEncodingUTF8);
NSString *ocString = (__bridge NSString *)cfString;
CFRelease(cfString);
NSLog(@"%@",ocString);
```

由于ARC下`NSString *ocString`定义的对象指针默认是strong的，所以在执行`CFRelease(cfString);`后`ocString `指针还持有桥接过来的对象，`ocString`指针仍能正常使用。但如果做出如下改动：

```objective-c
CFStringRef cfString = CFStringCreateWithCString(kCFAllocatorDefault, "CFString", kCFStringEncodingUTF8);
__weak NSString *ocString = (__bridge NSString *)cfString;
CFRelease(cfString);
NSLog(@"###%@",ocString);
```

即将定义方式改成`__weak NSString *ocString`，在执行`CFRelease(cfString);`后`ocString`将因不再持有被桥接对象所有权而无法正常使用。

反之从OC对象桥接到CF对象也是一个道理，该关键字有点像`__weak`关键字的作用。

* __bridge_retained 或 CFBridgingRetain

二者作用是一样的，只是用法不同。

该关键字在桥接的过程中会retain被桥接对象，相当于桥接方也持有了被桥接对象。需要注意的是，如果是CF对象桥接到OC对象，编译器会做好OC对象的内存管理工作；但如果是OC对象桥接到CF对象，那么CF需要执行内存释放操作，如下例所示：

```objective-c
NSArray *ocArray = [[NSArray alloc] initWithObjects:@"foggry", nil];
CFArrayRef cfArray = (__bridge_retained CFArrayRef)ocArray;
/**
 使用cfArray
 **/
CFRelease(cfArray);
```

* __bridge_transfer 或 CFBridgingRelease

二者作用也是一样的，只是用法不同。

该关键字将对象所有权由被桥接对象转移给了桥接对象，比如：

```objective-c
CFStringRef cfString = CFStringCreateWithCString(kCFAllocatorDefault, "CFString", kCFStringEncodingUTF8);
NSString *ocString = (__bridge_transfer NSString *)cfString;
//CFRelease(cfString); //不再需要释放操作
NSLog(@"%@",ocString);
```

此例中被桥接对象cfString的所有权就转移给了桥接对象ocString。

总之，理解了桥接关键字的作用，桥接转换过程中大家只需要根据具体需求选用适当的关键字即可。

另外，在ARC中`id`和`void *`也不能直接相互转换了，必须通过`Toll-FreeBridging`使用适当的关键字修饰。

## ARC和IBOutLet

对于IBOutLet属性应该用strong还是weak一直都有疑惑。关于这一点[官方文档](https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/LoadingResources/CocoaNibs/CocoaNibs.html#//apple_ref/doc/uid/10000051i-CH4-SW6)是这么介绍的：

>
From a practical perspective, in iOS and OS X outlets should be defined as declared properties. Outlets should generally be weak, except for those from File’s Owner to top-level objects in a nib >>>file (or, in iOS, a storyboard scene) which should be strong. Outlets that you create should therefore typically be weak.
>

那么长的一段英文想说的是：

如果nib文件构建的view是直接被Controller引用的顶层view，对应的IBOutLet属性应该是strong；

如果view是顶层view上的一个子view，那么该view的属性应该是weak，因为顶层view被Controller使用strong属性引用了，而顶层view本身又持有该view；

如果Controller对某个view需要单独引用，或者Controller没有引用某个view的父view，那么其属性也应该是strong。


好吧，其实我能说如果你实在懒得区分什么时候用strong，什么时候用weak，那就将所以后的IBOutLet属性都设成strong吧！在Controller销毁的时候，对应的IBOutLet实例变量也会被销毁，strong指针会被置成nil，因此也不会有内存问题。


## 参考文档

* [Transitioning to ARC Release Notes](https://developer.apple.com/library/ios/releasenotes/objectivec/rn-transitioningtoarc/introduction/introduction.html)
* [Managing the Lifetimes of Objects from Nib Files](https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/LoadingResources/CocoaNibs/CocoaNibs.html#//apple_ref/doc/uid/10000051i-CH4-SW6)
* [Nib Memory Management](https://mikeash.com/pyblog/friday-qa-2012-04-13-nib-memory-management.html)


