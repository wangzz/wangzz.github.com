---
layout: post
title: "如何手动解析CrashLog之----原理篇"
date: 2015-08-10 15:12:49 +0800
comments: true
categories: iOS
tags: [CrashLog, iOS]
keywords: CrashLog, iOS
description: 如何手动解析CrashLog之原理篇
---


在上篇文章[《如何手动解析CrashLog》](http://foggry.com/blog/2015/07/27/ru-he-shou-dong-jie-xi-crashlog/)里介绍了手动解析CrashLog的方法，接下来再说说`dwarfdump`、`atos`等解析工具是如何从符号表文件中获取到崩溃位置信息的。一切还得从`.dSYM`符号表文件开始说起。

## 一、`.dSYM`文件的生成
符号表文件`.dSYM`实际上是从Mach-O文件中抽取调试信息而得到的文件，其保存调试信息的格式是`DWARF`，其出身可以从苹果员工的文章[《Apple's "Lazy" DWARF Scheme》](http://wiki.dwarfstd.org/index.php?title=Apple%27s_%22Lazy%22_DWARF_Scheme)了解一二。

### 1、Xcode自动生成

Xcode会在编译工程或者归档时自动为我们生成`.dSYM`文件，当然我们也可以通过更改Xcode的若干项`Build Settings`来阻止它那么干。

### 2、手动生成

另一种方式是通过命令行从Mach-O文件中手工提取，比如：

```
$ /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/dsymutil /Users/wangzz/Library/Developer/Xcode/DerivedData/YourApp-cqvijavqbptjyhbwewgpdmzbmwzk/Build/Products/Debug-iphonesimulator/YourApp.app/YourApp -o YourApp.dSYM
```

该方式通过Xcode提供的工具`dsymutil`，从项目编译结果`.app`目录下的Mach-O文件中提取出调试符号表文件。Xcode实际上也是通过这种方式来得到符号表文件的。


<!-- more -->

## 二、`DWARF`简介

`DWARF`（DebuggingWith Arbitrary Record Formats），是ELF和Mach-O等文件格式中用来存储和处理调试信息的标准格式，`.dSYM`中真正保存符号表数据的是`DWARF`文件。`DWARF`中不同的数据都保存在相应的`section`（节）中，ELF文件里所有的section名称都以`".debug_"`开头，如下表所示：

Section Name  | Contents
------------- | -------------
.debug_abbrev  | Abbreviations used in the .debug_info section
.debug_aranges  | A mapping between memory address and compilation
.debug_frame  | Call Frame Information
.debug_info  | The core DWARF data containing DIEs
.debug_line  | Line Number Program
.debug_loc  | Macro descriptions
.debug_macinfo  | A lookup table for global objects and functions
.debug_pubnames  | A lookup table for global objects and functions 
.debug_pubtypes  | A lookup table for global types
.debug_ranges  | Address ranges referenced by DIEs
.debug_str  | String table used by .debug_info

*注 该表出自官方文档[《Introduction to the
DWARF Debugging Format》](http://www.dwarfstd.org/doc/Debugging%20using%20DWARF.pdf)

而Mach-O中关于section的命名和ELF稍有区别，把名称前的`.`换成了`_`，例如`.debug_info`变成了`_debug_info`。

## 三、section信息提取

保存在`DAWARF`中的信息是高度压缩的，可以通过`dwarfdump`命令从中提取出可读信息。前文所述的section中，定位CrashLog只需要用到`.debug_info`和`.debug_line`。由于解析出来的数据量较大，为了方便查看，就将其保存在文本中，两个section的数据提取方式如下：

* `.debug_info`

```
$ dwarfdump -e --debug-info YourPath/YourApp.dSYM/Contents/Resources/DWARF > info-e.txt
```

* `.debug_line`
 
```
$ dwarfdump -e --debug-line YourPath/YourApp.dSYM/Contents/Resources/DWARF > line-e.txt
```

命令中的`-e`可以增加解析结果的可读性；其它section的提取方式类似，详情请参考`dwarfdump`命令帮助信息。

## 四、解析崩溃地址

### 1、计算崩溃地址对应符号表中的地址

在[上篇文章](http://foggry.com/blog/2015/07/27/ru-he-shou-dong-jie-xi-crashlog/)中，介绍了如何根据崩溃地址计算得到对应符号表中的地址，并得到了最终数值：`0x52846`，接下来我们就通过这个值来介绍`dwarfdump`、`atos`等工具是如何解析崩溃日志的。

### 2、解析过程

* `.debug_info`

`.debug_info`中最基本的描述单元为DIE（Debug Information Entry），详情请参考[DWARF官方网站](http://www.dwarfstd.org/)，首先我们要根据符号表崩溃地址`0x52846`从`.debug_info`中取出包含这个地址的DIE单元。为了简单起见，直接贴出了从`info-e.txt`中取出的对应DIE，其部分内容如下：

```
0x00062112:     function [99] *
                low pc( 0x000502e0 )
                high pc( 0x00053730 )
                frame base( r7 )
                object pointer( {0x0006212a} )
                name( "-[OBDFirstConnectViewController showOilPricePickerView]" )
                decl file( "/YourSourcePath/OBDFirstConnectViewController.m" )
                decl line( 870 )
                prototyped( 0x01 )
                APPLE instruction set architecture( 0x01 )
```

可以看出，该DIE包含是方法`-[OBDFirstConnectViewController showOilPricePickerView]`的内容，其地址范围是`0x000502e0`-`0x00053730`，我们的目标地址`0x52846`正是在这个范围内，所以可以判定崩溃发生在该方法的某一行中。

需要指出的是，上面这段DIE是我为了介绍方便直接贴出来的，实际应用的时候需要通过搜索算法找出包含目标符号表崩溃地址（这里是`0x52846`）的DIE。

总结一下，通过`.debug_info`我们可以获取到这些信息：

```
崩溃所在源码文件：/YourSourcePath/OBDFirstConnectViewController.m
发生崩溃的方法：-[OBDFirstConnectViewController showOilPricePickerView]
发生崩溃的方法在源文件中的行号：870
```

* `. debug_line`

截止目前，我们可以获取到发生了崩溃的方法的相关信息，但要想确定崩溃发生的具体行号，还需要`.debug_line`的帮助。

`.debug_line`以一个方法为基本块，急了该方法中每一行对应的符号表地址。通过`.debug_info`得知崩溃发生的方法地址范围是`0x000502e0`-`0x00053730`，通过起始地址`0x000502e0`在解析`. debug_line`得到的line-e.txt中直接搜索即可得到崩溃所在方法的`. debug_line`数据，其中`部分内容`如下：

```
0x00000000000502e0    870 /YourSourcePath/OBDFirstConnectViewController.m
0x00000000000502e0      0
0x00000000000502f0    872
0x000000000005033c    873
0x0000000000050374    874
0x000000000005039e    875
0x00000000000503c8    876
...
0x0000000000052812    880
0x000000000005283e    881
0x0000000000052846    882
0x00000000000528c8    883
...
```

`. debug_line`段的第一行内容标识了该方法的起始符号表地址，行号及方法所在文件路径，通过之前得到的崩溃地址`0x52846`即可得知崩溃发生在882行。

至此我们已经根据崩溃地址完全解析出了崩溃位置的详细信息！

## 五、参考文档

* [Apple's "Lazy" DWARF Scheme](http://wiki.dwarfstd.org/index.php?title=Apple%27s_%22Lazy%22_DWARF_Scheme)
* [《Introduction to the DWARF Debugging Format》](http://www.dwarfstd.org/doc/Debugging%20using%20DWARF.pdf)

