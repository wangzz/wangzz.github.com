---
layout: post
title: "加密你的SQLite"
date: 2014-05-19 10:19:42 +0800
comments: true
categories: Database
tags: [SQLite, sqlcipher]
keywords: SQLite, sqlcipher
description: 加密你的SQLite

---


##关于SQLite

SQLite是一个`轻量的`、`跨平台的`、`开源的`数据库引擎，它的在`读写效率`、`消耗总量`、`延迟时间`和`整体简单性上`具有的优越性，使其成为移动平台数据库的最佳解决方案（如iOS、Android）。

然而`免费版`的SQLite有一个致命缺点：不支持加密。这就导致存储在SQLite中的数据可以被任何人用任何文本编辑器查看到。比如国内某团购iOS客户端的DB缓存数据就一览无余：

<img src="/images/article2/meituan_db_info.png" width="550" height="250">

<!-- more -->

##SQLite加密方式

对数据库加密的思路有两种：

* 将内容加密后再写入数据库

这种方式使用简单，在入库/出库只需要将字段做对应的加解密操作即可，一定程度上解决了将数据赤裸裸暴露的问题。

不过这种方式并不是彻底的加密，因为数据库的表结构等信息还是能被查看到。另外写入数据库的内容加密后，搜索也是个问题。

* 对数据库文件加密

将整个数据库整个文件加密，这种方式基本上能解决数据库的信息安全问题。目前已有的SQLite加密基本都是通过这种方式实现的。

##SQLite加密工具

目前网上查询到iOS平台可用的SQLite加密工具有以下几种：

1. [SQLite Encryption Extension (SEE)](http://www.sqlite.org/index.html)
	
	事实上SQLite有加解密接口，只是免费版本没有实现而已。而`SQLite Encryption Extension (SEE)`是SQLite的加密版本，提供以下加密方式：
	
	```
	RC4
	AES-128 in OFB mode
	AES-128 in CCM mode
	AES-256 in OFB mode
	```
	`SQLite Encryption Extension (SEE)`版本是收费的，本文发布时其售价高达2000美刀！
	
2. [SQLiteEncrypt](http://www.sqlite-encrypt.com/index.htm)

	使用`AES`方式加密，其原理是实现了开源免费版SQLite没有实现的加密相关接口。
	
	`SQLiteEncrypt`是收费的，本文发布时售价89.95美刀。

3. [SQLiteCrypt](http://sqlite-crypt.com/index.htm)

	使用`256-bit AES`方式加密，其原理和[SQLiteEncrypt](http://www.sqlite-encrypt.com/index.htm)一样，都是实现了SQLite的加密相关接口。
	
	`SQLiteCrypt`也是收费的，本文发布时售价128美刀。
	
4. [SQLCipher](http://sqlcipher.net/)
	
	首先需要说明的是，`SQLCipher`是完全开源的，代码托管在[github](https://github.com/sqlcipher/sqlcipher)上。
	
	`SQLCipher`使用`256-bit AES`方式加密，由于其基于免费版的SQLite，主要的加密接口和SQLite是相同的，但也增加了一些自己的接口，详情见[这里](http://sqlcipher.net/sqlcipher-api/)
	
	`SQLCipher`分为收费版本和免费版本，本文发布时收费版本iOS平台每个开发者售价499美刀。照官网的说法，收费版本和免费版本的区别：
	
	```
	1. easier to setup, saving many steps in project configuration
	2. pre-built with a modern version of OpenSSL, avoiding another external 	dependency
	3. much faster for each build cycle because the library doesn't need to be 	built from scratch on each compile (build time can be up to 95% faster 	with the static libraries)
	```
	只是集成起来更简单，不用再添加`OpenSSL`依赖库，而且编译速度更快，从功能上来说没有任何区别。仅仅为了上述一点便利去花费499美刀，对于我等苦逼RD来说太不值了，还好有一个免费版本。

鉴于上述SQLite加密工具中，只有`SQLCiper`有免费版本，下面将将着重介绍下`SQLCiper`。
	
##SQLCipher

本节主要介绍如何在项目中集成`SQLCipher`。


未完待续...



##参考文档

* [The SQLite Encryption Extension (SEE)](http://www.hwaci.com/sw/sqlite/see.html)

* [SQLiteEncrypt](http://www.sqlite-encrypt.com/index.htm)

* [SQLiteCrypt](http://sqlite-crypt.com/index.htm)

* [SQLite with encryption/password protection](http://stackoverflow.com/questions/5669905/sqlite-with-encryption-password-protection)

* [SQLCipher](http://sqlcipher.net/documentation/)



