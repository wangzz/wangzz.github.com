---
title: JS Module 语法
date: 2021-03-13 13:21:02
tags: [JavaScript]
---

## 概述

ES6 之前，社区定制了一些模块加载方案，最主要的有 `CommonJS` 和 `AMD` 两种。前者用于 node 服务器，后者用于浏览器。ES6 在语言标准的层面上实现了模块功能，而且相对简单，完全可以取代 `CommonJS` 和 `AMD` 规范，成为浏览器和服务器的通用模块解决方案。

ES6 的模块设计思想是尽量的静态化，使得编译时就能嫩嫩个确定模块的依赖关系，以及输入输出的变量。而 `CommonJS` 和 `AMD` 则都是在运行时确定这些东西，导致没办法在编译时做静态优化。

## 严格模式

ES6 的模块自动采用严格模式，不管有没有在模块头部加上 'use strict'。

详情见：[严格模式和非严格模式](https://note.youdao.com/ynoteshare1/index.html?id=f93d14cbaff8ab54343e375f5b27b4be&type=note)

<!-- more -->

## export 命令

模块功能主要由两个命令组成：export 和 import。export 用于定义模块对外暴露的接口，import 用于输入其它模块提供的接口。

* export 基本用法

一个模块就是`一个独立的文件`。该文件内部的所有变量、方法和类型外部默认都无法获取，必须通过 export 关键字输出以后才能在外部使用。下面两种写法都可以：

```
// profile.js
export var firstName = 'Michael';
export var lastName = 'Jackson';
export var year = 1958;

export function multiply(x, y) {
  return x * y;
};

export class ClassName {
    
}

```

或者：

```
// profile.js
var firstName = 'Michael';
var lastName = 'Jackson';
var year = 1958;

function multiply(x, y) {
  return x * y;
};

 class ClassName {
    
}

export { firstName, lastName, year, multiply, ClassName };
```

推荐使用后面这种写法，这样就可以在文件底部一眼看清楚输出了哪些变量。

* export as

export 输出的变量默认就是本来的名字，但也可以使用 as 关键字重命名：

```
export {
  v1 as streamV1,
  v2 as streamV2,
  v2 as streamLatestVersion
};
```

* export 对外接口要合内部变量一一对应

下面的写法会报错：

```
// 报错
export 1;

// 报错
var m = 1;
export m;
```

正确的写法是下面这样：

```
// 写法一
export var m = 1;

// 写法二
var m = 1;
export {m};

// 写法三
var n = 1;
export {n as m};
```

* export 输出的接口与对应的值动态绑定

如果模块内修改了 export 输出的变量，外部获取到的值也会更新。

而 `CommonJS` 输出的值是缓存，不存在动态更新。

* export 可以放在模块顶层的任何位置

只要别放在块级作用域内，可以放在文件顶层作用域的任何位置。

后面的 import 也是一样。

## import

* 基本用法

使用 export 定义了模块的对外接口以后，其它 JS 文件就可以通过 import 加载这个模块了：

```
// main.js
import { firstName, lastName, year } from './profile.js';

function setName(element) {
  element.textContent = firstName + ' ' + lastName;
}
```

* 重命名 export 定义的名称

import 也可以像 export 一样使用 as 关键字：

```
import { lastName as surname } from './profile.js';
```

* import 输入的变量都是只读的

```
import {a} from './xxx.js'

a = {}; // Syntax Error : 'a' is read-only;
```

但如果 a 是一个对象，修改 a 的属性是可以的：

```
import {a} from './xxx.js'

a.foo = 'hello'; // 合法操作
```

* 通过 import 执行所加载的模块

```
import 'lodash';
```

上面的代码仅仅执行了 loadash 模块，但你不输入任何值。

多次重复执行同一个 import 语句只会执行一次：

```
import 'lodash';
import 'lodash';
```

下面的写法：

```
import { foo } from 'my_module';
import { bar } from 'my_module';

// 等同于
import { foo, bar } from 'my_module';
```

## 模块的整体加载

可以使用 `*` 指定一个对象，将模块的所有输出值都加载在这个对象上面：

```
// circle.js

export function area(radius) {
  return Math.PI * radius * radius;
}

export function circumference(radius) {
  return 2 * Math.PI * radius;
}
```

整体加载用法：

```
import * as circle from './circle';

console.log('圆面积：' + circle.area(4));
console.log('圆周长：' + circle.circumference(14));
```

但整体对象的属性是不能修改的，所以下面的写法都会报错：

```
import * as circle from './circle';

// 下面两行都是不允许的
circle.foo = 'hello';
circle.area = function () {};
```

## export default

* 基本用法

前面的例子可以看出，使用 import 命令的时候，用户需要知道索要加载的变量名和函数名。而 export default 命令可以为模块指定默认输出：

```
// export-default.js
export default function () {
  console.log('foo');
}
```

使用的时候可以使用 import 命令为匿名函数指定任意名字：

```
// import-default.js
import customName from './export-default';
customName(); // 'foo'
```

* export default 输出的变量 import 时不需要用大括号

比如：

```
// 第一组
export default function crc32() { // 输出
  // ...
}

import crc32 from 'crc32'; // 输入
```

* 一个文件只能有一个 export default

* export default 的本质

export default 其实就是输出一个叫做 default 的变量或方法，然后系统允许你为它取任意名字。所以，下面的写法是有效的。

```
// modules.js
function add(x, y) {
  return x * y;
}
export {add as default};
// 等同于
// export default add;

// app.js
import { default as foo } from 'modules';
// 等同于
// import foo from 'modules';
```

## 模块的继承

假设有一个 circleplus 模块，继承 circle 模块，可以这么写：

```
// circleplus.js

export * from 'circle';
export var e = 2.71828182846;
export default function(x) {
  return Math.exp(x);
}
```

这样外面使用 circleplus 的时候就可以直接使用 circle 开放的内容。

## 参考文档

* [Module 的语法](http://es6.ruanyifeng.com/#docs/module)