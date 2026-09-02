---
title: HAL库常用函数及初始化流程
#tags: [数据结构—顺序表]          # 标签
tags: 
- HAL库常用函数         # 标签
- 初始化流程
categories: 
- HAL库   # 分类
top_img: /img/11.png # 顶部背景图
#sticky: 10              #置顶 越大越优先
cover: /img/封面/HAL库常用函数及初始化流程/cover (1).png   # 文章封面
---

# 1 常用HAL库函数汇总

## 1. 1 GPIO

```c
HAL_GPIO_WritePin()	 设置引脚状态
HAL_GPIO_ReadPin()	 读取引脚状态
HAL_GPIO_TogglePin() 切换引脚状态
HAL_Delay()			 延时，指定多少毫秒
```

***

```c
void HAL_GPIO_WritePin(GPIO_TypeDef *GPIOx, 
                      uint16_t GPIO_Pin, 
                      GPIO_PinState PinState);
GPIOx：GPIO 端口（如GPIOA、GPIOB等）。
GPIO_Pin：引脚编号（如GPIO_PIN_5）。
PinState：引脚状态（GPIO_PIN_RESET 或 GPIO_PIN_SET）。
```

```c
GPIO_PinState HAL_GPIO_ReadPin(GPIO_TypeDef *GPIOx, 
    uint16_t GPIO_Pin);
GPIOx：GPIO 端口。
GPIO_Pin：引脚编号。
```

```c
void HAL_GPIO_TogglePin(GPIO_TypeDef *GPIOx, 
                       uint16_t GPIO_Pin);
GPIOx：GPIO 端口。
GPIO_Pin：引脚编号。
```

```c
void HAL_Delay(uint32_t Delay);
Delay：延时时间（毫秒）。
```

## 1.2 EXTI

```c
__HAL_GPIO_EXTI_GET_IT()				获取EXTI中断挂起标志位
__HAL_GPIO_EXTI_CLEAR_IT() 			 	清除EXTI中断挂起标志位
__weak void HAL_GPIO_EXTI_Callback()	触发EXTI中断后自动调用的弱函数
```

## 1.3 UART

#### ① 阻塞式UART

```C
HAL_UART_Transmit()	发送指定长度的字节数据
HAL_UART_Receive（） 接收定长数据（接收到指定长度即停止）
HAL_UARTEx_ReceiveToIdle() 接收非定长数据（检测到Idle标志位或指定的最大长度停止接收）
```

***

```c
HAL_StatusTypeDef HAL_UART_Transmit(UART_HandleTypeDef *huart, 
                                    uint8_t *pData, 
                                    uint16_t Size, 
                                    uint32_t Timeout);
huart：UART 句柄（如&huart1）。
pData：待发送数据的指针。
Size：数据长度（字节数）。
Timeout：超时时间（毫秒）。
```

```c
HAL_StatusTypeDef HAL_UART_Receive(UART_HandleTypeDef *huart, 
                                   uint8_t *pData, 
                                   uint16_t Size, 
                                   uint32_t Timeout);
huart：UART 句柄（如&huart1）。
pData：待发送数据的指针。
Size：数据长度（字节数）。
Timeout：超时时间（毫秒）。
```

```c
HAL_StatusTypeDef HAL_UARTEx_ReceiveToIdle(UART_HandleTypeDef *huart, 
                                           uint8_t *pData, 
                                           uint16_t Size, 
                                           uint16_t *RxLen, 
                                           uint32_t Timeout);
huart：UART 句柄（如&huart1）。
pData：待发送数据的指针。
Size：数据长度（字节数）。
RxLen：实际接收到的字节数（函数返回后有效）。
Timeout：超时时间。
```

#### ②中断式UART

