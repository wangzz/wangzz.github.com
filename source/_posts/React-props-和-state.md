---
title: React props 和 state
date: 2021-01-16 20:51:36
tags: [React]
---

## 简介

React 的核心思想是组件化的思想，而 React 组件的定义可以通过下面的公式描述：

```
UI = Component(props, state)
```

组件根据 props 和 state 两个参数，计算得到对应界面的UI。可见，props 和 state 是组件的两个重要数据源。

## props 和 state 本质

一句话概括，`props 是组件对外的接口，state 是组件对内的接口`。

<!-- more -->

组件内可以引用其他组件，组件之间的引用形成了一个树状结构（组件树），如果下层组件需要使用上层组件的数据或方法，上层组件就可以通过下层组件的 props 属性进行传递，因此 props 是组件对外的接口。

组件除了使用上层组件传递的数据外，自身也可能需要维护管理数据，这就是组件对内的接口 state。根据对外接口 props 和对内接口 state，组件计算出对应界面的UI。

组件的 props 和 state 都和组件最终渲染出的UI直接相关。两者的主要区别是：`state 是可变的`，是组件内部维护的一组用于反映组件UI变化的状态集合；而 `props 是组件的只读属性`，组件内部不能直接修改 props，要想修改 props，只能在该组件的上层组件中修改。在组件状态上移的场景中，父组件正是通过子组件的props，传递给子组件其所需要的状态。

## 如何定义 state

state 必须能代表一个组件 UI 呈现的 `完整状态集`，即组件对应 UI 的任何改变，都可以从 state 的变化中反映出来；

同时，state 还必须是代表一个组件 UI 呈现的 `最小状态集`，即 state 中的所有状态都是用于反映组件 UI 的变化，没有任何多余的状态，也不需要通过其他状态计算而来的中间状态。

组件中用到的一个变量是不是应该作为组件 state，可以通过下面的 4 条依据进行判断：

* 这个变量是否是通过 props 从父组件中获取？如果是，那么它不是一个状态。

* 这个变量是否在组件的整个生命周期中都保持不变？如果是，那么它不是一个状态。

* 这个变量是否可以通过 state 或 props  中的已有数据计算得到？如果是，那么它不是一个状态。

* 这个变量是否在组件的 render 方法中使用？如果不是，那么它不是一个状态。这种情况下，这个变量更适合定义为组件的一个普通属性（除了 props 和 state 以外的组件属性 ），例如组件中用到的定时器，就应该直接定义为 this.timer，而不是 this.state.timer。

请务必牢记，`并不是组件中用到的所有变量都是组件的状态`！当存在多个组件共同依赖同一个状态时，一般的做法是`状态上移`，将这个状态放到这几个组件的公共父组件中。

## 如何正确修改 state

* 不能直接修改 state。

直接修改 state，组件并不会重新重发 render。例如：

```
// 错误
this.state.title = 'React';
正确的修改方式是使用setState():

// 正确
this.setState({title: 'React'});
```

* state 的更新是`异步`的。

调用 setState，组件的 state 并不会立即改变，setState 只是把要修改的状态放入一个队列中，React会优化真正的执行时机，并且 React 会出于性能原因，可能会将多次 setState 的状态修改合并成一次状态修改。所以不能依赖当前的 state，计算下个 state。当真正执行状态修改时，依赖的 this.state 并不能保证是最新的 state，因为 React 会把多次 state 的修改合并成一次，这时，this.state 还是等于这几次修改发生前的 state。另外需要注意的是，同样不能依赖当前的 props 计算下个 state，因为 `props 的更新也是异步的`。

举个例子，对于一个电商类应用，在我们的购物车中，当点击一次购买按钮，购买的数量就会加 1，如果我们连续点击了两次按钮，就会连续调用两次 this.setState({quantity: this.state.quantity + 1})，在 React 合并多次修改为一次的情况下，相当于等价执行了如下代码：

```
Object.assign(
  previousState,
  {quantity: this.state.quantity + 1},
  {quantity: this.state.quantity + 1}
)
```

于是乎，后面的操作覆盖掉了前面的操作，最终购买的数量只增加了 1 个。

如果你真的有这样的需求，可以使用另一个接收一个函数作为参数的 setState，这个函数有两个参数，第一个参数是组件的前一个 state（本次组件状态修改成功前的 state ），第二个参数是组件当前最新的 props。如下所示：

```
// 正确
this.setState((preState, props) => ({
  counter: preState.quantity + 1; 
}))
```

* state 的更新是一个浅合并（Shallow Merge）的过程。

当调用 `setState` 修改组件状态时，只需要传入发生改变的状态变量，而不是组件完整的 state，因为组件 state 的更新是一个浅合并（Shallow Merge）的过程。例如，一个组件的 state 为：

```
this.state = {
  title : 'React',
  content : 'React is an wonderful JS library!'
}
```

当只需要修改状态 title 时，只需要将修改后的 title 传给 setState：

```
this.setState({title: 'Reactjs'});
```

React 会合并新的 title 到原来的组件 state 中，同时保留原有的状态 content，合并后的 state为：

```
{
  title : 'Reactjs',
  content : 'React is an wonderful JS library!'
}
```

## state 与 immutable

React 官方建议把 state 当作不可变对象，一方面是如果直接修改 this.state，组件并不会重新 render；另一方面 state 中包含的所有状态都应该是不可变对象。当 state 中的某个状态发生变化，我们应该重新创建一个新状态，而不是直接修改原来的状态。

## 参考文档

[React 深入系列3：Props 和 State](https://www.jianshu.com/p/841a8b6eab46)