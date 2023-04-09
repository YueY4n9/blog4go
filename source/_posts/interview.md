---
title: 面试总结
date: 2021-05-31 15:07:04
tags:
  - 总结
  - 面试
---

>   整理了 2021 年 5 月面试 Java 中级研发工程师过程中，遇到的知识疏漏点和模糊点，以及面试过程中的面试题的详细解析，对于一些比较基础的问题只做了简单的记录，希望能对个人提升和习惯养成有所帮助

<!--more-->

>   2021-07-22

### TCP/UDP区别

TCP向上层提供面向连接的可靠服务 ，UDP向上层提供无连接不可靠服务

虽然 UDP 并没有 TCP 传输来的准确，但是也能在很多实时性要求高的地方有所作为

对数据准确性要求高，速度可以相对较慢的，可以选用TCP

### Zookeeper是什么框架

Zookeeper是分布式系统协调服务的框架，也叫作服务注册中心

### Dubbo一般用什么注册中心？还有别的选择吗？

Dubbo一般使用Zookeeper，也可以使用Redis，consul，数据库

### 为什么说Spring是一个容器？

Spring的核心思想是更方便的管理Java Bean，有Spring创建的Bean放入一个Map中，这个Map就可以理解成装Bean的容器，也就是IOC容器。

### JVM生命周期和体系结构

JVM声明周期是跟随程序一起的，JVM开始运行时就是程序启动时，JVM停止运行程序也随之结束。

JVM体系结构包含：类加载器、内存区、执行引擎、本地方法调用。

> 2021-06-07

### ConcurrentHashMap为什么是CAS+Synchronized？

用CAS是为了减小锁的粒度，毕竟CAS是JUC下面使用最多的锁，用Synchronized是因为Synchronized可以不断优化，并且粒度也不高。

### MyBatis是怎么实现的？不用Spring怎么集成？

### CAS会出现什么问题？怎么解决的？

ABA问题

### MySQL和Redis的重要数据，必须完全一致，这个怎么实现？

### MySQL是可重复读是怎么实现的？

使用MVCC（多版本并发控制），每次SELECT之前会找到上一个数据版本，只读当前版本的数据。innoDB已经实现"秒级快照版本"

### springboot做了哪些事？深入到底层是怎么实现的？

### Redis的Key过期后会立即删除么？

不会的，三种删除策略：定时删除、惰性删除（？还有什么？原理是什么）

### Redis的集群用过吗？是怎么的架构？哨兵机制呢？

### 分布式集群下怎么执行定时任务？

### 为什么分布式要用RestTemplete而不用HttpUtils？

### JWT的整体流程是怎样的？
MySQL锁
Redis集群

> 2021-06-04

### maven父类依赖冲突

maven的依赖原则

### 线城池参数、拒绝策略、流程

7个参数：核心线程数、总线程数、存活时间、时间单位、阻塞队列、工厂、拒绝策略

4个拒绝策略：拒绝并抛出异常、静默拒绝、移除队列中最前面的任务然后重新提交被拒绝的任务、由调用线程来执行该任务

流程：先看核心线程是否满了，满了再看阻塞队列是否满了，满了再看总线程数是否满了，满了再走拒绝策略

### ConcurrentHashMap的线程安全在JDK1.7和JDK1.8的区别

JDK1.7：分段锁

JDK1.8 :  Synchronized+CAS

### SpringMVC工作流程（需要仔细研究底层执行流程）

1. 客户端发送请求到前端控制器DispatcherServlet
2. 前端控制器DispatcherServlet根据URL来决定选择哪一个控制器Controller进行处理，并把请求委托给控制器
3. 控制器Controller接收请求后，将请求参数绑定为一个对象，这个对象叫命令对象，并进行验证。然后将命令对象委托给业务对象进行处理，处理完毕后返回一个ModelAndView
4. 前端控制器DispatcherServlet收回控制权，然后根据返回的逻辑视图名，选择相应的视图进行渲染，并把模型数据传入，以便渲染
5. 前端控制器DispatcherServlet再次收回控制权，将相应返回给用户

