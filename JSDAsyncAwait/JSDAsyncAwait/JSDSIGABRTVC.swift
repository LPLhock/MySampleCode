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
            self.arraySlotLock.lock()
            defer { self.arraySlotLock.unlock() }
            return _atomicRandomArray
        }
        set {
            self.arraySlotLock.lock()
            defer { self.arraySlotLock.unlock() }
            _atomicRandomArray = newValue
        }
    }
    
    let arraySlotLock: NSLock = NSLock()
//    let arraySlotlockLock: NSLock = NSLock()
    
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
//        atomic()
//        noAtomic()
//        autoreleasepoolArray()
//        serialQueue()
    }
    
    // MARK: Debug Thread 1: signal SIGABRT
    func setupData() {
    }
    
    func atomic() {
        for _ in 0..<10000 {
            DispatchQueue.global().async {
                let random = Int.random(in: 0...1000)
                self.atomicRandomArray = [random]
                printCurrentThread(filterString: "JSDSIGABRTVC", flagString: self.atomicRandomArray)
            }
        }
    }
    
    func noAtomic() {
        for _ in 0..<10000 {
            DispatchQueue.global().async {
                let random = Int.random(in: 0...1000)
                self.randomArray = [random]
                printCurrentThread(filterString: "JSDSIGABRTVC", flagString: self.randomArray)
            }
        }
    }
    
    func autoreleasepoolArray() {
        for _ in 0..<10000 {
            DispatchQueue.global().async {
                autoreleasepool {
                    let random = Int.random(in: 0...1000)
                    self.atomicRandomArray = [random]
                    printCurrentThread(filterString: "JSDSIGABRTVC", flagString: self.atomicRandomArray)
                }
            }
        }
    }
    
    func serialQueue() {
        for _ in 0..<10000 {
            DispatchQueue.global().async {
                let serialQueue = DispatchQueue(label: "JerseySerialQueue")
                serialQueue.async {
                    let random = Int.random(in: 0...1000)
                    self.randomArray = [random]
                    printCurrentThread(filterString: "JSDSIGABRTVC", flagString: self.randomArray)
                }
            }
        }
    }
}
