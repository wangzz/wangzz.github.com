---
title: JS Object.assign 学习笔记
date: 2021-01-2 20:35:01
tags: [JavaScript]
---

## 语法

```
Object.assign(target, ...sources);
```

该方法用于将一个或多个源对象的 `所有可枚举属性值` 复制到目标对象。

返回值就是 target 对象。

## 内部实现

```
if (!Object.assign) {
    // 定义assign方法
  Object.defineProperty(Object, 'assign', {
    enumerable: false,
    configurable: true,
    writable: true,
    value: function(target) { // assign方法的第一个参数
      'use strict';
      // 第一个参数为空，则抛错
      if (target === undefined || target === null) {
        throw new TypeError('Cannot convert first argument to object');
      }
 
      var to = Object(target);
      // 遍历剩余所有参数
      for (var i = 1; i < arguments.length; i++) {
        var nextSource = arguments[i];
        // 参数为空，则跳过，继续下一个
        if (nextSource === undefined || nextSource === null) {
          continue;
        }
        nextSource = Object(nextSource);
 
        // 获取改参数的所有key值，并遍历
        var keysArray = Object.keys(nextSource);
        for (var nextIndex = 0, len = keysArray.length; nextIndex < len; nextIndex++) {
          var nextKey = keysArray[nextIndex];
          var desc = Object.getOwnPropertyDescriptor(nextSource, nextKey);
          // 如果不为空且可枚举，则直接浅拷贝赋值
          if (desc !== undefined && desc.enumerable) {
            to[nextKey] = nextSource[nextKey];
          }
        }
      }
      return to;
    }
  });
}
```

<!-- more -->

## 示例

* 合并多个源对象的属性到目标对象

```
// Merging objects
var o1 = { a: 1 };
var o2 = { b: 2 };
var o3 = { c: 3 };
 
var obj = Object.assign({}, o1, o2, o3);
console.log(obj); // { a: 1, b: 2, c: 3 }
```

* 目标对象的属性值会被源对象同名属性值覆盖，哪怕二者类型不同

```
var sourceObj = {
    name:"sourceObj",
    time : {
        year:"2019",
        month:"1"
    }
}

var targetObj = {
    name:"targetObj",
    time : "2020.1"
};

Object.assign(targetObj, sourceObj)
console.log(targetObj)
```

输出为：

```
{
    name:"sourceObj",
    time : {
        year:"2019",
        month:"1"
    }
}
```

* 合并属性时的浅拷贝和深拷贝

如果对象的属性值为简单类型（string， number），通过 Object.assign({},srcObj); 得到的新对象为‘深拷贝’；

如果属性值为对象或其它引用类型，那对于这个对象而言其实是浅拷贝的。这是Object.assign()特别值得注意的地方。 

```
var sourceObj = {
    name:"sourceObj",
    time : {
        year:"2019",
        month:"1"
    }
}

var targetObj = {
    name:"targetObj",
    time : {
        year:"2020",
        month:"1"
    }
};

Object.assign(targetObj, sourceObj)

sourceObj.name = "newSourceObj"
sourceObj.time.year = "new2019"

console.log(targetObj)
```

输出为：

```
{
    name:"sourceObj",
    time : {
        year:"new2019",
        month:"1"
    }
}
```

## 完全深拷贝

一个可以简单实现深拷贝的方法，当然，有一定限制，如下：

```
const obj1 = JSON.parse(JSON.stringify(obj));
```

思路就是将一个对象转成 json 字符串，然后又将字符串转回对象。