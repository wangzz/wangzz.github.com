---
title: CSS 选择器
date: 2021-01-06 13:36:59
tags: [CSS]
---

## 选择器分组

使用相同布局配置的元素可以在一起声明：

```
h1,h2,h3,h4,h5,h6 {
  color: green;
}
```

## 继承选择器

针对 body 定义布局：

```
body {
    font-family: Verdana, sans-serif;
}
```

还可以只对 p 定义：

<!-- more -->

```
p  {
    font-family: Times, "Times New Roman", serif;
}
```

这样 body 里除了 p 以外就能使用相同的布局配置了。

## 子元素选择器

下面的例子只会选择直接作为 ol 子元素的 li 子标签生效，第二级 li 标签不会生效：

```
.father > li {
    font-style: italic;
    font-weight: normal;
}
```

```
<ol class="father">
    <li>我是意大利斜体。</li>
    <ol>
        <li>我不是意大利斜体。</li>
    </ol>
</ol>
```

也就是说，子元素选择器`只针对第一代子元素`生效。

## 后代选择器

```
.father li {
    font-style: italic;
    font-weight: normal;
}
```

```
<ol class="father">
    <li>我是意大利斜体。</li>
    <ol>
        <li>我是意大利斜体。</li>
    </ol>
</ol>
```
上面的例子中，所有的 li 元素的样式都为斜体字。也就是说，后代选择器`针对所有的后代子元素`生效。

## 相邻兄弟选择器

相邻兄弟选择器（Adjacent sibling selector）可选择紧接在另一元素后的元素，且二者有相同父元素。

例如，如果要增加紧接在 h1 元素后出现的段落的上边距，可以这样写：

```
h1 + p {
    margin-top: 50px;
}
```

需要注意的是，用一个结合符 `只能选择两个相邻兄弟中的第二个元素` ！

## class 选择器

* 通配 class 选择器

我们可以让所有类相同的元素使用相同的选择器，比如下面的例子针对所有类名为 `important` 的元素定义了一个筛选器：

```
*.important {
    color: red;
}
```

也可以把前面的通配符 `*` 省略，效果是一样的：

```
.important {
    color: red;
}
```

* 结合元素 class 选择器

下面的写法，只有针对类名为 `important` 的 p 元素生效：

```
p.important {
    color: red;
}
```

* 多 class 选择器

```
<p class="important warning">
    This paragraph is a very important warning.
</p>
```

```
.important {
    font-weight: bold;
}

.warning {
    font-style: italic;
}

.important.warning {
    background: silver;
}
```

上面的例子中，三个筛选器会同时对 p 元素生效。

## ID 选择器

类似于类选择器，ID 选择器前面有一个 # 号：

```
*#intro {
    font-weight: bold;
}
```

与类选择器一样，ID 选择器中可以忽略通配选择器。前面的例子也可以写成：

```
#intro {
    font-weight: bold;
}
```

这两个选择器的效果将是一样的，都会针对下面的 `p` 元素生效：

```
<p id="intro">This is a paragraph of introduction.</p>
```

## 属性选择器

属性选择器可以根据元素的属性及属性值来选择元素。

有以下几种写法：

* 所有有特定属性的元素

```
*[title] {
    color: red;
}
```

* 特定名称且特定属性的元素

```
a[href][title] {
    color: red;
}
```

* 属性值为特定值的元素

```
a[href="http://www.w3school.com.cn/about_us.asp"] {
    color: red;
}
```

* 属性值为模糊匹配

如果用特定值匹配，值必须要 `完全匹配` 才行。

比如：

```
<p class="important warning">This paragraph is a very important warning.</p>
```

下面的写法是匹配不了的：

```
p[class="important"] {
    color: red;
}
```

必须写成：

```
p[class="important warning"] {
    color: red;
}
```

可以通过下面的写法做到部分匹配：

```
p[class~="important"] {
    color: red;
}
```

完整的模糊匹配语法参考列表如下：

| 选择器             | 描述                                 |
| ------------------ | ------------------------------------ |
| [attribute]        | 用于选取带有指定属性的元素。         |
| [attribute=value]  | 用于选取带有指定属性和值的元素。     |
| [attribute~=value] | 用于选取属性值中包含指定词汇的元素。 |
| [attribute         | =value]                              |
| [attribute^=value] | 匹配属性值以指定值开头的每个元素。   |
| [attribute$=value] | 匹配属性值以指定值结尾的每个元素。   |
| [attribute*=value] | 匹配属性值中包含指定值的每个元素。   |

## 伪类选择器

伪类用于当已有元素处于的某个状态时，为其添加对应的样式，这个状态是根据用户行为而动态变化的。

语法如下：

```
selector : pseudo-class {
  property: value
}
```

伪类选择器分为静态伪类和动态伪类两种。

* 静态伪类

:link 超链接点击之前

:visited 链接被访问过之后

PS：以上两种样式，只能用于超链接。

* 动态伪类

:hover “悬停”：鼠标放到标签上的时候

:active “激活”： 鼠标点击标签，但是不松手时。

:focus 是某个标签获得焦点时的样式（比如某个输入框获得焦点）

PS：以上三种样式，只能用于超链接。

示例如下：

```
a:link {
    color: #FF0000
}		/* 未访问的链接 */
a:visited {
    color: #00FF00
}	/* 已访问的链接 */
a:hover {
    color: #FF00FF
}	/* 鼠标移动到链接上 */
a:active {
    color: #0000FF
}	/* 选定的链接 */
```

* 完整的伪类列表

| 属性         | 描述                                     | CSS  |
| ------------ | ---------------------------------------- | ---- |
| :link        | 向未被访问的链接添加样式。               | 1    |
| :visited     | 向已被访问的链接添加样式。               | 1    |
| :active      | 向被激活的元素添加样式。                 | 1    |
| :focus       | 向拥有键盘输入焦点的元素添加样式。       | 2    |
| :hover       | 当鼠标悬浮在元素上方时，向元素添加样式。 | 1    |
| :first-child | 向元素的第一个子元素添加样式。           | 2    |
| :lang        | 向带有指定 lang 属性的元素添加样式。     | 2    |

## 伪元素选择器

伪元素用于创建一些不在文档树中的元素，并为其添加样式。

基本语法如下：

```
selector::pseudo-element {
  property: value;
}
```

> 注意：按照规范，应该使用双冒号（::）而不是单个冒号（:），以便区分伪类和伪元素。但是，由于旧版本的 W3C 规范并未对此进行特别区分，因此目前绝大多数的浏览器都同时支持使用这两种方式来表示伪元素。

以 first-line 为例，可以通过它向文本的首行设置特殊样式，比如：

```
p:first-line {
  color: #ff0000;
  font-variant: small-caps;
}
```

会根据 "first-line" 伪元素中的样式对 p 元素的第一行文本进行格式化。

"first-line" 伪元素 `只能用于块级元素`。

下面的属性可应用于 "first-line" 伪元素：

```
font
color
background
word-spacing
letter-spacing
text-decoration
vertical-align
text-transform
line-height
clear
```

完整的伪属性列表如下：

| 属性                           | 描述                             | CSS  |
| ------------------------------ | -------------------------------- | ---- |
| ::first-letter (:first-letter) | 向文本的第一个字母添加特殊样式。 | 1    |
| ::first-line (:first-line)     | 向文本的首行添加特殊样式。       | 1    |
| ::before (:before)             | 在元素之前添加内容。             | 2    |
| ::after (:after)               | 在元素之后添加内容。             | 2    |


## 参考文档

* [伪类](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Pseudo-classes)

* [伪元素](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Pseudo-elements)