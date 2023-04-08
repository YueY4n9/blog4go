---
title: learn4mongo
date: 2020-08-27 16:29:24
categories:
- 笔记
tags:
    - mongo
---

>   MongoDB的一些基本操作，只适用于日常开发，深入了解MongoDB请略过本文

<!--more-->

# Mongo数据库操作

在学习Mongo之后因为没有系统的做过总结，就想在此写一篇比较系统比较全面的日常操作数据库的SQL操作总结。本文实时补充

增

```sql
//添加语句

db.COLLECTION_NAME.insert(document)

db.data.insert({
	title:'测试添加操作',
	by:'YueYang',
	time:'11:08'
});
WriteResult({ "nInserted" : 1, "writeConcernError" : [ ] })

```



删

```sql
// 删除操作

db.collection.remove(
   <query>,
   {
     justOne: <boolean>,
     writeConcern: <document>
   }
)

db.data.remove({
	by:'YueYang'
});
WriteResult({ "nRemoved" : 1, "writeConcernError" : [ ] })

```



改

```sql
// 更改操作

db.collection.update(
   <query>,
   <update>,
   {
     upsert: <boolean>,
     multi: <boolean>,
     writeConcern: <document>
   }
)

db.data.update({"title":"测试添加操作"},{$set:{"title":"测试更新操作"}});

WriteResult({
	"nMatched" : 1,
	"nUpserted" : 0,
	"nModified" : 1,
	"writeConcernError" : [ ]
})

db.data.update({"title":"测试添加操作"},{$set:{"title":"测试更新操作"}},{multi:true});

WriteResult({
	"nMatched" : 2,
	"nUpserted" : 0,
	"nModified" : 2,
	"writeConcernError" : [ ]
})

```



查

```sql
// 查询操作

db.data.find({"by":"YueYang"});

_id            				title    	by		time
5dafd24abc1b000007001bf7	测试更新操作	YueYang	11:08
5dafd2e5bc1b000007001bf8	测试更新操作	YueYang	12:10

```

条件查询

```sql
大于		 $gt
小于		 $lt
大于等于 	gte
小于等于	$lte
不等于		 $ne
等于		  $eq
包含于 	 $in


db.data.find({age: {$gt : 18}}); -- select * from data where age > 18;
```

模糊查询

```sql
查询 title 包含"测试"字的文档：
db.data.find({title:/测试/});

查询 title 字段以"教"字开头的文档：
db.data.find({title:/^测试/});

查询 titl e字段以"教"字结尾的文档：
db.data.find({title:/教$/});
```

模糊查询查询字段掌握了正则表达式就很容易扩展出来啦~
三种正则表达式方式：

```sql
{ < field >： { $ regex ： / pattern / ， $ options ： ‘’ } }
{ < field >： { $ regex ： ‘pattern’ ， $ options ： ‘’ } }
{ < field > ： { $ regex ： / pattern / < options > } }
```

排序

```sql
// 数据排序

db.data.find().sort({title:1}); 

// 其中 1 为升序排列，而 -1 是用于降序排列
```

分组操作

```sql
db.data.aggregate([{
    $group: {
        _id: {
            title: '$title',
            by: '$by'
        },
        count: {
            $sum: 1
        }
    }
}, {
    $match: {
        count: {
            $gt: 1
        }
    }
}]);

$group
将集合中的文档分组，可用于统计结果
_id表示分组的依据，使用某个字段的格式为'$字段'。

$match
用于过滤数据，只输出符合条件的文档
```

删除重复数据

```sql
// 前面写查询语句，对结果数据进行去重
.forEach(function(it) {
    it.dups.shift();
    db.data.remove({
        _id: {
            $in: it.dups
        }
    });
});

```

问题：

删除_id失败？

对id直接进行remove删除失败，是因为id是ObjectId类型，而id是字符串类型，类型对应不上就会导致删除失败。

解决方法就是把id转换成ObjectId：

```sql
db.data.remove({_id:ObjectId('1013')});
```

