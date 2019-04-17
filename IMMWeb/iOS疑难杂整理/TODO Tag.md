# TODO Tag

1. Xcode9.4 升级到 Xcode 10 之后 发现/YZHYolo/YZHYolo.xcodeproj/xcuserdata/AiWy.xcuserdatad/xcschemes/xcschememanagement.plist   
xcschememanagement.plist 文件的 SchemeUserState -> YZHYolo.xcscheme -> orderHint : Number 从 24 自动修改成 25.

2. 有时候 Xcode  升级出新的 iOS 系统之后, 有的模拟器对应 iOS 系统分别不一样, 然后三方库里的各个项目对应的支持最低 系统可能超过目前 Xcode 里模拟器的范围, 比如 AF 可能支持 iOS 6 7 以上,然后更新到 Xcode 10 出了 iPhone XR, 其只支持 8 - 12, 项目会报警告,  然后我们去升级 警告上面按个 Tagger Setting 即可。
3. (lldb) po self.view.bounds
(origin = (x = 0, y = 0), size = (width = 600, height = 600)) 莫名其妙.
[参考](https://stackoverflow.com/questions/27897884/uiview-in-xib-using-autolayout-is-always-600x600)
https://www.jianshu.com/p/3445edad9a94
4. UITableView 关于 使用 Xib 复用问题, [[NSBundle mainBundle] loadNibNamed:@"YZHMyInformationMyPlaceCell" owner:self options:nil].firstObject; 与 [[NSBundle mainBundle] loadNibNamed:@"YZHMyInformationMyPlaceCell" owner:nil options:nil].firstObject; 使用Self 时, 可正常完成复用, 否则不行. 
原来是 Identifier 位置写错了..... 自定义位置与 UITableViewCell 不一样。

5.     ``` _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.tableFooterView.height = 50;
        _tableView.tableFooterView.backgroundColor = [UIColor yellowColor];
        ```
        设置表尾 无效 .....
        
6. Printing description of $222:
<UIInputSetContainerView: 0x7beae090; frame = (0 0; 320 480); autoresize = W+H; layer = <CALayer: 0x7be53940>>
Printing description of $298:
<UIInputSetHostView: 0x7beae3b0; frame = (0 480; 320 0); layer = <CALayer: 0x7bebd5f0>>  低版本出现约束问题。
7. runtime: GPU Frame Capture: Shader performance data maybe unavailable due to deployment target older than device version
   运行时警告,
8. Property follows Cocoa naming convention for returning 'owned' objects 警告.


