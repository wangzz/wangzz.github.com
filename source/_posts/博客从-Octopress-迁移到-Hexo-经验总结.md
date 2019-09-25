---
title: Octopress 迁移 Hexo 经验总结
date: 2019-09-24 20:30:23
tags: [Octopress, hexo]
---


## 迁移过程

迁移过程网上有很多现成的文章，这里主要参考巧叔的 [从 Octopress 迁移到 Hexo](https://blog.devtang.com/2016/02/16/from-octopress-to-hexo/)

#### 安装 Hexo

先使用以下命令安装 Hexo：

```zsh
$ npm install hexo-cli -g
```

#### 创建新的博客目录

```zsh
$ hexo init <hexo root folder>
$ cd <hexo root folder>
$ npm install
```

<!-- more -->

#### 迁移配置

* 迁移文章

把以前 Octopress 的 `source/_post` 目录下的文章，拷贝到 Hexo 的同名目录下即可。

* 迁移图片资源

以前的图片目录，也可以直接拷贝到 `source/images` 目录下。

* 修改 _config.yml 文件

上一步生成的 Hexo 目录里，_config.yml 都是默认值，可以根据自己需要修改。

#### 提交到远端仓库

* clone Octopress source 仓库到本地

远程仓库还是使用原来 github 和 gitcafe 上的仓库，所以我的做法是将原来 github 上的 source 分支仓库 clone 到本地：

```zsh
$ git clone -b source git@github.com:username/username.github.com.git hexo
```

* 将 hexo 目录里的文件都删除，当然除了 .git 目录外；

* 将 <hexo root folder> 目录里生成的东西全部拷贝到 hexo 目录；

* 强制推送到远端 `git push origin source -f `

到这里 Hexo 博客的 source 部分迁移完成，接下来就可以生成博客了。

## 生成博客

生成博客很简单，执行以下命令即可：

```zsh
$ hexo clean
$ hexo generate
```

generate 命令会创建一个 public 目录（前面的 clean 命令会先删除这个目录，如果有），这个目录是实际的博客目录。

为了方便操作，生成博客并提交写了个 deploy 脚本：

```zsh
#! /bin/zsh

# git pull source
echo "**************BEGIN GIT PULL SOURCE**************"
git pull origin source

if [ $? != 0 ]
then
echo "**************GIT PULL SOURCE FAILED**************"
exit 1
else
echo "**************GIT PULL SOURCE SUCCESS**************"
fi


# hexo generate
echo "**************BEGIN HEXO GENERATE**************"
hexo clean
hexo generate

if [ $? != 0 ]
then
echo "**************HEXO GENERATE FAILED**************"
exit 1
else
echo "**************HEXO GENERATE SUCCESS**************"
fi


# git push source
echo "**************GIT PUSH BEGIN**************"
git add --all .
git commit -m "update at `date` "
git push origin source
if [ $? != 0 ]
then
echo "**************GIT PUSH FAILED**************"
exit 1
else
echo "**************GIT PUSH SUCCESS**************"
fi


# 创建发布用 git 仓库
cd public
git init
git add .
git commit -m "update at `date` "

# 添加 coding.net 源
echo "**************PUSH TO CODING.NET BEGIN**************"
# 改变 coding.net remote url
git remote add coding git@git.coding.net:foogry/foogry.git >> /dev/null 2>&1
# 提交博客内容
git push -u coding master:coding-pages -f

if [ $? != 0 ]
then
echo "**************PUSH TO CODING.NET FAILED**************"
exit 1
else
echo "**************PUSH TO CODING.NET SUCCESS**************"
fi

# 添加 github 源
echo "**************PUSH TO GITHUB BEGIN**************"
# 改变 github remote url
git remote add origin git@github.com:wangzz/wangzz.github.com.git >> /dev/null 2>&1
# 提交博客内容
git push origin master -f

if [ $? != 0 ]
then
echo "**************PUSH TO GITHUB FAILED**************"
exit 1
else
echo "**************PUSH TO GITHUB SUCCESS**************"
fi

cd -

echo "**************DONE**************"
```

我把这个脚本放在了博客 souce 的根目录下每次修改完 source 后，执行一次，博客就能更新了。

## 写新博客

使用下述命令可以生成一个新的 markdown 文件：

```zsh
$ hexo new "文章标题"
```

写完文章后执行前面的 deploy 脚本就行了。

## 在新电脑上配置已经存在的 Hexo 博客

#### 安装 Hexo

如果没安装过 Hexo，跟新建博客一样要先安装 ：

```zsh
$ npm install hexo-cli -g
$ npm install hexo --save
```

#### clone Hexo source 到本地

```zsh
$ git clone -b source git@github.com:wangzz/wangzz.github.com.git hexo
```

#### 部署博客

进入到 hexo 的 source 目录，执行 deploy 脚本即可。

#### SSH key

clone source 或提交博客到 github 或 gitcafe 前，需要将将当前电脑上的 SSH key 填到 github 或 gitcafe 上，具体操作方式见之前的文章 [《让Octopress博客在多台Mac上同时使用》](http://foggry.com/2014/04/02/2014-04-02-ru-he-pei-zhi-rang-ni-de-octopressbo-ke-zai-duo-tai-macshang-tong-shi-shi-yong/)



## 参考文档

* [从 Octopress 迁移到 Hexo](https://blog.devtang.com/2016/02/16/from-octopress-to-hexo/)

* [Hexo搭建博客教程]([https://thief.one/2017/03/03/Hexo%E6%90%AD%E5%BB%BA%E5%8D%9A%E5%AE%A2%E6%95%99%E7%A8%8B/](https://thief.one/2017/03/03/Hexo搭建博客教程/))