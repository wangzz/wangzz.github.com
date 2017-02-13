---
layout: post
title: "iOS内存探秘"
date: 2017-02-13 16:38:45 +0800
comments: true
categories: iOS
tags: [Objective-C, iOS, Clean Page, Dirty Page, 虚拟内存]
keywords: Objective-C, iOS, Clean Page, Dirty Page, 虚拟内存
---

## iOS 内存机制特点

* 有限的可用内存

iPhone 设备的 RAM 一直非常紧缺，iPhone 一代只有 128MB，直到 iPhone5 时达到了 1GB，并且在 iPhone7 plus 达到了 3GB。[StackOverFlow](http://stackoverflow.com/a/15200855/2293677) 上提供了部分 iPhone 机型的可用内存数目。

* 低内存通知

在可用物理内存较少时，iOS 会给各应用发出低内存广播通知，如果此后可用内存仍然低于特定值，则会杀死优先级较低的进程。

* 没有内存交换机制

桌面操作系统可以在物理内存紧张的时候把暂时不用的物理内存置换到磁盘上，并在需要的时候再次加载到内存中。而 iOS 没有这种机制，原因是移动设备的闪存没有 PC 机那么大的硬盘，而且频繁的读写闪存会降低其寿命。目前 iOS 在内存不足时采用的方案是杀死优先级较低的进程。

* 使用虚拟内存机制

和大多数桌面操作系统一样，iOS 也使用虚拟内存机制。

<!-- more -->

## 虚拟内存

关于虚拟内存的原理和优缺点就不再累述，这里说下 iOS 虚拟内存机制中与众不同的地方。

#### 内存分页

iOS 把虚拟内存每 4KB 划分成一个 Page，并不是所有的 Page 都会映射到物理内存中。每个 Page 有三种状态：

* Nonresident

是否 Resident 是一个 Page 状态的重要标识，如果 Page 被映射到内存里了，这个 Page 就是 Resident 状态，否则就是 Nonresident 状态；

* Resident and clean

基于 readonly 文件而被加载到内存中的 Page 称为 clean memory，比如：`系统 framework`、`可执行文件`、`通过 mmap 方式读取的文件` 等。这种 Page 由于是加载自不可变的文件，因此可以在物理内存紧张时被 iOS 自动 unload 出去，并且在需要的时候再重新从原来的文件加载到内存中。

* Resident and dirty

凡是非 clean 的 Page 都是 dirty 的，它们的共同特点是 Page 在闪存中没有对应的文件，比如通过 alloc 在堆上创建的内存空间，已经解压的图片，database caches 等。dirty memory 不能被操作系统交换出去，只有在进程被杀死的时候才能被回收，因此在系统发生内存告警时，如果进程创建了大量的 dirty memory，那么将很有可能被 kill 掉。

#### 举例说明

* Malloc 分配内存

如前问所述，Malloc 的内存都是  Resident dirty 的，但事实上并非如此，比如：

```
char *p = valloc(2 * 4096);

```

此时会在虚拟内存里申请两份 4096 字节的内存，但由于申请后没有使用，操作系统不会真正为刚申请的内存空间分配对应的物理内存空间，因此此时该内存空间处于 Nonresident 状态。如果对 p[0] 赋值：

```
p[0] = 1;
```

此时 P[0] 会被加载到物理内存上，由此变成 Resident dirty 状态，同理如果对 p[1] 赋值也一样。

* mmap 加载文件

一个文件通过如果下述 mmap 方式加载：

```
NSData *data = [NSData dataWithContentsOfMappedFile:file];char *p = (char *)[data bytes];
```

此时文件由于未被使用，因此也仅仅是在虚拟内存中，操作系统并没有将其映射到物理里，因此所属 Page 的状态是 Nonresident。如果调用以下代码：

```
printf("%c", p[0]);
```

此时由于该文件的 p[0] 部分被使用，操作系统就会将 p[0] 部分加载到物理内存中，又因为 p 对应的存储区域是一个 mmap 方式加载的只读文件，因此 p[0] 对应的 Page 就是 Resident clean 的，而 p[1] 往后的部分由于仍然未被使用，Page 的状态不变。


## 需要做什么

对于开发者来说，要想减少应用因内存告警被系统杀掉，应做到以下几点：

* 该尽可能减少 dirty 内存的创建

* 要尽量保证 dirty 内存用完之后及时释放

* 及时处理系统内存告警通知，释放掉大量占用内存并且可重建的对象

* 在发生内存告警时，不再持续申请内存，更不能申请较大块的内存

## 参考文档

* [List of iOS devices](https://en.wikipedia.org/wiki/List_of_iOS_devices)

* [WWDC2010 Session 417:Advanced Performance Optimization on iPhone OS, Part 2](https://developer.apple.com/videos/play/wwdc2010/147/)

* [WWDC2012 Session 242:iOS App Performance: Memory](https://developer.apple.com/videos/play/wwdc2012/242/)