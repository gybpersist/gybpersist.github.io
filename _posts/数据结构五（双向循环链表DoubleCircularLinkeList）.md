---
title: 数据结构五（双向循环链表DoubleCirLList）
#tags: [数据结构—双向循环链表]          # 标签
tags: 
- 数据结构          # 标签
- 双向循环链表
categories: 
- 数据结构   # 分类
- 五 双向循环链表
top_img: /img/11.png # 顶部背景图
#sticky: 6              #置顶 越大越优先
cover: /img/封面/cover (4).png   # 文章封面
---
##  前言

 创建一个双向循环链表实现对双向循环链表内元素的
 ——增加（头插 指定位置插入 尾插）
 ——删除（头删 指定位置删除 尾删）
 ——遍历双向循环链表

  ![双向循环链表](/img/文章/数据结构五（双向循环链表DoubleCirLList）/双向循环链表.png "双向循环链表")

More info: [DoubleCirLList](https://github.com/gybpersist/DoubleCirLList)

##  构造双向循环链表（DoubleCirLList）

### 构造双向循环链表的结点 双向循环链表中所有结点的数据类型应该是相同的

``` c
//类型别名
typedef int dataType_t;
typedef struct DoubleCirLList {
    dataType_t data;                 // 双向循环链表的数据域，用于存储具体的数据
    struct DoubleCirLList *prev;   // 双向循环链表的前驱指针域，指向前一个节点
    struct DoubleCirLList *next;   // 双向循环链表的后继指针域，指向后一个节点
} DoubleLList_t;
```
##  创建一个空链表，空链表应该有一个头结点（DoubleCirLList_Create）

``` c
DoubleLList_t* DoubleCirLList_Create(void) {
    // 创建一个头结点并给头结点申请内存，使用 calloc 函数将内存初始化为 0
    DoubleLList_t *Head = (DoubleLList_t*)calloc(1, sizeof(DoubleLList_t));
    if (Head == NULL) {
        // 若内存分配失败，使用 perror 输出错误信息并退出程序
        perror("calloc memory for Head is Failed!\n");
        exit(-1);
    }

    // 对头结点进行初始化，体现循环，将头结点的 prev 和 next 指针都指向自己
    Head->prev = Head;
    Head->next = Head;

    // 把头结点的地址返回，方便后续操作
    return Head;
}
```

##  创建新的结点，并对新结点进行初始化（数据域 指针域）（DoubleCirLList_NewNode）

``` c
DoubleLList_t *DoubleCirLList_NewNode(dataType_t data) {
    // 创建一个新结点并给新结点申请内存，使用 calloc 函数将内存初始化为 0
    DoubleLList_t *NewNode = (DoubleLList_t *) calloc(1, sizeof(DoubleLList_t));
    if (NewNode == NULL) {
        // 若内存分配失败，使用 perror 输出错误信息并返回 NULL
        perror("calloc memory for NewNode is Failed!\n");
        return NULL;
    }

    // 对新结点进行初始化（数据域 指针域2个），体现循环，将新结点的 prev 和 next 指针都指向自己
    NewNode->prev = NewNode;
    NewNode->data = data;
    NewNode->next = NewNode;

    // 把新结点的地址返回，方便后续操作
    return NewNode;
}
```

##  插入新节点到指定节点之后（insertAfter）

``` c
void insertAfter(DoubleLList_t *node, DoubleLList_t *newNode) {
    // 将新节点的 next 指针指向指定节点的下一个节点
    newNode->next = node->next;
    // 将新节点的 prev 指针指向指定节点
    newNode->prev = node;
    // 将指定节点的下一个节点的 prev 指针指向新节点
    node->next->prev = newNode;
    // 将指定节点的 next 指针指向新节点
    node->next = newNode;
}
```

##  头插（DoubleCirLList_HeadInsert）

  ![头插](/img/文章/数据结构五（双向循环链表DoubleCirLList）/头插.png "头插")

``` c
bool DoubleCirLList_HeadInsert(DoubleLList_t *Head, dataType_t data) {
    //3.1建新的结点，并对新结点进行初始化（数据域 指针域）
    DoubleLList_t *NewNode = DoubleCirLList_NewNode(data);
    if (NewNode == NULL) {
        // 若新节点创建失败，输出提示信息并返回 false
        printf("Can not insert new node!\n");
        return false;
    }

    //3.2 判断链表是否为空，如果为则直接插入
    if(Head->next == Head)
    {
        Head->next= NewNode;
        NewNode->next = Head;
        NewNode->prev = Head;
        Head->prev = NewNode;
        return true;
    }

    // 以下四步操作将新节点插入到链表头部
    NewNode->next = Head->next;
    NewNode->prev = Head;
    Head->next->prev = NewNode;
    Head->next = NewNode;

    //    insertAfter(Phead, NewNode);

    return true;
}
```

##  尾插（DoubleCirLList_TailInsert）

  ![尾插](/img/文章/数据结构五（双向循环链表DoubleCirLList）/尾插.png "尾插")

``` c
bool DoubleCirLList_TailInsert(DoubleLList_t *Head, dataType_t data)
{
    //4.1 建新的结点，并对新结点进行初始化（数据域 指针域）
    DoubleLList_t *NewNode = DoubleCirLList_NewNode(data);
    if(NewNode == NULL)
    {
        // 若新节点创建失败，输出提示信息并返回 false
        printf("Can not insert new node!\n");
        return false;
    }

    //把新结点插入到链表尾部
    // 将新节点的 prev 指针指向原尾节点
    NewNode->prev = Head->prev;
    // 将原尾节点的 next 指针指向新节点
    Head->prev->next = NewNode;
    // 将新节点的 next 指针指向头结点
    NewNode->next = Head;
    // 将头结点的 prev 指针指向新节点
    Head->prev = NewNode;

    //    insertAfter(Phead, NewNode);

    return true;
}
```

##  指定插入（DoubleCirLList_DestInsert）

  ![指定插入](/img/文章/数据结构五（双向循环链表DoubleCirLList）/指定插入.png "指定插入")

``` c
bool DoubleCirLList_DestInsert(DoubleLList_t *Head, dataType_t destval, dataType_t data) {
    // 建新的结点，并对新结点进行初始化（数据域 指针域）
    DoubleLList_t *NewNode = DoubleCirLList_NewNode(data);
    if (NewNode == NULL) {
        // 若新节点创建失败，输出提示信息并返回 false
        printf("Can not insert new node!\n");
        return false;
    }

    // 遍历链表，找到目标结点（比较数据域）
    DoubleLList_t *Phead = Head->next;
    while (Phead != Head && Phead->data != destval) {
        // 若未找到目标节点且未遍历完链表，将指针移动到下一个节点
        Phead = Phead->next;
    }

    if (Phead == Head) {
        // 未找到目标节点，释放新节点的内存并返回 false
        free(NewNode);
        return false;
    }

    // 以下四步操作将新节点插入到目标节点之后
    NewNode->next = Phead->next;
    NewNode->prev = Phead;
    Phead->next->prev = NewNode;
    Phead->next = NewNode;

//    insertAfter(Phead, NewNode);

    return true;
}
```

##  遍历链表（DoubleCirLList_Print）

``` c
bool DoubleCirLList_Print(DoubleLList_t *Head) {
    // 判断当前链表是否为空，为空则直接退出
    if (Head->next == Head) {
        // 若链表为空，输出提示信息并返回 false
        printf("Current linkedList is empty!\n");
        return false;
    }

    // 判断当前链表不为空则继续遍历
    int i = 0;
    DoubleLList_t *Phead = Head->next;
    while (Phead != Head) {
        i++;
        // 输出当前节点的数据
        printf("Date[%d] = %d\n", i, Phead->data);
        // 将指针移动到下一个节点
        Phead = Phead->next;
    }
    return true;
}
```

##  删除指定节点（deleteNode）

``` c
void deleteNode(DoubleLList_t *node) {
    // 将指定节点的前一个节点的 next 指针指向指定节点的下一个节点
    node->prev->next = node->next;
    // 将指定节点的下一个节点的 prev 指针指向指定节点的前一个节点
    node->next->prev = node->prev;
    // 将指定节点的 next 和 prev 指针置为 NULL
    node->next = NULL;
    node->prev = NULL;
    // 释放指定节点的内存
    free(node);
}
```

##  头删 删除首结点（DoubleCirLList_HeadDel）

  ![头删](/img/文章/数据结构五（双向循环链表DoubleCirLList）/头删.png "头删")

``` c
bool DoubleCirLList_HeadDel(DoubleLList_t *Head) {
    // 判断链表是否为空，如果为空则直接退出
    if (Head->next == Head) {
        return false;
    }

    // 7.2 对链表的首结点进行备份
    DoubleLList_t *Phead = Head->next;

    // 7.3 链表非空 删除首结点
    // 将首结点之后的结点的 prev 指针连接到头结点
    Head->next->next->prev = Head;
    // 将头结点的 next 指针指向原先首结点之后的结点
    Head->next = Head->next->next;

    // 7.4 释放首结点的内存
    free(Phead);

    //    deleteNode(Head->next);

    return true;
}
```

##  尾删 删除尾结点（DoubleCirLList_TailDel）

  ![尾删](/img/文章/数据结构五（双向循环链表DoubleCirLList）/尾删.png "尾删")

``` c
bool DoubleCirLList_TailDel(DoubleLList_t *Head) {
    // 8.1 判断判断链表是否为空，如果为空则直接退出
    if (Head->next == Head) {
        return false;
    }

    // 8.2 记录当前尾结点的地址
    DoubleLList_t *Phead = Head->prev;

    // 8.3 链表非空 删除尾结点
    // 将头结点的 prev 指针连接到尾结点的前一个结点
    Head->next->prev = Phead->prev;
    // 将尾结点的前一个结点的 next 指针连接到头结点
    Phead->prev->next = Head;

    // 8.4 释放尾结点的内存
    free(Phead);

    //    deleteNode(Head->prev);

    return true;
}
```

##  main主程序

``` c
int main() {
    // 创建一个双向循环链表
    DoubleLList_t *Head = DoubleCirLList_Create();

    // 进行头插操作
    DoubleCirLList_HeadInsert(Head, 5);
    DoubleCirLList_HeadInsert(Head, 8);
    DoubleCirLList_HeadInsert(Head, 1);
    DoubleCirLList_HeadInsert(Head, 6);
    DoubleCirLList_HeadInsert(Head, 3);

    // 遍历链表并输出结果
    DoubleCirLList_Print(Head);
    printf("\n");

    // 进行尾插操作
    DoubleCirLList_TailInsert(Head, 4);

    // 遍历链表并输出结果
    DoubleCirLList_Print(Head);
    printf("\n");

    // 在值为 1 的节点后插入新节点
    DoubleCirLList_DestInsert(Head, 1, 9);

    // 遍历链表并输出结果
    DoubleCirLList_Print(Head);
    printf("\n");

    // 进行头删操作
    DoubleCirLList_HeadDel(Head);

    // 遍历链表并输出结果
    DoubleCirLList_Print(Head);
    printf("\n");

    // 进行尾删操作
    DoubleCirLList_TailDel(Head);

    // 遍历链表并输出结果
    DoubleCirLList_Print(Head);
    printf("\n");

    return 0;
}
```

##  结果验证

``` c
Date[1] = 3
Date[2] = 6
Date[3] = 1
Date[4] = 8
Date[5] = 5

Date[1] = 3
Date[2] = 6
Date[3] = 1
Date[4] = 8
Date[5] = 5
Date[6] = 4

Date[1] = 3
Date[2] = 6
Date[3] = 1
Date[4] = 9
Date[5] = 8
Date[6] = 5
Date[7] = 4

Date[1] = 6
Date[2] = 1
Date[3] = 9
Date[4] = 8
Date[5] = 5
Date[6] = 4

Date[1] = 6
Date[2] = 1
Date[3] = 9
Date[4] = 8
Date[5] = 5


进程已结束,退出代码0
```
##  汇总

``` c
#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

// 类型别名，将 int 类型重命名为 dataType_t，方便后续修改数据类型
typedef int dataType_t;
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
// 构造双向循环链表的结点
typedef struct DoubleCirLList {
    dataType_t data;                 // 双向循环链表的数据域，用于存储具体的数据
    struct DoubleCirLList *prev;   // 双向循环链表的前驱指针域，指向前一个节点
    struct DoubleCirLList *next;   // 双向循环链表的后继指针域，指向后一个节点
} DoubleLList_t;
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
// 1 创建一个空链表，空链表应该有一个头结点
DoubleLList_t* DoubleCirLList_Create(void) {
    // 创建一个头结点并给头结点申请内存，使用 calloc 函数将内存初始化为 0
    DoubleLList_t *Head = (DoubleLList_t*)calloc(1, sizeof(DoubleLList_t));
    if (Head == NULL) {
        // 若内存分配失败，使用 perror 输出错误信息并退出程序
        perror("calloc memory for Head is Failed!\n");
        exit(-1);
    }

    // 对头结点进行初始化，体现循环，将头结点的 prev 和 next 指针都指向自己
    Head->prev = Head;
    Head->next = Head;

    // 把头结点的地址返回，方便后续操作
    return Head;
}
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
// 2 创建新的结点，并对新结点进行初始化（数据域 指针域）
DoubleLList_t *DoubleCirLList_NewNode(dataType_t data) {
    // 创建一个新结点并给新结点申请内存，使用 calloc 函数将内存初始化为 0
    DoubleLList_t *NewNode = (DoubleLList_t *) calloc(1, sizeof(DoubleLList_t));
    if (NewNode == NULL) {
        // 若内存分配失败，使用 perror 输出错误信息并返回 NULL
        perror("calloc memory for NewNode is Failed!\n");
        return NULL;
    }

    // 对新结点进行初始化（数据域 指针域2个），体现循环，将新结点的 prev 和 next 指针都指向自己
    NewNode->prev = NewNode;
    NewNode->data = data;
    NewNode->next = NewNode;

    // 把新结点的地址返回，方便后续操作
    return NewNode;
}
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
// 插入新节点到指定节点之后
void insertAfter(DoubleLList_t *node, DoubleLList_t *newNode) {
    // 将新节点的 next 指针指向指定节点的下一个节点
    newNode->next = node->next;
    // 将新节点的 prev 指针指向指定节点
    newNode->prev = node;
    // 将指定节点的下一个节点的 prev 指针指向新节点
    node->next->prev = newNode;
    // 将指定节点的 next 指针指向新节点
    node->next = newNode;
}
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
// 3 在链表中 头插
bool DoubleCirLList_HeadInsert(DoubleLList_t *Head, dataType_t data) {
    //3.1建新的结点，并对新结点进行初始化（数据域 指针域）
    DoubleLList_t *NewNode = DoubleCirLList_NewNode(data);
    if (NewNode == NULL) {
        // 若新节点创建失败，输出提示信息并返回 false
        printf("Can not insert new node!\n");
        return false;
    }

    //3.2 判断链表是否为空，如果为则直接插入
    if(Head->next == Head)
    {
        Head->next= NewNode;
        NewNode->next = Head;
        NewNode->prev = Head;
        Head->prev = NewNode;
        return true;
    }

    // 以下四步操作将新节点插入到链表头部
    NewNode->next = Head->next;
    NewNode->prev = Head;
    Head->next->prev = NewNode;
    Head->next = NewNode;

    //    insertAfter(Phead, NewNode);

    return true;
}
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
// 4 在链表中 尾部插
bool DoubleCirLList_TailInsert(DoubleLList_t *Head, dataType_t data)
{
    //4.1 建新的结点，并对新结点进行初始化（数据域 指针域）
    DoubleLList_t *NewNode = DoubleCirLList_NewNode(data);
    if(NewNode == NULL)
    {
        // 若新节点创建失败，输出提示信息并返回 false
        printf("Can not insert new node!\n");
        return false;
    }

    //把新结点插入到链表尾部
    // 将新节点的 prev 指针指向原尾节点
    NewNode->prev = Head->prev;
    // 将原尾节点的 next 指针指向新节点
    Head->prev->next = NewNode;
    // 将新节点的 next 指针指向头结点
    NewNode->next = Head;
    // 将头结点的 prev 指针指向新节点
    Head->prev = NewNode;

    //    insertAfter(Phead, NewNode);

    return true;
}
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
// 5 在链表中 指定插入
bool DoubleCirLList_DestInsert(DoubleLList_t *Head, dataType_t destval, dataType_t data) {
    // 建新的结点，并对新结点进行初始化（数据域 指针域）
    DoubleLList_t *NewNode = DoubleCirLList_NewNode(data);
    if (NewNode == NULL) {
        // 若新节点创建失败，输出提示信息并返回 false
        printf("Can not insert new node!\n");
        return false;
    }

    // 遍历链表，找到目标结点（比较数据域）
    DoubleLList_t *Phead = Head->next;
    while (Phead != Head && Phead->data != destval) {
        // 若未找到目标节点且未遍历完链表，将指针移动到下一个节点
        Phead = Phead->next;
    }

    if (Phead == Head) {
        // 未找到目标节点，释放新节点的内存并返回 false
        free(NewNode);
        return false;
    }

    // 以下四步操作将新节点插入到目标节点之后
    NewNode->next = Phead->next;
    NewNode->prev = Phead;
    Phead->next->prev = NewNode;
    Phead->next = NewNode;

//    insertAfter(Phead, NewNode);

    return true;
}
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
// 6 遍历链表
bool DoubleCirLList_Print(DoubleLList_t *Head) {
    // 判断当前链表是否为空，为空则直接退出
    if (Head->next == Head) {
        // 若链表为空，输出提示信息并返回 false
        printf("Current linkedList is empty!\n");
        return false;
    }

    // 判断当前链表不为空则继续遍历
    int i = 0;
    DoubleLList_t *Phead = Head->next;
    while (Phead != Head) {
        i++;
        // 输出当前节点的数据
        printf("Date[%d] = %d\n", i, Phead->data);
        // 将指针移动到下一个节点
        Phead = Phead->next;
    }
    return true;
}
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
// 删除指定节点
void deleteNode(DoubleLList_t *node) {
    // 将指定节点的前一个节点的 next 指针指向指定节点的下一个节点
    node->prev->next = node->next;
    // 将指定节点的下一个节点的 prev 指针指向指定节点的前一个节点
    node->next->prev = node->prev;
    // 将指定节点的 next 和 prev 指针置为 NULL
    node->next = NULL;
    node->prev = NULL;
    // 释放指定节点的内存
    free(node);
}
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
// 7 头删 删除首结点
bool DoubleCirLList_HeadDel(DoubleLList_t *Head) {
    // 判断链表是否为空，如果为空则直接退出
    if (Head->next == Head) {
        return false;
    }

    // 7.2 对链表的首结点进行备份
    DoubleLList_t *Phead = Head->next;

    // 7.3 链表非空 删除首结点
    // 将首结点之后的结点的 prev 指针连接到头结点
    Head->next->next->prev = Head;
    // 将头结点的 next 指针指向原先首结点之后的结点
    Head->next = Head->next->next;

    // 7.4 释放首结点的内存
    free(Phead);

    //    deleteNode(Head->next);

    return true;
}
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
// 8 尾删 删除尾结点
bool DoubleCirLList_TailDel(DoubleLList_t *Head) {
    // 8.1 判断判断链表是否为空，如果为空则直接退出
    if (Head->next == Head) {
        return false;
    }

    // 8.2 记录当前尾结点的地址
    DoubleLList_t *Phead = Head->prev;

    // 8.3 链表非空 删除尾结点
    // 将头结点的 prev 指针连接到尾结点的前一个结点
    Head->next->prev = Phead->prev;
    // 将尾结点的前一个结点的 next 指针连接到头结点
    Phead->prev->next = Head;

    // 8.4 释放尾结点的内存
    free(Phead);

    //    deleteNode(Head->prev);

    return true;
}
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
int main() {
    // 创建一个双向循环链表
    DoubleLList_t *Head = DoubleCirLList_Create();

    // 进行头插操作
    DoubleCirLList_HeadInsert(Head, 5);
    DoubleCirLList_HeadInsert(Head, 8);
    DoubleCirLList_HeadInsert(Head, 1);
    DoubleCirLList_HeadInsert(Head, 6);
    DoubleCirLList_HeadInsert(Head, 3);

    // 遍历链表并输出结果
    DoubleCirLList_Print(Head);
    printf("\n");

    // 进行尾插操作
    DoubleCirLList_TailInsert(Head, 4);

    // 遍历链表并输出结果
    DoubleCirLList_Print(Head);
    printf("\n");

    // 在值为 1 的节点后插入新节点
    DoubleCirLList_DestInsert(Head, 1, 9);

    // 遍历链表并输出结果
    DoubleCirLList_Print(Head);
    printf("\n");

    // 进行头删操作
    DoubleCirLList_HeadDel(Head);

    // 遍历链表并输出结果
    DoubleCirLList_Print(Head);
    printf("\n");

    // 进行尾删操作
    DoubleCirLList_TailDel(Head);

    // 遍历链表并输出结果
    DoubleCirLList_Print(Head);
    printf("\n");

    return 0;
}
```