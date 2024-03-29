---
title: learn4java
date: 2021-03-19 14:23:54
tags:
  - java
---

> 文章记录服务端开发小白的 Java 学习过程

<!--more-->

# 1	Java

## 1.1	Java 基础

### 1.1.1	面向对象

#### 三大特性

- 封装：

将数据的属性和方法隐藏在内部，对外提供接口。

- 继承：

将数据的非私有属性和方法传递给子类。

父类引用指向子类对象成为**向上转型**。

- 多态：

多态分为编译时多态和运行时多态：

编译时多态：主要是指方法的重载

运行时多态：主要是指对象引用所指向的具体类型需要在运行期间确定

### 知识点

#### 数据类型

基本数据类型：

- byte/8

- short/16

- int/32

- long/64

- float/32

- double/64

- boolean/1

- char/16

#### 缓存池

- new Integer(123)  每次都创建新的对象；

- Integer.valueOf(123) 会使用缓存池中的对象，多次调用会取得同一对象的引用。

- valueOf() 会先判断值是否在缓存池中，如果有则直接返回缓存池中的内容，如果没有则在缓存池中创建值。

- 编译器会在基本数据类型缓冲范围内进行自动装箱过程中调用valueOf()。

- Java 8中，基本数据类型的缓冲池范围：

- Byte、Short、Integer缓存池的大小默认是 -128~127。

- Boolean values true and false。

- Character int the range \u0000 to \u007F （符号、数字、字母）

#### String

String 被 final 声明，因此不可被继承。

内部使用 char[] 存储数据，被 final 修饰，因此 String 不可被修改。

##### 不可变的好处？为什么String不可变？

1. 缓存 hash 值

   因为 String 的 hash 经常被使用，比如 HashMap 的 Key，不可变可以使 hash 值不变，只需要进行一次 hash
   计算。

2. String Pool 需要

   如果一个 String 对象已经被创建过了，那么就会从 String Pool 中取得引用。只有 String 是不可变的，才可能使用
   String Pool。

3. 安全性

4. 线程安全

   因为 String 不可变，因此天生线程安全。

##### String、StringBuffer、StringBuilder

1. 可变性

    - String 不可变

    - StringBuffer、StringBuilder 可变

2. 线程安全

    - String 不可变，所以线程安全
    - StringBuilder 线程不安全
    - StringBuffer 线程安全，内部使用 synchronized 进行同步

##### String.intern()

intern() 可以保证相同内容的字符串变量引用同一内存对象。

当 String 调用 intern() 时，如果字符串常量池中没有该值，则在字符串常量池中先创建该值，再讲常量池中的字符串引用返回；如果常量池中已经存在该值，则直接返回常量池中的字符串引用。

#### 运算

##### 参数传递

Java中的参数传递是值传递，而不是引用传递。

#### float和double

1.1默认属于 double，不能直接赋值给float，因为不能隐式向下转型

1.1f 才属于 float

##### 隐式类型转换

隐式类型转换不能向下转型，只能向上转型，就是朝着比自己范围更大的类型转型。

#### Object 通用方法

