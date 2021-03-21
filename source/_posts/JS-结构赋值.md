---
title: JS 结构赋值
date: 2021-03-15 13:24:38
tags: [JavaScript]
---

## 简介

结构是一种打破数据结构，将其分拆为更小部分的过程。它可以方便我们有组织地从对象或数组中提取感兴趣的信息片段，是 ES6 新增加的特性。

## 对象解构

* 解构声明

将对象解构用于变量声明的用法如下：

```
let node = {
    type: "Identifier",
    name: "foo"
};
let { type, name } = node;
console.log(type); // "Identifier"
console.log(name); // "foo"
```

* 解构赋值

变量赋值使用解构语法：

<!-- more -->

```
let node = {
    type: "Identifier",
    name: "foo"
},
type = "Literal",
name = 5;
// 使用解构来分配不同的值
({ type, name } = node);
console.log(type); // "Identifier"
console.log(name); // "foo"
```

注意，一定要用小括号包裹结构赋值语句。因为 JS 引擎将一对开放的花括号视为一个代码块，而代码块不允许出现在赋值语句左侧，而添加小括号后可以将块语句转化为一个表达式，从而实现解构赋值。

另外，`解构表达式的值与表达式右侧，也就是 "=" 右侧的值相等`。比如：

```
function outputInfo(value) {
    console.log(value === node); // true
}
outputInfo({ type, name } = node);
```

上面的代码等于将 node 作为实参传入了 outputInfo 接口。

但如果结构表达式的值为 null 或 undefined 时，会抛出错误。也就是说，`任何尝试读取 null 或 undefined 属性的行为都会触发运行时错误`。

* 解构默认值

使用解构时，如果指定的局部变量名称在对象中不存在，这个局部变量就会被赋值成 undefined：

```
let node = {
    type: "Identifier",
    name: "foo"
};
let { type, name, value } = node;
console.log(type); // "Identifier"
console.log(name); // "foo"
console.log(value); // undefined
```

而当指定的属性不存在时，可以通过如下方式定义默认值：

```
let node = {
    type: "Identifier",
    name: "foo"
};
let { type, name, value = true } = node;
console.log(type); // "Identifier"
console.log(name); // "foo"
console.log(value); // true
```

* 非同名局部变量赋值

如果想使用不同命名的局部变量来存储对象属性的值，可以通过下面的扩展语法满足需求：

```
let node = {
    type: "Identifier",
    name: "foo"
};
let { type: localType, name: localName } = node;
console.log(localType); // "Identifier"
console.log(localName); // "foo"
```

其中 type 和 name 是对象中的属性，localType 和 localName 是想要新赋值的变量名。

当然，使用其它变量名赋值时，也可以添加默认值：

```
let node = {
    type: "Identifier"
};
let { type: localType, name: localName = "bar" } = node;
console.log(localType); // "Identifier"
console.log(localName); // "bar"
```

* 嵌套对象解构

可以通过嵌套对象解构来从一个对象的内嵌对象中获取数据：

```
let node = {
    type: "Identifier",
    name: "foo",
    loc: {
        start: {
            line: 1,
            column: 1
        },
    end: {
        line: 1,
        column: 4
    }
}
};
let { loc: { start }} = node;
console.log(start.line); // 1
console.log(start.column); // 1
```

* 嵌套对象解构中的默认值写法

用下面方式解构，会抛出异常：

```
const node = {};
const { loc: { name } } = node;
```

因为 node 对象中没有 loc，因此 loc 的值是 undefined；此时再从 loc 中解构 name 就会抛出下面的异常：

```
Uncaught TypeError: Cannot read property 'value' of undefined
```

为了解决这种问题，可以结合前面说过的解构默认值来方便地编码同时不会抛异常：

```
const node = {};
const { loc: { name } = {} } = node;
```

此时如果 node 中没有 loc 属性，loc 的默认值就会是空对象，从空对象中解构出的 name 值是 undefined。当然同样的道理，也可以给 name 指定一个默认值。

## 数组解构

* 解构声明

与对象解构相比，数组结构就简单多了：

```
let colors = [ "red", "green", "blue" ];
let [ firstColor, secondColor ] = colors;
console.log(firstColor); // "red"
console.log(secondColor); // "green"
```

在数组解构语法中，我们可以通过值在数组中的位置进行选取，未显式声明的元素都将被忽略，比如上例中的 "blue"。

也可以直接省略元素，只为感兴趣的元素提供变量名：