### 类加载过程

加载、验证、解析、准备、初始化

### 了解双亲委派机制吗？

一个类加载器加载类时，会将请求委托交给父加载器去加载，只要父加载器无法完成这个加载请求时，子加载器才会自己尝试完成加载。

好处：保证基础类环境的稳定运行

> 2021-06-03

### spring和springboot的区别

springboot就是spring的扩展，少了繁琐的配置，让开发、测试、部署方便了。

> 2021-06-02

### 了解HashMap吗？

- HashMap的数据结构（数组+链表/红黑树）
- 哈希冲突的实现原理
- HashMap扩容机制
- 线程不安全性
- HashMap为什么初始容量是2的4幂（16）：按位运算

### 那想用线程安全的Map用什么呢？（踩过坑）

我答的ConcurrentHashMap是线程安全的，并且把线程安全的机制详细的描述了一遍；但是我记忆里大学期间学过了一段设计，就是说ConcurrentHashMap也不是完全保证线程安全的，在事务下，也会发生线程不安全。当时对ConcurrentHashMap的理解也仅限于此；但今天细究了一下，ConcurrentHashMap是可以完全保证每次操作的线程安全问题的，但是事务的安全那就得另算了，需要考虑的就是事务的隔离级别了！这点希望大家不要和我一起进入这个误区。过段时间会详细写一下事务的隔离级别的专题文章。

### 了解MySQL索引吗？

- 索引的数据结构（B+树）
- B+树的自平衡（脑子清楚嘴笨）
- MySQL索引能存储的数据量
- 事务的基本要素ACID
- 事务并发问题：脏读、不可重复读、幻读
- 事务的隔离级别（读未提交、不可重复读、重复读、串行化）

### 算法题：数组中求最大差值（股票的最大收益问题）

这题朴实无华的动态规划，2分钟解决了。

```java
//    public static void main(String[] args) {
//        int[] nums;
//        nums = new int[0];
//        System.out.println(question1(nums));
//        nums = new int[]{1};
//        System.out.println(question1(nums));
//        nums = new int[]{21, 12, 7, 3, 11, 20};
//        System.out.println(question1(nums));
//        nums = new int[]{21, 20, 19, 18, 10};
//        System.out.println(question1(nums));
//        nums = new int[]{22, 20, 20, 20, 10};
//        System.out.println(question1(nums));
//    }

    /**
     * 动态规划实现, 如果按照题意求最大差值的话需要返回零和负数情况
     */
    public static int question1(int[] nums) {
        int len = nums.length;
        if (len < 2) {
            return 0;
        }
        int min = Math.min(nums[0], nums[1]);
        int max = nums[1] - nums[0];
        for (int i = 2; i < len; i++) {
            if (nums[i] - min > max) {
                max = nums[i] - min;
            }
            if (nums[i] < min) {
                min = nums[i];
            }
        }
        return max;
    }
```

### 算法题：计算合法`（）`的最大长度

？？？这连中间都不穿插点加减号了？？？

直接上代码

```java

//    public static void main(String[] args) {
//        String str;
////        str = "()()()()";
////        System.out.println(question2(str));
////        str = "((((()()";
////        System.out.println(question2(str));
//        str = "()(())";
//        System.out.println(question2(str));
//        str = "(()))))())";
//        System.out.println(question2(str));
//        str = "((((";
//        System.out.println(question2(str));
//        str = ")))((()((((()((";
//        System.out.println(question2(str));
//        str = "(*(*)*)*)(())";
//        System.out.println(question2(str));
//    }

    /**
     * 栈使用的问题
     */
    public static int question2(String str) {
        int result = 0;
        if (null == str)
            return 0;
        Stack<Integer> stack = new Stack<>();
        int start = 0;
        for (int i = 0; i < str.length(); i++) {
            if ('(' == str.charAt(i)) {
                stack.push(i);
            } else {
                if (stack.isEmpty()) {
                    start = i + 1;
                } else {
                    stack.pop();
                    if (stack.isEmpty()) {
                        result = Math.max(result, i - start + 1);
                    } else {
                        result = Math.max(result, i - stack.peek());
                    }
                }
            }
        }
        return result;
    }
```

