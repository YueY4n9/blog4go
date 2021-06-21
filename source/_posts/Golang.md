---
title: Golang
date: 2021-06-16 22:18:18
tags:
- Golang
---

> 本文目的是记录好Java开发转Golang开发的经历，分享一下学习过程来帮助想要Java转Golang的朋友一起进步一起学习！

# 0、安装配置

下载地址：https://golang.google.cn/dl/

下载好了用`go version`来校验

配置环境：GOPATH、Path

配置好了用`go env`来校验



# 1、Golang基础

### 优势：

- 天生支持并发
- 企业级编程语言（Golang、Java）
- 面向薪资编程（？）

### 命令

```go
go build
go build -o "***.exe"
go run main.go
go install
```



### 变量

```go
var name string // 声明
var age int = 16 // 声明并赋值
// 类型推导
var s1 string = "string1"
var s2 = "string2" // 上面可直接写成这样
// 简短变量声明，只能在函数中使用，不能在全局使用
s3 := "string3" // 上面的简写
// 匿名变量(就是一个下划线) -> _ : 匿名变量不占用命名空间，不会分配内存（Lua里叫哑元变量）
func foo(int, string){
    return 10, "yueyang"
}
func main(){
    x, _ := foo()
    _, y := foo()
}
```

注意事项：

- 函数外每个语句必须以关键字开始（var、func、const等）
- := 不能用于函数外
- _用于占位符，表示忽略值
- 函数内声明变量不使用，编译不能通过（似乎不同版本有不同的要求）

### 常量

常量是恒定不变的值，使用关键字const

```go
// 单个声明
const pai = 3.1415926
// 批量声明
const (
	statusOK = 200
    notFound = 404
)
// 这种批量声明方式，没有赋值的常量默认和上面那个值一样
const (
	n1 = 200
    n2
    n3
)
// iota: 常量计数器, iota将在const关键字出现时重置为0，const中每新增一行常量声明将使iota计数一次（iota可以理解成const语句块的行索引）。使用iota简化定义，在定义枚举时很有用
const (
	n1 = iota // 0
    n2		  // 1
    n3		  // 2
    n4		  // 3
)

const (
	a1 = iota // 0
    a2		  // 1
    _		  // 2
    a3		  // 3
)

const (
	b1 = iota // 0
    b2 = 100  // 100
    b3 = iota // 2
    b4		  // 3
)
// 多个常量声明在一行
const (
    c1, c2 = iota + 1, iota + 2 // d1:0+1, d2:0+2
    c3, c4 = iota + 1, iota + 2 // d3:1+1, d4:1+2
)
// iota的应用，举个例子
const (
	_ = iota
    KB = 1 << (10 * iota)
    MB = 1 << (10 * iota)
    GB = 1 << (10 * iota)
    TB = 1 << (10 * iota)
    PB = 1 << (10 * iota)
)
```

## 基本数据类型

基本数据类型有整型、浮点型、布尔型、字符串、数组、切片、结构体、函数、map、通道等

### 整型

int8、int16、int32、int64、uint8、uint16、uint32、uint64

特殊整型：

|  类型   |                        描述                        |
| :-----: | :------------------------------------------------: |
|  uinit  | 32位操作系统上就是uint32，64位操作系统上就是uint64 |
|   int   |  32位操作系统上就是int32，64位操作系统上就是int64  |
| uintptr |            无符号整型，用于存放一个指针            |

#### 八进制&十六进制

Go语言中无法直接使用二进制，关于八进制和十六进制实例如下：

```go
var num1 = 101 // 十进制
fmt.Printf("%d\n", num1) // 输出十进制数
fmt.Printf("%b\n", num1) // 输出二进制数
fmt.Printf("%o\n", num1) // 输出八进制数
fmt.Printf("%x\n", num1) // 输出十六进制数
fmt.Printf("%T\n", num1) // 输出数据类型
var num2 = 077 // 八进制
var num3 = 0x123456789abcdef // 十六进制

// 强制声明int8类型
var num4 int8 = 100
```



### 浮点型

float32、float64

```go
func main(){
    f1 := 1.2345
    fmt.Printf("%T\n", f1) // float64 默认go语言中小数都是float64
}
```

### 复数

`complex128`和`complex64`

### 布尔型

Go语言中使用`bool`类型声明布尔型，只有`true`和`false`两个值

注意事项：

- 布尔型默认值是`false`
- 不允许将整型强转为布尔型
- 布尔型无法参与数值运算，也无法与其他类型进行转换

### 字符串

Go语言中字符串内部实现使用`UTF-8`编码，字符串的值为双引号的内容。

Go语言单引号包裹的是字符。

```go
s1 := "嘻嘻"
s2 := '1'
s3 := 'a'
s4 := '岳'
// 字节：1字节 = 8Bit（8个二进制位）
// 定义多行字符串，使用``
s5 := `床前明月光
疑是地上霜
举头望明月
低头思故乡
`
```

#### 字符串操作

|      功能      |                 方法                 |
| :------------: | :----------------------------------: |
|     求长度     |              len（str）              |
|   拼接字符串   |        加号或者fmt.Sprintf()         |
|      分割      |            strings.Split             |
|    是否包含    |           strings.contains           |
|   前后缀判断   | strings.HasPrefix/strings.HasSuffix  |
| 子串出现的位置 | strings.Index()/strings.LastIndex()  |
|    join操作    | strings.Join(a []string, sep string) |

