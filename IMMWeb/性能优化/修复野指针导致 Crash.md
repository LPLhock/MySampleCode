# 野指针崩溃引发的思考

## 野指针

## 0x1 多线程下Setter 的崩溃

Thread 37: EXC_BAD_ACCESS (code=1, address=0x1fcd8dbc9b50)
Thread 13: signal SIGABRT

```
func testData() {
        DispatchQueue.global().async {
            for i in 0..<5000 {
                DispatchQueue.global().async {
                    self.lock.lock()
//                    NSLog("JerseyTTT当前正在循环: \(i), string: \(self.testDataString),  : thread:\(Thread.current)")
                    let random = Int.random(in: 0...1000)
                    self.testDataString = [random]
//                    let random2 = Int.random(in: 0...random)
//                    self.testDataString = [random, random2, random + random2]
//                    let random3 = Int.random(in: 0...random2)
//                    self.testDataString = [random, random2, random3, random + random2, random + random2 + random3]
                    NSLog("JerseyTTT当前正在循环: \(i), string: \(self.testDataString),  : thread:\(Thread.current)")
                    self.lock.unlock()
                }
            }
        }
    }
```


## Autoreleasepool

## RunLoop 与 线程

整理编辑：师大小海腾
Q：执行以下代码，打印结果是什么？
```
dispatch_async(dispatch_get_global_queue(0, 0), ^{
    NSLog(@"1");
    [self performSelector:@selector(test) withObject:nil afterDelay:.0];
    NSLog(@"3");
});

- (void)test {
    NSLog(@"2");
}

```
打印结果为 1、3。原因是：
	1	performSelector:withObject:afterDelay: 的本质是拿到当前线程的 RunLoop 往它里面添加 timer
	2	RunLoop 和线程是一一对应关系，子线程默认没有开启 RunLoop
	3	当前 performSelector:withObject:afterDelay: 在子线程执行
所以 2 不会打印。



### 参考资料

https://www.jianshu.com/p/c4bd2960b3fa
http://satanwoo.github.io/2016/10/23/multithread-dangling-pointer/
https://mp.weixin.qq.com/s?__biz=MzU2MDQzMjM3Ng==&mid=2247485932&idx=1&sn=169c7571eba452e8a2d03256c97102ca&chksm=fc095c7bcb7ed56d7087330e687af3b073c8af3bbd307a9962febdeebd4dc721a14a49da1143&scene=178&cur_album_id=1658864183834148870#rd




https://juejin.cn/post/6844903557733285896
https://github.com/xitu/gold-miner/blob/master/ios.md
https://mp.weixin.qq.com/s?__biz=MzU2MDQzMjM3Ng==&mid=2247485932&idx=1&sn=169c7571eba452e8a2d03256c97102ca&chksm=fc095c7bcb7ed56d7087330e687af3b073c8af3bbd307a9962febdeebd4dc721a14a49da1143&scene=178&cur_album_id=1658864183834148870#rd
https://github.com/SwiftOldDriver/iOS-Weekly/releases
https://mp.weixin.qq.com/s?__biz=MzI2NTAxMzg2MA==&mid=2247492205&idx=1&sn=1b2e05f338b40576891d5ee8da8cb006&chksm=eaa17d66ddd6f470f5c4638fc14c0fe27756ca9c396b055cba67d752f6fda75c42340f470d64&scene=178&cur_album_id=1432795573765193729#rd
anhuapp.com/web/#/item?tid=4c2c0f24-2302-4fd0-8ddd-0c0509b1767a&fid=all
https://onevcat.com/2016/12/concurrency/#asyncawait%E4%B8%B2%E8%A1%8C%E6%A8%A1%E5%BC%8F%E7%9A%84%E5%BC%82%E6%AD%A5%E7%BC%96%E7%A8%8B
http://satanwoo.github.io/2016/10/23/multithread-dangling-pointer/
https://www.jianshu.com/p/c4bd2960b3fa





let sharedView = LearningDataShareView.init(viewModel: self.viewModel, qrUrl: nil)
        sharedView.frame = CGRect(x: 0, y: 0, width: UIScreen.width, height: UIScreen.height)
        sharedView.setNeedsLayout()
        sharedView.layoutIfNeeded()
        NSLog("JerseyBro: width:\(UIScreen.width), height: \(UIScreen.height), sharedViewWithd: \(sharedView.ht.width), sharedViewheight: \(sharedView.ht.height)")
        let sharedVC = UIViewController()
        sharedVC.view.addSubview(sharedView)
        sharedView.frame = sharedVC.view.bounds
        self.present(sharedVC, animated: true, completion: nil)
        sharedView.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                sharedVC.dismiss(animated: true)
            })