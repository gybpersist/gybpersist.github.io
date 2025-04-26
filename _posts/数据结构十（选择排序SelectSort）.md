---
title: 数据结构十（选择排序SelectSort）
#tags: [数据结构—选择排序]          # 标签
tags: 
- 数据结构          # 标签
- 选择排序
categories: 
- 数据结构   # 分类
- 十 选择排序     # 子分类
top_img: /img/11.png # 顶部背景图
#sticky: 10              #置顶 越大越优先
cover: /img/封面/cover (9).png   # 文章封面
---
## 前言

选择排序 从序列中找到一个最小元素，把最小元素放到整个序列的首部，重复n轮，直到整个序列有序

 ![选择排序](/img/文章/数据结构十（选择排序SelectSort）/选择排序.gif "选择排序")

More info: [SelectSort](https://github.com/gybpersist/SelectSort)

##  选择排序（SelectSort）

### 选择排序 从序列中找到一个最小元素，把最小元素放到整个序列的首部，重复n轮，直到整个序列有序

``` c
bool SelectSort(int buf[],int bufsize)
{
    //备份交换元素
    int temp = 0;

    //1 通过线性查找找到最小元素，需要比较 n-1 轮（最后一轮不用排）
    for (int n = 0; n < bufsize-1; ++n)
    {
        //假设每轮序列中第一个元素为最小
        int min = n;

        //找到最小元素的下标（m=n为自己和自己比,可以优化掉）
        for (int m = n+1; m < bufsize; ++m)
        {
            //比较找到最小元素下标
            if(buf[min] > buf[m])
            {
                //更新最小值下标
                min = m;
            }
        }
        //把最小元素放到前面（交换元素）
        temp = buf[n];
        buf[n] = buf[min];
        buf[min] = temp;
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

    SelectSort(buf, sizeof(buf)/ sizeof(buf[1]));

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

// 选择排序 从序列中找到一个最小元素，把最小元素放到整个序列的首部，重复n轮，直到整个序列有序
bool SelectSort(int buf[],int bufsize)
{
    //备份交换元素
    int temp = 0;

    //1 通过线性查找找到最小元素，需要比较 n-1 轮（最后一轮不用排）
    for (int n = 0; n < bufsize-1; ++n)
    {
        //假设每轮序列中第一个元素为最小
        int min = n;

        //找到最小元素的下标（m=n为自己和自己比,可以优化掉）
        for (int m = n+1; m < bufsize; ++m)
        {
            //比较找到最小元素下标
            if(buf[min] > buf[m])
            {
                //更新最小值下标
                min = m;
            }
        }
        //把最小元素放到前面（交换元素）
        temp = buf[n];
        buf[n] = buf[min];
        buf[min] = temp;
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

    SelectSort(buf, sizeof(buf)/ sizeof(buf[1]));

    Prin(buf,sizeof(buf)/ sizeof(buf[1]));

    return 0;
}
```