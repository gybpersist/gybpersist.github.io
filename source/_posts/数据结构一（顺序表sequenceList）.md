---
title: 数据结构一（顺序表sequenceList）
#tags: [数据结构—顺序表]          # 标签
tags: 
- 数据结构          # 标签
- 顺序表
categories: 
- 数据结构   # 分类
- 一 顺序表     # 子分类
top_img: /img/11.png # 顶部背景图
#sticky: 10              #置顶 越大越优先
cover: /img/封面/cover.png   # 文章封面
---

<!-- 文章内跳转
[文章内目录](#前言)
<p id = "前言"></p> 
-->

## 前言
 创建一个顺序表实现对顺序表内元素的  
 ——增加（头插 指定位置插入 尾插）
 ——删除（头删 指定位置删除 尾删）
 ——遍历顺序表

![顺序表](/img/文章/数据结构一（顺序表sequenceList）/顺序表.png "顺序表")

More info: [sequenceList](https://github.com/gybpersist/sequenceList)

##  构造顺序表（sequenceList）

### 构造顺序表记录参数(顺序表的首地址 顺序表的容量 顺序表的有效元素的下标)

``` c
//类型别名
typedef int dataType_t;
typedef struct sequenceList {
    dataType_t *Addr;       //顺序表的首地址
    unsigned int size;      //顺序表的容量
    int last;               //顺序表的有效元素的下标
} sqList_t;
```
##  创建顺序表并对顺序表进行初始化（sqList_Create）

``` c
sqList_t *sqList_Create(unsigned int size)
{
    //1.1 利用calloc为顺序表的管理结构体申请堆内存
    sqList_t *manager = (sqList_t*)calloc(1,sizeof (manager));

    if(NULL == manager)
    {
        perror("calloc memory for manager is failed");
        exit(-1);       //程序终止
    }

    //1.2 为所有元素申请堆内存 calloc,并完成错误处理
    manager->Addr = (dataType_t*)calloc(size,sizeof(dataType_t));

    if(NULL == manager->Addr)
    {
        perror("calloc memory for element is failed");
        free(manager);  //释放内存
        exit(-1);       //程序终止
    }

    //1.3 对管理顺序表的结构体进行初始化（元素容量 最后元素下标）
    manager->size = size; //对顺序表的容量进行初始化
    manager->last = -1;   //由于顺序表为空，则最后元素下标初值为-1

    return manager;
}
```

##  判断顺序表是否以满（sqList_IsFull）

``` c
//判断顺序表是否以满
bool sqList_IsFull(sqList_t *manager)
{
    return (manager->last+1 == manager->size) ? true : false;
//        if(manager->last+1 == manager->size)
//    {
//        return ture;
//    }
//    return false;
}
```

##  尾插（sqList_endAdd）

``` c
//向顺序表的尾部插入元素
bool sqList_endAdd (sqList_t *manager,dataType_t data)
{
    //2.1 判断顺序表是否以满
    if(sqList_IsFull(manager))
    {
        printf("sequenceList is Full!\n");
        return false;
    }

    //2.2 若顺序表有空闲空间，则把新元素添加到顺序表尾部
/*    manager->last++;
    *(manager->Addr + manager->last) = data;*/
    manager->Addr[++manager->last] = data;
    return true;
}
```

##  头插（sqList_headAdd）

``` c
//3 向顺序表的头部插入元素
bool sqList_headAdd (sqList_t *manager,dataType_t data)
{
    //3.1 判断顺序表是否以满
    if(sqList_IsFull(manager))
    {
        printf("sequenceList is Full!\n");
        return false;
    }

    //3.2 若顺序表有空闲空间，则把新元素添加到顺序表头部 顺序表中所以元素向后移动1个单位
/*    manager->last++;
    *(manager->Addr + manager->last) = data;*/
    for(int i = manager->last;i >= 0;i--)
    {
        manager->Addr[i+1] = manager->Addr[i];
    }

    //3.3 把新元素放到顺序表的头部,并且更新管理结构体中的元素下标+1
    manager->Addr[0] = data;
    manager->last++;
    return true;
}
```

##  判断顺序表是否为空（sqList_IsEmpty）

``` c
//判断顺序表是否为空
bool sqList_IsEmpty(sqList_t *manager)
{
    return (manager->last == -1) ? true : false;
}
```

##  指定删除（sqList_delAdd）

``` c
//4 向顺序表删除元素
bool sqList_delAdd (sqList_t *manager,dataType_t destVal)
{
    int temp=-1;     //记录需要删除的下标

    //4.1 判断顺序表是否为空
    if(sqList_IsEmpty(manager))
    {
        printf("SequenceList is Empty!\n");
        return false;
    }

    //4.2 需要查找目标值是否在顺序表中
    for(int i=0;i <= manager->last;i++)
    {
        //如果目标值与顺序表中的值相同
        if(destVal == manager->Addr[i])
        {
            temp=i;     //把目标元素的下标备份到变量temp中
            break;
        }
    }

    //4.3 如果顺序表中没有目标值的元素则终止函数
    if(temp==-1)
    {
        printf("destval [%d] is not found\n",destVal);
        return  false;
    }

    //4.4 如果顺序表中有目标值的元素，则将该元素的后继元素向前移动一位
    for (int i = temp; i < manager->last; ++i)
    {
        manager->Addr[i] = manager->Addr[i+1];
    }

    //4.5 由于删掉一个元素，则顺序表有效元素下标减一
    manager->last--;

    return true;

}
```

##  遍历顺序表（sqList_print）

``` c
//5 遍历顺序表中的元素
void sqList_print (sqList_t *manager)
{
    for(int i=0;i<=manager->last;i++)
    {
        printf("Element[%d]=%d\n",i,manager->Addr[i]);
    }
}
```

##  main主程序

``` c
int main()
{

    //1 创建顺序表
    sqList_t *manager = sqList_Create(10);

    //2 向顺序表尾部插入新元素
    sqList_endAdd (manager,5);
    sqList_endAdd (manager,2);
    sqList_endAdd (manager,1);
    sqList_endAdd (manager,4);
    sqList_endAdd (manager,6);

    //3 遍历顺序表
    sqList_print (manager);     //5 2 1 4 6

    printf("\n");

    //4 向顺序表头部插入新元素
    sqList_headAdd (manager,8);
    sqList_headAdd (manager,4);
    sqList_headAdd (manager,8);
    sqList_headAdd (manager,8);

    //5 遍历顺序表
    sqList_print (manager);     //8 8 4 8 5 2 1 4 6

    printf("\n");

    //6 删除顺序表中元素
    sqList_delAdd (manager,20);
    sqList_delAdd (manager,5);
    sqList_delAdd (manager,1);
    sqList_delAdd (manager,6);

    //7 遍历顺序表
    sqList_print (manager);     //8 8 4 8 2 4

    printf("\n");

    return 0;
}
```

##  结果验证

``` c
Element[0]=5
Element[1]=2
Element[2]=1
Element[3]=4
Element[4]=6

Element[0]=8
Element[1]=8
Element[2]=4
Element[3]=8
Element[4]=5
Element[5]=2
Element[6]=1
Element[7]=4
Element[8]=6

destval [20] is not found
Element[0]=8
Element[1]=8
Element[2]=4
Element[3]=8
Element[4]=2
Element[5]=4


进程已结束,退出代码0
```
##  汇总

``` c
#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

//类型别名
typedef int dataType_t;
///////////////////////////////////////////////////////////////////////////////////////////////////
//构造顺序表记录参数(顺序表的首地址 顺序表的容量 顺序表的有效元素的下标)
typedef struct sequenceList {
    dataType_t *Addr;       //顺序表的首地址
    unsigned int size;      //顺序表的容量
    int last;               //顺序表的有效元素的下标
} sqList_t;
///////////////////////////////////////////////////////////////////////////////////////////////////
//1 创建顺序表并对顺序表进行初始化
sqList_t *sqList_Create(unsigned int size)
{
    //1.1 利用calloc为顺序表的管理结构体申请堆内存
    sqList_t *manager = (sqList_t*)calloc(1,sizeof (manager));

    if(NULL == manager)
    {
        perror("calloc memory for manager is failed");
        exit(-1);       //程序终止
    }

    //1.2 为所有元素申请堆内存 calloc,并完成错误处理
    manager->Addr = (dataType_t*)calloc(size,sizeof(dataType_t));

    if(NULL == manager->Addr)
    {
        perror("calloc memory for element is failed");
        free(manager);  //释放内存
        exit(-1);       //程序终止
    }

    //1.3 对管理顺序表的结构体进行初始化（元素容量 最后元素下标）
    manager->size = size; //对顺序表的容量进行初始化
    manager->last = -1;   //由于顺序表为空，则最后元素下标初值为-1

    return manager;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
//判断顺序表是否以满
bool sqList_IsFull(sqList_t *manager)
{
    return (manager->last+1 == manager->size) ? true : false;
//        if(manager->last+1 == manager->size)
//    {
//        return ture;
//    }
//    return false;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
//2 向顺序表的尾部插入元素
bool sqList_endAdd (sqList_t *manager,dataType_t data)
{
    //2.1 判断顺序表是否以满
    if(sqList_IsFull(manager))
    {
        printf("sequenceList is Full!\n");
        return false;
    }

    //2.2 若顺序表有空闲空间，则把新元素添加到顺序表尾部
/*    manager->last++;
    *(manager->Addr + manager->last) = data;*/
    manager->Addr[++manager->last] = data;
    return true;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
//3 向顺序表的头部插入元素
bool sqList_headAdd (sqList_t *manager,dataType_t data)
{
    //3.1 判断顺序表是否以满
    if(sqList_IsFull(manager))
    {
        printf("sequenceList is Full!\n");
        return false;
    }

    //3.2 若顺序表有空闲空间，则把新元素添加到顺序表头部 顺序表中所以元素向后移动1个单位
/*    manager->last++;
    *(manager->Addr + manager->last) = data;*/
    for(int i = manager->last;i >= 0;i--)
    {
        manager->Addr[i+1] = manager->Addr[i];
    }

    //3.3 把新元素放到顺序表的头部,并且更新管理结构体中的元素下标+1
    manager->Addr[0] = data;
    manager->last++;
    return true;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
//判断顺序表是否为空
bool sqList_IsEmpty(sqList_t *manager)
{
    return (manager->last == -1) ? true : false;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
//4 向顺序表删除元素
bool sqList_delAdd (sqList_t *manager,dataType_t destVal)
{
    int temp=-1;     //记录需要删除的下标

    //4.1 判断顺序表是否为空
    if(sqList_IsEmpty(manager))
    {
        printf("SequenceList is Empty!\n");
        return false;
    }

    //4.2 需要查找目标值是否在顺序表中
    for(int i=0;i <= manager->last;i++)
    {
        //如果目标值与顺序表中的值相同
        if(destVal == manager->Addr[i])
        {
            temp=i;     //把目标元素的下标备份到变量temp中
            break;
        }
    }

    //4.3 如果顺序表中没有目标值的元素则终止函数
    if(temp==-1)
    {
        printf("destval [%d] is not found\n",destVal);
        return  false;
    }

    //4.4 如果顺序表中有目标值的元素，则将该元素的后继元素向前移动一位
    for (int i = temp; i < manager->last; ++i)
    {
        manager->Addr[i] = manager->Addr[i+1];
    }

    //4.5 由于删掉一个元素，则顺序表有效元素下标减一
    manager->last--;

    return true;

}
///////////////////////////////////////////////////////////////////////////////////////////////////
//5 遍历顺序表中的元素
void sqList_print (sqList_t *manager)
{
    for(int i=0;i<=manager->last;i++)
    {
        printf("Element[%d]=%d\n",i,manager->Addr[i]);
    }
}
///////////////////////////////////////////////////////////////////////////////////////////////////
int main()
{

    //1 创建顺序表
    sqList_t *manager = sqList_Create(10);

    //2 向顺序表尾部插入新元素
    sqList_endAdd (manager,5);
    sqList_endAdd (manager,2);
    sqList_endAdd (manager,1);
    sqList_endAdd (manager,4);
    sqList_endAdd (manager,6);

    //3 遍历顺序表
    sqList_print (manager);     //5 2 1 4 6

    printf("\n");

    //4 向顺序表头部插入新元素
    sqList_headAdd (manager,8);
    sqList_headAdd (manager,4);
    sqList_headAdd (manager,8);
    sqList_headAdd (manager,8);

    //5 遍历顺序表
    sqList_print (manager);     //8 8 4 8 5 2 1 4 6

    printf("\n");

    //6 删除顺序表中元素
    sqList_delAdd (manager,20);
    sqList_delAdd (manager,5);
    sqList_delAdd (manager,1);
    sqList_delAdd (manager,6);

    //7 遍历顺序表
    sqList_print (manager);     //8 8 4 8 2 4

    printf("\n");

    return 0;
}
```