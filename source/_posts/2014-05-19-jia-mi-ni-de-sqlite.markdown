---
layout: post
title: "加密你的SQLite"
date: 2014-05-19 10:19:42 +0800
comments: true
categories: Database
tags: [SQLite, sqlcipher]
keywords: SQLite, sqlcipher
---


##关于SQLite

SQLite是一个`轻量的`、`跨平台的`、`开源的`数据库引擎，它的在`读写效率`、`消耗总量`、`延迟时间`和`整体简单性上`具有的优越性，使其成为移动平台数据库的最佳解决方案（如iOS、Android）。

然而免费版的SQLite有一个致命缺点：不支持加密。这就导致存储在SQLite中的数据可以被任何人用任何文本编辑器查看到。比如国内某团购iOS客户端的DB缓存数据就一览无余：

<img src="/images/article2/meituan_db_info.png" width="700" height="300">

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

* [SQLite Encryption Extension (SEE)](http://www.sqlite.org/index.html)
	
事实上SQLite有加解密接口，只是免费版本没有实现而已。而`SQLite Encryption Extension (SEE)`是SQLite的加密版本，提供以下加密方式：
	
```
RC4
AES-128 in OFB mode
AES-128 in CCM mode
AES-256 in OFB mode
```

SQLite Encryption Extension (SEE)版本是收费的。

	
* [SQLiteEncrypt](http://www.sqlite-encrypt.com/index.htm)

使用AES加密，其原理是实现了开源免费版SQLite没有实现的加密相关接口。
	
`SQLiteEncrypt`是收费的。

* [SQLiteCrypt](http://sqlite-crypt.com/index.htm)

使用256-bit AES加密，其原理和[SQLiteEncrypt](http://www.sqlite-encrypt.com/index.htm)一样，都是实现了SQLite的加密相关接口。
	
`SQLiteCrypt`也是收费的。
	
* [SQLCipher](http://sqlcipher.net/)
	
首先需要说明的是，`SQLCipher`是完全开源的，代码托管在[github](https://github.com/sqlcipher/sqlcipher)上。
	
`SQLCipher`使用256-bit AES加密，由于其基于免费版的SQLite，主要的加密接口和SQLite是相同的，但也增加了一些自己的接口，详情见[这里](http://sqlcipher.net/sqlcipher-api/)。
	
`SQLCipher`分为收费版本和免费版本，官网介绍的区别为：
	
```
easier to setup, saving many steps in project configuration
pre-built with a modern version of OpenSSL, avoiding another external dependency
much faster for each build cycle because the library doesn't need to be built from scratch on each compile (build time can be up to 95% faster with the static libraries)
```

只是集成起来更简单，不用再添加`OpenSSL`依赖库，而且编译速度更快，从功能上来说没有任何区别。仅仅为了上述一点便利去花费几百美刀，对于我等苦逼RD来说太不值了，还好有一个免费版本。

鉴于上述SQLite加密工具中，只有`SQLCiper`有免费版本，下面将将着重介绍下`SQLCiper`。
	
##在项目中使用SQLCipher

在项目中集成免费版的`SQLCipher`略显复杂，还好官网以图文的方式介绍的非常详细，集成过程请参考[官网教程](http://sqlcipher.net/ios-tutorial)。

* 使用SQLCipher初始化数据库

下面这段代码来自官网，其作用是使用SQLCipher创建一个新的加密数据库，或者打开一个使用SQLCipher创建的数据库。

```
NSString *databasePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
                              stringByAppendingPathComponent: @"cipher.db"];
    sqlite3 *db;
    if (sqlite3_open([databasePath UTF8String], &db) == SQLITE_OK) {
        const char* key = [@"BIGSecret" UTF8String];
        sqlite3_key(db, key, strlen(key));
        int result = sqlite3_exec(db, (const char*) "SELECT count(*) FROM sqlite_master;", NULL, NULL, NULL);
        if (result == SQLITE_OK) {
            NSLog(@"password is correct, or, database has been initialized");
        } else {
            NSLog(@"incorrect password! errCode:%d",result);
        }
        
        sqlite3_close(db);
    }
    
```

需要注意的是，在使用`sqlite3_open`打开或创建一个数据库，在对数据库做任何其它操作之前，都必须先使用`sqlite3_key`输入密码，否则会导致数据库操作失败，报出sqlite错误码`SQLITE_NOTADB`。

在`sqlite3_open`打开数据库成功，而且用`sqlite3_key`输入密码以后，就可以正常的对数据库进行增、删、改、查等操作了。


* 使用SQLCipher加密已存在的数据库

SQLCipher提供了`sqlcipher_export()`函数，该函数可以方便的对一个普通数据库导入到SQLCipher加密加密的数据库中，操作方式如下：

```
$ ./sqlcipher plaintext.db 
sqlite> ATTACH DATABASE 'encrypted.db' AS encrypted KEY 'testkey'; 
sqlite> SELECT sqlcipher_export('encrypted'); 
sqlite> DETACH DATABASE encrypted; 
```


* 解除使用SQLCipher加密的数据库密码

`sqlcipher_export()`函数同样可以将SQLCipher加密后的数据库内容导入到未加密的数据库中，从而实现解密，操作方式如下：

```
$ ./sqlcipher encrypted.db 
sqlite> PRAGMA key = 'testkey'; 
sqlite> ATTACH DATABASE 'plaintext.db' AS plaintext KEY '';  -- empty key will disable encryption
sqlite> SELECT sqlcipher_export('plaintext'); 
sqlite> DETACH DATABASE plaintext; 
```


总体来说，SQLCipher是一个使用方便，灵活性高的数据库加密工具。

另外，我写了个[SQLCipherDemo](http://download.csdn.net/detail/wzzvictory_tjsd/7379055)工程放到了[CSDN](http://download.csdn.net/detail/wzzvictory_tjsd/7379055)上，有需要的同学请自行下载。


##参考文档

* [The SQLite Encryption Extension (SEE)](http://www.hwaci.com/sw/sqlite/see.html)

* [SQLiteEncrypt](http://www.sqlite-encrypt.com/index.htm)

* [SQLiteCrypt](http://sqlite-crypt.com/index.htm)

* [SQLite with encryption/password protection](http://stackoverflow.com/questions/5669905/sqlite-with-encryption-password-protection)

* [SQLCipher](http://sqlcipher.net/documentation/)



