---
title: CSS 实现水平和竖直居中对齐
date: 2021-01-08 21:39:53
tags: [CSS]
---

## 水平居中对齐

#### 方案一

* 适用范围

只能用于`块元素` 水平居中对齐。

* 介绍

子元素指定 width，同时将 margin-left 和 margin-right 设置成 auto；

缺点是 `只能做到水平居中对齐`，不能竖直居中对齐，比如设置 margin: auto; 和设置 margin-left:auto; margin-right:auto; 效果相同

<!-- more -->

* 示例代码

http://editor.ruosen.io/?id=62b19aa7fed123ba66c6be3af7cae1ce

```
<div class="father">
    <div class="child">你好</div>
</div>

.father {
    background-color: red;
    height: 50px;
    
    .child {
        background-color: green;
        width: 200px;
        margin: auto;
    }
}

```

* 效果图

![](https://gitee.com/wangzz/pic/raw/master/align1.png)

#### 方案二

* 适用范围

只能用于`行内元素`水平居中对齐。

* 介绍

利用父元素的 `text-align: center` 属性来实现。

该方式对图片或其它行内元素都起作用。

* 示例代码

http://editor.ruosen.io/?id=ffbf1e3befaa3bd7a0d5ed05f9794d44

```
<div class="container">
    <img style="width: 100px; height: 100px;" src="http://www.tuqinghua.com/d/file/p/2019/08-06/24fadf0d7f8c2d6448ddc52bf5a5409c.jpg">
</div>

.container {
    width: 300px;
    height: 300px;
    background: red;
    text-align: center;
}
```

* 效果图

![](https://gitee.com/wangzz/pic/raw/master/image-center.png)

## 水平垂直同时居中对齐

#### 方案一

* 适用范围

同时适用`块元素`和`行内元素`实现水平和垂直方向同时居中对齐。

* 介绍

利用 transform 实现。

* 示例代码

http://editor.ruosen.io/?id=26c3aa622708de627eb694108b733939

```
<div class="father">
    <div class="child">你好</div>
</div>

<div class="father father2">
    <img class="child" src="https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2692023635,939588326&fm=26&gp=0.jpg" />
</div>

.father {
    background-color: red;
    position: relative;
    height: 100px;
    
    .child {
        background-color: green;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
    }
}

.father2 {
    background: black;
    img {
        width: 50px;
        height: 50px;
    }
}
```
* 效果图

![](https://gitee.com/wangzz/pic/raw/master/block_line_v_h_center2.png)


#### 方案二

* 适用范围

同时适用`块元素`和`行内元素`实现水平和垂直方向同时居中对齐。

* 介绍

利用增加一个高度为 0 的空白标签来实现。

* 示例代码

http://editor.ruosen.io/?id=3c2f0840c7fdab40b48438d441228b2d

```
<div class="img4 red">
	<img src="http://img.mukewang.com/52da54ed0001ecfa04120172.jpg" style="width: 100px; height: 50px" />
	<span class="iblock"></span>
</div>

<div class="img4 green">
	<span>111111</span>
	<i class="iblock"></i>
</div>

.img4 {
	text-align:center;
	width: 300px;
	height: 100px;

    img {
	  vertical-align:middle;
    }
    
    .iblock {
	  display:inline-block;
	  height:100%;
	  width:0;
	  vertical-align:middle;
    }
}

.red {
    background: red;
}

.green {
    background: green;
}

```

* 效果图

![](https://gitee.com/wangzz/pic/raw/master/line_v_h_center.png)

#### 方案三

* 适用范围

同时适用`块元素`和`行内元素`实现水平和垂直方向同时居中对齐。

* 介绍

利用 flex 布局实现

* 示例代码

http://editor.ruosen.io/?id=b926056b95cbc83288bbd74f8bb3b5f9

```
<div class="parent">
  <div class="children">我是通过flex的水平垂直居中噢！</div>
  <img src="https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2692023635,939588326&fm=26&gp=0.jpg" />
</div>

.parent {
   display:flex;
   align-items: center; /*垂直居中*/
   justify-content: center; /*水平居中*/
   flex-direction: column; /*沿着竖直方向布局*/
   width:100%;
   height:100%;
   background-color:red;
}

.children {
   background-color:blue;
}

```

* 效果图

![](https://gitee.com/wangzz/pic/raw/master/block_line_v_h_center.png)


#### 方案四

* 适用范围

`文本元素`的水平和垂直居中对齐。

* 介绍

利用绝对布局实现。

* 示例代码

http://editor.ruosen.io/?id=35056417c445656f8caad68a1109acab

```
<div class="parent">
    <div class="child">111</div>
</div>

.parent {
  position: relative;
  width: 200px;
  height: 200px;
  background: red;

  .child {
    position: absolute;
    color: #ccc;
    text-align: center;
    line-height: 50px;
    height: 50px;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    margin: auto;
    overflow: auto;
    background: green;
  }
}
```

* 效果图

![](https://gitee.com/wangzz/pic/raw/master/text_v_h_center.png)