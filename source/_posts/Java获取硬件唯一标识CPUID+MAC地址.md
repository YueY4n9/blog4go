---
title: JAVA获取主机硬件唯一标识CPUID+MAC地址。
date: 2020-08-17 10:47:47
tags:
---

>   Java为表示主机的唯一性而做出的获取主机CPUID和MAC地址时所进行的操作，整体是为了解决不同主机能在访问服务器时能通过某个唯一标识来进行权限认证，以此达到控制权限的目的

<!--more-->

### 初衷

结合上一篇博文，我需要拿到一台主机的唯一标识，并且这个标识是不可修改的，经查阅发现，MAC地址虽然是唯一标识，但是可修改，所以不可采用。现在选取当前主机唯一标识——CPU序列，本篇说下LINUX系统和WINSOWS系统获取CPU序列，顺带说下MAC地址的方法。

### 思路

主要思路就是使用Runtime.getRuntime().exec()执行命令来获取参数。毕竟是Java代码，要考虑多个平台的问题，而且linux和windows系统的命令又不同，所以分出处理。不多说，直接上代码：

```java
/**
 * 获取当前系统CPU序列，可区分linux系统和windows系统
 */
public static String getCpuId() throws Exception {
    String cpuId;
    // 获取当前操作系统名称
    String os = System.getProperty("os.name");
    os = os.toUpperCase();
    System.out.println(os);

    // linux系统用Runtime.getRuntime().exec()执行 dmidecode -t processor 查询cpu序列
    // windows系统用 wmic cpu get ProcessorId 查看cpu序列
    if ("LINUX".equals(os)) {
        cpuId = getLinuxCpuId("dmidecode -t processor | grep 'ID'", "ID", ":");
    } else {
        cpuId = getWindowsCpuId();
    }
    return cpuId.toUpperCase().replace(" ", "");
}

/**
 * 获取linux系统CPU序列
 */
public static String getLinuxCpuId(String cmd, String record, String symbol) throws Exception {
    String execResult = executeLinuxCmd(cmd);
    String[] infos = execResult.split("\n");
    for (String info : infos) {
        info = info.trim();
        if (info.indexOf(record) != -1) {
            info.replace(" ", "");
            String[] sn = info.split(symbol);
            return sn[1];
        }
    }
    return null;
}

public static String executeLinuxCmd(String cmd) throws Exception {
    Runtime run = Runtime.getRuntime();
    Process process;
    process = run.exec(cmd);
    InputStream in = process.getInputStream();
    BufferedReader bs = new BufferedReader(new InputStreamReader(in));
    StringBuffer out = new StringBuffer();
    byte[] b = new byte[8192];
    for (int n; (n = in.read(b)) != -1; ) {
        out.append(new String(b, 0, n));
    }
    in.close();
    process.destroy();
    return out.toString();
}

/**
 * 获取windows系统CPU序列
 */
public static String getWindowsCpuId() throws Exception {
    Process process = Runtime.getRuntime().exec(
            new String[]{"wmic", "cpu", "get", "ProcessorId"});
    process.getOutputStream().close();
    Scanner sc = new Scanner(process.getInputStream());
    sc.next();
    String serial = sc.next();
    return serial;
}
```
