# git 一些问题记录,  github 迁移到 gitee

今天把 github 代码迁移到 码云, 出现挺多问题的,  .ssh 下的 config 配置了两个码云的公钥, 但是 终端 一直 Ping  不通,  不知道是哪里搞错了。 

就简单的 三步 实在找不到是哪里出错了, 导致无法正常使用 SSH 访问项目,  暂时先使用 HTTPS 了。


## 代码迁移

码云原本是支持直接将 Git 项目迁移到其服务器上面的.
但是由于老大把项目创建好了, 我只能通过在原本 github 下那个本地项目对其 remove 进行修改.

$ git remove add [name] [url]

然后每次 git push  时可以选择 push 到那个远程服务上, 也可以 git push --all

还有我们可以通过 修改 remove origin 来完成。 
这样我们每次 git push 默认就是推向 origin 上。

## 合并问题

由于 码云上已经有受保护的 master 分支, 我们直接想把 github 上 master 分支 推到其服务器上, 是会报错的, 因为这两个分支完全没有任何关联.

### 两种迁移方法
1. git push
想直接接 github master push 到 mayun master 让其合并
终端报错:➜  YZHYolo git:(master) git push mayun
To https://gitee.com/yzhchain/yoloim-ios.git
 ! [rejected]        master -> master (non-fast-forward)
error: failed to push some refs to 'https://gitee.com/yzhchain/yoloim-ios.git'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Integrate the remote changes (e.g.
hint: 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.

可以通过 $ git pull origin master --allow-unrelated-histories  解决.

2. git meger
因为码云上面只有一个 master 分支, 我可以直接 使用  git push developer 分支到服务器上, 然后在通过其 master 将其合并   

报错 fatal: refusing to merge unrelated histories

由于 master 和 developer 完全无关联. 默认是会拒绝合并的.

参考: [stackoverflow](https://stackoverflow.com/questions/37937984/git-refusing-to-merge-unrelated-histories-on-rebase)

直接使用 强制合并.

$ git meger developer --allow-unrelated-histories  

## git push 报错

```
➜  YZHYolo git:(developer) git push
fatal: The current branch developer has no upstream branch.
To push the current branch and set the remote as upstream, use

    git push --set-upstream origin developer
```

ggpull 

ggpush

