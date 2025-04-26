---
title: 数据结构六（顺序栈sequenceStack）
#tags: [数据结构—顺序栈]          # 标签
tags: 
- 数据结构          # 标签
- 顺序栈
categories: 
- 数据结构   # 分类
- 六 顺序栈
top_img: /img/11.png # 顶部背景图
#sticky: 5              #置顶 越大越优先
cover: /img/封面/cover (5).png   # 文章封面
---
## 前言

 创建一个顺序栈实现对顺序栈内元素的
 ——入栈
 ——出栈
 ——遍历顺序栈

 ![顺序栈](/img/文章/数据结构六（顺序栈sequenceStack）/顺序栈.jpg "顺序栈")

More info: [sequenceStack](https://github.com/gybpersist/sequenceStack)

##  构造顺序栈（sequenceStack）

### 构造顺序栈记录参数(顺序栈的栈底地址 顺序栈的容量 顺序栈的栈顶元素的下标)

``` c
//类型别名
typedef int dataType_t;
typedef struct sequenceStack {
    dataType_t *Bottom;       //顺序栈的栈底地址
    unsigned int size;      //顺序栈的容量
    int Top;               //顺序栈的栈顶元素的下标
} sqStack_t;
```
##  创建顺序栈并对顺序栈进行初始化（sqStack_Create）

``` c
sqStack_t *sqStack_Create(unsigned int size)
{
    //1.1 利用calloc为顺序栈的管理结构体申请堆内存
    sqStack_t *manager = (sqStack_t*)calloc(1,sizeof (manager));

    if(NULL == manager)
    {
        perror("calloc memory for manager is failed");
        exit(-1);       //程序终止
    }

    //1.2 为所有元素申请堆内存 calloc,并完成错误处理
    manager->Bottom = (dataType_t*)calloc(size,sizeof(dataType_t));

    if(NULL == manager->Bottom)
    {
        perror("calloc memory for element is failed");
        free(manager);  //释放内存
        exit(-1);       //程序终止
    }

    //1.3 对管理顺序栈的结构体进行初始化（元素容量 最后元素下标）
    manager->size = size; //对顺序栈的容量进行初始化
    manager->Top = -1;   //由于顺序栈为空，则最后元素下标初值为-1

    return manager;
}
```

##  判断顺序栈是否以满（sqStack_IsFull）

``` c
//判断顺序栈是否以满
bool sqStack_IsFull(sqStack_t *manager)
{
    return (manager->Top+1 == manager->size) ? true : false;
//        if(manager->Top+1 == manager->size)
//    {
//        return ture;
//    }
//    return false;
}
```

##  入栈(sqStack_Push)

 ![入栈](/img/文章/数据结构六（顺序栈sequenceStack）/入栈.png "入栈")

``` c
bool sqStack_Push (sqStack_t *manager,dataType_t data)
{
    //2.1 判断顺序栈是否以满
    if(sqStack_IsFull(manager))
    {
        printf("sequenceStack is Full!\n");
        return false;
    }

    //2.2 若顺序栈有空闲空间，则把新元素添加到顺序栈尾部
/*    manager->Top++;
    *(manager->Bottom + manager->Top) = data;   */
    manager->Bottom[++manager->Top] = data;
    return true;
}
```

##  判断顺序栈是否为空（sqStack_IsEmpty）

``` c
bool sqStack_IsEmpty(sqStack_t *manager)
{
    return (manager->Top == -1) ? true : false;
}
```

##  出栈（sqStack_Pop）

 ![出栈](/img/文章/数据结构六（顺序栈sequenceStack）/出栈.png "出栈")

``` c
dataType_t sqStack_Pop (sqStack_t *manager)
{
    dataType_t temp=-1;     //记录需要出栈的值

    //4.1 判断顺序栈是否为空
    if(sqStack_IsEmpty(manager))
    {
        printf("SequenceStack is Empty!\n");
        return -1;
    }

    //4.2 由于删掉一个元素，则顺序栈有效元素下标减一 后--（先赋值后--）
    temp = manager->Bottom[manager->Top--];
    return temp;

    //return manager->Bottom[manager->Top--];
}
```

##  遍历顺序栈（sqStack_print）

``` c
//5 遍历顺序栈中的元素
void sqStack_print (sqStack_t *manager)
{
    for(int i=0;i<=manager->Top;i++)
    {
        printf("Element[%d]=%d\n",i,manager->Bottom[i]);
    }
}
```

##  main主程序

``` c
int main()
{

    //1 创建顺序栈
    sqStack_t *manager = sqStack_Create(10);

    //2 向顺序栈  入栈
    sqStack_Push (manager,5);
    sqStack_Push (manager,2);
    sqStack_Push (manager,1);
    sqStack_Push (manager,4);
    sqStack_Push (manager,6);
    sqStack_Push (manager,8);

    //3 遍历顺序栈
    sqStack_print (manager);     //5 2 1 4 6
    printf("\n");

    //6 出栈
    dataType_t temp1,temp2,temp3,temp4;
    
    temp1 = sqStack_Pop (manager);
    printf(" 出栈：%d ",temp1);

    temp2 = sqStack_Pop (manager);
    printf(" 出栈：%d ",temp2);

    temp3 = sqStack_Pop (manager);
    printf(" 出栈：%d ",temp3);

    temp4 = sqStack_Pop (manager);
    printf(" 出栈：%d\n",temp4);

    //7 遍历顺序栈
    sqStack_print (manager);     //8 8 4 8 2 4
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
Element[5]=8

 出栈：8  出栈：6  出栈：4  出栈：1
Element[0]=5
Element[1]=2


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
//构造顺序栈记录参数(顺序栈的栈底地址 顺序栈的容量 顺序栈的栈顶元素的下标)
typedef struct sequenceStack {
    dataType_t *Bottom;       //顺序栈的栈底地址
    unsigned int size;      //顺序栈的容量
    int Top;               //顺序栈的栈顶元素的下标
} sqStack_t;
///////////////////////////////////////////////////////////////////////////////////////////////////
//1 创建顺序栈并对顺序栈进行初始化
sqStack_t *sqStack_Create(unsigned int size)
{
    //1.1 利用calloc为顺序栈的管理结构体申请堆内存
    sqStack_t *manager = (sqStack_t*)calloc(1,sizeof (manager));

    if(NULL == manager)
    {
        perror("calloc memory for manager is failed");
        exit(-1);       //程序终止
    }

    //1.2 为所有元素申请堆内存 calloc,并完成错误处理
    manager->Bottom = (dataType_t*)calloc(size,sizeof(dataType_t));

    if(NULL == manager->Bottom)
    {
        perror("calloc memory for element is failed");
        free(manager);  //释放内存
        exit(-1);       //程序终止
    }

    //1.3 对管理顺序栈的结构体进行初始化（元素容量 最后元素下标）
    manager->size = size; //对顺序栈的容量进行初始化
    manager->Top = -1;   //由于顺序栈为空，则最后元素下标初值为-1

    return manager;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
//判断顺序栈是否以满
bool sqStack_IsFull(sqStack_t *manager)
{
    return (manager->Top+1 == manager->size) ? true : false;
//        if(manager->Top+1 == manager->size)
//    {
//        return ture;
//    }
//    return false;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
//2 顺序栈   入栈
bool sqStack_Push (sqStack_t *manager,dataType_t data)
{
    //2.1 判断顺序栈是否以满
    if(sqStack_IsFull(manager))
    {
        printf("sequenceStack is Full!\n");
        return false;
    }

    //2.2 若顺序栈有空闲空间，则把新元素添加到顺序栈尾部
/*    manager->Bottom++;
    *(manager->Bottom + manager->Top) = data;   */
    manager->Bottom[++manager->Top] = data;
    return true;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
//判断顺序栈是否为空
bool sqStack_IsEmpty(sqStack_t *manager)
{
    return (manager->Top == -1) ? true : false;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
//4 顺序栈  出栈
dataType_t sqStack_Pop (sqStack_t *manager)
{
    dataType_t temp=-1;     //记录需要出栈的值

    //4.1 判断顺序栈是否为空
    if(sqStack_IsEmpty(manager))
    {
        printf("SequenceStack is Empty!\n");
        return -1;
    }

    //4.2 由于删掉一个元素，则顺序栈有效元素下标减一 后--（先赋值后--）
    temp = manager->Bottom[manager->Top--];
    return temp;

    //return manager->Bottom[manager->Top--];
}
///////////////////////////////////////////////////////////////////////////////////////////////////
//5 遍历顺序栈中的元素
void sqStack_print (sqStack_t *manager)
{
    for(int i=0;i<=manager->Top;i++)
    {
        printf("Element[%d]=%d\n",i,manager->Bottom[i]);
    }
}
///////////////////////////////////////////////////////////////////////////////////////////////////
int main()
{

    //1 创建顺序栈
    sqStack_t *manager = sqStack_Create(10);

    //2 向顺序栈  入栈
    sqStack_Push (manager,5);
    sqStack_Push (manager,2);
    sqStack_Push (manager,1);
    sqStack_Push (manager,4);
    sqStack_Push (manager,6);
    sqStack_Push (manager,8);

    //3 遍历顺序栈
    sqStack_print (manager);     //5 2 1 4 6
    printf("\n");

    //6 出栈
    dataType_t temp1,temp2,temp3,temp4;
    
    temp1 = sqStack_Pop (manager);
    printf(" 出栈：%d ",temp1);

    temp2 = sqStack_Pop (manager);
    printf(" 出栈：%d ",temp2);

    temp3 = sqStack_Pop (manager);
    printf(" 出栈：%d ",temp3);

    temp4 = sqStack_Pop (manager);
    printf(" 出栈：%d\n",temp4);

    //7 遍历顺序栈
    sqStack_print (manager);     //8 8 4 8 2 4
    printf("\n");

    return 0;
}
```