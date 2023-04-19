---
title: learn4go
date: 2021-06-16 22:18:18
tags:

- go

---

> 本文目的是记录我从 Java 开发转 Golang 开发的学习经历，分享一下学习过程来帮助想要 Java 转 Golang 的朋友一起进步一起学习！

<!--more--> 

# 0、安装配置

下载地址：https://golang.google.cn/dl/

下载好了用`go version`来校验

配置环境：GOPATH、Path

配置好了用`go env`来校验

# 1、Golang基础

### 优势：

- 并发编程优雅简单：Go语言原生支持协程（goroutine）和管道（channel），并提供了灵活而简单的并发编程机制。使用goroutine可以让我们非常方便地实现高并发、高性能的服务，同时也能有效避免线程安全问题。
- 零值机制：天生就有初始值，不用考虑空值情况。
- 内存管理自动化：Go语言的垃圾回收机制使得开发者可以不用关心内存的回收问题，极大地降低了程序出错的可能性和代码的复杂度。
- 语法简洁、易读易写：Go语言的语法简洁，没有像C++和Java那样繁琐的语法，特别是其强制规范化的代码风格更是方便了开发者对代码的理解和阅读。
- 静态类型系统：Go语言采用静态类型系统，可以在编译期检查出很多类型错误，避免了在运行时出现的错误。
- 良好的可移植性：Go语言的标准库支持多种操作系统和硬件平台，开发者可以轻松地将代码移植到不同的平台上。
- 开发效率高：Go语言的构建工具可以帮助开发者进行高效构建和测试。同时，Go语言的包管理工具go mod也是一个非常强大的工具，可以帮助开发者解决依赖管理和版本控制等问题。

### 命令

```shell
go build
go build -o "***.exe"
go run main.go
go install
```

### 变量

```go
package main

import "fmt"

// 匿名变量(就是一个下划线) -> _ : 匿名变量不占用命名空间，不会分配内存（Lua里叫哑元变量）
func foo(i int, s string) (int, string) {
	return i, s
}
func main() {
	x, _ := foo(0, "zero")
	_, y := foo(1, "one")
	fmt.Println(x, y)

	var name string  // 声明
	var age int = 16 // 声明并赋值
	// 类型推导
	var s1 string = "string1"
	var s2 = "string2" // 上面可直接写成这样
	// 简短变量声明，只能在函数中使用，不能在全局使用
	s3 := "string3" // 上面的简写
	fmt.Println(name, age, s1, s2, s3)
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
package main

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
	n2        // 1
	n3        // 2
	n4        // 3
)

const (
	a1 = iota // 0
	a2        // 1
	_         // 2
	a3        // 3
)

const (
	b1 = iota // 0
	b2 = 100  // 100
	b3 = iota // 2
	b4        // 3
)

// 多个常量声明在一行
const (
	c1, c2 = iota + 1, iota + 2 // d1:0+1, d2:0+2
	c3, c4 = iota + 1, iota + 2 // d3:1+1, d4:1+2
)

// iota的应用，举个例子
const (
	_  = iota
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

|   类型    |                描述                 |
|:-------:|:---------------------------------:|
|  uinit  | 32位操作系统上就是uint32，64位操作系统上就是uint64 |
|   int   |  32位操作系统上就是int32，64位操作系统上就是int64  |
| uintptr |          无符号整型，用于存放一个指针           |

#### 八进制&十六进制

Go语言中无法直接使用二进制，关于八进制和十六进制实例如下：

```go
package main

import "fmt"

func main() {
	var num1 = 101               // 十进制
	fmt.Printf("%d\n", num1)     // 输出十进制数
	fmt.Printf("%b\n", num1)     // 输出二进制数
	fmt.Printf("%o\n", num1)     // 输出八进制数
	fmt.Printf("%x\n", num1)     // 输出十六进制数
	fmt.Printf("%T\n", num1)     // 输出数据类型
	var num2 = 077               // 八进制
	var num3 = 0x123456789abcdef // 十六进制
	// 强制声明int8类型
	var num4 int8 = 100
	fmt.Println(num2, num3, num4)
}

