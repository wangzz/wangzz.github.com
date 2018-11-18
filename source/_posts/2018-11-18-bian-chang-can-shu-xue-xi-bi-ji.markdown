---
layout: post
title: "变长参数学习笔记"
date: 2018-11-18 19:23:45 +0800
comments: true
categories: C语言
tags: [C语言, va_list,va_arg,va_end,变长参数,printf]
keywords: C语言, va_list,va_arg,va_end,变长参数,printf
---

## 1、简介

在定义接口时，经常会遇到参数个数甚至类型都不确定的情况。这时，在类 C 语言中我们可以使用省略号指定参数表，具体形式如下：

```
void fun(parm1,parm2,...);
```

这种传参形式被称为 `变长参数`。C 语言中的：

```
int printf(const char * format, ...)
```

便是两个最经典的例子。对于固定参数列表的函数，每个参数的名称、类型是直接可见的，他们的地址和值也可以直接得到。但是对于变长参数的函数，该如何获取这些信息呢？

<!-- more -->

## 2、实现原理

函数的参数在内存中是以从右到左的顺序依次存放在栈中，最右侧的参数最先入栈，最左边的参数最后入栈，比如：

```
void func(int x, float y, char z);
```

在发生函数调用的时候，形参 z 先进栈，然后是 y，最后是 x，最终在内存中几个变量的存放次序是 x->y->z。

按照 C 标准，支持变长参数的函数声明中，必须至少在最左侧有一个固定参数。根据前文所述，形参在内存中是存放在栈中，而且顺序是连续的。因此，有了最左侧的 `固定参数` 和 `可变参数的类型`，我们就能获取到所有的可变参数的地址和值。


## 3、变长参数获取

#### 3.1 获取

在 C 语言中 `<stdarg.h>` 文件中定义了几个用于获取变长参数的宏：

* va_list

```
typedef char* va_list;
```

va_list 是一个字符指针，可以理解为指向当前参数的一个指针，所有对变长参数的获取都需要通过这个指针进行。因此，在获取变长参数之前，需要先定义一个 va_list 类型的变量，比如叫 `ap`。

* va_start

```
void va_start(va_list ap, param);
```

`ap` 定义好了后，需要通过 va_start 初始化，让它指向变长参数列表中的第一个。该函数的第一个参数就是前面定义好的 `ap`，第二个参数则是变长参数表前面紧挨着的变量（即 `...` 之前的那个）。


* va_arg

```
type va_arg(va_list ap, type);
```

接下来便可以通过 va_arg 来按顺序获取变长参数列表中的每一个参数。该方法第一个参数是 `ap`，第二个参数是当前要获取的变长参数的类型；该方法的返回值便是当前要获取的参数值；每调用一次以后，便把 `ap` 指向了下一个变量的位置。

* va_end

```
void va_end(va_list ap);
```

全部参数获取结束以后，需要调用 va_end 把 `ap` 指针关掉，以保证程序健壮性。因此，通常 va_start 和 va_end 是成对出现。

#### 3.2 内部实现

在 VC++ 的 <stdarg.h> 里， x86 平台的上述宏定义实现如下 ：

```
typedef char * va_list;
#define _INTSIZEOF(n) \
((sizeof(n)+sizeof(int)-1)&~(sizeof(int) - 1) )
#define va_start(ap,v) ( ap = (va_list)&v + _INTSIZEOF(v) )
#define va_arg(ap,t) \
( *(t *)((ap += _INTSIZEOF(t)) - _INTSIZEOF(t)) )
#define va_end(ap) ( ap = (va_list)0 )
```

其中，_INTSIZEOF 的实现方式时为了保证获取到的大小是 int 的整数倍。其它的宏实现就比较容易理解了。

## 4、变长参数应用

我们可以写一个简单版的 printf 来展示该方法的实现原理和变长参数的获取方法：

```
void mineprintf(char *fmt, ...)
{
    va_list ap;
    char *p, *sval;
    int ival;
    double dval;
    
    va_start(ap, fmt);
    for (p = fmt; *p; p++) {
        if (*p != '%') {
            putchar(*p);
            continue;
        }
        
        switch (*++p) {
            case 'd':
                ival = va_arg(ap, int);
                printf("%d",ival);
                break;
            case 'f':
                dval = va_arg(ap, double);
                printf("%f",dval);
                break;
            case 's':
                for (sval = va_arg(ap, char *); *sval; sval++) {
                    putchar(*sval);
                }
                break;
            default:
                putchar(*p);
                break;
        }
    }
    va_end(ap);
}
```

## 参考文档

* C程序设计语言（第2版）K&R

* [Implementation of __builtin_va_start(v,l)](https://stackoverflow.com/a/22643365)
