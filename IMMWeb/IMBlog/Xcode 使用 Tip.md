# Xcode 使用 Tip

- 显示构建实现
打开终端输入下面命令行即可
$ defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool YES

- 模拟器支持全屏展示

$ defaults write com.apple.iphonesimulator AllowFullscreenMode -bool YES

- 使用模拟器隐藏的功能
- 
如果要在Simulator中使用更多秘密功能，则应启用Apple隐藏的Internals菜单。为此，您需要在根目录中创建一个名为“ AppleInternal ” 的空文件夹。只需在下面运行此命令并重新启动Simulator：

$ sudo mkdir /AppleInternal

- 使用声音通知调试AutoLayout约束
$ -_UIConstraintBasedLayoutPlaySoundOnUnsatisfiable YES