![%E6%A1%88%E4%BE%8B2-HAL%E5%BA%93-%E8%B0%83%E7%94%A8%E9%93%BE-%E5%AE%9A%E9%95%BF%E4%B8%AD%E6%96%AD.jpg](https://p.sda1.dev/22/266fe53819fc973c1fa3bf0f1ebd8abe/案例2-HAL库-调用链-定长中断.jpg)

![%E6%A1%88%E4%BE%8B2-HAL%E5%BA%93-%E8%B0%83%E7%94%A8%E9%93%BE-%E4%B8%8D%E5%AE%9A%E9%95%BF%E4%B8%AD%E6%96%AD.jpg](https://p.sda1.dev/22/3daa7357108791b312a83d2b970eab26/案例2-HAL库-调用链-不定长中断.jpg)

```c
HAL_UART_Receive_IT()			开启中断，定长方式接收数据，非阻塞方式, 处理完接收数据后需要重新调用
HAL_UARTEx_ReceiveToIdle_IT()   开启中断，非定长方式接收数据，非阻塞方式，处理完接收数据后需要重新调用

__weak HAL_UART_RxCpltCallback()     定长数据接收完成后自动调用
__weak HAL_UARTEx_RxEventCallback()  非定长数据接收完成后自动调用
```

```c
HAL_StatusTypeDef HAL_UART_Receive_IT(UART_HandleTypeDef *huart, 
                                     uint8_t *pData, 
                                     uint16_t Size);
huart：UART 句柄（如&huart1）。
pData：接收缓冲区指针。
Size：期望接收的字节数。
```

```c
HAL_StatusTypeDef HAL_UARTEx_ReceiveToIdle_IT(UART_HandleTypeDef *huart, 
                                              uint8_t *pData, 
                                              uint16_t Size, 
                                              uint16_t *RxLen);
huart：UART 句柄（如&huart1）。
pData：接收缓冲区指针。
Size：期望接收的字节数。
RxLen：指向变量的指针，用于存储实际接收到的字节数。
```

## 1.4 printf

```c
// 重定义 fputc
int fputc(int ch, FILE *stream)
{
  // 使用串口发送 ch
  HAL_UART_Transmit(&huart1, (uint8_t *)&ch, 1, 1000);
  // 返回
  return ch;
}
```

## 1.5 I2C

```c
HAL_I2C_Mem_Write()            向 I2C 设备的指定内存地址写入数据
HAL_I2C_Mem_Read()				从 I2C 设备的指定内存地址读取数据
HAL_I2C_Master_Transmit()		作为主设备向从设备发送数据（适用于无需指定内部寄存器的 I2C 通信）
HAL_I2C_Master_Receive()		作为主设备从从设备接收数据
```

```c
HAL_StatusTypeDef HAL_I2C_Mem_Write(I2C_HandleTypeDef *hi2c, 
                                    uint16_t DevAddress, 
                                    uint16_t MemAddress, 
                                    uint16_t MemAddSize, 
                                    uint8_t *pData, 
                                    uint16_t Size, 
                                    uint32_t Timeout);
hi2c：I2C 句柄，指定使用的 I2C 外设（如&hi2c1）。
DevAddress：目标设备的 I2C 地址（7 位地址需左移 1 位，如0xA0 << 1）。
MemAddress：目标设备的内部寄存器地址（如 EEPROM 的存储地址）。
MemAddSize：寄存器地址长度（I2C_MEMADD_SIZE_8BIT 或 I2C_MEMADD_SIZE_16BIT）。
pData：待写入数据的指针。
Size：数据长度（字节数）。
Timeout：超时时间（毫秒）。
```

```c
HAL_StatusTypeDef HAL_I2C_Mem_Read(I2C_HandleTypeDef *hi2c, 
                                   uint16_t DevAddress, 
                                   uint16_t MemAddress, 
                                   uint16_t MemAddSize, 
                                   uint8_t *pData, 
                                   uint16_t Size, 
                                   uint32_t Timeout);
hi2c：I2C 句柄，指定使用的 I2C 外设（如&hi2c1）。
DevAddress：目标设备的 I2C 地址（7 位地址需左移 1 位，如0xA0 << 1）。
MemAddress：目标设备的内部寄存器地址（如 EEPROM 的存储地址）。
MemAddSize：寄存器地址长度（I2C_MEMADD_SIZE_8BIT 或 I2C_MEMADD_SIZE_16BIT）。
pData：待写入数据的指针。
Size：数据长度（字节数）。
Timeout：超时时间（毫秒）。
```

```c
HAL_StatusTypeDef HAL_I2C_Master_Transmit(I2C_HandleTypeDef *hi2c, 
                                          uint16_t DevAddress, 
                                          uint8_t *pData, 
                                          uint16_t Size, 
                                          uint32_t Timeout);
hi2c：I2C 句柄，指定使用的 I2C 外设（如&hi2c1）。
DevAddress：目标设备的 I2C 地址（7 位地址需左移 1 位，如0xA0 << 1）。
pData：待写入数据的指针。
Size：数据长度（字节数）。
Timeout：超时时间（毫秒）。
```

```c
HAL_StatusTypeDef HAL_I2C_Master_Receive(I2C_HandleTypeDef *hi2c, 
                                         uint16_t DevAddress, 
                                         uint8_t *pData, 
                                         uint16_t Size, 
                                         uint32_t Timeout);
hi2c：I2C 句柄，指定使用的 I2C 外设（如&hi2c1）。
DevAddress：目标设备的 I2C 地址（7 位地址需左移 1 位，如0xA0 << 1）。
pData：待写入数据的指针。
Size：数据长度（字节数）。
Timeout：超时时间（毫秒）。
```

# 2 函数初始化流程

## 2.1 GPIO 初始化

```c
    //1 对 GPIOA 时钟使能 
	RCC->APB2ENR |= RCC_APB2ENR_IOPAEN;
	
	//2 设置 PA0 PA1 PA8 的引脚模式   CNF 00  MODE 11
	// 设置 PA0 PA1
	GPIOA->CRL &= ~(GPIO_CRL_CNF0 | GPIO_CRL_CNF1);
	GPIOA->CRL |= (GPIO_CRL_MODE0 | GPIO_CRL_MODE1);
	// 设置 PA8
	GPIOA->CRH &= ~GPIO_CRH_CNF8;
	GPIOA->CRH |= GPIO_CRH_MODE8;
	
	// 3 设置 PA0 PA1 PA8 输出高电平
	GPIOA->ODR |= (LED1 | LED2 | LED3); 
```

## 2.2 EXTI 外部中断初始化

```c
    // 1 时钟使能 -----------------------------------------
    // 1.1 对 GPIOF 进行时钟使能
    RCC->APB2ENR |= RCC_APB2ENR_IOPFEN;
    // 1.2 对 AFIO 时钟使能
    RCC->APB2ENR |= RCC_APB2ENR_AFIOEN;

    // 2 设置 GPIO 引脚模式
    // 2.1 将 PF8 设置为上下拉输入模式 MODE=00,CNF=10
    GPIOF->CRH &= ~GPIO_CRH_MODE8;
    GPIOF->CRH |= GPIO_CRH_CNF8_1;
    GPIOF->CRH &= ~GPIO_CRH_CNF8_0;
    // 2.2 设置 PF8 为上拉模式
    GPIOF->ODR |= GPIO_ODR_ODR8;

    // 3 设置 AFIO -----------------------------------------
    // 把 PF8 复用为 EXTI8 ,在 AFIO_EXTICR3 寄存器中进行配置
    AFIO->EXTICR[2] &= ~AFIO_EXTICR3_EXTI8;   //将用于设置EXTI8的4个位全设置为0
    AFIO->EXTICR[2] |= AFIO_EXTICR3_EXTI8_PF; //EXTI8的4个位设置为 0101 代表选择PF

    // 4 设置 EXTI -----------------------------------------
    // 4.1 设置下降沿触发 EXTI8
    EXTI->FTSR |= EXTI_FTSR_TR8;
    // 4.2 设置开放 EXTI8 的中断请求
    EXTI->IMR |= EXTI_IMR_MR8;

    // 5 设置 NVIC -----------------------------------------
    // 5.1 设置优先级的4个bit全是抢占优先级,将 SCB->AIRCR 寄存器中的对应的控制位设置成(3)011,表示4位全是抢占优先级 (全局设置)    
    NVIC_SetPriorityGrouping(3);  
    // 5.2 对 EXTI9_5 中断向量使能
    NVIC_EnableIRQ(EXTI9_5_IRQn);
    // 5.3 设置 EXTI9_5 的优先级为 10(随便设置)
    NVIC_SetPriority(EXTI9_5_IRQn,10);
```

## 2.3 UART 初始化

```c
    // 1 时钟使能，对GPIOA、USART1 时钟使能 ---------------------------------------->
    RCC->APB2ENR |= RCC_APB2ENR_IOPAEN;
    RCC->APB2ENR |= RCC_APB2ENR_USART1EN; 

    // 2 设置 GPIOA 的引脚 -------------------------------------------------------->
    // 2.1 TX引脚(PA9)设置为复用推挽输出 MODE=11,CNF=10
    GPIOA->CRH |= GPIO_CRH_MODE9;
    GPIOA->CRH |= GPIO_CRH_CNF9_1;
    GPIOA->CRH &= ~GPIO_CRH_CNF9_0;
    // 2.2 RX引脚(PA10)设置为浮空输入或者复用推挽输出 MODE=00,CNF=01  (默认值)
    GPIOA->CRH &= ~GPIO_CRH_MODE10;
    GPIOA->CRH &= ~GPIO_CRH_CNF10_1;
    GPIOA->CRH |= GPIO_CRH_CNF10_0;

    // 3 设置 USART1 -------------------------------------------------------------->
    // 3.1 使能整个 USART1 外设
    USART1->CR1 |= USART_CR1_UE;
    // 3.2 使能 发送使能TXD
    USART1->CR1 |= USART_CR1_TE;
    // 3.3 使能 接收使能RXD
    USART1->CR1 |= USART_CR1_RE;
    // 3.4 设置数据帧 -> 数据位长度 8 位 (默认值)
    USART1->CR1 &= ~USART_CR1_M;
    // 3.5 设置数据帧 -> 无校验位 (默认值)
    USART1->CR1 &= ~USART_CR1_PCE; 
    // 3.6 设置数据帧 -> 1停止位 (默认值)          
    USART1->CR2 &= ~USART_CR2_STOP;                          //         f(72MHZ)
    // 3.7 波特率设置 -> 设置19200波特率,求出除数因子:39.0625   //波特率=---------------   
    USART1->BRR = ((39 << 4) + 0001);  
```

## 2.4 I2C 初始化

### ①软件方式

```c
    // 1. 对 GPIOB 时钟使能
    RCC->APB2ENR |= RCC_APB2ENR_IOPBEN;

    // 2. SCL（PB10）设置为通用开漏输出, MODE=11；CNF=01
    GPIOB->CRH |= GPIO_CRH_MODE10;
    GPIOB->CRH &= ~GPIO_CRH_CNF10_1;
    GPIOB->CRH |= GPIO_CRH_CNF10_0;

    // 3. SDA（PB11）设置为通用开漏输出，MODE=11；CNF=01
    GPIOB->CRH |= GPIO_CRH_MODE11;
    GPIOB->CRH &= ~GPIO_CRH_CNF11_1;
    GPIOB->CRH |= GPIO_CRH_CNF11_0;

    // 4. 让SCL和SDA处于空闲状态
    SCL_HIGH;
    SDA_HIGH;
```

### ②硬件方式

```c
    // 1 时钟使能 -----------------------------------------
    // 1.1 对 GPIOB 时钟使能
    RCC->APB2ENR |= RCC_APB2ENR_IOPBEN;
    // 1.2 对 I2C2 时钟使能
    RCC->APB1ENR |= RCC_APB1ENR_I2C2EN;

    // 2 GPIO 引脚设置 ------------------------------------
    // 2.1 PB10(SCL) 复用开漏输出 MODE:11  ,CNF:11
    GPIOB->CRH |= GPIO_CRH_MODE10;
    GPIOB->CRH |= GPIO_CRH_CNF10;
    // 2.2 PB11(SDA) 复用开漏输出 MODE:11  ,CNF:11
    GPIOB->CRH |= GPIO_CRH_MODE11;
    GPIOB->CRH |= GPIO_CRH_CNF11;

    // 3 I2C2 配置 ----------------------------------------
    // 3.1 I2C2 软复位(可以省略)
    I2C2->CR1 |= I2C_CR1_SWRST;     // 置1进入复位状态
    Com_Delay_ms(100);              // 延迟100ms
    I2C2->CR1 &= ~I2C_CR1_SWRST;    // 置0退出复位状态
    Com_Delay_ms(100);              // 延迟100ms
    // 3.2 设置 I2C2 模块的输入时钟(APB1的时钟频率,36MHZ)       周期T_pclk1=1/36us
    I2C2->CR2 &= ~I2C_CR2_FREQ;     // 6个位置全部置0
    I2C2->CR2 |= 36;                // 将这6个位置设置为 100100
    // 3.3 设置 I2C2 模块的时钟分频系数                         标准模式： 速度 100kbit/s -> SCL频率:100kHz -> SCL周期：10us
    I2C2->CCR &= ~I2C_CCR_CCR;      // 12个位置全部置0         T_hight=5us T_low=5us 5=CCR*1/36 CCR=180
    I2C2->CCR |= 180;
    // 3.4 设置 I2C2 时钟的上升沿时间,设置为 1000ns=1us         T_pclk1=1/36us 标准模式最大上升沿时间:1us
    I2C2->TRISE = 37;                                      // 1/(1/36) = 36  36+1=37
    // 3.5 启动 I2C2 模块
    I2C2->CR1 |= I2C_CR1_PE;
```