```java
public final native Class<?> getClass()
public native int hashCode()
public boolean equals(Object obj)
protected native Object clone() throws CloneNotSupportedException`
public String toString()
public final native void notify()
public final native void notifyAll()
public final native void wait(long timeout) throws InterruptedException
public final void wait(long timeout, int nanos) throws InterruptedException
public final void wait() throws InterruptedException
protected void finalize() throws Throwable {}
```

#### 关键字

##### final

1. 作用于类：无法被继承；
2. 作用于方法：无法被重载；
3. 作用于对象：无法被再次赋值。

##### static

1. 静态变量：属于类的变量，类的所有实例共享静态变量；

2. 静态方法：类加载时就存在，所有的静态方法必须被实现（换句话说静态方法不能抽象）；

3. 静态代码块：类初始化时运行一次；

4. 静态内部类：非静态内部类需要依赖于外部类的实例，而静态内部类不需要；静态内部类不能访问外部类非静态方法和属性；

5. 静态导包：在使用静态变量和方法时不需要声明 ClassName，但可读性大大降低；

6. 初始化顺序：静态变量和静态代码块优先于普通变量和普通代码块，最后才是构造函数的初始化。以下为类初始化的加载顺序：

   父类静态变量、父类静态代码块

   子类静态变量、子类静态代码块

   父类普通变量、父类普通代码块

   父类构造函数

   子类普通变量、子类普通代码块

   子类构造函数

#### 反射

反射可以提供运行时的类信息。

[反射机制详解](https://pdai.tech/md/java/basic/java-basic-x-reflection.html)

#### 异常

[异常机制详解](https://pdai.tech/md/java/basic/java-basic-x-exception.html)

![img](C:%5CUsers%5CYueYang%5CDocuments%5CGitHub%5CStudyNote%5Cimg%5CPPjwP.png)

#### 泛型

[泛型机制详解](https://pdai.tech/md/java/basic/java-basic-x-generic.html)

泛型是JDK1.5提出的新特性，泛型提供了在编译时期的类型安全检测机制，该机制允许程序员在编译时期检测到非法的类型。泛型的本质是参数化类型，也就是说将所操作的数据类型被指定为参数。

泛型类：

```java
class Point<T>{         // 此处可以随便写标识符号，T是type的简称  
    private T var ;     // var的类型由T指定，即：由外部指定  
    public T getVar(){  // 返回值的类型由外部决定  
        return var ;  
    }  
    public void setVar(T var){  // 设置的类型也由外部决定  
        this.var = var ;  
    }  
}

public class GenericsDemo06{  
    public static void main(String args[]){  
        Point<String> p = new Point<String>() ;     // 里面的var类型为String类型  
        p.setVar("it") ;                            // 设置字符串  
        System.out.println(p.getVar().length()) ;   // 取得字符串的长度  
    }  
}
```

泛型接口：

```java
interface Info<T>{        // 在接口上定义泛型  
    public T getVar() ; // 定义抽象方法，抽象方法的返回值就是泛型类型  
}  

class InfoImpl<T> implements Info<T>{   // 定义泛型接口的子类  
    private T var ;             // 定义属性  
    public InfoImpl(T var){     // 通过构造方法设置属性内容  
        this.setVar(var) ;    
    }  
    public void setVar(T var){  
        this.var = var ;  
    }  
    public T getVar(){  
        return this.var ;  
    }  
} 

