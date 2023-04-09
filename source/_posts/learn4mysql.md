---
title: SQL优化笔记
date: 2021-05-31 09:41:56
tags:
  - mysql
---

> 最近更新时间：2021-05-31 09:41:56

<!--more-->

# 前言

SQL优化一般遵循五个原则：

```markdown
减少数据访问
返回更少的数据：只返回需要的字段和数据分页处理，减少磁盘IO和网络IO
减少交互次数：批量DML操作，来减少与数据库的交互次数
减少服务器CPU开销：减少数据库排序操作以及全表查询，减少CPU内存占用
利用更多资源：使用表分区，增加并行操作，最大限度使用CPU资源
```

总结一下就是

> - 最大化利用索
> - 尽可能避免全表扫描
> - 减少无效数据的查询

# SELECT语句——语法顺序

```sql
select distinct <查询字段>
from <表名>
    left / right join <表名>
on <条件>
where <条件>
group by <分组字段>
having <分组条件>
order by <排序字段>
    limit <参数1, 参数2>
```

# SELECT语句——执行顺序

```sql
from <表名> -- 选取表, 如果是多个表通过笛卡尔积形成一个表
on <条件> -- 对from的表进行筛选
join <表名> -- 添加字段到on之后的结果中
where <条件> -- 对结果再进行筛选
group by <分组字段> 
having <分组条件> -- 对分组之后的结果再进行筛选
select <字段> -- 筛选列, 返回的单列必须在group by中
    distinct  -- 数据去重
order by <排序字段> -- 排序
    limit -- 行数限制
```

# SQL优化策略

### 一、避免不走索引的场景

1. 避免在`字段开头模糊查询`，会放弃索引而全表扫描

   ```sql
   -- 尽量避免
   select id from user where name like '%岳%'
   -- 优化方式
   select id from user where name like '岳%'
   -- 如果必须要在字段开头模糊查询, 建议使用以下策略:
   -- 1. 使用FullText全文检索
   -- 2. 数据量较大时使用ElasticSearch
   -- 3. 使用MySQL内置函数INSTR(str,substr)来匹配
   -- 4. 如果数据量少, 就不用花里胡哨的使用策略了, 直接%%
   ```

2. 避免使用`or`，会放弃索引而全表扫描

   ```sql
   -- 不推荐
   select id from user where name = 'yueyang' or name = 'mengwu'
   -- 推荐
   select id from user where name = 'yueyang'
   union all
   select id from user where name = 'mengwu'
   ```

3. 避免`进行null值判断`，会放弃索引而全表扫描

   ```sql
   -- 不推荐
   select id from user where score is null
   -- 优化方式:给字段设置默认值
   select id from user where score = 0
   ```

4. 避免`在where条件等号左侧使用表达式`，会放弃索引而全表扫描

   ```sql
   -- 不推荐
   select id from user where score/10 = 8
   -- 优化方式:把左侧表达式的操作移到右侧
   select id from user where score = 8 * 10
   ```

5. //

### 二、SELECT 语句优化

1. 禁止出现`select *`，需要哪些字段必须明确标明， 原因是：
    1. 增加了查询分析器解析成本
    2. 容易与resultMap配置不一致
    3. 无用字段增加了网络IO

2. 多表关联查询时，小表在前，大表在后

   多表关联查询会全表扫描第一张表，所以第一张表尽可能小会提升不少性能

3. 使用表的别名

   SQL连接多个表时，使用表的别名并用表的别名来指定字段会减少解析时间

4. //

### 三、DML 语句优化

1. 批量`insert`数据使用`insert`多个值的方法

   ```sql
   -- 不推荐
   insert into user (id, name, age) values (1, 'yueyang', 18);
   insert into user (id, name, age) values (2, 'mengwu', 19);
   -- 推荐
   insert into user (id, name, age) values (1, 'yueyang', 18),(2, 'mengwu', 19);
   ```

2. //

### 四、查询条件优化

1. 对于复杂查询，使用中间表暂存数据

2. 优化`group by`语句

   默认情况下, MySQL会对`group by`中所有的值进行排序，也就相当于在后面添加了一段`order by`

   因此，查询`group by`如果你不想对分组数据进行排序，可以在最后加上`order by null`

3. 优化`join`语句

   对于逻辑顺畅的子查询来说，有时使用`join`替代会有更好的效率

   ```sql
   -- 查询没有成绩的学生ID
   select id from user not in(select id from grade where score = 0);
   -- 优化方式:减少了内存创建临时表的损耗 
   select id from user left join grade on user.id = grade.id where grade.socre = 0;
   ```

4. 优化`union`语句

   MySQL通过创建临时表并填充临时表的方式来执行`union`查询。

   使用`union`时，会隐式的给临时表加`distinct`
   ，从而对整个临时表做唯一性校验，非常损耗性能。因此如果不是非要去重，非常不建议使用`union`
   ，建议改成`union all`。

5. 合理的分页方式进行分页优化（^_^这个地方我还没学会呢，大家自己去研究深入一下，欢迎给我留言）

6. //

### 五、建表优化

1. 在表中建立`索引`，优先考虑`where`、`order by`使用到的字段。

2. 尽量使用数字型字段

   举个例子：性别男（1）女（2），就不要设计成字符型字段，会增加查询和连接性能，并增加存储开销

### 六、事务优化

1.  ```mysql
    -- 查询事务执行的锁情况
    select * from INFORMATION_SCHEMA.INNODB_TRX;
    ```

    