# WWDC2021 Async/await actor

## 异步
在日常工作中, 使用到异常的场景非常多, 异步不一定是并发, 只有异步函数结合并行队列时系统会进行 CPU 调度实现真正的并发, 异步函数的作用主要是标识不会阻塞当前线程, 最常见的写法就是(异步+并行)创建子线程进行网络请求数据, 子线程等待数据结果回来后, 使用(异步+主队列(串行))切换到主线程进行 UI 更新。

## 异步的烦恼
目前 iOS 基本都是 GCD 封装好的 API, GCD 是针对 NSOperation 进行了一层函数式编程的封装, 所以我们可以很方便的像调函数一样进行线程切换, 对于基础的业务逻辑, 简单的场景来说, 还是相当好用的, 但是随着版本迭代总是无法避免业务扩展后, 变得越来越复杂, 臃肿。
原来的一层回调实现, 后来可能变成了嵌套 3 - 4 层回调, 甚至更多, 一个方法可能从 50行 增多到 200 行等, 后面的维护也越来越难, 逻辑嵌套越多, 出错的概率也在不断增大, 仿佛头上悬着一把达摩克里斯之剑！


**异步编程问题**

基于 Block 的异步编程回调是目前 iOS 使用最广泛的异步编程方式，iOS 系统提供的 GCD 库让异步开发变得很简单方便，但是基于这种编程方式的缺点也有很多，主要有以下几点：





> 错误处理复杂和冗长
> 容易忘记调用 completion handler
> 条件执行变得很困难
> 从互相独立的调用中组合返回结果变得极其困难
> 在错误的线程中继续执行
> 难以定位原因的多线程崩溃
> 锁和信号量滥用带来的卡顿、卡死


**completion 地狱回调**

我们用「获取缩略图」来举例，先看下下面这段代码，找下有哪些逻辑问题：

```
func fetchThumbnail(for id: String, completion: @escaping (UIImage?, Error?) -> Void) {
	let request = thumbnailURLRequest(for: id)
	let task = URLSession.shared.dataTask(with: request) { data, response, error in
	   if let error = error {
	       completion(nil, error)
	   } else if (response as? HTTPURLResponse)?.statusCode != 200 {
	       completion(nil, FetchError.badID)
	   } else {
	       guard let image = UIImage(data: data!) else {
	           return
	       }
	       image.prepareThumbnail(of: CGSize(width: 40, height: 40)) { thumbnail in
	           guard let thumbnail = thumbnail else {
	               return
	           }
	           completion(thumbnail, nil)
	       }
	   }
	}
	task.resume()
}
```
通过上面的代码实现, 相信大多数同学都发现了存在的问题, 其中有两处图片处理结果异常, 直接被 **guard** 语句抛出, 没有调用 completion, 虽然不会影响到图片的下载, 但是外部调用因为内部实现的缺失导致没法处理到所有的可能的情况, 也容易产生一系列连锁反应。

这里突然想到之前接的 Tradplus, 是一个专门做聚合广告平台的 SDK, 当时使用其来获取广告, 一般获取广告的回调函数里面, 包含相应的广告数据外, 还有错误和成功的标识符, 正常来说这个回调对于使用者来说, 不管是出现什么情况都是要抛出回调的, 要么成功要么失败, 但是 SDK 有个非常低级的错误, 当设置广告位 ID 错误, 去获取广告时, 此回调会永远不执行, 这完全违背了当初约定的实现结果(PS: 对方开发文档标明此回调无论如何都会给回调的前提下)。


**通过 Result 改造 completion**

```
func fetchThumbnail(for id: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
   let request = URLRequest(url: self.imageURL)
   let task = URLSession.shared.dataTask(with: request) { data, response, error in
       if let _ = error {
           completion(.failure(FetchError.netError))
       } else if (response as? HTTPURLResponse)?.statusCode != 200 {
           completion(.failure(FetchError.netError))
       } else {
           guard let image = UIImage(data: data!) else {
               completion(.failure(FetchError.badImage))
               return
           }
           image.prepareThumbnail(of: CGSize(width: 40, height: 40)) { thumbnail in
               guard let thumbnail = thumbnail else {
                   completion(.failure(FetchError.badImage))
                   return
               }
               completion(.success(thumbnail))
           }
       }
   }
   task.resume()
}
```

