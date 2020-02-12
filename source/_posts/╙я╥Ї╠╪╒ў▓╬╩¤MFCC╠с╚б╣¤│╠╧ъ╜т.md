---
title: 语音特征参数MFCC提取过程详解
date: 2016-09-19 22:00:24
tags:
categories: 分享集
thumbnail: http://i1.piimg.com/567571/8d00f04e63e5752f.png
---

在语音处理领域里，梅尔频率倒谱(mel-frequency cepstrum简称MFC)表示一个语音的短时功率谱，是一个语音的对数功率谱在频率的一个非线性梅尔刻度上进行线性余弦转换所得。
## MFCC概述

所有的梅尔频率倒谱系数(Mel-frequency cepstral coefficients  简称MFCC)共同的组成一个MFC。MFCCs在Mel标度频率域提取出来的倒谱参数。倒谱和梅尔频率倒谱之间的差别是在MFC中，频带在梅尔刻度上是等间隔的，这比利用线性间隔频带的倒谱更接近于人类的听觉特性。

梅尔倒谱系数（Mel-scale Frequency Cepstral Coefficients，简称MFCC）。根据人耳听觉机理的研究发现，人耳对不同频率的声波有不同的听觉敏感度。从200Hz到5000Hz的语音信号对语音的清晰度影响对大。两个响度不等的声音作用于人耳时，则响度较高的频率成分的存在会影响到对响度较低的频率成分的感受，使其变得不易察觉，这种现象称为掩蔽效应。由于频率较低的声音在内耳蜗基底膜上行波传递的距离大于频率较高的声音，故一般来说，低音容易掩蔽高音，而高音掩蔽低音较困难。在低频处的声音掩蔽的临界带宽较高频要小。所以，人们从低频到高频这一段频带内按临界带宽的大小由密到疏安排一组带通滤波器，对输入信号进行滤波。将每个带通滤波器输出的信号能量作为信号的基本特征，对此特征经过进一步处理后就可以作为语音的输入特征。由于这种特征不依赖于信号的性质，对输入信号不做任何的假设和限制，又利用了听觉模型的研究成果。因此，这种参数比基于声道模型的LPCC相比具有更好的鲁邦性，更符合人耳的听觉特性，而且当信噪比降低时仍然具有较好的识别性能。
梅尔倒谱系数（Mel-scale Frequency Cepstral Coefficients，简称MFCC）是在Mel标度频率域提取出来的倒谱参数，Mel标度描述了人耳频率的非线性特性，它与频率的关系可用下式近似表示：
!式中f为频率，单位为Hz。![下图展示了Mel频率与线性频率的关系：](http://i4.buimg.com/567571/30101a853606f79a.png)
## MFCC的提取过程
基本流程图如下所示![：](http://i4.buimg.com/567571/b9f554db65843806.png)
### 预加重
预加重处理其实是将语音信号通过一个高通滤波器。预加重的目的是提升高频部分，使信号的频谱变得平坦，保持在低频到高频的整个频带中，能用同样的信噪比求频谱。同时，也是为了消除发生过程中声带和嘴唇的效应，来补偿语音信号受到发音系统所抑制的高频部分，也为了突出高频的共振峰。

### 分帧
先将N个采样点集合成一个观测单位，称为帧。通常情况下N的值为256或512，涵盖的时间约为20~30ms左右。为了避免相邻两帧的变化过大，因此会让两相邻帧之间有一段重叠区域，此重叠区域包含了M个取样点，通常M的值约为N的1/2或1/3。通常语音识别所采用语音信号的采样频率为8KHz或16KHz，以8KHz来说，若帧长度为256个采样点，则对应的时间长度是256/8000×1000=32ms。

### 加窗
将每一帧乘以汉明窗，以增加帧左端和右端的连续性。假设分帧后的信号为S(n), n=0,1…,N-1, N为帧的大小，那么乘上汉明窗后，![W(n)形式如下：](http://i4.buimg.com/567571/40616a69a003fdb5.png)

不同的a值会产生不同的汉明窗，一般情况下a取0.46

### 快速傅立叶变换(FFT)
由于信号在时域上的变换通常很难看出信号的特性，所以通常将它转换为频域上的能量分布来观察，不同的能量分布，就能代表不同语音的特性。所以在乘上汉明窗后，每帧还必须再经过快速傅里叶变换以得到在频谱上的能量分布。对分帧加窗后的各帧信号进行快速傅里叶变换得到各帧的频谱。并对语音信号的频谱取模平方得到语音信号的功率谱。![设语音信号的DFT为:](http://i4.buimg.com/567571/7bded251e1eef088.png)式中x(n)为输入的语音信号，N表示傅里叶变换的点数。

### 三角带通滤波器
三角形带通滤波器组的设计过程如下：假设语音信号的采样频率,帧长N=256，滤波器个数K=22.由此可得语音信号的最大频率为![：](http://i2.muimg.com/567571/f4ae206f2de2033a.png)
![根据公式：]()http://i4.buimg.com/567571/a2cb6880c19f3df6.png可以求得出最大的Mel频率。
由于在Mel刻度范围内，各个三角滤波器的中心频率是相等间隔的线性分布。由此，可以计算两个相邻三角滤波器的中心频率的间距为：(http://i1.piimg.com/567571/9b6787110581809b.png)
因此，各三角形滤波器在mel刻度上的中心频率可以由Mel频率与线性频率的关系式求出。

由上面的中心频率可以计算出对应的线性刻度上的频率。![如下图所示：](http://i2.muimg.com/567571/8b4d169ffeebcbb4.png)
将功率谱通过一组Mel尺度的三角形滤波器组，定义一个有K个滤波器的滤波器组（滤波器的个数和临界带的个数相近），采用的滤波器为三角滤波器，中心频率为f(m),m=1,2,...,K。K通常取22-26。各 f(m)之间的间隔随着m值的减小而缩小，随着m值的增大而增宽，

每一个三角形滤波器的中心频率c(l) 在Mel频率轴上等间隔分布。设o(l),c(l),h(l) 分别是第l 个三角形滤波器的下限，中心，和上限频率，则相邻三角形滤波器之间的下限，中心，上限频率的关系如下：c(l)=h(l-1)=o(l+1);  如图所示![：](http://i4.buimg.com/567571/47d4ea5baf1ec728.png)
###  计算每个滤波器组输出的对数能量为:
(http://i4.buimg.com/567571/f38f2ce76b6f9def.png)
### 经离散余弦变换（DCT）得到MFCC系数：
将上述的对数能量带入离散余弦变换，求出L阶的Mel-scale Cepstrum参数。L阶指MFCC系数阶数，通常取12-16。这里M是三角滤波器个数。

### 对数能量
此外，一帧的音量（即能量），也是语音的重要特征，而且非常容易计算。因此，通常再加上一帧的对数能量（定义：一帧内信号的平方和，再取以10为底的对数值，再乘以10）使得每一帧基本的语音特征就多了一维，包括一个对数能量和剩下的倒频谱参数。

注：若要加入其它语音特征以测试识别率，也可以在此阶段加入，这些常用的其它语音特征包含音高、过零率以及共振峰等。

### 动态差分参数的提取（包括一阶差分和二阶差分）
标准的倒谱参数MFCC只反映了语音参数的静态特性，语音的动态特性可以用这些静态特征的差分谱来描述。实验证明：把动、静态特征结合起来才能有效提高系统的识别性能。
### 总结：

因此，MFCC的全部组成其实是由：

N维MFCC参数（N/3 MFCC系数+ N/3 一阶差分参数+ N/3 二阶差分参数）+帧能量（此项可根据需求替换）

## 具体实现
### MATLAB实现
''' bash
% MFCC implement with Matlab % 
[x fs]=wavread('test.wav');
bank=melbankm(24,256,fs,0,0.4,'t'); %Mel滤波器的阶数为24，FFT变换的长度为256，采样频率为16000Hz
%归一化Mel滤波器组系数
bank=full(bank); %full() convert sparse matrix to full matrix 
bank=bank/max(bank(:)); 
for k=1:12 
    n=0:23; 
    dctcoef(k,:)=cos((2*n+1)*k*pi/(2*24));
end  
w=1+6*sin(pi*[1:12]./12);%归一化倒谱提升窗口
w=w/max(w);%预加重滤波器  
xx=double(x);  
xx=filter([1-0.9375],1,xx);%语音信号分帧  
xx=enframe(xx,256,80);%对xx 256点分为一帧  
%计算每帧的MFCC参数  
for i=1:size(xx,1)  
    y=xx(i,:);  
    s=y'.*hamming(256);  
    t=abs(fft(s));%FFT快速傅里叶变换  
    t=t.^2;  
    c1=dctcoef*log(bank*t(1:129));  
    c2=c1.*w';  
    m(i,:)=c2;  
end  
%求一阶差分系数  
dtm=zeros(size(m));  
for i=3:size(m,1)-2  
    dtm(i,:)=-2*m(i-2,:)-m(i-1,:)+m(i+1,:)+2*m(i+2,:);  
end  
dtm=dtm/3;  
%求取二阶差分系数  
dtmm=zeros(size(dtm));  
for i=3:size(dtm,1)-2  
    dtmm(i,:)=-2*dtm(i-2,:)-dtm(i-1,:)+dtm(i+1,:)+2*dtm(i+2,:);  
end  
dtmm=dtmm/3;  
%合并mfcc参数和一阶差分mfcc参数  
ccc=[m dtm dtmm];  
%去除首尾两帧，以为这两帧的一阶差分参数为0  
ccc=ccc(3:size(m,1)-2,:);  
ccc;  
subplot(2,1,1);  
ccc_1=ccc(:,1);  
plot(ccc_1);title('MFCC');ylabel('幅值');  
[h,w]=size(ccc);  
A=size(ccc);  
subplot(2,1,2);  
plot([1,w],A);  
xlabel('维数');ylabel('幅值');  
title('维数与幅值的关系'); 
'''

![所得结果为：](http://i1.piimg.com/567571/0f67ecb1f9e4e8a7.png)

### HTK(HTK Speech Recognition Toolkit)工具包提取MFCC：
cd ~/HTK/htk/bin.win32/下运行如下指令:
''' bash
再配置文件夹下运行： HCopy config 8.wav 8.mfcc 其中，涉及mfcc的参数为： TARGETKIND=MFCC_E_D_A -目标是MFCC文件，以及energy(E), delta(D),delta-delta(A) TARGETRATE=100000 -窗间隔为10ms WINDOWSIZE=250000 -窗长为25ms 注：HTK中时间单位为100ns ZMEANSOURCE=T -将来源文件取zero mean,即去掉DC值 USEHAMMING=T -使用hamming window PREEMCOEF=0.97 -预加重系数0.97 NUMCHANS=31 -在MEL刻度下等分成31个频带 USEPOWER=F -不使用c(0)参数 
'''

### OpenSMILE工具包提取MFCC：
对于批量提取的wav音频数据的MFCC特征，可以将提取指令写入批处理文件，执行即可。
cd ~/opensmile/bin/Win32/下运行如下指令:
''' bash
SMILExtract_Release -C E:\speakerData\opensmile-2.3.0\config\MFCC12_E_D_A_Z.conf -I	E:\深度学习\基于声音的场景识别\音频数据集\TUT-acoustic-scenes-2016-development.audio\TUT-acoustic-scenes-2016-development.Audio.All\audio\a001_0_30.wav	-O	E:\深度学习\基于声音的场景识别\音频数据集\TUT-acoustic-scenes-2016-development.audio\TUT-acoustic-scenes-2016-development.Audio.All\DNNmfcc\a001_0_30.mfcc
'''

