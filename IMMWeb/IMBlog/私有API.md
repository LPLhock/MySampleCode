# 私有API

## 前景

在开发过程使用系统库时, 经常遇到一些需要再原有类库上进行特殊定制的需求, 比如 UIAlertView. UINavigationController. UITabBarItem. 等等,  主要是一些常用的系统控件, 但是又和当前产品需求有些儿不符合的地方, 这时候一般是获取到 库公共的属性来进行修改, 但是在遇到库未将属性暴露出来的时候就有点麻烦了. 不过我们可以借助 KVC 来进行访问。


## KVC

例如:
```
@property (nonatomic, readonly, copy, nullable) NSString *reuseIdentifier;
[cell setValue:identifierID forKey:@"reuseIdentifier"];
```
此属性系统在定义的时候将其设置成 readonly, 只有 get 方法没有 set 方法。所以不允许直接进行修改.
不过我们通过 KVC 键值对编码即可正常进行修改.

不过使用 KVC 时需要注意, 如果某一天系统将这个 Key 修改了,未做兼容的话, 我们直接这样访问会导致 Crash. 所以在使用的时候我们一般使用 异常捕获来调用.

```
@try {
    [cell setValue:identifierID forKey:@"reuseIdentifier"];
}
@catch(NSException *exception) {
    NSLog(@"Failed setting Cell with reuseIdentifier key : %@", exception);
}

```


参考: [在iOS 8中自定义UIAlertController以包含UITableView等标准元素](https://stackoverflow.com/questions/25896696/customize-uialertcontroller-in-ios-8-to-include-standard-elements-like-uitablevi/26820173#26820173)
[Using `valueForKey` to access view in UIBarButtonItem, private API violation?](https://stackoverflow.com/questions/11923597/using-valueforkey-to-access-view-in-uibarbuttonitem-private-api-violation)
[Get the width of a UIBarButtonItem](https://stackoverflow.com/questions/5066847/get-the-width-of-a-uibarbuttonitem/5066899#5066899)
[Is it possible to set value to readonly property using KVC in iOS?](https://stackoverflow.com/questions/33677909/is-it-possible-to-set-value-to-readonly-property-using-kvc-in-ios
)



