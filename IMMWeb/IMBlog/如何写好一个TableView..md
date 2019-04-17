# 如何写好一个TableView.

##关于动态 Cell 高度,引发的一系列问题
  
  计算动态高度本身是一件消耗性能的事情, 边滚动的时候需要保证滑动流畅性, 还需要让 CPU 去进行高度计算, 算出相应高度在展示出来, UITableView 在滚动前是完全不知道下一个 Cell 是多高, 所以也就无法确定其 contentSize , 导致了一定要等结果算出来 才能确保其 contentSize , 这是一系列连锁反应,  在 iOS 7 Apple 推出 **estimatedRowHeight** 来进行解决,  其是一种对 Cell 的预估, 大于小于都没有关系, UITableView 会从预估值先确定下来, 还是等滚动的时候去计算, 只不过会对其高度做一个缓存, 下次读取就会变快。 iOS 7 之前性能提升还是挺显著的.
  iOS 8 AppLe 推出 **self-sizing cell** 在计算 Cell 高度上解决了 **AutoLayout** 和 **Frame** 所困难的地方, self.tableView.estimatedRowHeight = 213; 必须要加上这段代码才可以享受自动算高功能,self.tableView.rowHeight = UITableViewAutomaticDimension; 这段是默认执行.   坑点: 其不在对 Cell 高度进行缓存, Apple 认为 Cell 随时都可能会改变高度（如从设置中调整动态字体大小），所以每次滑动出来后都要重新计算高度。
  **UITableView+FDTemplateLayoutCell**
  在这样的背景下其研发出了一种同时解决 iOS 7 以前, iOS 8 以后对高度不缓存,影响滚动流畅度的 算高机制, 其主要运用 runLoop, 在UITableView 空闲时机则去计算高度, 并缓存下来。
 
  
  参考:[优化UITableViewCell高度计算的那些事](http://blog.sunnyxx.com/2015/05/17/cell-height-calculation/)

