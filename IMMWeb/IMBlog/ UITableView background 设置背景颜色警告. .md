#  正确设置 UITableViewHeaderFooterView 背景颜色. 

##警告
  Console error: [TableView] Setting the background color on UITableViewHeaderFooterView has been deprecated. Please set a custom UIView with your desired background color to the backgroundView property instead.
  
  警告原因:  因为 UITableViewHeaderFooterView, 包括 表头表尾,段头段尾, 它的 backgroundColor 属性实际上已经被遗弃了, 我们不能直接通过 self.backgroundColor 来设置其颜色, 其提示让我们自定义一个 View 使用 backgroundView 来接收这个自定义 View, 来作为背景视图。
否则我们直接使用 self.backgroundColor 来设置是无效的。 
  所以如果我们想设置其背景颜色的话可以这样写:
  
### 错误做法

```
myTableViewHeaderFooterView.contentView.backgroundColor = [UIColor blackColor];
myTableViewHeaderFooterView.backgroundView.backgroundColor = [UIColor blackColor];
myTableViewHeaderFooterView.backgroundColor = [UIColor blackColor];
```

### 正确做法

应该使用myTableViewHeaderFooterView.tintColor.
或者为myTableViewHeaderFooterView.backgroundView指定自定义背景视图。

###OC
  ```  
  self.backgroundView = ({
        UIView * view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = [UIColor blueColor];
        view;
  })
  ```
###Swift
  ```
  self.backgroundView = UIView(frame: self.bounds)
  self.backgroundView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
  ```
  
  
## Xib

有时候我们使用的时候 Xib 来构建的 UITableViewHeaderFooterView, 然后使用上面的方式修改了代码之后发现还是接收到了警告, 那么我们应该来看一下 Xib 文件, 将父视图  UITableViewHeaderFooterView 的背景颜色设置为 Default 即可。


## 参考: [Stackoverflow](https://stackoverflow.com/questions/15604900/uitableviewheaderfooterview-unable-to-change-background-color)
  

