#Zsh + Oh My Zsh


 在Mac 系统中，自带的Shell 有好几种， 但是默认使用的是 Bash， 比较推荐使用Zsh。 
Oh My Zsh 是一个很出名的开元项目，主要用于管理Zsh。 
安装了 Oh My Zsh 之后 可以到 
.zshrc 中修改 plugins、  填写相应的插件，即可在Zsh 中直接使用。
plugins=(git autojump extract osx sublime brew-cask copydir copyfile git-extras git-flow gitignore history npm zsh-syntax-highlighting encode64 urltools)

source $ZSH/oh-my-zsh.sh

alias -s md=mvim  
在配置文件中也开元直接填写缩写。
-s 表示打开文件。  md表示以 md 为后缀的文件， 表示在 md 为后缀的文件默认使用mvim打开。


## 参考
[知乎](https://www.zhihu.com/question/21418449)
[iterm2](http://wulfric.me/2015/08/iterm2/)































