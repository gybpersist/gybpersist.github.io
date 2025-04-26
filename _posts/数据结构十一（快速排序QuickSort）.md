---
title: 数据结构十一（快速排序QuickSort）
#tags: [数据结构—快速排序]          # 标签
tags: 
- 数据结构          # 标签
- 快速排序
categories: 
- 数据结构   # 分类
- 十一 快速排序     # 子分类
top_img: /img/11.png # 顶部背景图
#sticky: 10              #置顶 越大越优先
cover: /img/封面/cover (10).png   # 文章封面
---
## 前言

记录key，key一般都是最左边，目的就是为了把key排到正确的位置，同时将key设为坑位  
开始坑在左边，右边开始找值补坑，right找到比key小的值，放入坑位，right形成新的坑  
现在坑在右边，左边开始找值补坑，left找到比key大的值，放入坑位，left形成新的坑  
直到left和right相遇就结束，最后把key放到坑位，key就排到正确的位置

 ![快速排序](/img/文章/数据结构十一（快速排序QuickSort）/快速排序.gif "快速排序")

More info: [QuickSort](https://github.com/gybpersist/QuickSort)

##  快速排序（QuickSort）

``` c
bool QuickSort(int buf[],int begin,int end)
{
    //备份关键元素
    int temp = 0;

    //备份首元素下标，尾元素下标
    int left = begin,right = end;

    //1 避免元素为空
    if(begin < end)
    {
        //备份关键元素(把首元素先作为关键元素)
        temp = buf[begin];

        //当左右找到相同元素是停止
        while (left != right)
        {
            //先是从右向左找 找到比关键元素大的，不交换，然后向左移动（h--）,直到找到比关键元素小的
            while (left < right && buf[right] >= temp)
            {
                right--;
            }

            //判断左右两边是否指到同一个位置，不是则把 比关键元素小的元素放到关键元素位置上
            if(left < right)
            {
                //比关键元素小的元素放到关键元素位置上
                buf[left] = buf[right];
                left++;
            }

            //然后是从左向右找 找到比关键元素小的，不交换，然后向左移动（right--）,直到找到比关键元素小的
            while (left < right && buf[left] <= temp)
            {
                left++;
            }

            //判断左右两边是否指到同一个位置，不是则把 比关键元素大的元素放到关键元素位置上
            if(left < right)
            {
                //比关键元素小的元素放到关键元素位置上
                buf[right] = buf[left];
                right--;
            }
        }

        //左右两边指到同一个位置(buf[left] = buf[right]) 把关键元素放到这个位置上
        buf[left] = temp;

        //在基准元素归位之后，数组被分成了两个子数组：
        //左子数组：从begin到left - 1
        //右子数组：从left + 1到end

        //随后，对这两个子数组分别调用QuickSort函数进行递归排序：
        //对左子数组进行排序
        QuickSort(buf,begin,left-1);

        //右子数组进行排序
        QuickSort(buf,left+1,end);
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

    QuickSort(buf, 0,9);

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

//记录key，key一般都是最左边，目的就是为了把key排到正确的位置，同时将key设为坑位
//开始坑在左边，右边开始找值补坑，right找到比key小的值，放入坑位，right形成新的坑
//现在坑在右边，左边开始找值补坑，left找到比key大的值，放入坑位，left形成新的坑
//直到left和right相遇就结束，最后把key放到坑位，key就排到正确的位置

// 快速排序
bool QuickSort(int buf[],int begin,int end)
{
    //备份关键元素
    int temp = 0;

    //备份首元素下标，尾元素下标
    int left = begin,right = end;

    //1 避免元素为空
    if(begin < end)
    {
        //备份关键元素(把首元素先作为关键元素)
        temp = buf[begin];

        //当左右找到相同元素是停止
        while (left != right)
        {
            //先是从右向左找 找到比关键元素大的，不交换，然后向左移动（h--）,直到找到比关键元素小的
            while (left < right && buf[right] >= temp)
            {
                right--;
            }

            //判断左右两边是否指到同一个位置，不是则把 比关键元素小的元素放到关键元素位置上
            if(left < right)
            {
                //比关键元素小的元素放到关键元素位置上
                buf[left] = buf[right];
                left++;
            }

            //然后是从左向右找 找到比关键元素小的，不交换，然后向左移动（right--）,直到找到比关键元素小的
            while (left < right && buf[left] <= temp)
            {
                left++;
            }

            //判断左右两边是否指到同一个位置，不是则把 比关键元素大的元素放到关键元素位置上
            if(left < right)
            {
                //比关键元素小的元素放到关键元素位置上
                buf[right] = buf[left];
                right--;
            }
        }

        //左右两边指到同一个位置(buf[left] = buf[right]) 把关键元素放到这个位置上
        buf[left] = temp;

        //在基准元素归位之后，数组被分成了两个子数组：
        //左子数组：从begin到left - 1
        //右子数组：从left + 1到end

        //随后，对这两个子数组分别调用QuickSort函数进行递归排序：
        //对左子数组进行排序
        QuickSort(buf,begin,left-1);

        //右子数组进行排序
        QuickSort(buf,left+1,end);
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

    QuickSort(buf, 0,9);

    Prin(buf,sizeof(buf)/ sizeof(buf[1]));

    return 0;
}
```