public class GenericsDemo24{  
    public static void main(String arsg[]){  
        Info<String> i = null;        // 声明接口对象  
        i = new InfoImpl<String>("汤姆") ;  // 通过子类实例化对象  
        System.out.println("内容：" + i.getVar()) ;  
    }  
}  
```

泛型方法：

```java
public <T> T getObject(Class<T> c){
    T t = c.newInstance();
    return t;
}
```

说明一下，定义泛型方法时，必须在返回值前边加一个`<T>`，来声明这是一个泛型方法，持有一个泛型`T`
，然后才可以用泛型T作为方法的返回值。

#### 注解

[注解机制详解](https://pdai.tech/md/java/basic/java-basic-x-annotation.html)

#### 特性

##### Java SE 8

1. Lambda Expressions
2. Pipelines and Streams
3. Date and Time API
4. Default Methods
5. Type Annotations
6. Nashhorn JavaScript Engine
7. Concurrent Accumulators
8. Parallel operations
9. PermGen Error Removed

## 1.2	Java 集合框架

### Collection 关系图

![img](C:%5CUsers%5CYueYang%5CDocuments%5CGitHub%5CStudyNote%5Cimg%5Cjava_collections_overview.png)

### Collection

#### Set

##### TreeSet

基于红黑树实现，支持有序性操作。查询的时间复杂度为 O(logN)。

##### HashSet

基于哈希实现，不支持有序性操作，插入无序。查询的时间复杂度为 O(1)。

##### LinkedHashSet

具有HashSet的查询效率，且内部使用双向链表维护元素插入顺序。

#### List

##### ArrayList

基于数组实现，查询效率高，但在数组内部进行添加删除元素效率低。线程不安全。

自动扩容：每当向数组中添加元素时，都会检测添加后元素个数是否超出数组长度，如果超出，调用

```java
public void ensureCapacity(int minCapacity)
```

数组进行扩容时，会将老数组的元素重新拷贝一份到新数组，每次数组增加容量为原容量的 1.5
倍，这种操作代价很高，所以应尽量避免数组扩容，可以采用手动调用 ensureCapacity() 方法或者初始化时指定数组容量大小。

##### Vector

和 ArrayList 类似，线程安全。

##### LinkedList

基于双向链表实现，查询效率比 ArrayList 低，但可以快速在链表中间插入和删除元素。LinkedList
还可以用作栈、队列、双向队列。

LinkedList 同时实现了 List 和 Deque 接口，所以说既可以看做是一个列表，可以以看做是一个队列。当你需要使用栈时，还可以当做栈来使用，因为
Java 官方已经不推荐使用 Stack 了，当然，现在使用栈时更推荐使用 ArrayDeque，它比 LinkedList 当做栈使用时效率更高。

#### Queue

##### LinkedList

可以用来做双向队列。

```java
public class LinkedList<E> extends AbstractSequentialList<E> implements List<E>, Deque<E>, Cloneable, java.io.Serializable
```

##### PriorityQueue

优先队列，基于堆结构实现。优先队列的作用是每次取出的元素都是队列中权值最小的（ Java 中的优先队列取权值最小的，C++
中的优先队列取权值最大的）。

小顶堆。

#### Map

##### HashMap

基于哈希表实现，内部数据结构为链表+数组的形式，Java 8 以后改为链表+数组+红黑树的形式。

HashMap的扩容。

HashMap的查询时间复杂度 O(1)。

##### TreeMap

基于红黑树实现。

##### HashTable

和 HashMap 类似，在 HashMap 基础上每个方法都加了 synchronized 关键字保证线程安全，但多线程访问时会锁住整个数据结构，不推荐使用。

##### ConcurrentHashMap

线程安全，相比 HashTable 效率更高，JDK1.7使用分段锁加锁，JDK1.7使用Synchronized+CAS加锁。

简单总结一下JDK1.8的ConcurrentHashMap的加锁机制，当头结点为空时，使用CAS机制赋值，当头结点不为空时，Synchronized锁住当前头结点，判断当前头结点和期望头结点是否一致，这个过程就像CAS机制的判断过程一暗影，如果一致，则进行赋值操作，如果不一致，则重新对头结点进行赋值预期值，重新锁住头结点，巴拉巴拉。。。其实这样做的道理很简单，因为对头结点赋值的操作和锁住头结点的操作是两个时刻的操作，如果这个过程中有其他线程对头结点进行了一些修改，那就出问题了。

##### LinkedHashMap

使用双向链表来维护元素顺序，顺序为插入顺序或者最近最少使用顺序（LRU）。

### 集合框架相关问题

1. Stack，ArrayDeque，LinkedList的区别

   底层存储结构方面：

    - Stack 长度为 10 的数组；

    - ArrayDeque 长度为 16 的数组；

    - LinkedList 链表。

   线程安全方面：

    - Stack 线程安全
    - ArrayDeque 线程不安全
    - LinkedList 线程不安全

   性能选择方面：

    - 需要线程同步的话，使用 Collections.synchronizedxxx() 讲ArrayDeque 或 LinkedList 转换成线程安全的。
    - 频繁插入删除，使用 LinkedList。
    - 频繁随机访问，使用ArrayDeque。
    - 未知初始数据容量，使用 LinkedList。

2. 栈和队列

   Java 中有 Stack 的类，没有 Queue 的类（ Queue 是接口）。当使用栈时，Java 官方已经不推荐使用 Stack
   了，而是使用效率更高的 ArrayDeque。既然 Queue 只是一个接口，当需要使用队列时，首选 ArrayDeque（次选
   LinkedList）。

## 1.3	Java 多线程与并发

### 死锁

1. 什么是死锁？

   死锁是多个线程抢占公共资源而出现线程僵持，若无外力作用，它们都将无法继续前进。

2. 死锁产生的原因

   资源竞争、进程推进顺序非法

3. 死锁产生的四个必要条件

    - 互斥条件
    - 请求保持
    - 不可剥夺
    - 环路等待

4. 预防死锁的方式

    - 资源一次性分配（破坏请求条件）
    - 不能一次性得到所有资源，则一个资源也不分配（破坏保持条件）
    - 可剥夺资源（破坏不可剥夺）
    - 资源有序分配法

### 线程池

创建线程池的参数

```java
public ThreadPoolExecutor(int corePoolSize, // 核心线程数
                          int maximumPoolSize, // 最大线程数
                          long keepAliveTime, // 保持时间
                          TimeUnit unit, // 保持时间的单位
                          BlockingQueue<Runnable> workQueue, // 等待队列
                          ThreadFactory threadFactory, // 线程工厂
                          RejectedExecutionHandler handler); // 拒绝策略
