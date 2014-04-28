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

* 博客侧边栏增加category列表

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



> <section>
>  <h1>Categories</h1>
>  <ul id="categories">
>   {% category_list %}
>  </ul>
> </section>


最后更改_config.yml文件，让侧边栏链接到刚才新增加的`source/_includes/asides/category_list.html`文件：


```
default_asides: [asides/recent_posts.html, asides/category_list.html, asides/github.html, asides/delicious.html, asides/pinboard.html, asides/googleplus.html]

```

完成以上步骤后，重新部署就能看到博客的右侧边栏增加了`category`列表：
![category](https://github.com/wangzz/wangzz.github.com/blob/master/images/ED4CED7F-41A1-4A2C-9681-79D73342B4B0.png?raw=true)








##参考文章

* [http://blog.csdn.net/lcliliil/article/details/13727927](http://blog.csdn.net/lcliliil/article/details/13727927)

*
