---
title: Docker入门
date: 2021-03-11 19:09:15
tags: [Docker]
---

## 安装

通过以下步骤安装 docker：

* 设置 docker repository

  ```
  $ sudo yum install -y yum-utils
  $ sudo yum-config-manager \
      --add-repo \
      https://download.docker.com/linux/centos/docker-ce.repo
  ```

  设置成功以后，后续就可以通过这个仓库安装或更新 docker 了。

* 安装 docker 引擎

  ```
  $ sudo yum install docker-ce docker-ce-cli containerd.io
  ```

* 启动 docker 

  ```
  $ sudo systemctl start docker
  ```

  或者：

  ```
  $ sudo service docker start
  ```

<!-- more -->

## 常用命令

* 列出已安装的 docker 镜像

  ```
  # 列出本机的所有 image 文件。
  $ docker image ls
  ```

* 删除镜像

  ```
  # 删除 image 文件
  $ docker image rm [imageName]
  ```

* 终止当前运行的容器

  对于运行后不会自动终止的容器，需要手动终止：

  ```
  $ docker container kill [containID]
  ```

  

## 参考文档

* [Install Docker Engine on CentOS](https://docs.docker.com/engine/install/centos/)

