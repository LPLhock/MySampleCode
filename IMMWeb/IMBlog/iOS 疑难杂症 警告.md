# iOS 疑难杂症 警告


## "Could not load the "" image referenced from a nib in the bundle with identifier "

这个警告跟弱智一样.....
我去查看警告的 imageView, 检查其是否属于本Tager 发现都没有什么问题. 然后我清理 Xcode 运行还是没有效果, 我最后把使用到相关 imageName 都给注释掉, 发现没有警告了.  我又重新在使用发现居然好了。 无疑这是 Xcode 的 Bug.
[Error](https://stackoverflow.com/questions/31198946/could-not-load-the-image-referenced-from-a-nib-in-the-bundle-with-identifier)
Urughhh。我尝试用上述所有解决方案解决这个问题，但没有任何效果。最终起作用的是：
	1.	从项目中删除图像，然后选择“移至废纸篓”
	2.	清洁项目
	3.	关闭并重新启动XCode
	4.	重命名您的图像文件名，使其不是以前的名称
	5.	将新图像添加到项目中

	很多弱智的, SB 的, 无脑的 Bug 警告都是从 Xib 缓存冒出来的, 真的让人恶心！！！！


