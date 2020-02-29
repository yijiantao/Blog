---
title: UbuntuKylin13.10下安装配置Theano
date: 2016-04-16 18:30:22
tags:
categories: 技术向
thumbnail: # http://i4.buimg.com/567571/6cf2c02911d0cda6.png
---

  今天在师兄的引领下开始学习基于Python的类库——Theano. 来自网上的一种说法是Theano基于表示矩阵向量的numpy和包含大量数学功能的scipy模块。对于数据的处理来说Python还是具有一定的优势。打算配置Theano时，因为官网的一句温馨提示（“除Linux64位机外，其他OS并不能很好用于测试”），才想起来打开那尘封已久的Kubuntu13.10。遂毅然决定在Ubuntu下安装配置Theano。

     在刚配置Theano时，存在使用命令apt-get下载无源的情况。鉴于这种情况，个人给出建议无非三点：

      一、切换软件源（国内好评的有网易的、搜狐的或者阿里的）或者换时间段安装；

      二、连接的网络有问题或者无线网卡驱动升级；

      三、系统版本已不受支持，要改为旧版本的源。


     本人遇到情况是属于第三种，解决方法是无非两种：
     一、升级系统到最新版本
     二、重新配置旧版本的源：
打开源列表    
``` bash
$ sudo gedit /etc/apt/sources.list
``` 
把该配置文件内的所有http:// us.archive.ubuntu.com改为http:// old-releases.ubuntu.com
执行sudo apt-get update 更新缓存。
     下载完成后，如果安装失败，可能的情况是系统先前的安装软件的Python依赖库过于庞杂，因为配置前的环境较为恶劣，请安装Theano前务必清理干净。正常安装如下图所示：![image1](http://i4.buimg.com/567571/1782df22181a5fbf.png)
``` bash
$ sudo pip install --upgrade --no-deps theano 
``` 
![image2](http://i2.muimg.com/567571/82b8ed4f76e6d38c.png)
安装完成后，测试配置是否正确：
测试指令：
``` bash
$ python -c "import numpy; numpy.test()" 
$ python -c "import scipy; scipy.test()" 
$ python -c "import theano; theano.test()" 
``` 

