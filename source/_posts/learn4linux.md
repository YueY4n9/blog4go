---
title: learn4linux
date: 2022-05-01 17:14:02
tags:
  - linux
---

> 整理 linux 的学习过程, 尝试通过单词全拼来理解命令含义

<!--more-->

# 命令

1. cal = CALendar calendar 日历
2. cat = CATenate 链接 `该更多的情况是将文件内容输出以及合并多个文件内容`
3. cd = Change Directory 更改目录
4. chgrp = CHange GRouP 改变组
5. chmod = CHange MODe 改变模式
6. chown = CHange OWNer 更改所有者
7. chsh = CHange SHell 更改壳
8. cmp = compare 比较
9. comm = common 常见的
10. cp = CoPy 复制
11. cpio = CoPy In and Out 拷贝进出
    ```shell
    # 在当前目录以及所有子目录中查找文件, 并将它们放入名为 archive.cpio 的归档文件中
    find . -depth -print | cpio -ov > archive.cpio
    
    # 这个命令会从名为 archive.cpio 的归档文件中提取所有文件, 并解压到当前目录中
    cpio -idv < archive.cpio
    
    # 这个命令会列出名为 archive.cpio 的归档文件中包含的所有文件列表
    cpio -itv < archive.cpio
    ```
12. cpp = C Pre Processor C预处理器
13. cron = Chronos 希腊文时间, 用于执行定时任务
    ```markdown
    cron 的配置文件为 /etc/crontab, 这个文件定义了系统级别的计划任务. 而每个用户都可以使用 crontab 命令来创建自己的计划任务表(也就是 crontab 文件), 这些任务只对该用户有效
    ```
14. daemon = Disk And Execution MONitor 磁盘和执行监视器
15. dc = Desk Calculator 桌上计算器(逆波兰式计算器)
16. dd = Disk Dump 磁盘转储
17. df = Disk Free 查看磁盘空间使用情况
    ```shell
     df -h # 选项表示以可读的方式输出结果, 易于阅读
    ```
18. diff = DIFFerence 差异
    ```shell
    # 基本语法
    diff file1 file2
    # 额外参数
    diff -c file1 file2 # 以上下文模式输出差异信息
    diff -u file1 file2 # 以合并模式输出差异信息
    diff -i file1 file2 # 忽略大小写进行比较
    diff -B file1 file2 # 忽略空格进行比较
    diff -w file1 file2 # 忽略所有空白字符进行比较
    ```
19. dmesg = Diagnostic MESsaGe 诊断信息, 显示内核环形缓冲区(kernel ring buffer)的信息
20. du = Disk Usage 磁盘使用
    ```markdown
    du [-Aclnx] [-H | -L | -P] [-g | -h | -k | -m] [-a | -s | -d depth] [-B blocksize] [-I mask] [-t threshold] [file ...]
    
    下面对这些参数和选项进行一一解释：
    -A : 将大文件(超过2GB)的大小正确计算为1KB, 而不是512字节；
    -c : 显示指定文件或目录总共的大小；
    -l : 统计符号链接占据磁盘空间的大小, 而不是链接指向的文件的大小；
    -n : 不递归显示大小；
    -x : 显示当前文件系统的大小, 不会统计挂载在其上的其他文件系统的大小；
    -H : 递归处理命令行中指定的目录, 当遇到符号链接时, 直接使用链接所指向的文件的大小；
    -L : 与 -H 类似, 但是当遇到符号链接时, 直接计算链接本身的大小；
    -P : 与 -H 和 -L 相反, 不跟踪任何符号链接, 直接计算链接本身的大小；
    -g, -h, -k, -m : 以不同的大小单位显示输出结果(用于人类可读)
    -a : 显示所有文件和目录的大小；
    -s : 只显示目录总大小, 不显示各子目录和文件的大小；
    -d depth : 指定显示目录树的深度, 即子目录的最大层数；
    -B blocksize : 指定块大小, 以字节为单位；
    -I mask : 指定忽略某些文件或目录(按照 shell 的语法来进行匹配)；
    -t threshold : 只对大于或等于指定大小的文件和目录进行计算磁盘空间使用情况
    
    注意：在使用 du 命令时, 请谨慎选择文件或目录, 不要将它用于根目录 ("/") 或 "/home" 等包含大量文件的目录, 否则可能会导致系统崩溃或性能下降
    ```
21. ed = editor 编辑
22. egrep = Extended GREP 扩展的grep
23. emacs = Editor MACroS 编辑宏, 一款强大的编辑器, 和 vim 并称两大最强编辑器
24. eval = EVALuate 用于将命令行参数作为 shell 命令来执行
    ```shell
    mycmd="ls" && eval result=$mycmd && echo $result
    ```
25. ex = EXtended 是一个文本编辑器, 是 vi 编辑器的前身. ex 编辑器相对来说比较老旧, 因为现在更常用的文本编辑器是 vi、nano、emacs 等
26. exec = EXECute 执行
    ```shell
    # 它用于执行一个命令并替换当前 shell 进程(即将当前进程替换为指定命令). exec 命令通常在 shell 脚本中使用, 可以用于执行其他程序并将其输出/错误输出重新定向到脚本中。
    # 具体来说, 当你执行 exec 命令时, 它会首先关闭当前的 shell 进程, 然后创建一个新的进程来运行指定的命令, 这个新的进程将继承当前 shell 进程的环境变量和文件描述符等信息。因此, 通过 exec 命令可以让脚本中的命令取代 shell 进程, 从而达到更高效的执行效果。
    ```