```
let colors = [ "red", "green", "blue" ];
let [ , , thirdColor ] = colors;
console.log(thirdColor); // "blue"
```

* 解构赋值

数组解构也可以用于变量赋值，只是因为没有大括号代码块，所以不需要用小括号包裹表达式：

```
let colors = [ "red", "green", "blue" ],
firstColor = "black",
secondColor = "purple";
[ firstColor, secondColor ] = colors;
console.log(firstColor); // "red"
console.log(secondColor); // "green"
```

* 变量交换

变量交换是数组解构的独特用法，可以让我们不需要定义额外的中间变量就能实现互换两个变量的值：

```
// 在 ES6 中互换值
let a = 1,
    b = 2;
[ a, b ] = [ b, a ];
console.log(a); // 2
console.log(b); // 1
```

* 解构默认值

也可以在数组解构表达式中为数组中的任意位置变量添加默认值，当对应位置的变量不存在或值为 undefined 时使用默认值：

```
let colors = [ "red" ];
let [ firstColor, secondColor = "green" ] = colors;
console.log(firstColor); // "red"
console.log(secondColor); // "green"
```

* 嵌套数组解构

与嵌套对象解构语法类似：

```
let colors = [ "red", [ "green", "lightgreen" ], "blue" ];
// 随后
let [ firstColor, [ secondColor ] ] = colors;
console.log(firstColor); // "red"
console.log(secondColor); // "green"
```

* 不定元素解构

可以通过 `...` 语法将数组中的其余元素赋值给一个特定变量：

```
let colors = [ "red", "green", "blue" ];
let [ firstColor, ...restColors ] = colors;
console.log(firstColor); // "red"
console.log(restColors.length); // 2
console.log(restColors[0]); // "green"
console.log(restColors[1]); // "blue"
```

* 数组复制

在 ES5 中，开发者常用 `contact()` 方法来克隆数组：

```
// 在 ES5 中克隆数组
var colors = [ "red", "green", "blue" ];
var clonedColors = colors.concat();
console.log(clonedColors); //"[red,green,blue]"
```

`contact()` 方法的设计初衷是连接两个数组，但如果调用时不传递参数就会返回当前数组的拷贝。

在 ES6 中可以通过不定元素的语法来实现相同的目标：

```
// 在 ES6 中克隆数组
let colors = [ "red", "green", "blue" ];
let [ ...clonedColors ] = colors;
console.log(clonedColors); //"[red,green,blue]"
```

注意，在被解构数组中，不定元素必须为最后一个条目，如果在后面继续添加逗号会抛出语法错误。


## 字符串解构

可以将字符串解构成数组对象：

```
const [a, b, c, d, e] = 'hello';
console.log(a);//"h"
console.log(b);//"e"
console.log(c);//"l"
console.log(d);//"l"
console.log(e);//"o"
```

类似数组的对象都有一个 length 属性，因此还可以像普通对象解构一样对这个属性解构赋值：

```
const {length} = 'hello';
console.log(length); // 5
```

## 数值和布尔值解构

解构赋值的规则是，只要等号右侧的值不是数组或对象，就先将其转换为对象。因此数值和布尔值解构时会转为对象：

```
let {toString:s1} = 123;
console.log(s1 === Number.prototype.toString);//true
let {toString:s2} = true;
console.log(s2 === Boolean.prototype.toString);//true
```


下面的语句都会报错，因为等号右边的值，要么转为对象以后不具备 Iterator 接口（前五个表达式），要么本身就不具备 Iterator 接口（最后一个表达式）： 

```
// 报错
let [foo] = 1;
let [foo] = false;
let [foo] = NaN;
let [foo] = undefined;
let [foo] = null;
let [foo] = {};
```

事实上，只要某种数据结构 `具有 Iterator 接口`，都可以采用数组形式的解构赋值。

## 函数参数

* 解构参数

如果一个方法的入参是个对象，外部传参的时候不容易看出对象包含哪些属性，则可以通过下面的方式声明方法形参：

```
function setCookie({ secure, path, domain, expires }) {
// 设置 cookie 的代码
}
setCookie({
    secure: true,
    expires: 60000
});
```

* 解构参数默认值

可以通过下面的方式为解构参数设置默认值：

```
function setCookie({ secure= true, path, domain, expires }) {
// 设置 cookie 的代码
}
```


## 参考文档

* [ES6解构赋值](https://www.cnblogs.com/xiaohuochai/p/7243166.html)