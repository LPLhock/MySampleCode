##SSH

在使用多用户配置 SSH 连接 git 时,将每个独立的 SSH 公私钥生成在 ~/.ssh 下, 然后在 config 指定其路径, 然后在相应的 git 账号下添加 SSH 公钥, 并且将私钥添通过 ssh-add 到代理中. 通过 ssh -T  git@github.com 验证链接正常,  但是重启 terminal 时,  链接 git 发现, git@github.com: Permission denied (publickey).   然后每次启动都要进行  ssh-add 将指定私钥添加. 


使用 ssh-add -K  即可一劳永逸


####参考 

[ssh](https://www.cnblogs.com/ayseeing/p/4445194.html)

http://www.icodeyou.com/2016/01/17/ssh-add-mac/


 
 