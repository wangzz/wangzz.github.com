---
title: React refs
date: 2021-01-14 13:52:42
tags: [React]
---

## 简介

在 React 典型的数据流中，`props` 是父子组件交互的唯一方式。但在典型数据流之外，React 还提供了 `ref` 方式，用于`在父组件中获取子组件的实例`，以从子组件获取数据或对其进行修改（比如 focus 某个 dom 元素）。

ref 表示`对组件实例的引用`，其实就是 ReactDOM.render() 返回值。

## 适合使用 ref 的情况

* 管理焦点，文本选择或媒体播放。

* 触发强制动画。

* 集成第三方 DOM 库。

另外，应该避免使用 ref 来做任何可以通过声明式 (declaratively) 实现来完成的事情。

总之，不要滥用 ref。

<!-- more -->

## ReactDOM.render() 方法返回值

当 ReactDOM.render() 渲染组件时，返回值是对应组件的实例；而渲染 React 元素时，返回的是具体 React 元素节点：

```
const domCom = <button type="button">button</button>;
const refDom = ReactDOM.render(domCom，container);
console.log(refDom);

// ConfirmPass 的组件内容省略
const refCom = ReactDOM.render(<ConfirmPass/>,container);
console.log(refCom);
```

ref 可以挂到任何组件上，也可以挂到任何 React 元素上；当挂到组件（有状态组件）时，表示对组件实例的引用，挂到 React 元素上时，表示对元素的引用。

## ref 设置回调函数

ref 属性可以设置成一个回调函数，这也是官方强烈推荐的做法。该函数的执行时机：

* 组件被挂载后

回调函数被立即执行，函数的参数为该组件的实例。

* 组件被卸载或原有的 ref 属性本身发生变化

回调函数被立即执行，函数参数为 null，以确保内存泄漏。

示例代码：

```
RegisterStepTwo = React.createClass({
    getInitialState(){
      return {visible: true};
    },
  changeVisible(){
    this.setState({visible: !this.state.visible});
  },
  refCb(instance){
    console.log(instance);
  },
  render(){
    return(
      <div>
        <button type="button" onClick={this.changeVisible.bind(this)}>{this.state.visible ? '卸载' : '挂载'}ConfirmPass
        </button>
        {
          this.state.visible ?
            <ConfirmPass ref={this.refCb} onChange={this.handleChange.bind(this)}/> : null
         }
       </div>
     )
  }
});
```

或者通过箭头函数：

```
import React, { Component } from 'react';

class App extends Component {
    componentDidMount() {
        this.textInput.focus();
    }
    
    render() {
        return (
            <input type="text" ref={el => this.textInput = el} />
        );
    }
}

export default App;
```

## React.createRef() 方式

举例如下：

```
class AutoFocusTextInput extends React.Component {
  constructor(props) {
    super(props);
    this.textInput = React.createRef();
  }

  componentDidMount() {
    this.textInput.current.focusTextInput();
  }

  render() {
    return (
      <CustomTextInput ref={this.textInput} />
    );
  }
}
```

这样就可以通过 `textInput` 引用到 `CustomTextInput` 的实例。注意事项：

* createRef 初始化动作要在组件挂载之前，如果是挂载之后初始化，则无法得到 DOM 元素的引用。

* 真正的 DOM 元素引用在current属性上。

## ref 设置字符串

ref 属性值也可以设置成字符串，但这种方式在 React17 里将被废弃，因此不推荐使用了。比如：

```
componentDidMount () {
  Toast.$this = this.refs.Toast;
}

render () {
  return (
    <ToastPlace ref="Toast"></ToastPlace>
  );
}
```

## 获取 ref 指向组件对应的 dom 节点

不管 ref 设置的值是回调函数还是字符串，通过 ref 拿到组件实例的引用后，都可以通过 `ReactDOM.findDOMNode(ref)` 来获取组件挂载后真正的 dom 节点。

对于 html 元素使用 ref 的情况，ref 本身引用的就是该元素的 dom 节点，无需再使用上述方法获取。

## ref 在有状态组件中的应用

前面说过，有状态组件中 ref 指向的是组件的实例，因此可以通过 ref 获取组件的 `props`、`state`、`refs`、`实例方法（非继承方法）`等，这样就可以在父组件中改变子组件的行为。

## ref 在无状态组件（函数组件）中的应用

默认情况下，你不能在 [无状态组件](https://www.cnblogs.com/wonyun/p/5930333.html)(函数组件)上使用 ref 属性，因为它们没有实例，所以父组件中通过 ref 获取子组件时，其值为 null，也就是说`无法通过 ref 来获取无状态组件实例`。但是可以有以下两种方式在无状态组件上使用 ref：

* 结合复合组件来包装无状态组件

* 通过变量保存我们想要的组件或 dom 元素的实例引用

```
function TestComp(props){
    let refDom;
    return (<div>
        <div ref={(node) => refDom = node}>
            ...
        </div>
    </div>)
}
```

这样就可以通过 refDom 来访问无状态组件中的指定 dom 元素了，访问其它组件实例也类似。

## ref 转发

如下的代码：

```
const FancyButton = React.forwardRef((props, ref) => (
  <button ref={ref} className="FancyButton">
    {props.children}
  </button>
));

// 你可以直接获取 DOM button 的 ref：
const ref = React.createRef();
<FancyButton ref={ref}>Click me!</FancyButton>;
```

当 ref 挂载完成，ref.current 将指向 <button> DOM 节点。

## 其它说明

不要在 render 方法中访问 ref 引用，因为 render 方法只是返回一个虚拟 dom，这时组件不一定挂载到了 dom 中，或 render 方法返回的虚拟 dom 不一定更新到了 dom 中。

## 参考文章

* [React之ref详细用法](https://segmentfault.com/a/1190000008665915)

* [Refs and the DOM](https://zh-hans.reactjs.org/docs/refs-and-the-dom.html)

* [Refs 转发](https://zh-hans.reactjs.org/docs/forwarding-refs.html)

* [React专题：操作DOM](https://juejin.im/post/5b907ad65188255c38533bbf)