27. fd = file descriptors 文件描述符
28. fg = ForeGround 前景
29. fgrep = Fixed GREP 固定grep(非正则表达式匹配)
30. fish = the Friendly Interactive SHell 是一款现代化的、用户友好的命令行 Shell
31. file = file 查看文件类型, 是否是二进制等
32. fmt = format 格式化文件
33. fsck = File System ChecK 文件系统检查
34. fstab = FileSystem TABle 文件系统表
35. fvwm = Feeble Virtual Window Manager 虚拟窗口管理器, 是一个基于X Window System的轻量级窗口管理器
36. gawk = GNU AWK, 是 [GNU](https://en.wikipedia.org/wiki/GNU) 计划下的 awk 工具的实现, 是一个高级文本处理工具, 通常用于对大型文本文件进行搜索、过滤和转换等操作
37. gcc = GNU compiler collection 是 GNU 编译器套装的缩写，是一个基于自由软件的编译器系统
38. gpg = GNU Privacy Guard GNU 隐私保护
39. grep = Global Regular Expression Print 全局正则表达式打印
40. ksh = Korn SHell 是一个Unix和Linux系统上的命令行解释器和编程语言。它是由David Korn开发的，旨在提供一种功能更强大的shell，用于代替传统的Bourne shell和C shell。
41. lex = LEXical analyser 词法分析器
42. ln = LiNk
43. lpr = Line PRint 行打印
44. ls = list 列出当前或指定目录下的文件和目录
    ```shell
    ls -l # 以长格式列出文件和目录信息，包括文件类型、权限、拥有者、大小、日期等
    ls -a # 列出所有文件和目录，包括 . 开头的隐藏文件和目录
    ls -h # 以易读的方式显示文件和目录的大小
    ls -t # 按修改时间排序，最近修改的文件或目录先显示
    ls -r # 反向排序，从后往前排列
    
    # $ which ls
    # ls: aliased to ls -G
    ```
45. lsof = LiSt Open Files 列出打开的文件, 并显示哪些进程打开了这些文件
    ```shell
    lsof -p 100     # 显示指定 PID 的进程打开的文件信息。
    lsof -u yueyang # 显示指定用户打开的文件信息
    lsof -c name    # 列出指定进程名字的进程打开的所有文件
    lsof -i         # 列出所有网络连接相关的文件
    lsof -n         # 不进行DNS解析，直接使用IP地址
    ```
46. m4 = Macro processor Version 4 宏处理器版本4
47. make = make
48. man = MANual pages 手册页
49. mawk = Mike Brennan’s AWK
50. mc = Midnight Commander 午夜指挥官
51. MIME = Multipurpose Internet Mail Extensions 多用途因特网邮件扩展
52. mkfs = MaKe FileSystem 使文件系统
53. mknod = MaKe NODe 使节点
54. motd = Message of The Day 当天的信息
55. mozilla = MOsaic GodZILLa
56. mtab = Mount TABle 安装表
57. mv = MoVe
58. nano = Nano’s ANOther editor 纳米的另一个编辑
59. nawk = New AWK
60. nl = Number of Lines
61. nm = names
62. nohup = No HangUP
63. nroff = New ROFF
64. od = Octal Dump 该命令的名称由来
65. passwd = PASSWorD
66. pg = pager
67. pico = PIne’s message COmposition editor 松的消息组合编辑器
68. pine = “Program for Internet News & Email” = “Pine is not Elm”
69. ping = Packet InterNet Groper ping程序
70. pirntcap = PRINTer CAPability 打印机的能力
71. popd = POP Directory
72. pr = pre
73. printf = PRINT Formatted
74. ps = Processes Status 进程状态
75. pty = pseudo tty
76. pushd = PUSH Directory
77. pwd = Print Working Directory 打印工作目录
78. rc = runcom = run command
79. rev = REVerse
80. rm = ReMove
81. rn = Read News
82. roff = RunOFF
83. rpm = RPM Package Manager = RedHat Package Manager    RedHat软件包管理器
84. rsh, rlogin, rvim中的r = Remote
85. rxvt = ouR XVT
86. seamoneky = 我
87. sed = Stream EDitor
88. seq = SEQuence
89. shar = SHell ARchive
90. slrn = S-Lang rn
91. ssh = Secure SHell
92. ssl = Secure Sockets Layer
93. stty = Set TTY
94. su = Substitute User 或 Switch User(前者较常见)
95. sudo = superuser / substitue user do 在ubuntu下更倾向于superuser, 因为它代表了root权限
96. svn = SubVersioN
97. tar = Tape ARchive
98. tcsh = TENEX C shell
99. tee = T (T形水管接口)
100. telnet = TEminaL over Network
101. termcap = terminal capability
102. terminfo = terminal information
103. tex = τέχνη的缩写, 希腊文art
104. tr = translate
105. troff = Typesetter new ROFF 照排机新Roff
106. tsort = Topological SORT
107. tty = TeleTypewriter
108. twm = Tom’s Window Manager
109. tz = TimeZone
110. udev = Userspace DEV
111. ulimit = User’s LIMIT
112. umask = User’s MASK
113. uniq = UNIQue
114. vi = VIsual = Very Inconvenient 很不方便
115. vim = Vi IMproved
116. wall = write all
117. wc = Word Count
118. wine = WINE Is Not an Emulator 酒不是一个模拟器
119. xargs = eXtended ARGuments 扩展参数
120. xdm = X Display Manager X显示管理器
121. xlfd = X Logical Font Description 逻辑字体描述
122. xmms = X Multimedia System X多媒体系统
123. xrdb = X Resources DataBase X资源数据库
124. xwd = X Window Dump X窗口转储
125. yacc = yet another compiler compiler 另一个编译器的编译器
126. pwd = Print work diretory 打印工作目录
￼
