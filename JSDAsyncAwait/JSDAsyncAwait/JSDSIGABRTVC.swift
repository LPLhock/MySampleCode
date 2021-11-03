//
//  JSDSIGABRTVC.swift
//  JSDAsyncAwait
//
//  Created by Jersey on 2021/11/3.
//

import Foundation

class JSDSIGABRTVC: UIViewController {
    var userData: [User]?

    var randomArray: [Int]? = [1]
    
    var _atomicRandomArray: [Int]?
    
    var atomicRandomArray: [Int]? {
        get {
            self.arrayGetLock.lock()
            defer { self.arrayGetLock.unlock() }
            return _atomicRandomArray
        }
        set {
            self.arraySetLock.lock()
            defer { self.arraySetLock.unlock() }
            _atomicRandomArray = newValue
        }
    }
    
    let arraySetLock: NSLock = NSLock()
    let arrayGetLock: NSLock = NSLock()
    
//    var wrappedValue: Value {
//          get { return load() }
//          set { store(newValue: newValue) }
//        }

    
    static var userName: String = ""
    
    let lock: NSLock = NSLock()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "JSDSIGABRTVC"
        self.view.backgroundColor = .white
        setupData()
    }
    
    // MARK: Debug Thread 1: signal SIGABRT
    func setupData() {
//        let queue = DispatchQueue(label: "JerseyCafe")
//        queue.async {
//        }
//        self.lock.lock()
//        self.lock.unlock()
//        autoreleasepool(invoking: {
//        }
        
        for i in 0..<10000 {
            DispatchQueue.global().async {
            let random = Int.random(in: 0...1000)
            self.atomicRandomArray = [1]
            NSLog("JerseyTTT当前正在循环: \(i), string: \(self.atomicRandomArray), : thread:\(Thread.current)")
            }
        }
        
//        DispatchQueue.global().async {
//            async {
//                for i in 0..<100000 {
//                    let random = Int.random(in: 0...1000)
//                    self.atomicRandomArray = [1]
//                    NSLog("JerseyTTT当前正在循环: \(i), string: \(self.atomicRandomArray), : thread:\(Thread.current)")
//                }
//            }
//        }
        
//        for i in 0..<100000 {
//            DispatchQueue.global().async {
//            let random = Int.random(in: 0...1000)
//                autoreleasepool(invoking: {
//                    self.randomArray = [random]
//                    NSLog("JerseyTTT当前正在循环: \(i), string: \(String(describing: self.randomArray)), : thread:\(Thread.current)")
//                })
//            }
//        }
//
//        for i in 0..<100000 {
//            DispatchQueue.global().async {
//                let random = Int.random(in: 0...1000)
//                ViewController.userName = String(random)
//                NSLog("JerseyTTT当前正在循环: \(i), string: \(ViewController.userName), : thread:\(Thread.current)")
//            }
//        }
        
//        let testActor = Counter()
//                testActor.testDataString = [random]
//        Task.init(priority: .high) {
//            for i in 0..<5000 {
//                let random = Int.random(in: 0...1000)
//                await testActor.updateData([random])
//                NSLog("JerseyTTT当前正在循环: \(i), string: \(await testActor.testDataString),  : thread:\(Thread.current)")
//            }
//        }
    }
}