```

### 浮点型

float32、float64

```go
package main

import "fmt"

func main() {
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
package main

import "fmt"

func main() {
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
	fmt.Print(s1, s2, s3, s4, s5)
}

```

#### 字符串操作

|   功能    |                  方法                  |
|:-------:|:------------------------------------:|
|   求长度   |               len（str）               |
|  拼接字符串  |          加号或者fmt.Sprintf()           |
|   分割    |            strings.Split             |
|  是否包含   |           strings.contains           |
|  前后缀判断  | strings.HasPrefix/strings.HasSuffix  |
| 子串出现的位置 | strings.Index()/strings.LastIndex()  |
| join操作  | strings.Join(a []string, sep string) |

#### 字符

组成字符串的元素称为`字符`，Go语言字符有两种：

1. `uint8`，或者叫`byte`类型，代表了ASCII码的一个字符
2. `rune`，代表一个`UTF-8`字符，当需要表示中文、日语或者其他复合字符时，就需要用到`rune`类型。`rune`类型实际上是一个`int32`

#### 修改字符串

字符串是无法直接修改的，如果修改，可以转换成字符切片

```go
package main

import "fmt"

func main() {
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
package main

import "fmt"

func main() {
	var nums [3]int
	fmt.Println(nums)
}

```

#### 初始化

如果不初始化，默认元素为零值

```go
package main

import "fmt"

func main() {
	// 方式一
	var nums1 = [4]int{1, 2, 3, 4} // [1, 2, 3, 4]
	// 方式二
	var nums2 = [...]int{1, 2, 3, 4} // [1, 2, 3, 4]
	// 方式三
	var nums3 = [4]int{1, 2} // [1, 2, 0, 0]
	// 方式四
	var nums4 = [4]int{0: 1, 3: 4} // [1, 0, 0, 4]
	fmt.Println(nums1, nums2, nums3, nums4)
}

```

#### 遍历

```go
package main

import "fmt"

func main() {
	names := [...]string{"岳杨", "幂律", "GO语言"}
	// 方式一
	for i := 0; i < len(names); i++ {
		fmt.Println(names[i])
	}
	// 方式二
	for i, v := range names {
		fmt.Println(i, v)
	}
}

```

> 数组是值类型

```go
package main

import "fmt"

func main() {
	// 证明数组是值类型
	nums1 := [3]int{1, 2, 3}
	nums2 := nums1
	nums2[0] = 100
	fmt.Println(nums1, nums2) // [1, 2, 3] [100, 2, 3]    
}

```

### 切片

切片`Slice`是一个拥有相通类型元素的可变长度的序列

```go
package main

import "fmt"

func main() {
	var nums1 []int
	var nums2 []int
	fmt.Println(nums1 == nil) // true
	fmt.Println(nums2 == nil) // true
	nums1 = []int{1, 2, 3}
	nums2 = []int{4, 5, 6, 7}
	fmt.Println(nums1 == nil) // false
	fmt.Println(nums2 == nil) // false    
}

```

#### 长度和容量

```go
package main

import "fmt"

func main() {
	nums1 := []int{1, 3, 5, 7}           // 切片
	nums2 := [7]int{0, 1, 2, 3, 4, 5, 6} // 数组
	fmt.Printf("%d %d\n", len(nums1), cap(nums1))
	fmt.Printf("%d %d\n", len(nums2), cap(nums2))
}

```

#### 由数组得到切片

```go
package main

import "fmt"

func main() {
	nums1 := [7]int{0, 1, 2, 3, 4, 5, 6} // 数组
	nums2 := nums1[0:4]                  // [0, 1, 2, 3] // 数组得到切片，左闭右开
	nums3 := nums1[1:]
	nums4 := nums1[:4]
	nums5 := nums1[:]
	fmt.Println(nums1, nums2, nums3, nums4, nums5)
}

```

> 1、切片是引用类型，真正的数组都是保存在底层的数组里。
>
> 2、一个`nil`的切片是没有底层数组的。
>
> 3、判断切片为空应该判断`len() == 0`。
>
> 4、`nil`的切片就算没有底层数组，也可以进行`append`操作，`append`会自动为`nil`切片创建空间。

#### make函数

```go
package main

import "fmt"

func main() {
	nums1 := make([]int, 5, 10) // 参数：切片类型，长度，容量
	fmt.Println(nums1)
}

```

#### append函数

```go
package main

import "fmt"

func main() {
	nums1 := []int{1, 2, 3}
	nums1[3] = 4 // 错误写法，切片超过容量导致编译错误：索引越界
	fmt.Println(nums1)

	// append函数
	fmt.Printf("%v %d %d", nums1, len(nums1), cap(nums1)) // [1, 2, 3] len=3 cap=3
	nums1 = append(nums1, 4)                              // 调用append函数必须用原来的切片变量接收返回值
	fmt.Printf("%v %d %d", nums1, len(nums1), cap(nums1)) // [1, 2, 3, 4] len=4 cap=6    
}

```

> 调用`append`函数必须用原来的切片变量接收返回值，底层涉及到数组的重新分配内存空间
>
> `append`函数会为空切片创建内存空间，并且会对容量不够的切片进行扩容操作

## fmt包

```go
package main

import "fmt"

func main() {
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
package main

import "fmt"

func main() {
	expression := true
	// 经典用法
	if expression {
		// 执行操作
	} else {
		// 执行操作
	}
	// 特殊用法
	if age := 19; age > 18 {
		fmt.Printf("青年")
	}
}

```

### for

```go
package main

import "fmt"

func main() {
	for i := 0; i < 10; i++ {
		// 执行操作
		fmt.Println(i)
		if i < 3 {
			continue // 跳过for循环

		} else if i < 6 {
			break // 跳出for循环
		}
		goto breakLabel // 跳出到标签
	}
breakLabel: // 标签
	fmt.Println("跳出来了，嘻嘻")
}

```

### for range

```go
package main

import "fmt"

func main() {
	s := "yueyang"
	for i, c := range s {
		fmt.Printf("%d, %c\n", i, c)
	}
}

```

### switch

```go
package main

func main() {
	str := "0"
	switch str {
	case "0":
		// 操作
	case "1":
		// 操作
	default:
		// 操作    
	}
	switch str = "1"; str {
	case "0", "1", "2":
		// 操作
		fallthrough // 向下穿透一个
	case "3", "4", "5":
		// 操作
	default:
		// 操作
	}
}

```

## 运算符

`&`按位与

`|`按位或

`^`按位异或

`<<`左移

`>>`右移

## 指针

取地址操作符`&`

取值操作符`*`

注意事项：

- 引用类型变量不仅要声明还要分配内存空间

那么就引入了两个初始化方式`new` `make`

### new函数

`new`函数不太常用

```go
package main

type T struct{}

func new(T) *T // 接收一个类型，返回该类型的指针

```

### make函数

make也是用于内存分配的，区别于new，make函数只作用于slice、map、chan类型的内存创建，由于这些类型本身就是引用类型，make返回的就是类型本身。

```go
package main

func make(t string, size ...int) string // 接收一个类型和容量大小，返回类型本身

```

make函数是不可替代的函数，slice、map、chan都需要make函数初始化才能进行操作。

### new和make

1. 两者都是用来创建内存的
2. new用于类型的内存分配，内存对应的值为类型的零值，返回的是指向类型的指针
3. make作用于slice、map、chan类型，返回类型本身

## 结构体

### 自定义类型

类型定义和类型别名

```go
package main

import "fmt"

// NewInt 类型定义
type NewInt int

// MyInt 类型别名
type MyInt = int

func main() {
	var a NewInt
	var b MyInt
	fmt.Println("%T", a) // main.NewInt
	fmt.Println("%T", b) // int
}

```

### 结构体

Go语言通过`struct`来面向对象

```go
package main

type T struct {
	Id   int
	Name string
}

```

### 结构体实例化

```go
package main

import "fmt"

type Person struct {
	name string
	age  int8
}

func main() {
	var person Person
	person.name = "yueyang"
	person.age = 24
	fmt.Printf("%v\n", person)  // {yueyang, 24}
	fmt.Printf("%#v\n", person) // main.Person{name:"yueyang", age:24}
}

```

### 匿名结构体

```go
package main

import "fmt"

func main() {
	var user struct {
		Name string
		Age  int
	}
	user.Name = "yueyang"
	user.Age = 24
	fmt.Printf("%#v\n", user) // struct { Name string; Age int }{Name:"yueyang", Age:24}
}

```

### 结构体指针

```go
package main

import "fmt"

type Person struct{}

func main() {
	var person = new(Person)
	fmt.Printf("%+v", *person)
}

```

# 2、Golang标准库

## strconv

### Atoi()

> 将字符串转换成整形

### Itoa()

> 将整形转换成字符串

### ParseBool()

> 解析字符串成布尔类型, 可以接受1, t, T, TRUE, true, True, 0, f, F, FALSE, false, False; 否则返回错误

### ParseInt()

### ParseUnit()

> 类似于ParseInt(), 区别在于不能接受正负号, 返回uint

### ParseFloat()

### FormatBool()

### FormatInt()

### FormatUint()

### FormatFloat()

# 3、异常机制

> go中追求简洁优雅，使用多返回值来返回错误解决异常情况。只有在除数为零时，才会真正的使用异常机制，`defer`、`panic`、`recover`

底层实现看[这篇文章](https://blog.csdn.net/shidantong/article/details/106341159)

> 调用 defer 关键字会立刻对函数中引用的外部参数进行拷贝

# 4、Golang第三方包

## github.com/gin-gonic/gin

gin包提供golang一个基本web框架

gin.Context实现了Golang标准库中的net/http下Handler接口中的唯一方法ServeHttp(ReponseWriter, \*Request)

```go
package http

// A Handler responds to an HTTP request.
//
// ServeHTTP should write reply headers and data to the ResponseWriter
// and then return. Returning signals that the request is finished; it
// is not valid to use the ResponseWriter or read from the
// Request.Body after or concurrently with the completion of the
// ServeHTTP call.
//
// Depending on the HTTP client software, HTTP protocol version, and
// any intermediaries between the client and the Go server, it may not
// be possible to read from the Request.Body after writing to the
// ResponseWriter. Cautious handlers should read the Request.Body
// first, and then reply.
//
// Except for reading the body, handlers should not modify the
// provided Request.
//
// If ServeHTTP panics, the server (the caller of ServeHTTP) assumes
// that the effect of the panic was isolated to the active request.
// It recovers the panic, logs a stack trace to the server error log,
// and either closes the network connection or sends an HTTP/2
// RST_STREAM, depending on the HTTP protocol. To abort a handler so
// the client sees an interrupted response but the server doesn't log
// an error, panic with the value ErrAbortHandler.
type Handler interface {
	ServeHTTP(ResponseWriter, *Request)
}

```

这是 Golang 实现 WebService 最基础的接口，通过实现其方法来

# Golang 的编译过程

1. 词法和语法分析：编译器读入源代码文件，对代码进行分词和语法分析，生成语法树的数据结构。
2. AST 转换：编译器会对语法树进行一些处理和转换，例如检查类型、解析函数调用等，在此过程中还会对代码进行优化。
3. 代码生成：将转换后的语法树转换成机器码或字节码，并将其打包成可执行文件或库文件。
4. 链接：链接器将被引用的库文件链接到目标程序中，生成最终的可执行文件。在 Golang 中，链接过程是由 go 工具自动完成的，开发人员无需显式执行链接命令。