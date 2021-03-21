---
title: JS prototype 和 conttructor
date: 2021-01-2 21:32:36
tags: [JavaScript]
---

在 Javascript 语言体系中，是不存在类（Class）的概念的，Javascript 中不是基于‘类的'，而是通过构造函数（constructor）和原型链（prototype chains）实现的。但是在 ES6 中提供了更接近传统语言的写法，引入了 Class（类）这个概念，作为对象的模板。通过 class 关键字，可以定义类。基本上，ES6 的 class 可以看作只是一个语法糖，它的绝大部分功能，ES5 都可以做到，新的 class 写法只是让原型对象的写法更加清晰、更像面向对象编程的语法而已。

## 构造函数

#### 简介

构造函数的特点有：

* 构造函数的函数名首字母必须大写
* 内部使用 this 对象，来指向将要生成的对象实例
* 使用 new 操作符来调用构造函数，并返回对象实例

<!-- more -->

示例如下：

```
function Person() {
  this.name = 'keith';
}
var boy = new Person();
console.log(boy.name); //'keith'
```

#### 缺点

构造函数的缺点为：同一个构造函数的对象实例之间无法共享属性或方法。


```
function Person(name,height) {
 this.name=name;
 this.hobby=function() {
  return 'watching movies';
 }
}

var boy=new Person('keith',180);
var girl=new Person('rascal',153);
console.log(boy.name); //'keith'
console.log(girl.name); //'rascal'
console.log(boy.hobby===girl.hobby); //false
```

上面代码中，一个构造函数 Person 生成了两个对象实例 boy 和 girl，并且有两个属性和一个方法。但是，它们的 hobby 方法是不一样的。也就是说，每当你使用 new 来调用构造函数放回一个对象实例的时候，都会创建一个 hobby 方法。这既没有必要，又浪费资源，因为所有 hobby 方法都是同样的行为，完全可以被两个对象实例共享。

## prototype

#### prototype 属性的作用

为了解决 `构造函数的对象实例之间无法共享属性` 的缺点，js 提供了 prototype 属性。

js 中每个数据类型都是对象（除了 null 和 undefined），而每个对象都继承自另外一个对象，后者称为“原型”（prototype）对象，只有 null 除外，它没有自己的原型对象。

原型对象上的所有属性和方法，都会被对象实例所共享。

每个构造函数都默认有一个 prototype 属性。

通过构造函数生成对象实例时，会将对象实例的 prototype 指向构造函数的 prototype 属性。

```
function Person(name,height){
 this.name=name;
 this.height=height;
}

Person.prototype.hobby=function(){
 return 'watching movies';
}

var boy=new Person('keith',180);
var girl=new Person('rascal',153);
console.log(boy.name); //'keith'
console.log(girl.name); //'rascal'
console.log(boy.hobby===girl.hobby); //true
```

对于构造函数来说，prototype 是作为构造函数的属性；对于对象实例来说，prototype 是对象实例的原型对象。

原型对象的属性不是对象实例的属性，有点像 OC 中类的属性。比如通过 for 循环遍历 boy 对象的属性时，就只能获取到 name 和 height。

当某个对象实例没有该属性和方法时，就会到原型对象上去查找。如果实例对象自身有某个属性或方法，就不会去原型对象上查找。比如下例：

```
boy.hobby=function(){
 return 'play basketball';
}
console.log(boy.hobby()); //'play basketball'
console.log(girl.hobby()); //'swimming'
```

可以把任何类型的值赋给 prototype。将对象赋值给 prototype，正如上面的例子所示，将会动态的创建原型链, 但是将原子类型赋给 prototype 的操作将会被忽略：

```
function Foo() {}
Foo.prototype = 1; // 无效
```

#### 原型链（prototype chains)

对象的属性和方法，有可能是定义在自身，也有可能是定义在它的原型对象。由于原型对象本身对于对象实例来说也是对象，它也有自己的原型，所以形成了一条原型链（prototype chain）。比如，a 对象是 b 对象的原型，b 对象是 c 对象的原型，以此类推。所有一切的对象的原型顶端，都是 Object.prototype，即 Object 构造函数的 prototype 属性指向的那个对象。

