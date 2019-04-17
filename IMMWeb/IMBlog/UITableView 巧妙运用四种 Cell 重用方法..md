# UITableView 巧妙运用四种 Cell 重用方法.

## 背景

UITableView 无意在开发中是我们最经常接触的 UI 控件了. 为了让视图更加流畅的展示, Apple 对其底层已经帮我们加入了非常棒的 **复用机制**. 使视图在展示多行列表时, 不会因为每次刷新出新列表然后在去创建, 影响性能.
系统对 UITableView 已经底层已经实现了 Cell 的重用机制, 我们在开发中只需要懂其原理, 并而且在 创建 Cell 的时候灵活运用此机制即可。
这篇文章不深入讲解系统底层是如何实现的复用, 主要讲解实现重用 Cell 的四中方法,技巧。 附Dome 实现。

## 如何重用

上面已经说了重用的底层实现系统已经默认实现好了. 

说说我们在开发中如何实现复用, 步骤实际上很简单.
```
- (void)registerNib:(nullable UINib *)nib forCellReuseIdentifier:(NSString *)identifier NS_AVAILABLE_IOS(5_0);
- (void)registerClass:(nullable Class)cellClass forCellReuseIdentifier:(NSString *)identifier NS_AVAILABLE_IOS(6_0);
- (nullable __kindof UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;
```
1.UITableView 提前注册相应的 Cell 并提供其 Identifier, 完成注册
2.在 UITableViewDataSource 的返回 UITableViewCell 方法中, 使用先前完成注册的 TableView 通过 Identifier. 到复用池中去查找看是否有相同 Identifier 的 Cell, 如果复用池中可重用的 Cell, 则直接返回, 否则会通过注册的方法来进行创建, 创建成功之后会将这个 Cell 的 Identifier 赋值成我们在注册时提供的 Identifier。

步骤这么简单,为啥能衍生出 4 种不同的方法？

## 四种不同的复用方法

先解释一下为什么衍生出了**四种**不同的复用方法.
由于其注册方式有两种  Nib 和 Class 
```
- (void)registerNib:(nullable UINib *)nib forCellReuseIdentifier:(NSString *)identifier NS_AVAILABLE_IOS(5_0);
- (void)registerClass:(nullable Class)cellClass forCellReuseIdentifier:(NSString *)identifier NS_AVAILABLE_IOS(6_0);
```
然后我们也可以不提前注册, 等到时候的时候在自行去创建并且为 Cell 设置 Identifier, 所有有衍生出了两种。 

下面将这四种方式分别罗列出来. 包括 一个 Nib 中使用多种类型 Cell 的复用方法等等.

## 一、提前注册 Cell 并且指定其 Identifier

## 二、延后注册, 即手动创建 Cell 并且指定其 Identifier

## 三、提前注册 Nib 并且指定其 Identifier

## 四、延后注册, 即手动创建 Nib 并指定其 Identifier


https://www.jianshu.com/p/2a9c50bc101f


## Tip
[cell setValue:identifierID forKey:@"reuseIdentifier"];









