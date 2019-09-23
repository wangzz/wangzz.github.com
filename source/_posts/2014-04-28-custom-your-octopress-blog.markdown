---

layout: post
title: "自定义你的Octopress博客"
date: 2014-04-28 11:17:31 +0800
comments: true
categories: Octopress
tags: [octopress, 博客自定义, seo]
keywords: seo, octopress, analytics, 博客自定义
---


##SEO

* 增加统计工具

博客搭建好了以后，大家一定很想知道每天都有多少的访问量。现在有很多工具都可以帮助我们做这件事，比如`Google Analytics`、`百度统计`、`CNZZ` 等。

其中`Google Analytics`是Octopress自带的统计工具，使用方式也非常简单，只需要到`Google Analytics`申请一个`app id`，填写到`_config.yml`文件中的`google_analytics_tracking_id`后面即可。但`Google Analytics`存在翻墙的麻烦，而且`百度统计`功能也挺齐全，完全能满足我的需求，就选择了`百度统计`。

集成百度统计方式非常简单：

只需到`百度统计`官方网站申请一个账号，将获取的代码添加到`source/_includes/custom/footer.html`中，重新部署即可。

 <!-- more -->

* 搜索优化

为了让自己搭建的博客更容易被搜索引擎搜到，最好将网站地址提交给各大搜索引擎，下面有两个连接搜集了各个搜索引擎的网站提交入口：

```
http://urlc.cn/tool/addurl.html
http://tool.lusongsong.com/addurl.html
```

我试了下，添加到`google`以后，搜索关键字的时候自己的博客确实排名靠前了。


光是将网址添加到搜索引擎还不够，你必须得为你的文章添加关键字，才能更好地被引擎搜到，在创建一篇新文章的时候，生成的makedown文件包含以下内容，以本文举例：

```

---

layout: post
title: "自定义你的Octopress博客"
date: 2014-04-28 11:17:31 +0800
comments: true
categories: Octopress

---
```

实际上我们还可以为其添加以下几项，以本文举例：

```
tags: [octopress, 博客自定义, seo]
keywords: seo, octopress, analytics, 博客自定义
description: 如何自定义Octopress博客
```

这样更利于搜索引擎抓取到我们的博客。

事实上，如果我们不做上述设置，Octopress会默认将文章的前150个字作为文章的关键字，供搜索引擎抓取，但那并不一定准确。

Octopress实现该功能的代码在`source/_includes/head.html`文件中：

```
{% capture description %}{% if page.description %}{{ page.description }}{% else %}{{ content | raw_content }}{% endif %}{% endcapture %}
  <meta name="description" content="{{ description | strip_html | condense_spaces | truncate:150 }}">
{% if page.keywords %}<meta name="keywords" content="{{ page.keywords }}">{% endif %}
```

此外，还可以在`_config.yml`里添加默认的`description`和`keywords`，不过我没试过。



##界面相关

* 博客首页显示文章摘要

默认情况下，博客首页文章列表中都会全部展示，要想让文章在首页中只显示一部分配置也非常简单：

首先在文章列表中你想展示的缩略部分增加标记：

```
 <!-- more -->

```


然后自定义`_config.yml`中的对应设置项：

```
 excerpt_link: "阅读更多 &rarr;"
```

