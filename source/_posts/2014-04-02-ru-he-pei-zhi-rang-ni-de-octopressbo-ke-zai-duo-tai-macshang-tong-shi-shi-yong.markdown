---
layout: post
title: "让你的Octopress博客在多台Mac上同时使用"
date: 2014-04-02 14:28:35 +0800
comments: true
categories:
 
---


前阵子在公司电脑上配置好了Octopress博客，但是想在家里的Mac上使用，开始以为简单的将仓库clone就可以了，不幸的是我想的太简单。后来在网上看到了前面列出的第一篇文章，终于解决问题。

##一、Octopress目录结构

Octopress的仓库目录下有两个branch，`source`和`master`。

1. `source`分支下保存Octopress的源代码，我们需要用他们生成博客，该分支保存在Octopress本地仓库的根目录下；

2. `master`分支下保存生成的博客内容，该分支在Octopress本地仓库的根目录下一个叫`_deploy`得文件夹中。该文件夹是以下划线开头的，会在执行`git push origin source`命令时被忽略，这也是为什么一个目录中能同时存在两个不同分支的文件夹的原因。

##二、在本地重建Octopress仓库

需要执行以下命令：

1. clone `source`分支

```
$ git clone -b source git@github.com:username/username.github.com.git octopress
```
别忘了`username`替换成你自己github用户名。
另外还要注意的是，clone的地址不能是`http`而必须得是`ssh`的。
如果执行时提示以下错误：

```
Cloning into 'octopress'...
The authenticity of host 'github.com (192.30.252.131)' can't be established.
RSA key fingerprint is 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'github.com,192.30.252.131' (RSA) to the list of known hosts.
Permission denied (publickey).
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.

```

说明你的电脑不被github信任，需要在你电脑上创建`ssh key`并添加到github中。

这是你需要执行2；
如果没出现上述错误，直接执行3。

2.创建并添加ssh key

2.1 创建ssh key

2.1.1 生成key

执行命令：

```
$ ssh-keygen -t rsa -C "your_email@example.com"
```

会提示：

```
Generating public/private rsa key pair.
Enter file in which to save the key (/Users/you/.ssh/id_rsa): [Press enter]
```

这时候按回车键(Enter)继续：

```
Enter passphrase (empty for no passphrase): [Type a passphrase]
# Enter same passphrase again: [Type passphrase again]
```

会要求你输入一个密码，4位以上，要记住，后面有用。

接下来会提示：

```
Your identification has been saved in /Users/you/.ssh/id_rsa.
# Your public key has been saved in /Users/you/.ssh/id_rsa.pub.
# The key fingerprint is:
# 01:0f:f4:3b:ca:85:d6:17:a1:7d:f0:68:9d:f0:a2:db your_email@example.com
```

到这里就说明key已经创建成功了。

2.1.2 把生成的key添加到`ssh-agent`中
最后需要执行以下命令：

```
$ ssh-add ~/.ssh/id_rsa
```

2.2 把生成的key添加到github

2.2.1 copy key内容

先执行下面的命令：

```
pbcopy < ~/.ssh/id_rsa.pub
```
该命令将key中的内容copy到粘贴板中，以便后面使用。当然你也可以用自己的方式copy。

2.2.2 找到添加key的地方

先点击[Account Settings](https://github.com/settings)：

![账户设置](https://github-images.s3.amazonaws.com/help/settings/userbar-account-settings.png)

进入设置界面后，点击界面左侧的[SSH KEYS](https://github.com/settings/ssh):

![ssh keys](https://github-images.s3.amazonaws.com/help/settings/settings-sidebar-ssh-keys.png)

点击`Add SSH key`按钮：

![add ssh key](https://github-images.s3.amazonaws.com/help/settings/ssh-add-ssh-key.png)

点击`Add key`按钮：

![add key](https://github-images.s3.amazonaws.com/help/settings/ssh-add-key.png)

在输入框内粘贴刚才copy的key，点击确定即可。

2.3 验证key可用性

通过ssh github验证key是否可用：

```
$ ssh -T git@github.com
```

命令执行后会输出：


```
The authenticity of host 'github.com (207.97.227.239)' can't be established.
RSA key fingerprint is 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48.
Are you sure you want to continue connecting (yes/no)?
```

输入`yes`如果打印以下内容，就说明OK了：

```
Hi username! You've successfully authenticated, but GitHub does not
```

 3.clone master分支

下面需要将master分支clone到`_deploy`目录：

```
$ cd octopress
$ git clone git@github.com:username/username.github.com.git _deploy 
```

 4.配置环境

执行以下命令配置环境：
 
```
$ gem install bundler
$ rbenv rehash    # If you use rbenv, rehash to be able to run the bundle command
$ bundle install
$ rake setup_github_pages 
```

执行最后一条命令时需要你输入github中博客仓库地址：

```
Enter the read/write url for your repository
(For example, 'git@github.com:your_username/your_username.github.com)
```
到此所有的工作都完成了，你就可以享受在两台电脑上使用Octopress了！


##三、Tips

1. 及时提交本地修改

在每处配置了Octopress的地方，做了任何修改都要提交，否则另一个地方做了修改，本地更新的时候肯定会冲突。

每次在本地做完修改以后，都要及时提交，分别执行以下命令：

```
$ rake generate
$ rake deploy             # update the remote master branch
```

第一条命令会使用本地的修改生成最新的blog网站，并且生成的blog会存放到`Octopress`根目录下的`public/`目录下；

第二条命令主要做了两件事：

*用`generate`命令生成在`public/`目录下的内容覆盖`_deploy/`目录下内容；

*将`_deploy/`目录下的修改`add` 、 `commit`到git，并`push`到git的`master`分支。


别以为这就结束了，你还得把source分支中做的修改提交的git仓库中，执行以下命令：

```
$ git add .
$ git commit -am "Some comment here." 
$ git push origin source  # update the remote source branch 
```
执行完这两步后，稍过一会就能看到自己blog中的更新啦！

 2.修改前先更新到最新版本

为了以防万一，在本地做任何修改前都要先做更新，可以执行以下命令分别更新`source`和`master`分支：

```
$ cd octopress
$ git pull origin source  # update the local source branch
$ cd ./_deploy
$ git pull origin master  # update the local master branch
```


##四、参考文档

本文参考了以下两篇文章：

1. [**Clone Your Octopress to Blog From Two Places**](http://blog.zerosharp.com/clone-your-octopress-to-blog-from-two-places/)

2. [**Generating SSH Keys**](https://help.github.com/articles/generating-ssh-keys)

