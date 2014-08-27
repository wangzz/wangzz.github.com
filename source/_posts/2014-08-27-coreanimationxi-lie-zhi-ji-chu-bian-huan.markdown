---
layout: post
title: "CoreAnimation系列之基础变换"
date: 2014-08-27 12:21:50 +0800
comments: true
categories: iOS
tags: [CoreAnimation, iOS, CATransform3D]
keywords: CoreAnimation, iOS, CATransform3D, Translate, Scale, Rotate, 平移, 缩放, 旋转
description: CoreAnimation系列之基础变换

---

<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=default"></script>

从[CSDN]()时代开始，就有用一系列文章聊聊CoreAnimation的打算，这算是本系列中的第三篇了。一直以来都是哪天心情好的时候来一篇，真怀疑等把整个系列写完的时候CoreAnimation是不是都要被Apple换掉了。

本文打算介绍自己对基础变换的认识。

##一、简介

CoreAnimation中基础变换包括平移（Translate）、缩放（Scale）、旋转（Rotate）。变换对于动画来说应该是最基础最核心的内容了


##二、基础变换与数学

####1.两种坐标系

不管是平面几何还是立体几何，笛卡尔坐标系都是我们学习和研究几何的最基础工具。的笛卡尔坐标系主要分两种：左手坐标系和右手坐标系。

对于三维坐标系，[百度百科](http://baike.baidu.com/view/2939423.htm)上给出了右手坐标系的判断方法：在空间直角坐标系中，让右手拇指指向x轴的正方向，食指指向y轴的正方向，如果中指能指向z轴的正方向，则称这个坐标系为右手直角坐标系。同理左手直角三维坐标系。

下图直观的表示了上述判断方法（图片来自[这里](http://outofmemory.cn/wr/?u=http%3A%2F%2Fwonderffee.github.io%2Fblog%2F2013%2F10%2F17%2Fa-simple-method-to-determine-positive-rotation-in-in-three-dimensional-space%2F)）：

![left-right hand coordinate](/images/article6/coordinate-system.jpg)

由此判断，从中学到大学的课堂上我们接触的立体几何都是右手系。

####2.基础变换的数学公式

一个点在立体空间内的变换可以通过数学公式表示，前面讲那么多左手和右手坐标系相关的内容是因为`不同坐标系下计算公式不同`。

iOS中CoreAnimation的CALayer默认使用的是`左手坐标系`（使用哪种坐标系可以通过CALayer的`geometryFlipped`属性更改，该值默认为NO，设为YES时表示使用右手坐标系），因此本文后面所说的所有坐标系都是之左手坐标系。

假如三维空间中有一个点(x0, y0, z0)，该点经过一定条件的基础变换，变换后的坐标为(x, y, z)，则针对平移、缩放、旋转三种基础变换，对应的坐标变换关系如下：

######2.1 平移

平移对应的变化量为(δx, δy, δz)。

```
x = x0 + δx;
y = y0 + δy;
z = z0 + δz;
```

######2.2 缩放

缩放对应的缩放倍数为(δx, δy, δz)。

```
x = x0 * δx;
y = y0 * δy;
z = z0 * δz;
```

######2.3 旋转

旋转的方式有很多，比如简单点的绕X轴、Y轴、Z轴旋转，复杂点的还有绕任意三维向量旋转。为了简单起见，旋转以绕Z轴旋转了角度α（注意这里及后文所有涉及角度的地方都是弧度制）为例，对应的变化关系为：

```
x = y0*sinα + x0*cosα;
y = y0*conα - x0*sinα;
z = z0;
```

其它的大家感兴趣可以自己推倒下。


##三、变换矩阵

在CoreAnimation中用CATransform3D来表示三维齐次坐标变换矩阵，在齐次坐标中n维空间的坐标需要用n+1个元素的坐标元组来表示（详情还请自行Google），因此CATransform3D定义如下：

```
struct CATransform3D
{
  CGFloat m11, m12, m13, m14;
  CGFloat m21, m22, m23, m24;
  CGFloat m31, m32, m33, m34;
  CGFloat m41, m42, m43, m44;
};
```
为什么实现变换要有变换矩阵呢？

以上文中旋转的计算公式为例，可以使用如下矩阵运算表示：

$$\begin{bmatrix}
cosα & sinα & 0 & 0 \\\
-sinα & consα & 0 & 0 \\\
0 & 0 & 1 & 0 \\\
0 & 0 & 0 & 1 \\\
\end{bmatrix}
×
\begin{bmatrix}
x0 \\\
y0 \\\
z0 \\\
1 \\\
\end{bmatrix}$$

![left-right hand coordinate](/images/article6/matrix1.png)

其中的矩阵：

$$\begin{bmatrix}
cosα & sinα & 0 & 0\\\
-sinα & consα & 0 & 0\\\
0 & 0 & 1 & 0\\\
0 & 0 & 0 & 1\\\
\end{bmatrix}$$

![left-right hand coordinate](/images/article6/matrix2.png)

就被称为点(x0, y0, z0)绕Z轴旋转角度α的变换矩阵。

由于放射变换可以通过矩阵变换来实现，而且看起来更加直观，因此变换公式通常都用对应的变换矩阵表示。

在CoreAnimation中平移、缩放、旋转对应的变换矩阵为：

####1. 平移

$$\begin{bmatrix}
1 & 0 & 0 & 0\\\
0 & 1 & 0 & 0\\\
0 & 0 & 1 & 0\\\
δx & δy & δz & 1\\\
\end{bmatrix}$$

![left-right hand coordinate](/images/article6/matrix3.png)

其中δx、δy、δz表示三个坐标上对应的平移量。

####2. 缩放

$$\begin{bmatrix}
δx & 0 & 0 & 0\\\
0 & δy & 0 & 0\\\
0 & 0 & δz & 0\\\
0 & 0 & 0 & 1\\\
\end{bmatrix}$$

![left-right hand coordinate](/images/article6/matrix4.png)

其中δx、δy、δz表示三个坐标上对应的缩放倍数。

####3. 旋转

$$\begin{bmatrix}
cosα+(1-cosα)x^{2} & (1-cosα)yx+sinα\*z & (1-cosα)zx-sinα\*y & 0\\\
(1-cosα)xy-sinα\*z & cosα+(1-cosα)y^{2} & (1-cosα)zy+sinα\*x & 0\\\
(1-cosα)xz+sinα\*y & (1-cosα)yz-sinα\*x & cosα+(1-cosα)z^{2} & 0\\\
0 & 0 & 0 & 1\\\
\end{bmatrix}$$

![left-right hand coordinate](/images/article6/matrix5.png)

该矩阵为任意点(x, y, z)绕任意向量旋转旋转角度α的旋转向量。


##四、CoreAnimation基础变换方法


##五、

##六、



变换的核心在于变换矩阵。

