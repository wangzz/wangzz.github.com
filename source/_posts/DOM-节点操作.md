---
title: DOM 节点操作
date: 2021-01-10 13:45:39
tags: [DOM]
---

## 什么是 DOM 节点

根据 W3C 的 HTML DOM 标准，HTML 文档中的所有内容都是节点：

* 整个文档是一个文档节点

* 每个 HTML 元素是元素节点

* HTML 元素内的文本是文本节点

* 每个 HTML 属性是属性节点

* 注释是注释节点

## 节点的属性

所有的节点都有以下属性：

* innerHTML

节点（元素）的文本值

* nodeName

<!-- more -->

节点的名称，具有以下特点：

> nodeName 是只读的
>
> 元素节点的 nodeName 与标签名相同
>
> 属性节点的 nodeName 与属性名相同
>
> 文本节点的 nodeName 始终是 #text
>
> 文档节点的 nodeName 始终是 #document
>
> nodeName 始终包含 HTML 元素的大写字母标签名

* nodeValue

节点的值，具有以下特点：

> 元素节点的 nodeValue 是 undefined 或 null
>
> 文本节点的 nodeValue 是文本本身
>
> 属性节点的 nodeValue 是属性值

示例如下：

```
<html>
<body>

<p id="intro">Hello World!</p>

<script type="text/javascript">
x=document.getElementById("intro");
document.write(x.firstChild.nodeValue);
</script>

</body>
</html>
```

* nodeType

返回节点的类型。nodeType 是只读的。

比较重要的节点类型有：

| 元素类型 | NodeType |
| -------- | -------- |
| 元素     | 1        |
| 属性     | 2        |
| 文本     | 3        |
| 注释     | 8        |
| 文档     | 9        |

## 节点之间关系

节点之间有以下关系：

* parentNode 获取所选节点的父节点，最顶层的节点为#document

* childNodes 获取所选节点的子节点们 

```
<div id="div">
    <div></div>
</div>
<script>
    var div = document.getElementById("div");
    //标准浏览器输出[text, div, text], 此处text指空白文本节点
    //ie8及ie8以下浏览器输出[div], 并不包含空白文本节点
    console.log(div.childNodes);
</script>
```

* firstChild 获取所选节点的第一个子节点

* lastChild 获取所选节点的最后一个子节点

* nextSibling 获取所选节点的后一个兄弟节点，列表中最后一个节点的nextSibling属性值为null

* previousSibling 获取所选节点的前一兄弟节点，列表中第一个节点的previousSibling属性值为null

## 获取节点

可以通过以下方法获取特定的节点：

* getElementById() ：获取指定 ID 的节点，不存在这返回null。正常情况下 Id 在整个 DOM 里都是唯一的。

该方法只可以对 `document` 对象使用，对其它 DOM 节点对象使用会报 `TypeError` 错误。

```
<div id="d1"></div>
<script>
    var div = document.getElementById("d1"); //<div>标签dom化
    console.log(div.nodeName);  //"DIV"
    console.log(div.tagName);   //"DIV"
    console.log(div.__proto__); //查看节点属性
</script>
```

* getElementsByTagName() ：获取给定标签名的所有节点的集合，返回 HTMLCollection 对象，该对象是一个类数组，找不到指定标签则集合为空。

该方法可以对 `document` 对象使用，也可以对其它 DOM 节点对象使用。

```
<div></div>

// 找出所有 div 标签的节点
document.getElementsByTagName('div')
```

* getElementsByClassName() ：获取给定 CSS 类名的所有元素的集合，返回 HTMLCollection 对象。

该方法可以对 `document` 对象使用，也可以对其它 DOM 节点对象使用。

```
<div class='className'></div>

// 找出所有 class='className' 的节点
document.getElementsByClassName('className')
```

* getElementsByName() ：获取给定 name 特性的所有元素的集合，返回 NodeList 。

该方法可以对 `document` 对象使用，也可以对其它 DOM 节点对象使用。

```
<div name='elementsName'></div>

// 找出所有 name='elementsName' 的节点
document.getElementsByName('elementsName')
```

* querySelector() ：获取给定 CSS 选择符的第一个元素，无则返回null。可以标签类型、id、class 名作为筛选条件。

该方法可以对 `document` 对象使用，也可以对其它 DOM 节点对象使用。

```
<div id="d1"></div>
<div id="abc" class='className1 className2'></div>

document.querySelector('div')   // 根据标签类型
document.querySelector('#d1')   // 根据 id
document.querySelector('.className1')   // 根据类名
document.querySelector('.className1, .className2, #abc')    // 也可以用多条件组合筛选
```

* querySelectorAll() ：获取给定 CSS 选择符的所有元素的集合，返回 NodeList 。

和 querySelector() 类似，区别是会返回符合条件的多个结果。

## 遍历节点树

可以通过以下方法遍历节点树：

* parentElement　返回当前元素的父元素节点（IE9以下不兼容）

* children  返回当前元素的元素子节点

* firstElementChild 返回的是第一个元素子节点（IE9以下不兼容）

* lastElementChild  返回的是最后一个元素子节点（IE9以下不兼容）

* nextElementSibling  返回的是后一个兄弟元素节点（IE9以下不兼容）

* previousElementSibling  返回的是前一个兄弟元素节点（IE9以下不兼容）

## 修改节点

修改 HTML DOM 意味着许多不同的方面：

> 改变 HTML 内容
>
> 改变 CSS 样式
>
> 改变 HTML 属性
>
> 创建新的 HTML 元素
>
> 删除已有的 HTML 元素
>
> 改变事件（处理程序）

* 改变节点内容

改变元素内容的最简答的方法是使用 innerHTML 属性。

下面的例子改变一个 <p> 元素的 HTML 内容：

```
<html>
<body>

<p id="p1">Hello World!</p>

<script>
document.getElementById("p1").innerHTML="New text!";
</script>

</body>
</html>
```

* 改变 HTML 样式

通过 HTML DOM，能够访问 HTML 元素的样式对象。

下面的例子改变一个段落的 HTML 样式：

```
<html>

<body>
<p id="p2">Hello world!</p>

<script>
document.getElementById("p2").style.color="blue";
</script>

</body>
</html>
```

* 创建新的 HTML 元素

如需向 HTML DOM 添加新元素，首先必须创建该元素（元素节点），然后把它追加到已有的元素上：

```
<div id="d1">
<p id="p1">This is a paragraph.</p>
<p id="p2">This is another paragraph.</p>
</div>

<script>
var para=document.createElement("p");
var node=document.createTextNode("This is new.");
para.appendChild(node);

var element=document.getElementById("d1");
element.appendChild(para);
</script>
```

* 使用事件修改节点

HTML DOM 允许在事件发生时执行代码。下面两个例子在按钮被点击时改变 <body> 元素的背景色：

```
<html>
<body>

<input type="button" onclick="document.body.style.backgroundColor='lavender';"
value="Change background color" />

</body>
</html>
```

另一个例子：

```
<html>
<body>

<script>
function ChangeBackground()
{
document.body.style.backgroundColor="lavender";
}
</script>

<input type="button" onclick="ChangeBackground()"
value="Change background color" />

</body>
</html>
```

## 参考文档

* [Javascript 原生查询 DOM 节点或元素的方法](https://github.com/tcatche/tcatche.github.io/issues/84)