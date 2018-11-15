---
layout: post
title: "try catch 原理剖析"
date: 2018-11-15 08:27:01 +0800
comments: true
categories: iOS
tags: [Objective-C, iOS,setjmp,longjmp,异常处理,try,catch]
keywords: Objective-C, iOS,setjmp,longjmp,异常处理,try,catch
---

## 一、非局部跳转

### 1、简介

大部分语言的运行控制模型，都是基于栈的。在这种模型中，调用一个函数时，就会将这个函数的参数、返回地址、局部变量等信息入栈；这个函数返回时，对应信息再出栈。正常情况下，函数调用的进栈和出栈都是成对出现的，比如函数的调用顺序是：func1 --> func2 -- > func3，那么一定是 func1 先进栈，然后是 func2，最后是 func3；而 func3 调用结束后一定是先返回到 func2 ，然后从 func2 返回到func3，而不能直接从 func3 返回到 func1。

我们都知道，C 语言中的 goto 语句，可以实现在一个函数内部跳转;与此同时，C 语言还提供了一种能够在函数间跳转、被称为 `非局部跳转` (no-local goto) 的机制，这种机制可以允许从一个多层嵌套的函数调用中直接返回。我们先通过下面的栗子来见证它的神奇之处：

<!-- more -->

```
#include <stdio.h>
#include <setjmp.h>

jmp_buf jump_buffer;

void func2(void)
{
printf("Before calling longjmp\n");
longjmp(jump_buffer, 1);
printf("After calling longjmp\n");
}

void func1(void)
{
printf("Before calling func2\n");
func2();
printf("After calling func2\n");
}

int main()
{
if (setjmp(jump_buffer) == 0){
printf("first calling set_jmp\n");
func1();
} else {
printf("second calling set_jmp\n");
}

return 0;
}

```

运行结果如下：

```
first calling set_jmp
Before calling func2
Before calling longjmp
second calling set_jmp
```

从日志可以看出，函数的执行过程跳过了 `After calling func2`、`After calling longjmp` 两句日志所在的代码行，在 `func2` 中执行了 `longjmp` 方法后函数直接从 `func2` 跳转回了 `main` 函数中继续执行，而没经过 `func1`！

### 2、实现机制

非局部跳转功能主要是通过位于 `<setjmp.h>` 中的 `setjmp` 和 `longjmp` 两个函数实现。

* setjmp

```
`int setjmp(jmp_buf env);`
```

可以把当前代码行的状态信息保存到 env 中，供以后 `longjmp` 恢复状态信息时使用。如果直接调用 `setjmp()`，则返回值为 0；如果是由于调用了 `longjmp` 而调用到 `setjmp`，则返回值为 `longjmp` 第二个参数所指定的值。

* longjmp

```
`void longjmp(jmp_buf env, int val);`
```

用于将调用堆栈恢复成最近一次调用 `setjmp` 时所保存到 env 中的状态信息。也就是说，调用了 `longjmp` 后，不管当前调用堆栈在哪个方法中，都会回到有效范围内最近一次调用 `setjmp` 方法的地方，而 `setjmp` 方法的返回值就是这里设置的 `val` 的值，用于区分到底是从哪个 `longjmp` 返回到的 `setjmp`。


而 `jmp_buf` 是 `<setjmp.h>` 文件中定义的结构类型，用于保存系统状态信息。函数 `setjmp` 会将其所在的程序点的系统状态信息都保存到 `jmp_buf` 类型的结构变量 env 中，而调用 `longjmp` 会将 env 的系统状态信息恢复，以实现非局部跳转的功能。

### 3、注意事项

* 执行顺序

`setjmp` 和 `longjmp` 结合使用时，必须要有严格的先后执行顺序，即先调用 `setjmp` 函数，再调用 `longjmp` 函数。否则如果在 `setjmp` 之前调用 `longjmp`，将导致程序的执行流变的不可预测，有可能导致程序崩溃。

