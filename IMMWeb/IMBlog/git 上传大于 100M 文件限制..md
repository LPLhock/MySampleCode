# git 上传大于 100M 文件限制.

##命令

一、
git rm -cache 文件路径 
如失败
若提示not removing 'xxx/xxx' 
git rm -r -cache 文件路径 强制移出缓存。

二、 git commit --amend -CHEAD


##参考

[【Git】git上传大于100M文件异常解决方案](https://blog.csdn.net/jabony/article/details/80626888)


    fix #01, 修改会话列表。

    1. 修改会话列表排序功能。
    2. 新增会话列表分类展示。

    commit fc797caf1e66efe34f2230549caa8215f28bcfc6 (HEAD -> developer, master)
Author: Jersey <zexi0625@gmail.com>
Date:   Fri Oct 19 18:07:09 2018 +0800

    fix #03, 移除文件

    1. 移除 NIMDemo/Supporting Files/

commit e8c46119fbc8eb57df5d3d1a69045a1a8aef8582
Author: Jersey <zexi0625@gmail.com>
Date:   Fri Oct 19 17:30:28 2018 +0800

    fix #02, git 移除大文件

    1. 移除 NIMDemo->Vendors。
    2. 移除 NIMDemo->Classes->Vendors。
    3. 移除 NIMDemo->Images.xcassets。
    4. 后期再使用的时候,需要手动添加。

commit 0edcd374d7b90edabe968807145d2a8bf9f7090b
Author: Jersey <zexi0625@gmail.com>
Date:   Fri Oct 19 16:48:51 2018 +0800

    fix #01, 修改会话列表。

    1. 修改会话列表排序功能。
    2. 新增会话列表分类展示。

    
    
  NIMDemo/Classes/Vendors/
	NIMDemo/Images.xcassets/
	NIMDemo/Supporting Files/
	NIMDemo/Vendors/


