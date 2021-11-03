# 浅谈野指针异常

## 前言
工程师们苦 Crash 久矣，尤其是用户感知最为明显的客户端。那居高不下的崩溃率、数不胜数的用户反馈、迟迟无法完成的 KPI，折磨着每一位客户端的开发同学。

> 加断点再Debug，堆栈瞬间就爆炸，日志输出如雨下，看到异常就害怕；调试一夜没人陪，心想这锅该归谁？回想当初心后悔，不该重构这地雷；翻日志查半天，博客看了千百遍，低头又点一根烟，闪退还是没复现。

上面这段文字很形象的描述了一位深夜排查闪退问题的工程师。那么 Crash 为何如此难以解决且反复发作，它究竟难在哪里，从客户端工程诞生至今一直困扰着无数的工程师。

## 线程 And RunLoop

**Q：执行以下代码，打印结果是什么？**
```
dispatch_queue_t cQueue = dispatch_queue_create("JSD", DISPATCH_QUEUE_CONCURRENT);
dispatch_async(cQueue, ^{
   NSLog(@"Perform: 1");
   [self performSelector:@selector(testPerformSelector) withObject:nil afterDelay: 0];
   NSLog(@"Perform: 3");
});

- (void)testPerformSelector {
    NSLog(@"Perform: 2");
}

```

打印结果为 1、3。原因是：
1. performSelector:withObject:afterDelay: 的本质是拿到当前线程的 RunLoop 往它里面添加 timer
2.RunLoop 和线程是一一对应关系，子线程默认没有开启 RunLoop
3.当前 performSelector:withObject:afterDelay: 在子线程执行, 所以 2 不会打印。


## 野指针

>野指针是指指向一个已删除的对象或未申请访问受限内存区域的指针

**Obj-C的野指针最常见的一种栈是objc_msgSend**

看了一下 Firebase 崩溃信息收集, 历史遗留问题最多当属野指针和多线程相关的异常。
野指针崩溃为什么如此难以排查, 最主要是原因是其随机性较高, 在测试阶段很难浮出水面, 往往需要等到上线后, 用户量覆盖足够多之后, 问题才会暴露出来。

**两大类型:**

1. 跑不进出错的逻辑，执行不到出错的代码，这种可以提高测试场景覆盖度来解决。
2. 跑进了有问题的逻辑，但是野指针指向的地址并不一定会导致Crash，这好像要看人品了？

**为什么会随机**
因为dealloc执行后只是告诉系统，这片内存我不用了，而系统并没有就让这片内存不能访问。
现实大概是下面几种可能的情况：

1. 对象释放后内存没被改动过，原来的内存保存完好，可能不Crash或者出现逻辑错误（随机Crash）。
2. 对象释放后内存没被改动过，但是它自己析构的时候已经删掉某些必要的东西，可能不Crash、Crash在访问依赖的对象比如类成员上、出现逻辑错误（随机Crash）。
3. 对象释放后内存被改动过，写上了不可访问的数据，直接就出错了很可能Crash在objc_msgSend上面（必现Crash，常见）。
4. 对象释放后内存被改动过，写上了可以访问的数据，可能不Crash、出现逻辑错误、间接访问到不可访问的数据（随机Crash）。
5. 对象释放后内存被改动过，写上了可以访问的数据，但是再次访问的时候执行的代码把别的数据写坏了，遇到这种Crash只能哭了（随机Crash，难度大，概率低）！！
6. 对象释放后再次release（几乎是必现Crash，但也有例外，很常见）。

**参考下图:**
![野指针](https://upload-images.jianshu.io/upload_images/68070-cf1c2444137fa0db.png?imageMogr2/auto-orient/strip|imageView2/2/format/webp====)

## atomic


## Autoreleasepool

## release 

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
            
            
            
            
            
            
            0x2809870f0