上面通过 Result 返回值和包含类型的限定上, 对 completion 进行了改造, 以及缺少异常处理的代码补充, 这样在使用的时候

**使用 async 和 await 重构函数**

```
func asycnAwaitFetchThumbnail(for id: String) async throws -> Result<UIImage, Error> {
   let request = URLRequest(url: self.imageURL)
   let (data, response) = try await URLSession.shared.data(for: request)
   guard (response as? HTTPURLResponse)?.statusCode == 200 else {
       throw FetchError.netError
   }
   let maybeImage = UIImage(data: data)
   guard let resultImage = await maybeImage?.byPreparingThumbnail(ofSize: CGSize(width: 40, height: 40)) else {
       throw FetchError.netError
   }
   return .success(resultImage)
}
```
明显看到代码行数减少了一些, 也不用担心多个异步函数嵌套, 地狱回调的问题

步骤: 
1. 生成 Request
2. try 请求数据, 使用 await 标记暂停, 方法内部实现是异步操作
3. 等待 await 暂停结束, 判断请求结果
4. 生成 Image
5. 因为裁剪图片是异步操作, 继续使用 await 将其标记暂停
6. 最后等待 await 返回结果后, return 下载/裁剪完的图片

## 协程


##Async/await简介: 
异步与阻塞的方式来控制管理,多线程异步并发线程切换问题, await 是相对 async 修饰下的异步任务下进行阻塞。 相对于以前写异步嵌套多个异步操作时, 不需要将所以按顺序的任务,多层嵌套在一个 callback 里面来进行处理。提供了一个非常简洁的关键字特性

使用 Async 实现了异步, 但并不一定是并发, Swift 引入结构化async-let并发让 Async 编写并发更加简便, 同时解决控制繁琐的问题。