```

几种常用的线程池类型：

```java
Excutors.newFixdThreadPool(int nThread); // 固定线程池
Excutors.newCacheThreadPool(); // 无边界线程池
Excutors.newSingleThreadPool(); // 单线程池
```

拒绝策略（上源码，自己悟）：

```java
    /**
     * A handler for rejected tasks that throws a
     * {@code RejectedExecutionException}.
     */
    public static class AbortPolicy implements RejectedExecutionHandler {..}

    /**
     * A handler for rejected tasks that runs the rejected task
     * directly in the calling thread of the {@code execute} method,
     * unless the executor has been shut down, in which case the task
     * is discarded.
     */
    public static class CallerRunsPolicy implements RejectedExecutionHandler {..}

    /**
     * A handler for rejected tasks that discards the oldest unhandled
     * request and then retries {@code execute}, unless the executor
     * is shut down, in which case the task is discarded.
     */
    public static class DiscardOldestPolicy implements RejectedExecutionHandler {..}

    /**
     * A handler for rejected tasks that silently discards the
     * rejected task.
     */
    public static class DiscardPolicy implements RejectedExecutionHandler {..}
```

### CAS机制

CAS机制叫做Compare And Swap，CAS机制中使用了3个基本操作数：内存地址V，旧的预期值A，要修改的新值B。

每次更新新值会判断内存地址V得值和预期值A是否一致，一致才会更新新值B，否则自旋，重新得到预期值A和计算新值B，这样来保证线程安全。

从思想上来说，synchronized是悲观锁，悲观的认为并发情况极其严重，所以无论如何也保证线程安全；CAS机制是乐观锁，乐观的认为并发情况并不严重，所以无限次的去重试更新。

#### CAS机制的缺点

- CPU开销过大，毕竟都乐观锁了，不断地尝试肯定对CPU有不小的开销
- 不能保证代码块的原子性
- ABA问题：这事CAS机制最大的问题所在

#### CAS机制的ABA问题

A线程：内存值为200，希望更改为100

B线程：内存值为200，希望更改为100

A线程执行完了，内存值为100，但是B线程卡住了，并且C线程进来了

C线程：内存值为100，希望更改为200

C线程执行完了，内存值为200，这之后B线程好了，B读取的内存值为200，确实是和期望的值一致，并且更改了值为100

这就是问题所在，解决的方式就是使用`版本号`

> 在Java中，AtomicStampedReference类就实现了用版本号作比较额CAS机制。

### Synchronized

#### 作用

保证原子性、可见性、有序性

#### 使用

- 修饰实例方法，对当前实例对象加锁
- 修饰静态方法，对当前类的Class对象加锁
- 修饰代码块，对synchronized括号内的对象加锁

#### Synchronized实现原理

JVM通过进入和退出Monitor对象来实现方法的同步和代码块的同步。

方法级的同步是隐式的，无需通过字节码指令来控制，它实现在方法调用和返回操作中。调用指令在会检测方法常量表中ACC_SYNCHRONIZED标志是否被设置，如果设置了，执行线程将持有monitor，然后再执行方法，在方法完成时释放monitor。

代码块的同步是利用monitorenter和monitorexit两个字节码指令，它们位于代码块的开始和结束位置，当执行到monitorenter时，当前线程尝试获取monitor对象的所有权，如果未加锁或者已经被当前线程加锁，那么就把锁的计数器+1，当执行到monitorexit时，锁的计数器-1；如果锁计数器不为0，如获取monitor所有权失败，当前线程被阻塞，直到其他线程释放锁。

来举个栗子！^_^

```java
public class SynchronizedDemo {
    public synchronized void f(){    //这个是同步方法
        System.out.println("Hello world");
    }
    public void g(){
        synchronized (this){		//这个是同步代码块
            System.out.println("Hello world");
        }
    }
}
```

反编译来瞅一眼JVM底层指令走的过程

```shell
javap -verbose SynchronizedDemo
```

```shell
  public synchronized void f();
    descriptor: ()V
    flags: ACC_PUBLIC, ACC_SYNCHRONIZED # 兄弟们看这里, 对于方法就是加了标识位
    Code:
      stack=2, locals=1, args_size=1
         0: getstatic     #2                  // Field java/lang/System.out:Ljava/io/PrintStream;
         3: ldc           #3                  // String Hello world
         5: invokevirtual #4                  // Method java/io/PrintStream.println:(Ljava/lang/String;)V
         8: return
      LineNumberTable:
        line 6: 0
        line 7: 8
      LocalVariableTable:
        Start  Length  Slot  Name   Signature
            0       9     0  this   Lcom/yueyang/SynchronizedDemo;

  public void g();
    descriptor: ()V
    flags: ACC_PUBLIC
    Code:
      stack=2, locals=3, args_size=1
         0: aload_0
         1: dup
         2: astore_1
         3: monitorenter  # 这里这里, 代码块开头加monitorenter
         4: getstatic     #2                  // Field java/lang/System.out:Ljava/io/PrintStream;
         7: ldc           #3                  // String Hello world
         9: invokevirtual #4                  // Method java/io/PrintStream.println:(Ljava/lang/String;)V
        12: aload_1
        13: monitorexit
        14: goto          22
        17: astore_2
        18: aload_1
        19: monitorexit # 这里这里, 代码块结尾加monitorexit
        20: aload_2
        21: athrow
        22: return
      Exception table:
         from    to  target type
             4    14    17   any
            17    20    17   any
      LineNumberTable:
        line 10: 0
        line 11: 4
        line 12: 12
        line 13: 22
      LocalVariableTable:
        Start  Length  Slot  Name   Signature
            0      23     0  this   Lcom/yueyang/SynchronizedDemo;
      StackMapTable: number_of_entries = 2
        frame_type = 255 /* full_frame */
          offset_delta = 17
          locals = [ class com/yueyang/SynchronizedDemo, class java/lang/Object ]
          stack = [ class java/lang/Throwable ]
        frame_type = 250 /* chop */
          offset_delta = 4
