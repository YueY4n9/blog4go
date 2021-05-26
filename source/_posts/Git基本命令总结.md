---
title: Git基本命令总结
date: 2020-08-27 16:42:54
tags:
- Git
---

把之前学习的GIT操作总结整理一下

## 基本操作

### 下载代码

```
git colne <url>

eg：git clone https://git.gitedit.com:8081/******
123
```

### 拉代码

```
git pull
1
```

### 冲突解决

```
流程：暂存(压栈)->拉取代码->释放代码（弹栈）->手动合并代码
如果本地代码与线上代码有冲突，git pull 是会报错，如：error: Your local changes to '-----' would be overwritten by merge. Aborting.Please, commit your changes or stash them before you can merge.

这时，需先将本地代码暂存（压栈）:==暂存==会将代码恢复到上一次拉取的版本。
git stash

之后：拉取代码
git pull

弹栈:将之前暂存（压栈的代码）==取出==
git stash pop

最后：==手动合并代码==
查看代码状态：
git status
# On branch master
# Changes to be committed:  （绿色）(已经在stage区, 等待添加到HEAD中的文件)
# (use "git reset HEAD <file>..." to unstage)
#
#modified: hello.py
#
# Changes not staged for commit: （红色）(有修改, 但是没有被添加到stage区的文件)
# (use "git add <file>..." to update what will be committed)
# (use "git checkout -- <file>..." to discard changes in working directory)
#
#modified: main.py
#
# Untracked files:（红色）(没有tracked过的文件, 即从没有add过的文件)
# (use "git add <file>..." to include in what will be committed)
1234567891011121314151617181920212223242526272829
```

### 版本回退

```
git reset 

版本回退（建议加上––hard参数，git支持无限次后悔）

回退到上一个版本：git reset ––hard HEAD^

回退到上上一个版本：git reset ––hard HEAD^^

回退到上N个版本：git reset ––hard HEAD~N（N是一个整数）

回退到任意一个版本：git reset ––hard 版本号（版本号用7位即可）

重点：git reset 可以清空暂存区（git add 暂存的文件变为 modify状态）
12345678910111213
```

### 提交代码

```
流程：暂存代码->提交到本地仓库->推送到远端分支

==暂存代码==：所有变化提交到暂存区
暂存所有： git add .
暂存目录下文件：git add <url>

eg: git add src/

暂存单个文件：git add <url>
eg: git add src/view/plat/***.java

==提交到本地仓库==：
git commit -m "注释"

==推送到远端分支==：
git push <远程主机名> <本地分支名>:<远程分支名>

简写：git push
注：推送到远端默认分支（与本地代码相同分支）

简写：git push origin master
注：推送到远端的主线分支

简写：git push origin dev
注：推送到远端的dev分支
12345678910111213141516171819202122232425
```

## 分支操作

### 查看所有分支（本地）

```
git branch

输出内容：
$ git branch
  master
* dev

说明：*符号说明当前代码处于哪个分支
12345678
```

### 创建分支

```
git branch <name>

eg:git branch dev

说明：从当前分支创建了名称为 dev的分支。
12345
```

### 切换分支

```
git checkout <name>

eg:git checkout dev
注：如有文件修改（新增文件不需要），切换分支前，需==暂存（git stash）或提交（git add . ->git commit -m ""）当前所有修改==。否则会报如下错误：

$ git checkout master

输出内容：
error: Your local changes to the following files would be overwritten by checkout:
        readme.txt
Please commit your changes or stash them before you can switch branches.
Aborting
123456789101112
```

### 创建+切换分支（拷贝分支）

```
git checkout -b <name>

eg：git checkout -b dev

说明：此操作为前两步的结合体，从当前分支创建新分支并且切换到新分支上。

重点：此操作可以在任一分支的任何状态执行，执行成功之后，会将所有操作复制到新的分支上，并且会切换到新分支，如果新分支提交了修改，则原有分支的操作会撤销掉。
1234567
```

### 合并某分支到当前分支

```
git merge <name>

eg: git marge master

注：有代码冲突需手动合并
12345
```

### 删除分支

```
git branch -d <name>

eg:git branch -d dev2
123
```

### git 将本地项目提交到 git 远程仓库（远程仓库有空项目）

```
1、（先进入项目文件夹）通过命令 git init 把这个目录变成git可以管理的仓库

git init
2、把文件添加到版本库中，使用命令 git add .添加到暂存区里面去，不要忘记后面的小数点“.”，意为添加文件夹下的所有文件

git add .
3、用命令 git commit告诉Git，把文件提交到仓库。引号内为提交说明

git commit -m 'first commit'
4、关联到远程库

git remote add origin 你的远程库地址
如：
git remote add origin https://git.gitedit.com:8081/yuansiyu/gislibrary.git

5、获取远程库与本地同步合并（如果远程库不为空必须做这一步，否则后面的提交会失败）

git pull origin master
6、把本地库的内容推送到远程，使用 git push命令，实际上是把当前分支master推送到远程。执行此命令后会要求输入用户名、密码，验证通过后即开始上传。

git push -u origin master
```