**如何工作的**
![async/await](https://images.xiaozhuanlan.com/photo/2021/1843711b998e370aed21c6faf4d26330.png)

![async/await](https://images.xiaozhuanlan.com/photo/2021/33a708f4237ec970b790a49a90fee1dc.png)

**原理**
![async/await](https://images.xiaozhuanlan.com/photo/2021/a373d3ca1b7207290147ee126875fe1b.png)


**async / await 实际上的意思：**

1. async 允许一个函数被挂起；
2. await 标记一个异步函数的潜在暂停点；  
3. 在挂起期间可能会进行其他工作；
4. 一旦等待的异步调用完成，在 await 之后恢复执行。


## 并发

**使用 async 和 await 处理多个缩略图**

```
func fetchThumbnails(for ids: [String]) async throws -> [String: UIImage] {
   var thumbnails: [String: UIImage] = [:]
   for id in ids {
       let request = thumbnailURLRequest(for: id)
       let (data, response) = try await URLSession.shared.data(for: request)
       try validateResponse(response)
       guard let image = await UIImage(data: data)?.byPreparingThumbnail(ofSize: thumbSize) else {
           throw ThumbnailFailedError()
       }
       thumbnails[id] = image
   }
   return thumbnails
}
```
步骤非常简单：
	1	声明 thumbnails 保存返回值；
	2	使用 for-in 循环创建任务；
	a	创建请求；
	b	下载图片；
	c	检查资源合法性；
	d	生成缩略图；
	e	保存缩略图。
	3	返回 thumbnails。
可以发现，仅仅是增加了 for-in 循环，就可以非常方便地顺序处理多张缩略图。



**使用 async-let 处理结构化并发**

```
func fetchOneThumbnail(withID id: String) async throws -> UIImage {
   let imageReq = imageRequest(for: id), metadataReq = metadataRequest(for: id)
   let (data, _) = try await URLSession.shared.data(for: imageReq)
   let (metadata, _) = try await URLSession.shared.data(for: metadataReq)
   guard let size = parseSize(from: metadata),
         let image = await UIImage(data: data)?.byPreparingThumbnail(ofSize: size)
   else {
       throw ThumbnailFailedError()
   }
   return image
}
```

**async-let 真正的并发**


```
func fetchOneThumbnail(withID id: String) async throws -> UIImage {
    let imageReq = imageRequest(for: id), metadataReq = metadataRequest(for: id)
    async let (data, _) = URLSession.shared.data(for: imageReq)
    async let (metadata, _) = URLSession.shared.data(for: metadataReq)
    guard let size = parseSize(from: try await metadata),
          let image = try await UIImage(data: data)?.byPreparingThumbnail(ofSize: size)
    else {
        throw ThumbnailFailedError()
    }
    return image
}
```
切换成 async let 的方式, 初始化两个网络请求, 并使用 await 来标记返回数据, 相当于同时发起两个网络请求, await 暂停挂起等待结果, 要注意的是第一个 await 的是 metadata, 当其请求失败抛出异常时, 如果 data 网络请求结果还未返回, 系统则会自动取消掉此次网络请求, 非常方便使用

## 对比 Kotlin Async/await 	

**串行**
```
launch(UI) {                             
    prograssBar.isVisible = true
 
    val token = async { getToken() }
    val profile = async { loadProfile(token.await()) }.await()
    nameText.text = profile.name
    
    prograssBar.isVisible = false
                                                
}
```

**并行**
```
 launch(UI) {                                            
    prograssBar.isVisible = true
 
    val profile = async { loadProfile() }
    val articles = async { loadArticles() }
    show(profile.await(), articles.await())
    prograssBar.isVisible = false
                                              
} 
```

Swift 和 Kotlin 还挺相似的, await 标识挂起, 如果想并行同时发起两个异步任务时, 

## 代码迁移

更新前:
![Async](https://filescdn.proginn.com/b5f1a65060a197d9e6881de01670fff4/993882758580a1d9a4395c8c8e607cc0.webp)
更新后:
![Async](https://filescdn.proginn.com/10f912fd9c9b8808d679c8a3c9925956/e6add094e7db0990c345b0bdf773f266.webp)


## 使用任务组进行并发

**withThrowingTaskGroup**
Swift 提供了


## Actors 简介:
异步并发使编程性能上得以更大化发挥了 CPU 的利用率，同时也引入了不可避免的资源竞争问题, 大多数使用是通过锁来解决资源竞争, 使用锁的时候也需要异常的注意，否则又会容易出现死锁的问题。
Swift 引入了 Actor 概念, 使用 Actor 内部实现数据的同步, 不需要额外的关心数据竞争, 可以理解为, 只要继承 Actor 的类, 通过 Actor 内部隔离的方式, 修改值只能通过像 Actor 发送信号并等待结果, 消息会自动被 Actor 同步处理, 类似帮我们维护了一个锁来实现, 数据同步问题！


**解决资源竞争**

```
actor Counter {
    var value = 0

    func increment() -> Int {
        value = value + 1
        return value
    }
}

let counter = Counter()

asyncDetached {
    print(await counter.increment())
}

asyncDetached {
    print(await counter.increment())
}
```

## 参考资料

https://xiaozhuanlan.com/topic/8627905413
https://developer.apple.com/videos/play/wwdc2021/10132/
https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html
https://github.com/alibaba/coobjc/blob/master/README_cn.md
https://onevcat.com/2016/12/concurrency/

2021-08-27 17:38:29.955171+0800 HelloTalk_Binary[33156:2961981] <Google> <Google:HTML> Invalid click coordinates detected. Click coordinate (0, 67) should be positive and within the ad view boundary.

[bindIDNavVC setSupportRotate:NO];