### 算法题：实现LRU算法

这题我是最喜欢的^_^因为我脑子会，手不会写（我就想知道谁能记住LinkedHashMap里面的API啊），所以百度帮我做了，但想法我就是这样的。

给大家讲一下实现吧，首先LRU就叫做Least Recently Used最少最近使用，就是把最老最久没碰过得数据给淘汰掉，刚好LinkedHashMap就已经做了按照访问顺序来实现节点排序，HashMap的put方法有一个实现，参数是accessOrder，当accessOrder=true时，访问节点和插入节点都会将当前节点放到链表最新处（如果是JDK1.6+那就是放到结尾去），那不就是LRU的想法么 ~ 那我直接用就好了（源码解析我7月份会贡献笔记）

```java
    /**
     * LRU算法：最少最近使用：利用LinkedHashMap实现了按访问顺序存储的特性来简单实现
     */
    static class LRUCache<K, V> {
        private static final float loadFactor = 0.75f;
        private LinkedHashMap<K, V> map;
        private int initialCapacity;

        public LRUCache(int cacheSize) {
            this.initialCapacity = cacheSize;
            int capacity = (int) Math.ceil(cacheSize / loadFactor) + 1;
            // accessOrder=true是重点, 该参数为true是按照访问顺序插入到链表最新节点后, false是按照插入顺序存储
            map = new LinkedHashMap<K, V>(capacity, loadFactor, true) {

                @Override
                protected boolean removeEldestEntry(Map.Entry eldest) {
                    return size() > LRUCache.this.initialCapacity;
                }
            };
        }

        public synchronized V get(K key) {
            return map.get(key);
        }

        public synchronized void put(K key, V value) {
            map.put(key, value);
        }
    }
```



### 设计一个门票限时销售系统

听到这个题目我直接懵圈了，what？我设计一个系统？

提供系统架构图和业务流程图，what？画图？

这个考的不是我的专业技能，是对总体把控的能力，但我觉得我现在还不是把精力去花费在把一个个专业知识整合的时候，我更应该做的是去精通和扎实每一个我熟悉的技术（听起来像是在给自己找理由，嘻嘻），所以这题我就简单答了答，做了一个微服务，订单和商品的并发操作使用Redis的分布式锁保证安全，然后限时功能也是就用Redis的设置存活时间来实现。

> 2021-06-01

### 算法题：求100以内质数的阶乘之和

思路是先求100以内的阶乘，放到数组中，再对数组中的质数一一求阶乘，再累加；

思路清晰，但编码过程中我发现了两个问题，一个就是10以上的阶乘其实是非常大的，那么他们的和很可能超过int和long的范围，所以尽可能使用其他更能长的数据结构来存储。果然，97的阶乘甚至都到达了

```java
// 96192759682482119853328425949563698712343813919172976158104477319333745612481875498805879175589072651261284189679678167647067832320000000000000000000000
```

那么就先用BigDecimal来试试够不够，上我的代码