#### 字符

组成字符串的元素称为`字符`，Go语言字符有两种：

1. `uint8`，或者叫`byte`类型，代表了ASCII码的一个字符
2. `rune`，代表一个`UTF-8`字符，当需要表示中文、日语或者其他复合字符时，就需要用到`rune`类型。`rune`类型实际上是一个`int32`

#### 修改字符串

字符串是无法直接修改的，如果修改，可以转换成字符切片

```go
func main(){
    s1 := "岳小杨超可爱"
    s2 := []rune(s1)
    s2[2] = '羊'
    fmt.Printf(string(s2)) // 将s2强制转换成string
}
```

## 复合数据类型

### 数组

数组的长度是数组类型的一部分

```go
var nums [3]int
```

#### 初始化

如果不初始化，默认元素为零值

```go
// 方式一
var nums1 = [3]int{1, 2, 3}
// 方式二
var nums2 = [...]int{1, 2, 3, 4, 5, 6, 7, 8, 9}
// 方式三
var nums3 = [5]int{1, 2} // [1, 2, 0, 0, 0]
// 方式四
var nums4 = [5]int{0:1, 4:2} // [1, 0, 0, 0, 2]
```

#### 遍历

```go
names := [...]string{"岳杨", "幂律", "GO语言"}
// 方式一
for i := 0; i < len(names); i++ {
    fmt.Println(names[i])
}
// 方式二
for i, v := range names {
    fmt.Println(i, v)
}
```

>  数组是值类型

```go
// 证明数组是值类型
nums1 := [3]int{1, 2, 3}
nums2 := num1
nums2[0] = 100
fmt.Println(b1, b2) // [1, 2, 3] [100, 2, 3]
```

### 切片

切片`Slice`是一个拥有相通类型元素的可变长度的序列

```go
var nums1 []int
var nums2 []int
fmt.Println(nums1 == nil) // true
fmt.Println(nums2 == nil) // true
nums1 = []int{1, 2, 3}
nums2 = []int{4, 5, 6, 7}
fmt.Println(nums1 == nil) // false
fmt.Println(nums2 == nil) // false
```

#### 长度和容量

```go
nums1 := []int{1, 3, 5, 7} // 切片
nums2 := [7]int{0, 1, 2, 3, 4, 5, 6} // 数组
fmt.Printf("%d %d\n", len(nums1), cap(nums1))
```

#### 由数组得到切片

```go
nums1 := [7]int{0, 1, 2, 3, 4, 5, 6} // 数组
nums2 := nums1[0, 4] // [0, 1, 2, 3] // 数组得到切片，左闭右开
nums3 := nums1[1:]
nums4 := nums1[:4]
nums5 := nums1[:]
```

> 1、切片是引用类型，真正的数组都是保存在底层的数组里。
>
> 2、一个`nil`的切片是没有底层数组的。
>
> 3、判断切片为空应该判断`len() == 0`

#### make函数

```go
nums1 := make([]int, 5, 10) // 参数：切片类型，长度，容量
```

#### append函数

```go
nums1 := []int{1, 2, 3}
nums1[3] = 4 // 错误写法，切片超过容量导致编译错误：索引越界
fmt.Println(nums1)

// append函数
fmt.Println("%v %d %d", nums1, len(nums1), cap(nums1)) // [1, 2, 3] len=3 cap=3
nums1 = append(nums1, 4) // 调用append函数必须用原来的切片变量接收返回值
fmt.Println("%v %d %d", nums1, len(nums1), cap(nums1)) // [1, 2, 3, 4] len=4 cap=6
```

> 调用append函数必须用原来的切片变量接收返回值，底层涉及到数组的重新分配内存空间

注意事项：

- 





## fmt包

```go
func main(){
    var num = 100
	fmt.Printf("%T\n", num)
    fmt.Printf("%v\n", num)
    fmt.Printf("%b\n", num)
    fmt.Printf("%d\n", num)
    fmt.Printf("%o\n", num)
    fmt.Printf("%x\n", num)
    var str = "String"
    fmt.Printf("%s\n", str)
    fmt.Printf("%v\n", num)
    fmt.Printf("%#v\n", num)
}

```

## 流程控制

### if

```go
// 经典用法
if 表达式 {
    // 执行操作
} else if 表达式 {
    // 执行操作
} else {
    // 执行操作
}
// 特殊用法
if age := 19; age > 18 {
    fmt.Printf("青年")
}
```

### for

```go
for 初始语句;条件语句;结束语句 {
    // 执行操作
    break // 跳出for循环
    continue // 跳过for循环
    goto breakLabel// 跳出到标签
}

breakLabel: // 标签
fmt.Println("跳出来了，嘻嘻")
```

### for range

```go
s := "yueyang"
for i,v := range s {
    fmt.Printf("%d, %c\n", i, v);
}
```

### switch

```go
switch 值{
    case 值:
    	// 操作
    case 值:
    	// 操作
    default:
    	// 操作
}

switch 初始化; 值{
    case 值,值,值:
    	// 操作
    	fallthrough // 向下穿透一个
    case 值,值,值:
    	// 操作
    default:
    	// 操作
}


```

## 运算符

`&`按位与

`|`按位或

`^`按位异或

`<<`左移

`>>`右移