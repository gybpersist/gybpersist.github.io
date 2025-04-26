---
title: 数据结构八（插入排序InsertSort）
#tags: [数据结构—插入排序]          # 标签
tags: 
- 数据结构          # 标签
- 插入排序
categories: 
- 数据结构   # 分类
- 八 插入排序     # 子分类
top_img: /img/11.png # 顶部背景图
#sticky: 10              #置顶 越大越优先
cover: /img/封面/cover (7).png   # 文章封面
---
## 前言

插入排序 是把无序序列依次插入到有序序列，一般是从尾部开始比较

 ![插入排序](/img/文章/数据结构八（插入排序InsertSort）/插入排序.jpg "插入排序")

More info: [InsertSort](https://github.com/gybpersist/InsertSort)

##  插入排序（InsertSort）

### 把无序序列的第一个当有序序列，然后每次从无序序列中拿出一个元素 在有序序列中进行比较（一般是从尾部开始比较）
### 1.如果比较结果为 待插入大于被比较的有序元素 则把待插入元素插入到被比较的有序元素后面 
### 2.如果比较结果为 待插入小于被比较的有序元素 则把被比较的元素向后移动一位（依次与有序元素进行比较）直到来到首位或大于被比较的元素

``` c
bool InsertSort(int buf[],int bufsize)
{
    //备份元素
    int temp=0;

    //1 选择第一个元素作为已经排序过的，剩下的元素作为无序序列
    for (int i = 1; i < bufsize; ++i)
    {
        //备份待插入元素
        temp = buf[i];
        //备份待插入元素下标
        int subscript=i;

        //把当前待插入元素与有序序列中元素进行比较，从有序序列尾部开始
        for (int j = i-1 ; j >= 0 ; j--)
        {
            //当待插入元素 > 当待插入元素前面的值
            if(temp >= buf[j])
            {
                break;
            }

            //当待插入元素 < 当待插入元素前面的值
            if(temp < buf[j])
            {
                subscript=j;
                //把待插入元素前面的值向后移动
                buf[j + 1] = buf[j];
            }
        }
        //把待插入元素插入指定位置
        buf[subscript]=temp;
    }
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

    InsertSort(buf, sizeof(buf)/ sizeof(buf[1]));

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

//插入排序 是把无序序列依次插入到有序序列，一般是从尾部开始比较
bool InsertSort(int buf[],int bufsize)
{
    //备份元素
    int temp=0;

    //1 选择第一个元素作为已经排序过的，剩下的元素作为无序序列
    for (int i = 1; i < bufsize; ++i)
    {
        //备份待插入元素
        temp = buf[i];
        //备份待插入元素下标
        int subscript=i;

        //把当前待插入元素与有序序列中元素进行比较，从有序序列尾部开始
        for (int j = i-1 ; j >= 0 ; j--)
        {
            //当待插入元素 > 当待插入元素前面的值
            if(temp >= buf[j])
            {
                break;
            }

            //当待插入元素 < 当待插入元素前面的值
            if(temp < buf[j])
            {
                subscript=j;
                //把待插入元素前面的值向后移动
                buf[j + 1] = buf[j];
            }
        }
        //把待插入元素插入指定位置
        buf[subscript]=temp;
    }
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

    InsertSort(buf, sizeof(buf)/ sizeof(buf[1]));

    Prin(buf,sizeof(buf)/ sizeof(buf[1]));

    return 0;
}
```