```java
    /**
     * 题目2
     */
    private static void question2() {
        // 保存质数结果集
        List<Integer> list = new ArrayList<>();
        for (int i = 2; i <= 100; i++) {
            // 判断当前数字是否为质数
            if (isPrimeNumber(i)) {
                // 将质数添加到结果集
                list.add(i);
            }
        }
        // 打印质数结果集, 为question5参考
        list.forEach(System.out::println);
        // 返回结果超出long长度, 使用BigDecimal保存最终结果和计算过程结果
        BigDecimal result = new BigDecimal(0);
        for (int num : list) {
            // 顺序添加BigDecimal类型的阶乘结果
            result = result.add(getBigDecimalFactorial(num));
        }
        System.out.println("结果:" + result); 
    }

    /**
     * 判断一个2-100的数字是否是质数
     */
    private static boolean isPrimeNumber(int num) {
        if (num == 2) return true;
        for (int i = 2; i <= Math.sqrt(num); i++) {
            if (num % i == 0) {
                return false;
            }
        }
        return true;
    }

    /**
     * 计算一个1-100之间数字的阶乘
     * 返回结果超过long长度, 使用BigDecima保存过程结果
     */
    private static BigDecimal getBigDecimalFactorial(int num) {
        BigDecimal result = new BigDecimal(num);
        for (int i = 2; i < num; i++) {
            result = result.multiply(new BigDecimal(i));
        }
        System.out.println(num + "的阶乘是" + result);
        return result;
    }
```

运气不错，BigDecimal就存下了。但如果是BigDecimal也存储不下的话，就用String来存吧，就是要重写一个加减乘除方法来实现就比较麻烦了。

### 智力题：23枚硬币中10枚是朝上的，分两堆怎么实现朝上的硬币一样多

这题我采用的数学的方式解决，也是需要转个弯就解决了。

```markdown
# 设一堆中朝上硬币是x, 另一堆则是10-x
# 那我需要做的令 x = 10-x
# 那么问题就来了, 错误的逻辑是让 x = 5, 思考无果后换个方向
# 如果还有一个10-x的变量, 那么尝试着解决交换变量种类可不可以
# 百度：如果令一堆硬币是10, 翻转这10枚硬币, 就可以了（啊啊啊, 我的思路没错, 就差一点点）
```

### 证明题：中间只隔一个数字的两个质数数被称为质数对，比如17和19。证明质数对之间的数字总能被6整除

这个话不多说了，我思路都在我的回答上了

```java
    private static void question5() {
        // 1 3 中间这个数字是2, 这个数字需要大于6*********************************
        // 2 4 不可能2结尾, 因为所有2结尾的数字都可以被2整除
        // 3 5 不可能5结尾, 因为所有5结尾的大于6的数字都可以被5整除(15, 25, 35)
        // 4 6 不可能4结尾, 因为所有4结尾的数字都可以被2整除
        // 5 7 不可能5结尾, 因为所有5结尾的大于6的数字都可以被5整除(15, 25, 35)
        // 6 8 不可能6结尾, 因为所有6结尾的数字都可以被2整除
        // 7 9 中间这个数字是8, 这个数字需要大于6***************************************
        // 8 0 不可能8结尾, 因为所有8结尾的数字都可以被2整除
        // 9 1 中间这个数字是0, 这个数字需要大于6*********************************
        // 0 2 不可能0结尾, 因为所有0结尾的数字都可以被5整除
        // 根据星号“*****”行的分析可知
        // 根据我的上面这个分析, 只需要证明这个数字一定可以被2整除, 那么该命题就可以转换成去证明这个数字可以被3整除
        // 假设质数对数字为x, x-1, x+1分别是质数
        // 而且x-1和x+1都是大于6的质数, 那么x-1不可能被三整除, 要么余1, 要么余2, 同理可知x+2, 要么余1, 要么余2
        // 并且关键是x-1与x+1之间只差了2, 所以这两个质数的余数一定是一个余1, 一个余2
        // 那么假设x不可能被3整除, 那么一定余1或者余2, 无论如何都是x+1和x-1余1余2的条件矛盾
        // 所以x一定可以被3整除
        // 最后得到结论, 质数对之前的数字一定可以被6整除
    }
```

百度的答案稍微复杂点，我是拆解了6，感觉更容易理解一些。

> 2021-05-31

### 我在项目中遇到的难点

- 地图切片的分组缓存
- 负责集成LiquiBase