```

### volatile

作用：保证可见性

### 相关文章

#### Java 并发的理论知识

- 多线程的出现是要解决什么问题？

  众所周知，IO 设备、内存、CPU 之间速度有很大差异，为了更完全的使用 CPU
  的高性能，平衡三者之间的速度差异，CPU、操作系统、编译程序都做出了贡献：

    - CPU 增加缓存，平衡了 CPU 与内存的速度差异。导致可见性问题
    - 操作系统增加了线程、进程，复用CPU，平衡了 CPU 与 IO 设备的速度差异。导致了原子性问题
    - 编译程序优化指令执行次序，使缓存合理利用。导致有序性问题

- 线程不安全是指什么?

  线程不安全指的是多个线程对共享数据进行操作，会导致多次相同操作的结果不同。

- 并发出现线程不安全的本质什么? 可见性，原子性，有序性

    - 可见性：CPU 缓存引起的

    - 原子性：分时复用问题

      经典的**转账问题**：比如从账户A向账户B转1000元，那么必然包括2个操作：从账户A减去1000元，往账户B加上1000元。

      试想一下，如果这2个操作不具备原子性，会造成什么样的后果。假如从账户A减去1000元之后，操作突然中止。然后又从B取出了500元，取出500元之后，再执行
      往账户B加上1000元 的操作。这样就会导致账户A虽然减去了1000元，但是账户B没有收到这个转过来的1000元。

    - 有序性：重排序引起

- JAVA是怎么解决并发问题的: JMM(Java内存模型)

  https://www.infoq.cn/minibook/java_memory_model

###    

## 1.4	Java IO/NIO/AIO

## 1.5	Java 新版本特性

## 1.6	Java JVM相关

### JVM内存模型

JDK1.7：`堆`，`栈`，`方法区`，`程序计数器`，`本地方法栈`

JDK1.8：`堆`，`栈`，`程序计数器`，`本地方法栈`

JDK1.8将`方法区`改成`元空间`，从虚拟机内存中移出到本地内存

方法区也称为永久代，存放`静态变量`、`常量`、`类信息`、`运行时常量池`；

### JVM GC

#### JDK1.8默认垃圾收集器

查看方式：Java -XX:PrintCommandLineFlags -version

```shell
-XX:InitialHeapSize=133385472 -XX:MaxHeapSize=2134167552 -XX:+PrintCommandLineFlags -XX:+UseCompressedClassPointers -XX:+UseCompressedOops -XX:-UseLargePagesIndividualAllocation -XX:+UseParallelGC -- 默认垃圾收集器
java version "1.8.0_281"
Java(TM) SE Runtime Environment (build 1.8.0_281-b09)
Java HotSpot(TM) 64-Bit Server VM (build 25.281-b09, mixed mode)
```

JDK1.8的默认值是UseParallelGC，打开此开关后，使用`新生代（Parallel Scavenge）`，`老年代（Ps MarkSweep）`
的收集器组合进行内存回收。

`新生代收集器（Parallel Scavenge）`是采用标记复制算法、多线程模型进行垃圾收集。

与其他新生代垃圾收集器的差别是，它更关注于吞吐量，而不是停顿时间。一般来说，需要与用户交互的

程序更关注较短的停顿时间，而如果是需要达成尽量大的吞吐量的话，则该处理器会更加适合。

其通过`-XX：UseAdaptiveSizePolicy`参数，可以开启其自动调节功能，适用于对垃圾收集器的调优不太了解的

用户。

#### 如何查看GC日志？

JVM参数中添加：`-Xloggc : gc.log`

# 2	算法

## 2.1	数据结构基础

## 2.2	常见排序算法

### 冒泡排序

```java
    /**
     * 冒泡排序
     */
    public static void bubbleSort(int[] array) {
        int length = array.length;
        for (int i = length - 1; i > 0; i--) {
            for (int j = 0; j < i; j++) {
                if (array[j] > array[j + 1]) {
                    int temp = array[j];
                    array[j] = array[j + 1];
                    array[j + 1] = temp;
                }
            }
        }
    }
