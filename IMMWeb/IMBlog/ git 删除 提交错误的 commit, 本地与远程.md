#  git 删除 提交错误的 commit, 本地与远程

## 前景

在使用 git 工作时,  难免会出现 commit 了一些不想提交的内容, 或者 commit 的时候 commit 的日志不太满意想要进行修改。 分两种情况一种是针对  commit 之后没有进行 push. 另一种则是 commit 之后 push 到了 remote, 下面分别讲一下分别对应的修改方式.

## 修改本地 commit. 


1. 如果单纯只是想修改 commit 的提交备注信息的话, 只需输入 **$ git commit!** 即可直接修改上次 commit 日志.

- 单纯修改**commit 提交备注信息** 对应命令 **$ git commit!**

2. 想修改 commit 内容则需要回滚版本, git log 直接查看上一个版本 HEAD, 输入命令 **$ git reset HADE** 回到上一个版本, 然后在重新提交自己想要提交的即可. 同时 commit 日志也可以重新写.

- 修改 **commit 提交内容** 对应命令 **$ git reset HADE**


## 修改远程 commit. 即 commit 后已 push 到远程

分别两种解决方法.

- 方法一
删除掉上一个 commit 并且保留内容, 但是不需要 commit 日志, 或者单单修改 日志等。
命令行:
**git reset HADE**
**git push origin developer --force**  developer 指的是远程分支名.根据你自己分支来输入。
相当于回到上一个版本, 之后 push 将之前修改的内容全部也 push 上来, **--force** 表示强制将本地 push 到远程, 使用 --force 需要谨慎 确保无误之后在添加哦.
- 方法二
 先撤销上一次的错误的 commit, 然后在重新生成一个新的提交. 可以理解成覆盖的效果。

1. **$ git revert	 HADE**
2. **$ git add**
3. **$ git commit**
4. **$ git push**

**reset 与 revert 区别**
引用 [git revert 用法](https://www.cnblogs.com/0616--ataozhijia/p/3709917.html)

1. git revert是用一次新的commit来回滚之前的commit，git reset是直接删除指定的commit。 
2. 在回滚这一操作上看，效果差不多。但是在日后继续merge以前的老版本时有区别。因为git revert是用一次逆向的commit“中和”之前的提交，因此日后合并老的branch时，导致这部分改变不会再次出现，但是git reset是之间把某些commit在某个branch上删除，因而和老的branch再次merge时，这些被回滚的commit应该还会被引入。 
3. git reset 是把HEAD向后移动了一下，而git revert是HEAD继续前进，只是新的commit的内容和要revert的内容正好相反，能够抵消要被revert的内容。

## 最后

>希望此篇文章对您有所帮助，如有不对的地方，希望大家能留言指出纠正。
>谢谢！！！！！
>学习的路上,与君共勉!!!    
>>本文原创作者:[Jersey](https://www.jianshu.com/u/9c6bbe968616). 欢迎转载，请注明出处和[本文链接](https://www.jianshu.com/p/730a0619c339)