* 作用域

`longjmp` 必须在正确的 `setjmp` 的作用域范围内。具体来说，在一个函数中调用了 `setjmp`，只要该函数没有返回，那么在任何其它地方都可以通过 `longjmp` 调用来跳转到 `setjmp` 的下一条语句执行。

## 二、try/catch 异常处理机制

在类 C 语言中，非局部跳转的一个重要应用场景就是 `异常处理机制`。Objective-C 使用 try/catch/finally 来捕获并处理异常，比如下面的代码：

```
#import <Foundation/Foundation.h>

int main (int argc, const char * argv[])
{
@autoreleasepool
{
@try {
NSException *e = [NSException
exceptionWithName:@"FileNotFoundException"
reason:@"File Not Found on System"
userInfo:nil];
@throw e;
}
@catch (NSException *exception) {
if ([[exception name] isEqualToString:NSInvalidArgumentException]) {
NSLog(@"%@", exception);
} else {
@throw exception;
}
}
@finally {
NSLog(@"finally");
}
}
return 0;
}
```

通过 Clang 生成的 C 中间代码，可以看出 try/catch 的原理，上述代码保存成 main.m 文件后通过命令：

```
clang -rewrite-objc main.m
```

剔除无用信息后，可以得到下述代码：

```
#include <Foundation/Foundation.h>

int main (int argc, const char * argv[])
{
@autoreleasepool
{
/**
* try/catch的作用域从这里开始
*/
/* @try scope begin */
{
/**
* 首先定义一个_objc_exception_data类型的结构体，用来保存异常现场的数据。
*/
struct _objc_exception_data
{
/**
* buf变量就是c语言中的jmp_buf
* jmp_buf的定义可在setjmp.h文件中找到：
*
*      #define _JBLEN        (10 + 16 + 2)
*      #define _JBLEN_MAX    _JBLEN
*
*      typedef int jmp_buf[_JBLEN];
*/
int buf[18/*32-bit i386*/];

/**
* pointers[0]用来存储通过@throw抛出的异常对象，
* pointers[1]存储下一个_stack数据。
*/
char *pointers[4];
} _stack;

/**
* _rethrow保存可能在@catch中再次抛出的异常对象。
*/
id volatile _rethrow = 0;

/**
* 因为异常处理支持嵌套，_stack会被存储在一个全局的栈中，这个栈用单链表的存储结构表示。
* objc_exception_try_enter函数将_stack压栈。
*/
objc_exception_try_enter(&_stack);

/**
* _setjmp是C的函数，用于保存当前程序现场。
* _setjmp需要传入一个jmp_buf参数，保存当前需要用到的寄存器的值。
* _setjmp()它能返回两次，第一次是初始化时，返回0，第二次遇到_longjmp()函数调用会返回，返回值由_longjmp的第二个参数决定。
* 如果对_setjmp()和_longjmp()概念不太了解的，请参考C语言的异常处理机制。
*
* 下面_setjmp()初始化返回0，然后执行if{}中也就是@try{}中的代码。
*/
if (!_setjmp(_stack.buf)) /* @try block continue */
{
/**
* 创建一个NSException对象，对应代码：
*
*             NSException *e = [NSException
*                               exceptionWithName:@"FileNotFoundException"
*                               reason:@"File Not Found on System"
*                               userInfo:nil];
*/
NSException *e = ((NSException *(*)(id, SEL, NSString *, NSString *, NSDictionary *))(void *)objc_msgSend)(objc_getClass("NSException"), sel_registerName("exceptionWithName:reason:userInfo:"), (NSString *)&__NSConstantStringImpl_main_m_0, (NSString *)&__NSConstantStringImpl_main_m_1, (NSDictionary *)((void *)0));

/**
* 抛出异常对象，对应代码：@throw e;
*
* objc_exception_throw函数实现步骤如下：
* 1. 把e对象保存到_stack->pointers[0]中使其在@catch{}中能被捕获。
* 2. 将_stack从全局栈中弹出。
* 3. 调用_longjmp()跳转到前面if语句中的_setjmp()位置。_longjmp()使得_setjmp()函数第二次返回，
* 返回值为1，所以会执行else{}中也就是@catch{}中的代码。
*/
objc_exception_throw(e);

} /* @catch begin */ else {

/**
* objc_exception_extract函数从_stack->pointers[0]中取得上面抛出的异常对象。
*/
id _caught = objc_exception_extract(&_stack);

/**
* 这里为何再次调用objc_exception_try_enter对_stack压栈？先保留这个疑问，继续看下面的代码。
*/
objc_exception_try_enter (&_stack);

/**
* 在@catch中设置一个跳转位置
*/
if (_setjmp(_stack.buf))

/**
* 如果@catch{}中再次抛出异常，在这里捕获。
*/
_rethrow = objc_exception_extract(&_stack);

else { /* @catch continue */

/**
* objc_exception_match函数判断_caught对象是否是需要捕获的目标对象。对应代码：
*
* @catch (NSException *exception) {
*/
if (objc_exception_match((struct objc_class *)objc_getClass("NSException"), (struct objc_object *)_caught)) {
NSException *exception = _caught;

/**
* 比较捕获的异常是不是NSInvalidArgumentException类型。对应代码：
*
* if ([[exception name] isEqualToString:NSInvalidArgumentException]) {
*      NSLog(@"%@", exception);
*
*/
if (((BOOL (*)(id, SEL, NSString *))(void *)objc_msgSend)((id)((NSString *(*)(id, SEL))(void *)objc_msgSend)((id)exception, sel_registerName("name")), sel_registerName("isEqualToString:"), (NSString *)NSInvalidArgumentException)) {

NSLog((NSString *)&__NSConstantStringImpl_main_m_2, exception);
} else {

/**
* 抛出异常对象，然后跳转到前面@catch中的if语句中的_setjmp()位置。
* 这就解释了前面为什么要在@catch中再次将_stack压栈和调用_setjmp()的原因。
* 在当前@catch中，如果不设置一个跳转点来捕获@catch中抛出的异常，那么程序就直接跳转到全局栈的下一个@catch中，而下面的@finally{}代码就无法执行。
* 在@catch中设置跳转点就是为了最后总能执行@finally中的代码。
*/
objc_exception_throw( exception);
}

} /* last catch end */ else {

/**
* 如果异常对象没被处理，先将其保存到_rethrow变量。
* objc_exception_try_exit函数将_stack从全局栈中弹出。
*/
_rethrow = _caught;
objc_exception_try_exit(&_stack);
}
} /* @catch end */
}
/* @finally */
{
if (!_rethrow) objc_exception_try_exit(&_stack);

NSLog((NSString *)&__NSConstantStringImpl_main_m_3);

/**
* _rethrow是前面@catch中没有被处理的或被捕获的异常对象，
* 最后，_rethrow异常对象被抛到全局栈的下一个@catch中。
*/
if (_rethrow) objc_exception_throw(_rethrow);
}

} /* @try scope end */

}
return 0;
}
```

以上代码还涉及了 objc_exception_try_enter、 objc_exception_extract、 objc_exception_throw、 objc_exception_try_exit 等函数，都可以在苹果开源 [objc4](https://opensource.apple.com/source/objc4/) 的 objc-exception.mm 文件中找到。


## 参考文档

* [浅析C语言的非局部跳转：setjmp和longjmp](https://www.cnblogs.com/lienhua34/archive/2012/04/22/2464859.html)

* [setjmp和longjmp函数使用详解](https://blog.csdn.net/wykwdy007/article/details/6535322)

* [Objective-C try/catch异常处理机制原理](https://www.cnblogs.com/markhy/p/3169035.html)
