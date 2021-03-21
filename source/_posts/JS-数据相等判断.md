---
title: JS 数据相等判断
date: 2021-03-12 23:17:40
tags: [JavaScript]
---

## 相等判断分类

* 非严格比较 == 和 != 

比较若类型不同，先偿试转换类型，再作值比较，最后返回值比较结果 。


* 严格比较 === 和 !== 

只有在相同类型下,才会比较其值；类型不同直接返回 false。


* 严格比较 [Object.is](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/is)

[Object.is](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/is) 的行为方式与三等号相同，只在 NaN 以及 -0 和 +0 对比时有区别，详情见下面的对照表。

<!-- more -->

## 对照表

| x                 | y                 | ==    | ===   | [Object.is](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/is) |
| ----------------- | ----------------- | ----- | ----- | ------------------------------------------------------------ |
| undefined         | undefined         | true  | true  | true                                                         |
| null              | null              | true  | true  | true                                                         |
| true              | true              | true  | true  | true                                                         |
| false             | false             | true  | true  | true                                                         |
| "foo"             | "foo"             | true  | true  | true                                                         |
| 0                 | 0                 | true  | true  | true                                                         |
| +0                | -0                | true  | true  | false                                                        |
| 0                 | false             | true  | false | false                                                        |
| ""                | false             | true  | false | false                                                        |
| ""                | 0                 | true  | false | false                                                        |
| "0"               | 0                 | true  | false | false                                                        |
| "17"              | 17                | true  | false | false                                                        |
| [1,2]             | "1,2"             | true  | false | false                                                        |
| new String("foo") | "foo"             | true  | false | false                                                        |
| null              | undefined         | true  | false | false                                                        |
| null              | false             | false | false | false                                                        |
| undefined         | false             | false | false | false                                                        |
| { foo: "bar" }    | { foo: "bar" }    | false | false | false                                                        |
| new String("foo") | new String("foo") | false | false | false                                                        |
| 0                 | null              | false | false | false                                                        |
| 0                 | NaN               | false | false | false                                                        |
| "foo"             | NaN               | false | false | false                                                        |
| NaN               | NaN               | false | false | true                                                         |

## 类型转换

JavaScript 是弱类型语言，所以会在任何可能的情况下应用强制类型转换。

```
// 下面的比较结果是：true
new Number(10) == 10; // Number.toString() 返回的字符串被再次转换为数字
10 == '10';           // 字符串被转换为数字
10 == '+10 ';         // 同上
10 == '010';          // 同上 
isNaN(null) == false; // null 被转换为数字 0，0 当然不是一个 NaN（译者注：否定之否定）

// 下面的比较结果是：false
10 == 010;
10 == '-10';
```

为了避免上面复杂的强制类型转换，强烈推荐使用严格的等于操作符。

* 内置类型的构造函数

内置类型（比如 Number 和 String）的构造函数在被调用时，使用或者不使用 new 的结果完全不同。

```
new Number(10) === 10;     // False, 对象与数字的比较
Number(10) === 10;         // True, 数字与数字的比较
new Number(10) + 0 === 10; // True, 由于隐式的类型转换
```

使用内置类型 Number 作为构造函数将会创建一个新的 Number 对象， 而在不使用 new 关键字的 Number 函数更像是一个数字转换器。

## 参考文档

* [JavaScript 中的相等性判断](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Equality_comparisons_and_sameness)

* [你可能忽略的 js 类型转换](https://juejin.im/post/5b076c006fb9a07aa43c9fda)

* [Javascript 数据类型转换规则](https://www.cnblogs.com/wangmeijian/p/4639112.html)