---
title: React 组件和元素
date: 2021-01-15 23:53:36
tags: [React]
---

## 元素（Element）

React 元素其实就是一个简单的 JS 对象。一个元素和界面上的一部分 DOM 对应，元素描述了这部分 DOM 的结构和渲染效果。

#### 元素创建方法

有以下几种创建元素的方法：

* React.createElement

语法：

```
React.createElement(
    type,
    [props],
    [...children]
)
```

<!-- more -->

参数：

> type：可以是个标签名，入 div、span，也可以是个 React 组件名；
>
> props：传入的属性；
>
> children：第三个及之后的参数，都作为组件的子组件。

示例：

```
const element = React.createElement(
  'h1',
  {className: 'greeting'},
  'Hello, world!'
);
```

* React.cloneElement

React.cloneElement 和 React.createElement 相似，只不过它传入的第一个参数是个 React 元素，而不是标签名或组件。目的是基于第一个参数传入的元素复制出新的元素。

语法：

```
React.cloneElement(
  element,
  [props],
  [...children]
)
```

参数：

> element：要被复制的 React 元素；
>
> props：新添加的属性；
>
> children：新添加的子元素；

* JSX 

```
const element = <h1 className='greeting'>Hello, world</h1>;
```

实际就是调用 React.createElement 创建一个新的元素，本质上是这个方法的一个语法糖。

编译后的结果为：

```
const element = React.createElement(
  'h1',
  {className: 'greeting'},
  'Hello, world!'
);
```

#### 元素的本质

元素最终都会被转化成类似下面这个简单的 JS 对象：

```
const element = {
  type: 'h1',
  props: {
    className: 'greeting',
    children: 'Hello, world'
  }
}
```

#### 元素分类

* DOM 类型元素

使用 h1、div、p 等 DOM 节点创建的元素

* 组件类型元素

使用 React 组件创建的元素，例如：

```
const buttonElement = <Button color='red'>OK</Button>;
```

它对应的 JS 对象为：

```
const buttonElement = {
  type: 'Button',
  props: {
    color: 'red',
    children: 'OK'
  }
}
```

## 组件（Component）

React 通过组件的思想，将界面拆分成一个个可以复用的模块，一个模块就是一个组件。

组件和元素的关系密切，组件`最核心的作用就是返回 React 元素`。

#### 组件分类

* 函数组件（无状态组件）

```
function Welcome(props) {
  return <h1>Hello, {props.name}</h1>;
}
```

函数组件是最简单的组件，它和类组件最大的区别是`函数本身不会被实例化`。

* 类组件（有状态组件）

```
class Welcome extends React.Component {
  render() {
    return <h1>Hello, {this.props.name}</h1>;
  }
}
```

类组件中，render 是唯一必须的方法，其它组件的声明周期方法都只是为了 render 服务而已。

#### 有状态组件和无状态组件区别

* 无状态组件不会被实例化，无需分配多余的内存，渲染性能得到提升

* 无状态组件不能访问 this 对象

* 无状态组件不能访问声明周期方法

* 无状态组件智能访问输入的 props，同样的 props 会得到同样的渲染结果，不会有副作用

## 元素如何被渲染

渲染引擎可以通过 JS 对象里的 type 字段区分元素类型。对于 DOM 类型的元素，因为和页面的 DOM 节点直接对应，所以 React 知道如何进行渲染。但组件类型的元素，React 如何知道怎么渲染呢？

原来，当 `type 的首字母是大写`时，React 就会认定这是个组件。

比如下面的代码：

```
class Home extends React.Component {
  render() {
    return (
      <div>
        <Welcome name='老干部' />
        <p>Anything you like</p>
      </div>
    )
  }
}
```

对应的 JS 对象为：

```
{
  type: 'div',
  props: {
    children: [
      {
        type: 'Welcome',
        props: {
          name: '老干部'
        }
      },
      {
        type: 'p',
        props: {
          children: 'Anything you like'
        }
      }，
    ]
  }
}
```

当发现 Welcome 是个组件时，会根据它返回的元素决定如何渲染这个节点：

```
{
  type: 'h1',
  props: {
  	children: 'Hello, 老干部'
  }
}
```

本质上，React 组件的复用就是为了复用组件返回的元素；React 元素是 React 应用最基础的组成单位。

## 实例（Instance）

* React 实例指的就是组件的实例

* 只有类组件才有实例，函数组件不会被实例化

* 组件被实例化以后才有自己的 props 和 state，才持有对它 DOM 节点和子组件实例的引用

* 组件实例化工作由 React 自动完成，开发者不需要关心实例的创建、更新和销毁

## 节点（Node）

在使用 PropTypes 校验组件属性时，有这样一种类型：

```
MyComponent.propTypes = { 
  optionalNode: PropTypes.node,
}
```

PropTypes.node 是一个 React 节点。React 节点是指可以被 React 渲染的数据类型，包括数字、字符串、React 元素或者是包含这些数据类型的数组等。

## 参考文档

* [React 深入系列：React 中的元素、组件、实例和节点](https://juejin.im/post/5ac42e17f265da239e4e491a)

* [React 中元素与组件的区别](https://segmentfault.com/a/1190000008587988)

* [深入解读 React 核心之元素篇](https://juejin.im/post/5d5007bd51882505730d0008)

* [深入解读 React 核心之组件篇](https://juejin.im/post/5d52c08fe51d4561cb5dde7a)

* [React创建组件的三种方式及其区别](https://www.cnblogs.com/wonyun/p/5930333.html)