```

### 快速排序

```java
    /**
     * 快速排序
     */
    public static void quickSortTest(int[] array, int l, int r) {
        if (l < r) {
            int i = l;
            int j = r;
            int num = array[i];
            while (i < j) {
                while (i < j && array[j] > num)
                    j--;
                if (i < j)
                    array[i++] = array[j];
                while (i < j && array[i] < num)
                    i++;
                if (i < j)
                    array[j--] = array[i];
            }
            array[i] = num;
            quickSortTest(array, l, i - 1);
            quickSortTest(array, i + 1, r);
        }
    }
```

-----

# 3	数据库

## 3.1	关系型数据库

关系型数据库查询的流程：

1. 客户端管理器

   当连接数据库时：

    - 验证账号密码，验证访问权限
    - 检查进程是否有空余
    - 检查数据库负载是否严重
    - 管理器花一段时间来获取资源
    - 管理器发送查询语句给查询管理器
    - 得到数据后保存到缓冲区，向你发送数据

2. 查询管理器

    - 查询解析器：解析，并判断是否合法
    - 查询重写器：预优化，避免不必要的计算，给优化器提供最佳解决方案
    - 统计
    - 查询优化器
    -

3. 数据管理器

4. 客户端管理器

## 3.3非关系型数据库

## 3.4 事务

### 事务的基本要素

- **原子性**：要么全部执行，要么全部不执行；就像一件事一样，是不可再分的。
- **一致性**：事务执行前后，数据库完整性不会被破坏；就像A给B转账，A少了钱，B不可能不加钱。
- **隔离性**：同一时间，只允许一个事务访问同一数据；就像A取钱到结束之前，B不可能对这个账号进行转账操作。
- **持久性**：事务结束之后，数据永久性保存在数据库中，不能再回滚。

### 事务并发会造成问题

- **脏读**：事务A读到了事务B为提交的数据，然后B回滚了，A就读多了就叫脏读。

- **不可重复读**：事务A多次读取同一数据，但是B在A多次读取同一数据过程中，修改并提交了一部分数据，导致多次读取的数据结果不一致。

- **幻读**：事务A读取数据时，事务B插入了一条不太一致的数据，导致A读取到的数据和其他数据不太一致，就像幻觉一样。

  `不可重复读和幻读的区别在于，不可重复读是修改一条数据，幻读是增删了数据。所以解决方案上不可重复读只需要锁住行，幻读需要锁住表。`

### 事务的隔离级别

|                 事务隔离级别                 | 脏读 | 不可重复读 | 幻读 |
|:--------------------------------------:|:--:|:-----:|:--:|
| 读未提交（read-uncommited）<br>（可以读取到未提交的数据） | 是  |   是   | 是  |
|        读提交（read-commited）<br>（）        | 否  |   是   | 是  |
|         可重复读（repeatable-read）          | 否  |   否   | 是  |
|           串行化（seriallizable）           | 否  |   否   | 否  |

**总结**：

- 事务隔离级别为读提交时，写数据只会锁住相应的行
- 事务隔离级别为可重复读时，如果索引条件有索引的话，默认加锁方式是next-key锁；如果没有索引，那么会锁住整张表，这样可以方式幻读
- 事务隔离级别为串行化时，读写都会锁住整张表，完全保证了事务的安全情况下也具有极低的并发性，开发中不推荐使用
- 事务隔离级别越高，越能保证数据的完整性，但是相应的对并发的影响也越大

### 事务的传播机制

|                      类型                       |                             说明                             |
|:---------------------------------------------:|:----------------------------------------------------------:|
|       PROPAGATION_REQUIRED<br/>（必须是事务）        |      如果当前没有事务，就新建一个事务，如果已经存在一个事务中，加入到这个事务中。这是最常见的选择。       |
|     PROPAGATION_SUPPORTS<br>（支持事务，没有就算了）      |                 支持当前事务，如果当前没有事务，就以非事务方式执行。                 |
|    PROPAGATION_MANDATORY<br>（强制性，如果没有事务报错）    |                  使用当前的事务，如果当前没有事务，就抛出异常。                   |
|  PROPAGATION_REQUIRES_NEW<br>（必须新建，原来有事务就等着）  |                   新建事务，如果当前存在事务，把当前事务挂起。                   |
| PROPAGATION_NOT_SUPPORTED<br>（不支持事务，原来有事务就等着） |               以非事务方式执行操作，如果当前存在事务，就把当前事务挂起。                |
|      PROPAGATION_NEVER<br>（从不，不能以事务方式执行）      |                  以非事务方式执行，如果当前存在事务，则抛出异常。                  |
|    PROPAGATION_NESTED<br>（嵌套，作为原事务中的一个子事务）    | 如果当前存在事务，则在嵌套事务内执行。如果当前没有事务，则执行与PROPAGATION_REQUIRED类似的操作。 |

# 4	Spring

IOC

PCG中台

9500

Spring声明周期：

Bean定义、实例化前、实例化、实例化后、属性注入、初始化前、初始化、初始化后、得到Bean。

Spring三级缓存：

一级缓存：单例池，singletonObjects，存放成熟的Bean

二级缓存：earlySingletonObjects，存放循环依赖过程中不完整的Bean

三级缓存：AOP

单例Bean：可以通过唯一ID来定位唯一实例的Bean对象

单例池：单例Bean的实现方式，使用Map实现，key是beanName，value是bean对象

单例模式：一种设计模式，程序运行期间只存在一个实例

# 5	设计模式

## 5.1	策略模式

废话不多说，上代码来理解吧，人类的语言很难将设计模式讲明白，起码我不行

```java
public interface Strategy {
    int doOperation(int num1, int num2);
}
```

```java
public class OperateAdd implements Strategy {

