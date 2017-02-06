---
layout: post
title: "为什么 Objective-C 对象存储在堆上而不是栈上"
date: 2017-02-06 18:36:10 +0800
comments: true
categories: iOS
tags: [Objective-C, iOS, 栈对象, 堆对象]
keywords: Objective-C, iOS, 栈对象, 堆对象
---

为什么 Objective-C 对象存储在堆上而不是栈上

#### 一、什么是栈对象和堆对象

在 Objective-C 中，对象通常是指一块有特定布局的连续内存区域。我们通常这样创建一个对象：

```
NSObject *obj = [[NSObject alloc] init];
```

这行代码创建了一个 NSObject 类型的指针 obj 和一个 NSObject 类型的对象，obj 指针存储在栈上，而其指向的对象则存储在堆上（简称为堆对象）。

目前 Objective-C 并不支持直接在栈上创建对象（简称为堆对象），但可以通过如下方式间接地创建：

```
struct {
Class isa;
} fakeNSObject;
fakeNSObject.isa = [NSObject class];

NSObject *obj = (NSObject *)&fakeNSObject;
NSLog(@"%@", [obj description]);
```

栈对象 obj 也能正常工作，由此可见栈对象和堆对象都是可行的，但为什么 Objective-C 不默认使用栈对象呢？

<!-- more -->

#### 二、栈对象优缺点

##### 1、优点

* 速度

在栈上创建对象是非常快的，因为很多东西在编译时就确定了，运行时分配空间几乎不耗时；相对而言在堆上创建对象就非常耗时。

* 简单

栈对象的生命周期是确定的，对象出栈以后就会被释放，不会存在内存泄漏，但这同时也是栈对象的最大缺点。

##### 2、缺点

* 生命周期固定

Objective-C 变量有效范围是由 "{}" 包含的块来决定的，也就是说栈对象的生命周期仅限于其所在的块里，出了块立马会被释放。一个对象被创建以后有可能会通过方法调用传递到别的方法，当栈对象的创建方法返回时，栈对象会被一起 pop 出栈而释放，导致其没法在别处被继续持有。此时 retain 操作会失效，除非用 copy 方法在想持有该栈对象的地方重新拷贝一份属于自己的栈对象。

因此，栈对象回给对象的内存管理造成相当大的麻烦。

* 空间

现代操作系统的栈和线程绑定，而栈空间是有限的，具体如下：

```
512 KB (secondary threads)
8 MB (OS X main thread)
1 MB (iOS main thread)
```

因此对象如果都在栈上创建不太现实，而堆只要物理内存不告警可以无限制使用。


综合以上优缺点，Objective-C 选择用堆存储对象。

#### 三、真的没有栈对象吗

实际上 Objective-C 里的 block 却是栈对象，因此栈对象面临的问题在 block 身上一个都不少，但由于 block 是仅有的特殊对象，大家对它的特殊都已经习惯了，比如入行第一年的时候老师就告诉我们想持有一个 block 要用 copy 将 block 从栈拷贝到堆上。

另外，根据前面所说，栈对象的有效区域仅限于其所在的块，因此像下面的代码就无法输出期望的结果：

```
void (^block)();
if(x)
{
block = ^{ printf("x\n"); };
}
else
{
block = ^{ printf("not x\n"); };
}
block();
```

这也是大家需要特别注意的地方。

#### 四、参考文档

* [Threading Programming Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Multithreading/CreatingThreads/CreatingThreads.html#//apple_ref/doc/uid/10000057i-CH15-SW2)

* [Stack and Heap Objects in Objective-C](https://www.mikeash.com/pyblog/friday-qa-2010-01-15-stack-and-heap-objects-in-objective-c.html)


