---
title: 数据结构九（冒泡排序BubbleSort）
#tags: [数据结构—冒泡排序]          # 标签
tags: 
- 数据结构          # 标签
- 冒泡排序
categories: 
- 数据结构   # 分类
- 九 冒泡排序     # 子分类
top_img: /img/11.png # 顶部背景图
#sticky: 10              #置顶 越大越优先
cover: /img/封面/cover (8).png   # 文章封面
---
## 前言

插入排序 是把无序序列依次插入到有序序列，一般是从尾部开始比较

 ![冒泡排序](/img/文章/数据结构九（冒泡排序BubbleSort）/冒泡排序.gif "插入排序")

More info: [BubbleSort](https://github.com/gybpersist/BubbleSort)

##  冒泡排序（BubbleSort）

### 元素两两之间进行交换，需要比较n轮(n初值为1)，每轮需要 bufsize-n 次(从左到右比较，升序)

``` c
bool BubbleSort(int buf[],int bufsize)
{
    //备份元素 临时存储交换值
    int temp=0;

    //1 循环比较元素，比较的第n轮，总共需要比较(bufsize-1)轮
    for (int n = 1; n < bufsize; n++)
    {
        //每轮比较中需要 两两比较 的次数为（n=1 两两比较bufsize-1次；n=2 两两比较bufsize-2次...）
        for (int m = 0 ; m < bufsize-n ; m++)
        {
            //两两比较
            if(buf[m] > buf[m+1])
            {
                temp=buf[m];
                buf[m]=buf[m+1];
                buf[m+1]=temp;
            }
        }
    }
    return true;
}
```
##  遍历元素（Prin）

``` c
bool Prin(int buf[],int size)
{
    printf("Element:");
    for(int i= 0;i< size;i++)
    {
        printf("%d  ",buf[i]);
    }
    printf("\n");
    return true;
}
```

##  main主程序

``` c
int main()
{
    //定义一个数组 10个整数
    int buf[10]={2,4,1,6,8,2,6,1,7,4};

    Prin(buf,sizeof(buf)/ sizeof(buf[1]));

    BubbleSort(buf, sizeof(buf)/ sizeof(buf[1]));

    Prin(buf,sizeof(buf)/ sizeof(buf[1]));

    return 0;
}
```

##  结果验证

``` c
Element:2  4  1  6  8  2  6  1  7  4
Element:1  1  2  2  4  4  6  6  7  8

进程已结束,退出代码0
```
##  汇总

``` c
#include <stdio.h>
#include <stdbool.h>

// 冒泡排序 是元素两两之间进行交换，需要比较n轮（n初值为1），每轮需要 bufsize-n 次(从左到右比较，升序)
bool BubbleSort(int buf[],int bufsize)
{
    //备份元素 临时存储交换值
    int temp=0;

    //1 循环比较元素，比较的第n轮，总共需要比较(bufsize-1)轮
    for (int n = 1; n < bufsize; n++)
    {
        //每轮比较中需要 两两比较 的次数为（n=1 两两比较bufsize-1次；n=2 两两比较bufsize-2次...）
        for (int m = 0 ; m < bufsize-n ; m++)
        {
            //两两比较
            if(buf[m] > buf[m+1])
            {
                temp=buf[m];
                buf[m]=buf[m+1];
                buf[m+1]=temp;
            }
        }
    }
    return true;
}

//遍历元素
bool Prin(int buf[],int size)
{
    printf("Element:");
    for(int i= 0;i< size;i++)
    {
        printf("%d  ",buf[i]);
    }
    printf("\n");
    return true;
}

int main()
{
    //定义一个数组 10个整数
    int buf[10]={2,4,1,6,8,2,6,1,7,4};

    Prin(buf,sizeof(buf)/ sizeof(buf[1]));

    BubbleSort(buf, sizeof(buf)/ sizeof(buf[1]));

    Prin(buf,sizeof(buf)/ sizeof(buf[1]));

    return 0;
}
```