```
function Father(){
    this.fatherProperty = true;
}

function Son(){
    this.sonProperty = false;
}

// 继承 Father
Son.prototype = new Father(); //Son.prototype被重写,导致Son.prototype.constructor也一同被重写
```

这个例子中，Son 和 Father 的 prototype 就构成了一个链路关系，相当于具备了 OC 中的继承关系。

当然，Object.prototype 对象也有自己的原型对象，那就是没有任何属性和方法的 null 对象，而 null 对象没有自己的原型。


```
console.log(Object.getPrototypeOf(Object.prototype)); //null
console.log(Person.prototype.isPrototypeOf(boy)) //true
```

原型链（prototype chain）的特点有：

* 读取对象的某个属性时，JavaScript 引擎先寻找对象本身的属性，如果找不到，就到它的原型去找，如果还是找不到，就到原型的原型去找。如果直到最顶层的 Object.prototype 还是找不到，则返回 undefined。

* 如果对象自身和它的原型，都定义了一个同名属性，那么优先读取对象自身的属性，这叫做“覆盖”（overiding）。

* 一级级向上在原型链寻找某个属性，对性能是有影响的。所寻找的属性在越上层的原型对象，对性能的影响越大。如果寻找某个不存在的属性，将会遍历整个原型链。

可以通过以下方法判断对象自身有哪些属性：

```
console.log(Object.getOwnPropertyNames(Array.prototype))
// ["length", "toSource", "toString", "toLocaleString", "join", "reverse", "sort", "push", "pop", "shift", "unshift", "splice", "concat", "slice", "lastIndexOf", "indexOf", "forEach", "map", "filter", "reduce", "reduceRight", "some", "every", "find", "findIndex", "copyWithin", "fill", "entries", "keys", "values", "includes", "constructor", "$set", "$remove"]
```

#### __proto__

* 每个对象都有__proto__ ( 除了 var obj = Object.create(null) )

* 对象的 __proto__ 指向的是构造函数的 prototype

```
var obj = new Func()
```

上面的 new 实例化操作，会将 Func 函数对象的 prototype 赋值给 obj 对象的 __proto__
即 obj.__proto__ = Func.prototype。

## constructor 属性

constructor 是 prototype 的一个属性，默认指向 prototype 所在的构造函数。

要注意的是，prototype 是构造函数的属性，而 constructor 则是指向构造函数。

```
function A(){};
var a=new A();
console.log(a.constructor); //A()
console.log(a.constructor===A.prototype.constructor);//true
```

a 是构造函数 A 的实例对象，但是 a 自身没有 contructor 属性，该属性其实是读取原型链上面的 A.prototype.constructor 属性。

## instanceof 运算符

instanceof 运算符返回一个布尔值，表示指定对象是否为某个构造函数的实例。

因为 instanceof 对整个原型链上的对象都有效，所以同一个实例对象，可能会对多个构造函数都返回 true。

注意，instanceof 对象只能用于复杂数据类型（数组，对象等），不能用于简单数据类型（布尔值，数字，字符串等）。

此外，null 和 undefined 都不是对象，所以 instanceof 总是返回 false。

## 总结

* 函数、实例、prototype、constructor 之间的关系

每个构造函数（constructor）都有一个原型对象（prototype），原型对象都包含一个指向构造函数的指针,而实例（instance）都包含一个指向原型对象的内部指针。


* 默认情况下函数才有 prototype，函数的实例没有

```
function Foo() {}
var foo = new Foo();
console.log(foo.prototype);// undefined
console.log(Foo.prototype);// [object Object]
```

默认只有函数有 prototype 属性，当然，一般的对象（比如上例中的 foo）自己也可以加这个属性。

## 参考文档

* [详解Javascript中prototype属性](https://www.cnblogs.com/douyage/p/8630529.html)
* [帮你彻底搞懂JS中的prototype、__proto__与constructor](https://blog.csdn.net/cc18868876837/article/details/81211729)
* [JavaScript中__proto__与prototype的关系](https://www.cnblogs.com/snandy/archive/2012/09/01/2664134.html)