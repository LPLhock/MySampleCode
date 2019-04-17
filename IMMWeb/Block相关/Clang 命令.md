# Clang 命令

## 使用

直接使用 clang -rewrite-objc file.m 
总是报错
not found "UIKit" error

修改成xcrun -sdk iphonesimulator12.1 clang -rewrite-objc AppDelegate.m 依然报错

以及  clang -x objective-c -rewrite-objc -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk 等都是无效的

xcrun -sdk iphonesimulator12.1 clang -rewrite-objc JSDBlockGuideVC.m

发现好像是当前文件的问题, 不能使用系统库不包含, 自己手动引入的文件, 否则会编译失败。。


## 

https://www.zybuluo.com/qidiandasheng/note/486848

https://www.google.com.hk/search?safe=strict&source=hp&ei=EkWHXKTqN7Gh-Qb9tbKACw&q=main.m%3A9%3A9%3A+fatal+error%3A+%27UIKit%2FUIKit.h%27+file+not+found&btnK=Google+%E6%90%9C%E7%B4%A2&oq=main.m%3A9%3A9%3A+fatal+error%3A+%27UIKit%2FUIKit.h%27+file+not+found&gs_l=psy-ab.3...175054.176051..176619...0.0..0.172.225.1j1......0....2j1..gws-wiz.....0.ZN2ICUWHd30

