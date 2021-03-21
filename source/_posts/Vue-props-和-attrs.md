---
title: Vue props 和 $attrs
date: 2021-01-18 23:57:28
tags: [Vue]
---

* props

一个组件可以给自己定义 props 属性，这样别的组件使用自己的时候就可以给自己 props 里指定的属性传值。比如：

```
// parent.vue
<div id="app">
    A{{msg}}
    <component-a :msg="msg"></component-a>
</div>

// component-a.vue
export default {
  props: ["msg"]
}
```

这样的话 component-a 组件里就能使用 parent 传递过来的 msg 属性。

<!-- more -->

* $attrs

如果 parent 给 component-a 传了几个参数，component-a 又调用了 component-b，但是希望把父组件传过来但自己不用的属性透传给 component-b，可以通过 $attrs 实现。比如：

```
// parent.vue
<div id="app">
    A{{msg}}
    <component-a :a="a" :b="b" c="cstring" ></component-a>
</div>

// component-a.vue
<component-b v-bind="$attrs" ></component-b>
export default {
  props: ["a"]
}

// component-b.vue
export default {
  props: ["b", "c"]
}
```

上面的例子中，parent 给 component-a 传了 a、b、c 三个参数，但 component-a 只在 props 里声明了 a ，也就是说 component-a 自己只能用到 a；剩余的 b、c 参数 component-b 用的上，就通过 `v-bind="$attrs"` 都透传给了 component-b。

需要注意的是，只有 parent 传过来的且不在 component-a 的 props 列表里的参数才会透传给 component-b。

当然在 component-a 里也可以通过 `this.$attrs` 访问到 b、c 两个参数。