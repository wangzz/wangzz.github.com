---
title: JS 三个点运算符
date: 2021-01-21 13:29:31
tags: [JavaScript]
---

## 普通对象的扩展运算符

理解对象的扩展运算符其实很简单，只要记住一句话就可以：

> 对象中的扩展运算符(...)用于取出参数对象中的所有可遍历属性，拷贝到当前对象之中

```
let bar = { a: 1, b: 2 };
let baz = { ...bar }; // { a: 1, b: 2 }
```

上述方法实际上等价于:

```
let bar = { a: 1, b: 2 };
let baz = Object.assign({}, bar); // { a: 1, b: 2 }
```

<!-- more -->

## 数组的扩展运算符

扩展运算符同样可以运用在对数组的操作中，不过有了更多特别的用法。

* 复制数组元素到另一个数组

```
const arr1 = [1, 2];
const arr2 = [...arr1];
```

不过需要注意只有基本数值元素是深拷贝，其它元素都是浅拷贝。

* 可以将数组转换为方法调用的参数列表

它好比 rest 参数的逆运算，将一个数组转为用逗号分隔的参数序列。

```
function add(x, y) {
  return x + y;
}

const numbers = [4, 38];
add(...numbers) // 42
```

* 与解构赋值结合起来，用于生成数组

```
const [first, ...rest] = [1, 2, 3, 4, 5];
first // 1
rest  // [2, 3, 4, 5]
```

需要注意的一点是：

> 如果将扩展运算符用于数组赋值，只能放在参数的最后一位，否则会报错。

```
const [...rest, last] = [1, 2, 3, 4, 5];
// 报错
const [first, ...rest, last] = [1, 2, 3, 4, 5];
// 报错
```

* 将字符串转为真正的数组

```
[...'hello']
// [ "h", "e", "l", "l", "o" ]
```

* 任何 Iterator 接口的对象（参阅 Iterator 一章），都可以用扩展运算符转为真正的数组

## 参考文档

[ECMAScript 6 入门](http://es6.ruanyifeng.com/?search=map&x=0&y=0#docs/array)