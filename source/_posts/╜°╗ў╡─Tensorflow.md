---
title: 进击的Tensorflow
date: 2017-04-25 22:07:47
tags:
categories: 分享集
thumbnail: http://i2.muimg.com/567571/8a8c33b8e8f2438c.png
---

开源人工智能神器——TensorFlow

# TensorFlow安装
## 编译源码安装TensorFlow
参加官网[https://www.tensorflow.org/install/install_sources](https://www.tensorflow.org/install/install_sources)

本教程基于ubuntu16.04系统,安装前默认以下模块均已安装完成：python3.5,cuda8.0,cudnn 5.1.10 

### install GNU coreutils
``` bash
$ sudo apt-get install coreutils
``` 
### 安装bazel

参见官网 [https://bazel.build/versions/master/docs/install.html](https://bazel.build/versions/master/docs/install.html)

第一步
``` bash
sudo add-apt-repository ppa:webupd8team.java
sudo apt-get update
sudo apt-get install oracle-java8-installer
``` 

第二步
``` bash
echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add -
``` 


第三步
``` bash
sudo apt-get update && sudo apt-get install bazel
sudo apt-get upgrade bazel
``` 

### Configure the installation

下载tensorflow,进入目录进行配置
``` bash
git clone --recurse-submodules https://github.com/tensorflow/tensorflow
cd tensorflow
./configure
``` 

按照提示做完即可，别填错自己的Python路径，gcc路径和cuda以及cudnn路径，不然后面编译可能会失败。

### build a pip package with gpu
``` bash
$ bazel build --config=opt --config=cuda //tensorflow/tools/pip_package:build_pip_package
``` 


## 使用安装包安装TensorFlow

在安装必不可少的python-pip和python-dev

在这个窗口中输入命令：
``` bash
$ sudo apt-get install python-pip python-dev
``` 
### 安装TensorFlow CPU版本
安装完成之后，此时就可以安装TensorFlow CPU版本了了，命令如下：
``` bash
sudo pip install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.0.0-cp27-none-linux_x86_64.whl
``` 


### 安装TensorFlow GPU版本
命令如下：
``` bash
sudo pip install --upgrade https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-1.0.0-cp27-none-linux_x86_64.whl
``` 

安装成功显示如下：
![](http://i2.muimg.com/567571/b3c444e41485ce6f.png)

运行如下代码测试是否成功安装TensorFlow：
![](http://i2.muimg.com/567571/1146e7725996c190.png)

# TensorFlow相关资源：

## TensorFlow 中文社区
[http://www.tensorfly.cn/](http://www.tensorfly.cn/)

## TensorFlow 白皮书

在这份白皮书里，你可以找到关于 TensorFlow 编程模型的更多详情和 TensorFlow 的实现原理。

TensorFlow: Large-scale machine learning on heterogeneous systems [http://download.tensorflow.org/paper/whitepaper2015.pdf](http://download.tensorflow.org/paper/whitepaper2015.pdf)

## TensorFlow使用样例
[https://github.com/aymericdamien/TensorFlow-Examples](https://github.com/aymericdamien/TensorFlow-Examples)

##更多机器学习资源
[http://www.tensorfly.cn/tfdoc/mltools.html](http://www.tensorfly.cn/tfdoc/mltools.html)

# 注意事项

(1) 如果需要 GPU，那么首先安装 CUDA 和 cuDNN。 
(2) GTX1080为 Pascal 架构，需要安装 CUDA 8.0 + cuDNN 5.1.5 才能正常运行。 
(3) TensorFlow 从 0.8.0rc 开始支持多机多卡分布式计算，而更早的版本只支持单计算节点。 
