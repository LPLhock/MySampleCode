# pod install error , 项目包含框架冲突

## 背景

导入三方资源的时候发现一个报错, 修改完 podfile 之后终端执行 $ pod install. 提示错误
**The 'Pods-ProjectName' target has frameworks with conflicting names: nimsdk.framework** 虽然看提示很清楚知道是项目中已包含了 nimsdk, 但是一下子并没有想到到底是因为那里出了问题导致.

## 原因

1. 一般是由于 podfile 新导入的库与原有项目中的 framework 有包含或者依赖关系导致。
2. 之前使用手动导入库的方式, 后面修改成 cocoaPod 进行管理, 但是 Project 内残留 Pod 导入库的相关类等等. 导致冲突。

## 解决
- 针对第一种:

项目版本管理的强大之处就这个时候就很好的提现出来了. 比较喜欢用 git。
一般这种情况, 在执行 podfile 之前, 项目正常编译通过的情况下, 我们直接通过 **git** 或者 **svn**  checkout 回到上一个版本, 或者如果这次修改内容过多, 可以执行针对 podfile 进行 checkout 即可.
$ git checkout Podfile 
然后在重新 pod install 回到正常版本.

即可知道是具体由于那一个 framework 与原有项目中存在冲突, 在进一步针对具体情况进行解决即可。

- 针对第二种:
  
  需要检查 Project 里面是否包含导入三方库的相关类等等, 如果存在的话删除或者注释掉, 然后重新 
  $ pod install 即可

## 注意看注释

有些三方资源是相互依赖或者包含的关系, 可能由时候我们之前使用的是同一个组织, 或者开发者的三方库等等. 这时候就经常出现这种问题, 在遇到报错的时候, 可以去仔细看一下项目的 使用注释, 一般都会有相关介绍和提示。 然后直接删掉有包含关系的那个即可！

比如之前在使用 云信通讯框架的时候, 首先引入的是 **NIMSDK**, 后面发现 **NIMKit**, 然后没有注意看文档介绍, 直接在 podfile 新增了 pod 'NIMKit', 就会出现上面的错误。

到官方查看文档才 发现 NIMKit 这个 framework 已经包含了 NIMSDK, 所以直接将 NIMSDK 删除掉, 直接使用  **NIMKit** 就可以了.

## 最后

>希望此篇文章对您有所帮助，如有不对的地方，希望大家能留言指出纠正。
>谢谢！！！！！
>学习的路上,与君共勉!!!    
>作者: Jersey   
>如需转载请注明出处    



  

