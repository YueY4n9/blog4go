---
title: MongoTemple操作报错Dangling meta character ‘+‘ near index 1异常
date: 2020-12-15 15:16:04
tags:
---

MongoTemple操作报错Dangling meta character ‘+’ near index 1异常

```java
Query query = new Query();
String searchValue = "XQ03B13-FZL023+1+008-LW-LH-01B";
Criteria criteriaName = Criteria.where("name").regex(searchValue);
```

代码这样写，regex的时候会报Dangling meta character ‘+’ near index 1，简单查了一下，发现当searchValue中包含 + 等特殊字符，需要转义一下。
转义可以转义成 [+] 或者 \+
得到如下代码：

```java
Query query = new Query();
String searchValue = "XQ03B13-FZL023+1+008-LW-LH-01B";
searchValue = searchValue.replaceAll("\\+", "[+]");
Criteria criteriaName = Criteria.where("name").regex(searchValue);
```

雷霆嘎巴，查询成功，真不戳！