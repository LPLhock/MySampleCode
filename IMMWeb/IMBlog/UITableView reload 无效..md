# UITableView reload 无效.

**过程:** 在使用 AF 请求网络, 成功回调里面 使用 tableView reload 无效. 只执行了行和列方法, 未执行 cell 。
tableView 加载方式改成非懒加载的方式即可。