这样就有了我博客中现在的效果：
![read more](https://github.com/wangzz/wangzz.github.com/blob/master/images/336C83D8-ADEB-49A2-93D6-815A74509434.png?raw=true)

* 自定义侧边栏之增加category列表

下面以增加侧边栏category列表为例。

在创建新文章时，我们会填写以下属性：

```

---

layout: post
title: "自定义你的Octopress博客"
date: 2014-04-28 11:17:31 +0800
comments: true
categories: Octopress
tags: [octopress, 博客自定义, seo]
keywords: seo, octopress, analytics, 博客自定义
description: 如何自定义Octopress博客

---
```



其中的`categories`会为当前文章指定一个分类。我们可能有需要通过分类查找文章的需求，而侧边栏中默认只有最近提交列表。下面就介绍如何在侧边栏中显示文章分类列表。


首先，保存以下内容到`plugins/category_list_tag.rb`中（如果文件不存在就新创建一个）：


```
 module Jekyll
  class CategoryListTag < Liquid::Tag
    def render(context)
      html = ""
      categories = context.registers[:site].categories.keys
      categories.sort.each do |category|
        posts_in_category = context.registers[:site].categories[category].size
        category_dir = context.registers[:site].config['category_dir']
        category_url = File.join(category_dir, category.gsub(/_|\P{Word}/, '-').gsub(/-{2,}/, '-').downcase)
        html << "<li class='category'><a href='/#{category_url}/'>#{category} (#{posts_in_category})</a></li>\n"
      end
      html
    end
  end
end

Liquid::Template.register_tag('category_list', Jekyll::CategoryListTag)

```


这个插件会向liquid注册一个名为`category_list`的tag，该tag就是以li的形式将站点所有的category组织起来。


然后再增加aside，复制以下代码到`source/_includes/asides/category_list.html`（如果没有就新建）中：

```
<section>
 <h1>Categories</h1>
 <ul id="categories">
  { category_list }
 </ul>
</section>
```
注意要将`{ category_list }`中`category_list`单词的左右两边分别加个`%`,即写成下图所示样式：
![categorylist_pic](https://github.com/wangzz/wangzz.github.com/blob/master/images/D04878A8-B17E-4B76-A8FD-E4938C293B84.png?raw=true)

搞那么复杂是markdown排版问题。。。

最后更改_config.yml文件，让侧边栏链接到刚才新增加的`source/_includes/asides/category_list.html`文件：


```
default_asides: [asides/recent_posts.html, asides/category_list.html, asides/github.html, asides/delicious.html, asides/pinboard.html, asides/googleplus.html]
```

完成以上步骤后，重新部署就能看到博客的右侧边栏增加了`category`列表了。



* 自定义侧边栏之增加新浪微博

在博客中增加新浪模块是一个很好的和渎职互动方式，增加方式如下：

首先要从[新浪微博秀](http://app.weibo.com/tool/weiboshow)获取到自定义的微博秀代码，设定好微博秀样式后将代码复制下来。

然后在`source/_includes/custom/asides`目录下新建`weibo.html`文件，按照如下格式编辑该文件：

```
<section>
    <h1>新浪微博</h1>
    <ul id="weibo">
    <li>

   -- 在此插入获得的微博秀代码 --

      </li>
    </ul>
</section>
```

将刚才赋值下来的自定义微博秀代码粘贴到上述指定位置。

最后，和自定义category侧边栏一样，我们需要在`default_asides`中加入`custom/asides/weibo.html`。

重新部署后，微博秀就能正常展示啦！



* 自定义Navigation

默认的导航栏只有Blog、Archives两项，很难满足大家的要求。下面以增加about界面为例说明如何在导航栏上增加内容。

首先编辑文件`/source/_includes/custom/navigation.html`，仿照Blog和Archives的写法增加一行About：

![about](https://github.com/wangzz/wangzz.github.com/blob/master/images/1E66BCE6-EB83-42E8-AA5A-F0E66CD04A65.png?raw=true)

然后使用命令：

```
rake new_page['about']
```

创建一个页面，保存路径为`source\about\index.markdown`

编辑index.markdown文件成自己想要的样式，然后重新部署，就能看到导航栏上新增了About项目。


* 自定义Footer

界面底部的声明部分同样可以自定义，修改文件：`source/_includes/custom/footer.html`成自己想要的格式即可。


* 自定义网站主题

目前有很多第三方主题，比如：[http://opthemes.com/](http://opthemes.com/)

该网站搜集了很多漂亮的主题，对应的主题里都有安装方式。


* 新标签页打开网站中第三方链接

Octopress博客中，默认是在当前界面中打开第三方链接，这导致网站浏览者跳到第三方链接后很难回来。

将以下代码加入`source/_includes/custom/head.html`文件中：

```
> <script type="text/javascript">
> function addBlankTargetForLinks () {
>   $('a[href^="http"]').each(function(){
>       $(this).attr('target', '_blank');
>   });
> }
> 
> $(document).bind('DOMNodeInserted', function(event) {
>  addBlankTargetForLinks();
> });
> </script>
```
记得把左侧的`>`符号都去掉。

不过本站的链接还是会在当前界面中打开。

## 返回顶部按钮

文章较长时，返回顶部按钮还是很有用的。下面方法介绍了如何添加一个返回顶部按钮：

* 实现返回按钮功能

首先创建`source/javascripts/top.js`，添加如下代码实现滑动返回顶部效果:
```
function goTop(acceleration, time)
{
        acceleration = acceleration || 0.1;
        time = time || 16;

        var x1 = 0;
        var y1 = 0;
        var x2 = 0;
        var y2 = 0;
        var x3 = 0;
        var y3 = 0;

        if (document.documentElement)
        {
                x1 = document.documentElement.scrollLeft || 0;
                y1 = document.documentElement.scrollTop || 0;
        }
        if (document.body)
        {
                x2 = document.body.scrollLeft || 0;
                y2 = document.body.scrollTop || 0;
        }
        var x3 = window.scrollX || 0;
        var y3 = window.scrollY || 0;

        var x = Math.max(x1, Math.max(x2, x3));
        var y = Math.max(y1, Math.max(y2, y3));

        var speed = 1 + acceleration;
        window.scrollTo(Math.floor(x / speed), Math.floor(y / speed));

        if(x > 0 || y > 0)
        {
                var invokeFunction = "goTop(" + acceleration + ", " + time + ")";
                window.setTimeout(invokeFunction, time);
        }
}
```

* 自定义返回按钮格式

创建`source/_includes/custom/totop.html`，设置返回顶部按钮样式和位置，代码如下：

```
<!--返回顶部开始-->
<div id="full" style="width:0px; height:0px; position:fixed; right:180px; bottom:150px; z-index:100; text-align:center; background-color:transparent; cursor:pointer;">
	<a href="#" onclick="goTop();return false;"><img src="/images/top.png" border=0 alt="返回顶部"></a>
</div>
<script src="/javascripts/top.js" type="text/javascript"></script>
<!--返回顶部结束-->
```

* 选择按钮图片

找到自己喜爱的返回按钮图片，命名为`top.png`后添加到`source/images`目录中（或修改`totop.html`中图片的路径）。

## 自定义域名

使用[Github Pages](https://pages.github.com/)服务搭建好博客以后，默认的访问地址是`yourname.github.io`形式的二级域名。大家一定迫不及待的想换成自己的个性域名了。

* 购买域名

到各大域名购买网站购买自己心仪的域名

* 获取自己github二级域名的IP

以我的域名`wangzz.github.io`为例，输入以下命令：

```
$dig wangzz.github.io
```

在输出内容中找到`ANSWER SECTION`一项，比如我的：

```
ANSWER SECTION:
wangzz.github.io.	3599	IN	CNAME	github.map.fastly.net.
github.map.fastly.net.	29	IN	A	103.235.222.168
```

可以看到我的IP是`103.235.222.168`。

* 添加A记录

得到IP以后，需要到你的域名解析服务商处添加一个A记录，将你的域名解析成对应的IP。

经过以上步骤，访问`wangzz.github.io`的地址就会自动跳转到自己的域名了。不过更改需要等一段时间才能生效。


##参考文章

* [SEO统计](http://blog.csdn.net/lcliliil/article/details/13727927)

* [增加category列表](http://codemacro.com/2012/07/18/add-category-list-to-octopress/)

* [Theming & Customization](http://octopress.org/docs/theme/template/)

* [Add About Page](http://asaf.github.io/blog/2013/07/08/blogging-with-octopress-add-about-page/)

* [新标签页打开第三方链接](http://www.blogjava.net/lishunli/archive/2013/01/20/394478.html)

* [增加新浪微博秀](http://blog.csdn.net/lcliliil/article/details/13725895)

* [Octopress主题样式修改](http://812lcl.com/blog/2013/10/27/octopresszhu-ti-yang-shi-xiu-gai/)