    @Override
    public int doOperation(int num1, int num2) {
        return num1 + num2;
    }
}
```

```java
public class OperateSubtract implements Strategy {

    @Override
    public int doOperation(int num1, int num2) {
        return num1 - num2;
    }
}
```

```java
public class OperateMultiply implements Strategy {

    @Override
    public int doOperation(int num1, int num2) {
        return num1 * num2;
    }
}
```

```java
public class Context {

    private Strategy strategy;

    public Context(Strategy strategy) {
        this.strategy = strategy;
    }

    public int executeStrategy(int num1, int num2) {
        return strategy.doOperation(num1, num2);
    }
}
```

```java
public class StrategyPatternDemo {

    public static void main(String[] args) {
        Context context = new Context(new OperateAdd());
        System.out.println("10 + 5 = " + context.executeStrategy(10, 5));

        context = new Context(new OperateSubtract());
        System.out.println("10 - 5 = " + context.executeStrategy(10, 5));

        context = new Context(new OperateMultiply());
        System.out.println("10 * 5 = " + context.executeStrategy(10, 5));
    }

}
```

**核心思想**：`抽象实现共性，接口实现特性`

多使用行为特性的组合，少用共性抽象，这样更有弹性。


------

# 等待解决的面试题

- [ ] 了解一下 sonrt

- [ ] 了解一下 kafka

- [ ] 数据库：引擎、索引、事务、锁

- [ ] 计算机网络：TCP、UDP

- [ ] 讲讲 redis

- [ ] 面向对象的理解、面向过程的理解、多态的理解

- [ ] 深拷贝和浅拷贝，进行深拷贝的方式有那些？

- [ ] 讲一讲集合：List、Set、Map、ArrayList、LinkedList

- [ ] 讲讲泛型，如何使用？举个例子

- [ ] 讲讲异常

- [ ] 计算机网络分几层？分别使用什么协议？

- [ ] MySql 事务特性的理解，并发问题，隔离级别

- [ ] 讲讲 cookie和session的区别、作用

- [ ] linux常用命令：如何查看可用端口？lsof -i 和 netstat -aptn；如何查看日志？tail -f 、less、cat

- [ ] 什么是幂等？什么情况下需要考虑幂等？我是怎么解决幂等的？

- [ ] 多个线程同时读写，读线程的数量远远大于写线程，你认为应该如何解决
  并发的问题？你会选择加什么样的锁？ReentrantReadWriteLock 读写锁；

- [ ] JAVA的AQS是否了解，它是⼲嘛的？AbstractQueuedSynchronizer

- [ ] 除了synchronized关键字之外，你是怎么来保障线程安全的？加锁啊，就上面那个问题

- [ ] 什么时候需要加volatile关键字？它能保证线程安全吗？答案：在满足以下两个条件的情况下，volatile就能保证变量的线程安全问题：

    1. 运算结果并不依赖变量的当前值，或者能够确保只有单一的线程修改变量的值。

    2. 变量不需要与其他状态变量共同参与不变约束

       能保证可见性、有序性，不能保证原子性，所以不能完全保证线程安全。

- [ ] 线程池内的线程如果全部忙，提交⼀个新的任务，会发⽣什么？队列全部 塞满了之后，还是忙，再提交会发⽣什么？

- [ ] TCP和UDP的区别？TCP可靠稳定传输慢，UDP迅速大量不可靠

- [ ] 互联网公司的分布式ID的生成策略？Redis生成ID并持久化、雪花算法

- [ ] MySQL事务相关知识
