---
layout: post
title: "iOS进程间通信之CFMessagePort"
date: 2014-06-04 18:31:51 +0800
comments: true
categories: iOS
tags: [iOS, 进程通信, CFMessagePort]
keywords: iOS, 进程通信, CFMessagePort
---



iOS系统是出了名的封闭，每个应用的活动范围被严格地限制在各自的沙盒中。尽管如此，iOS还是提供了若干进程间通信机制，CFMessagePort就是其中之一。

从类名可以看出，CFMessagePort属于`Core Foundation`层的东西，其实现部分是开源的，代码在可以在苹果的[开源代码库](http://opensource.apple.com/source/CF/CF-855.14/CFMessagePort.c)中找到。


##使用方式


####1、消息接收者

CFMessagePort端口消息的接收者需要实现以下功能：

######1.1 注册监听

消息接收者需要通过以下方式注册消息监听：

```objective-c
-(void)startListenning
{
	if (0 != mMsgPortListenner && CFMessagePortIsValid(mMsgPortListenner))
	{
		CFMessagePortInvalidate(mMsgPortListenner);
	}
    mMsgPortListenner = CFMessagePortCreateLocal(kCFAllocatorDefault,CFSTR(LOCAL_MACH_PORT_NAME),onRecvMessageCallBack, NULL, NULL);
    CFRunLoopSourceRef source = CFMessagePortCreateRunLoopSource(kCFAllocatorDefault, mMsgPortListenner, 0);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopCommonModes);
    NSLog(@"start listenning");
}
```


 <!-- more -->
 
 

其中`LOCAL_MACH_PORT_NAME`的定义为：

```objective-c
#define LOCAL_MACH_PORT_NAME    "com.wangzz.demo"
```

经过查看源码发现，CFMessagePort实际上是通过mach port实现的。Mach port是iOS系统提供的基于端口的输入源，可用于线程或进程间通讯。而Runloop支持的输入源类型中就包括基于端口的输入源，因此可以使用Runloop做为CFMessagePort端口源事件的监听者。

上述代码有几点需要说明：

* 通过CFMessagePortCreateLocal可以创建一个本地CFMessagePortRef对象

* CFMessagePort对象是靠一个字符串来唯一标识的，这一点非常重要，在这里字符串是由宏`LOCAL_MACH_PORT_NAME`定义的；

* 创建CFMessagePort对象的同时设置了端口源事件的回调函数onRecvMessageCallBack，用于处理端口源事件；

* 将创建的对象作为输入源添加到Runloop中，从而实现对端口源事件的监听，当Runloop收到对应的端口源事件时，会调用上一步中指定的回调芳芳；


######1.2 实现回调方法


回调函数为CFMessagePortCallBack类型，其定义部分为：
```objective-c
typedef CFDataRef (*CFMessagePortCallBack) (
   CFMessagePortRef local,
   SInt32 msgid,
   CFDataRef data,
   void *info
);
```
各个参数的含义为：

* CFMessagePortRef local
 
	当前接收消息的CFMessagePortRef对象。

* SInt32 msgid

	这个字段非常有用，用于标识消息。如果通信双方进程约定号每个msgid对应的数据结构，即可实现较为复杂的通信。

* CFDataRef data

	通信的真正数据部分。

* void *info
	
	为使用CFMessagePortCreateLocal方法创建port端口时指定的CFMessagePortContext对象的info字段，通常为空。

该回调方法可以返回一个CFDataRef类型的数据给port消息的发送者，以实现有效的双方通信，这一点也非常重要。

我的回调函数onRecvMessageCallBack的实现：

```objective-c
CFDataRef onRecvMessageCallBack(CFMessagePortRef local,SInt32 msgid,CFDataRef cfData, void*info)
{
    NSLog(@"onRecvMessageCallBack is called");
    NSString *strData = nil;
    if (cfData)
    {
       	const UInt8  * recvedMsg = CFDataGetBytePtr(cfData);
    	strData = [NSString stringWithCString:(char *)recvedMsg encoding:NSUTF8StringEncoding];
        /**
         
         实现数据解析操作
         
         **/
        
        NSLog(@"receive message:%@",strData);
    }
    
    //为了测试，生成返回数据
    NSString *returnString = [NSString stringWithFormat:@"i have receive:%@",strData];
    const char* cStr = [returnString UTF8String];
	NSUInteger ulen = [returnString lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    CFDataRef sgReturn = CFDataCreate(NULL, (UInt8 *)cStr, ulen);
    
    return sgReturn;
}
```

该方法实现的较为简单，解析约定的数据（测试代码中约定传送的是string）,为了测试，同时生成一个CFDataRef数据返回给port消息的发送者。


######1.3 取消端口监听

可以通过如下方式取消对port端口的监听：

```objective-c
- (void)endLisenning
{
    CFMessagePortInvalidate(mMsgPortListenner);
    CFRelease(mMsgPortListenner);
}
```
CFMessagePortInvalidate会停止port消息的发送和接收操作，而只有调用了CFRelease，CFMessagePortRef对象才真正的被释放掉。

####2、消息发送者

发送部分代码如下：

```objective-c
-(NSString *)sendMessageToDameonWith:(id)msgInfo msgID:(NSInteger)msgid
{
    // 生成Remote port
    CFMessagePortRef bRemote = CFMessagePortCreateRemote(kCFAllocatorDefault, CFSTR(MACH_PORT_REMOTE));
    if (nil == bRemote) {
        NSLog(@"bRemote create failed");
        return nil;
    }
    
    // 构建发送数据（string）
    NSString    *msg = [NSString stringWithFormat:@"%@",msgInfo];
    NSLog(@"send msg is :%@",msg);
    const char *message = [msg UTF8String];
    CFDataRef data,recvData = nil;
    data = CFDataCreate(NULL, (UInt8 *)message, strlen(message));
    
    // 执行发送操作
    CFMessagePortSendRequest(bRemote, msgid, data, 0, 100 , kCFRunLoopDefaultMode, &recvData);
    if (nil == recvData) {
        NSLog(@"recvData date is nil.");
        CFRelease(data);
        CFMessagePortInvalidate(bRemote);
        CFRelease(bRemote);
        return nil;
    }
    
    // 解析返回数据
    const UInt8  * recvedMsg = CFDataGetBytePtr(recvData);
    if (nil == recvedMsg) {
        NSLog(@"receive date err.");
        CFRelease(data);
        CFMessagePortInvalidate(bRemote);
        CFRelease(bRemote);
        return nil;
    }

    NSString    *strMsg = [NSString stringWithCString:(char *)recvedMsg encoding:NSUTF8StringEncoding];
    NSLog(@"%@",strMsg);
    
    CFRelease(data);
    CFMessagePortInvalidate(bRemote);
    CFRelease(bRemote);
    CFRelease(recvData);
    
    return strMsg;
}

```

其中`MACH_PORT_REMOTE`的定义为：

```objective-c
#define MACH_PORT_REMOTE    "com.wangzz.demo"
```

发送消息时要相对简单，首先通过CFMessagePortCreateRemote生成一个Remote的CFMessagePortRef，这里需要注意的是CFMessagePortCreateRemote时传入的字符串唯一标识`MACH_PORT_REMOTE`必须和消息接收者创建local的CFMessagePortRef时使用的字符串唯一标识是同一个！

通过查看源码发现，CFMessagePortCreateRemote会根据`MACH_PORT_REMOTE`定义的字符串为唯一标识获取消息接收者通过CFMessagePortCreateLocal使用相同字符串创建的底层mach port端口，从而实现向消息接收者发送信息。

如果消息接收者还没有创建或者通过CFMessagePortCreateLocal创建local端口失败时，想要通过CFMessagePortCreateRemote去创建remote端口肯定是失败的。

##说明

* 很遗憾的是，在iOS7及以后系统中，CFMessagePort的通信机制不再可用。

在使用CFMessagePortCreateLocal/CFMessagePortCreateRemote创建CFMessagePortRef对象时会失败，官方文档中是这么说的：

```
This method is not available on iOS 7 and later—it will return NULL and log a sandbox violation in syslog. See Concurrency Programming Guide for possible replacement technologies.
```

* CFMessagePort只能用于本地进程通信。

* CFMessagePort是基于mach port端口的通信方式，不但可以用于进程通信，也可以用于线程间通信，只是线程间通信有了GCD和Cocoa提供的原生方法，已经能很方便的实现了，没必要再使用CFMessagePort。

* 进程通信使用场景

iOS系统多任务机制，使得进程间通信基本都只能用于越狱开发。常用的场景是前端有一个UI程序用于界面展示，后端有一个daemo精灵程序用于任务处理。

##demo工程

特地做了了个demo工程，以便更好地演示CFMessagePort的使用，可以到[CSDN下载](http://download.csdn.net/detail/wzzvictory_tjsd/7446745)。

为了模拟进程间通信场景，我将消息接收进程CFMessagePortReceive做成了能够后台播放音乐的程序，以便其切到后台后能继续存活。

由于CFMessagePort不再支持iOS7及以后系统，本demo实在iOS6系统上测试的。

demo使用方式：

* CFMessagePortReceive启动后，点击Start Listenning创建CFMessagePort接口并开始监听port消息，然后将CFMessagePortReceive切到后台；

* 启动CFMessagePortSend程序，在输入框中写入内容，点击发送按钮即可和CFMessagePortReceive通信。

* MessagePort通信过程中会有日志输出，可以使用以下方式查看日志：

	1.真机
	
	选择：Xcode->Window->Organizer->Devices，然后选中窗口左侧当前设备的Console窗口查看。
	
	2.模拟器
	
	选择：模拟器->调试->打开系统日志，或者直接使用快捷键`⌘/`直接打开系统控制台查看日志。


##参考文档

* [CF-855.14](http://opensource.apple.com/source/CF/CF-855.14/)

* [Threading Programming Guide](https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/Multithreading/RunLoopManagement/RunLoopManagement.html#//apple_ref/doc/uid/10000057i-CH16-SW1)

* [CFMessagePort Reference](https://developer.apple.com/library/mac/documentation/corefoundation/Reference/CFMessagePortRef/Reference/reference.html#//apple_ref/doc/uid/20001437-CH203-DontLinkElementID_8)
