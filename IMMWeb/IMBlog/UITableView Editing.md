# UITableView Editing

## 前言

平时开发中很少使用到 UITableView 编辑相关 API，正好碰到就来尝试撸了一下， 暂时记录一下，后续有时间在更新。

# 自定义返回  UITableViewRowAction
```
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 1) {

        UITableViewRowAction* removeAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        }];
        
        return @[removeAction];
    } else {
        
        return @[];
    }
}

```
发现个很奇怪的问题, 我想在左滑时, 除了分区 1 可以出现删除按钮, 其他的不进入编辑, 但是我们在写 return nil 的话会出现默认的, 只能 return @[] 空数组才行.....


## API

```
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath;
// 可通过这个方法设置返回按钮的设置, 不过返回的按钮属于 UITableViewRowAction,不允许高度定制.
能修改 文字 背景 风格. 
要注意, 如果没有实现能否支持编辑方法的话,默认都是 YES。 然后如果想要某一行不支持, 则需要返回 @[]; 或者实现支持编辑方法 设置成 NO 即可.

```

```
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
// 每次滑动时,回来找回返回的是那种编辑类型,  设置成其他风格则无。。。。。。
- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
```

```
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
// 不知道干嘛的。。。
```

```
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
// 每次触发了 editing 的按钮时会调用这个方法。 但是这个方法很神奇, 实现了之后相当于所有 都支持编辑.
```

```
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
// 滑动前会来这里先查看 当前行是否支持编辑, 默认 不重写情况下是返回 YES 的.
```


