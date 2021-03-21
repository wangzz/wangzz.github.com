---
title: JS 定时器
date: 2021-03-14 16:13:06
tags: [JavaScript]
---

## 介绍

JS 有两种计时器方法：

| 方法                      | 描述                                                   |
| ------------------------- | ------------------------------------------------------ |
| setTimeout(fun,millisec)  | 在指定的延迟时间之后调用一个函数或者执行一个代码片段。 |
| clearTimeout(timerID)     | 方法可取消由 setTimeout() 方法设置的 timeout。         |
| setInterval(fun,millisec) | 周期性地调用一个函数(function)或者执行一段代码。       |
| clearInterval(timerID)    | 取消掉用setInterval设置的重复执行动作。                |

* setTimeout

用来指定某个函数或字符串在指定的毫秒数后执行一次；它返回一个整数，表示定时器的编号，这个编号可以传递给 clearTimeout() 用于取消这个函数的执行。

<!-- more -->

```
let pollingFunction = () => {
  console.log('pollingFunction');
};

pollingFunction.apply(this);
this.pollingTimer = setTimeout(pollingFunction.bind(this), this.pollingDuring);
```

如果省略第二个时间参数，则默认值为 0。

* clearTimeout

```
if (this.pollingTimer) {
  clearTimeout(this.pollingTimer);
  this.pollingTimer = null;
}
```

* setInterval

和 setTimeout() 用法完全一致，区别是会循环执行直到被 clearInterval() 取消。

```
let pollingFunction = () => {
  console.log('pollingFunction');
};

pollingFunction.apply(this);
this.pollingTimer = setInterval(pollingFunction.bind(this), this.pollingDuring);
```

* clearInterval

```
if (this.pollingTimer) {
  clearInterval(this.pollingTimer);
  this.pollingTimer = null;
}
```

## 最小时间间隔

HTML5 标准规定，setTimeout() 的最短时间间隔是 4 毫秒；setInterval() 的最短时间间隔是 10 毫秒。

## this 指向

由于定时器对应函数中的 this 存在[隐式丢失](https://www.cnblogs.com/xiaohuochai/p/5735901.html#anchor3) 的情况，极易出错，比如：

```
var a = 0;
function foo(){
    console.log(this.a);
};
var obj = {
    a : 2,
    foo:foo
}
setTimeout(obj.foo,100); // 0
```

要想获得 obj 对象中的 a 属性值，可以将 obj.foo 函数进行[隐式绑定](https://www.cnblogs.com/xiaohuochai/p/5735901.html#anchor2)：

```
var a = 0;
function foo(){
    console.log(this.a);
};
var obj = {
    a : 2,
    foo:foo
}
setTimeout(function(){
    obj.foo();
},100); // 2
```

或者也可以使用 bind() 方法将 foo() 方法的 this 绑定到 obj 对象上：

```
var a = 0;
function foo(){
    console.log(this.a);
};
var obj = {
    a : 2,
    foo:foo
}
setTimeout(obj.foo.bind(obj),100); // 2
```

## 参考文档

* [深入理解定时器系列第一篇——理解setTimeout和setInterval](https://www.cnblogs.com/xiaohuochai/p/5773183.html)