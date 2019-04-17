#RubyGems source 域名变更 https://gems.ruby-china.com/

## 背景

今天在使用 Ruby gems 安装一个脚本打包工具,  使用 **sudo gem install fastlane --verbose**,  提示找不到此项目, 想到是不是 Rouserce 出了问题, 查看当前源 https://gems.ruby-china.org/ , 感觉应该没问题, 试着更新, 替换其他源等等。 最后由通过 ** gem sources -a https://gems.ruby-china.org/ , 重新添加回来, 看了下提示才恍然大悟。


## https://gems.ruby-china.org/ 服务域名变更

执行 sudo gem install fastlane --verbose   报错
![k9Mo2d.md.png](https://s2.ax1x.com/2019/01/18/k9Mo2d.md.png)
执行 gem sources -a https://gems.ruby-china.org/  报错
![k9MDC4.md.png](https://s2.ax1x.com/2019/01/18/k9MDC4.md.png)

通过后面的添加源发现原来是自己之前一直用的 https://gems.ruby-china.org/ 是有问题的,  打开浏览器访问才发现, 其域名已变更至 https://gems.ruby-china.com/
![k9MOVf.md.png](https://s2.ax1x.com/2019/01/18/k9MOVf.md.png)


## 更换最新的 ruby-china 域名

命令行:
查看当前 sources
gem sources -l 
如还是显示 https://gems.ruby-china.org/ 
则移除  重新添加
$ gem sources -remove https://gems.ruby-china.org/
添加新的 sources
$ gem sources -a https://gems.ruby-china.com/
等待添加完成
$ gem sources -l 查看当前源地址。 

添加成功尝试安装

sudo gem install fastlane --verbose 

sudo gem install -n /usr/local/bin cocoapods --pre 

升级 CocoaPod 

一切畅通无阻！


## 最后

>希望此篇文章对您有所帮助，如有不对的地方，希望大家能留言指出纠正。
>谢谢！！！！！
>学习的路上,与君共勉!!!    
>>本文原创作者:[Jersey](https://www.jianshu.com/u/9c6bbe968616). 欢迎转载，请注明出处和[本文链接](https://www.jianshu.com/p/730a0619c339)


