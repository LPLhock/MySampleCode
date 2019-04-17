# UITableView 重用机制.

重用机制是 系统已经实现好的, 可以通过源码分析得到其重用机制原理。 只要我们在开发过程中, 手动进行一个注册, 然后在其 DataSource 方法中进行一个默认先从缓存池里面去找即可。

方法一: 在创建 tableView 的时候使用想用标识符对 Cell 进行注册,注册也分两种, 一种是时候 Class 一种是 Nib, 我们注册的时候选择哪种, 等到缓存池里面取的时候,如果没有就会采用哪种方式进行创建.
注册则最好搭配 dequeueReusableCellWithIdentifier: forIndexPath:  去使用,  这个方式去针对 注册时使用的. 因为调用这个方法 则会在 没有时主动去创建.

方法二: 不事先注册, 在其 DataSource 方法直接通过 dequeueReusableCellWithIdentifier: 方法, 去查询缓存池, 如果有则读取, 否则自行去创建,  创建方式直接手动创建就好。 
这个方法调用返回参数可能是 null。

## 问题.

有时候 一个 自定义 Cell 我时候 Xib 来创建, 但是里面包含多种类型 Cell, 这时候如果我采用 多个进行注册的方式, 则不能直接使用 dequeueReusableCellWithIdentifier: forIndexPath 方法, 否则会 Crash, 因为这里不知道该指定哪一个 Cell。

我们直接采用不注册, dequeueReusableCellWithIdentifier: 去进行查找, 如果没有则在进行创建即可。


<YZHMyCenterVC: 0x7fb44ce14c90> ---> <YZHMyInformationVC: 0x7fb44ce638a0>
2018-09-22 19:08:49.841430+0800 YZHYolo[61063:5953694] [framework] CUICatalog: Invalid asset name supplied: ''
2018-09-22 19:08:49.855920+0800 YZHYolo[61063:5953694] [framework] CUICatalog: Invalid asset name supplied: ''
2018-09-22 19:08:49.870543+0800 YZHYolo[61063:5953694] [framework] CUICatalog: Invalid asset name supplied: ''
2018-09-22 19:08:49.888998+0800 YZHYolo[61063:5953694] [framework] CUICatalog: Invalid asset name supplied: ''


参考: [复用的精妙 - UITableView 复用技术原理分析](https://www.desgard.com/iOS-Source-Probe/Objective-C/Foundation/%E5%A4%8D%E7%94%A8%E7%9A%84%E7%B2%BE%E5%A6%99%20-%20UITableView%20%E5%A4%8D%E7%94%A8%E6%8A%80%E6%9C%AF%E5%8E%9F%E7%90%86%E5%88%86%E6%9E%90.html)




## UITableViewHeaderFooterView 复用

其表头和表尾复用好像跟 Cell 有点儿区别, 表头只要我们注册了, 然后第一次去取就能取得到. 

方法一:   很奇怪,通过 重写  init 方法也没有拦截到, 不知道系统是从那个方法直接生成的.
```
[self.tableView registerClass:[YZHAddBookSetTagSectionView class] forHeaderFooterViewReuseIdentifier:@"sectionViewIdentifier"];
YZHAddBookSetTagSectionView* view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"sectionViewIdentifier"];
```
方法二:  没有进行注册直接取
```
// 由于没有进行注册直接取并且是自定义的, 则第一次是空的状况, 所以我们需要去生成
YZHAddBookSetTagSectionView* view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"sectionViewIdentifier"];
if (!view) {
   view = [[YZHAddBookSetTagSectionView alloc] initWithReuseIdentifier:@"sectionViewIdentifier"];
}
// 重写
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        NSLog(@"直接复用");
    } else {
        NSLog(@"找不到该肿么办");
    }
    
    return self;
}
```

不太明白为什么 self = [super initWithReuseIdentifier:reuseIdentifier];  从复用池里去找都能一直找得到. 没有 nil 的时候.


解释:  
[self.tableView registerClass:[YZHAddBookSetTagSectionView class] forHeaderFooterViewReuseIdentifier:@"sectionViewIdentifier"];  

**注册**
1. 当我们进行注册时, 相当于告诉 UITableView 可以通过  initWithReuseIdentifier 来找这个标识符. 
2. initWithReuseIdentifier 它会初始化一个 YZHAddBookSetTagSectionView 子类,并将其使用 标识符标识。

**未注册直接找**
1. 如果我们预先没有进行注册,那么我们直接通过  dequeueReusableHeaderFooterViewWithIdentifier 方法. 系统并不会自动调用 initWithReuseIdentifier 方法来找。  所以返回的 view 永远是 nil 。
2. 进而我们还需要 判断 如果 找不到的时候, 要去进行创建并且为 这个 View 添加标识符,  这样下次找的时候就可以直接找到了。
```
- (instancetype)init {
    
    self = [super init];
    if (self) {
        
       self =  [self initWithReuseIdentifier:@"kkk"];
    }
    return self;
}
```

**标识符找View**
YZHAddBookSetTagSectionView* view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"sectionViewIdentifier"];

1. UITableView 先使用这个标识符打复用池里面找, 看是否有可使用的, 如果有就直接使用. 返回。 
2. 如果没有找到, 则才会调用 initWithReuseIdentifier 方法, 然后初始化一个 View, 并且将其使用标识符来标记.

**initWithReuseIdentifier 与 init**

1. 调用了 init 自后 默认会在 调用 initWithReuseIdentifier。   initWithReuseIdentifier 主要是对这个 View 做一个 标记。






