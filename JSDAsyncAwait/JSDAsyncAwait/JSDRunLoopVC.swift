//
//  JSDRunLoop.swift
//  JSDAsyncAwait
//
//  Created by Jersey on 2021/11/3.
//

import Foundation
import UIKit

class JSDRunLoopVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.title = "RunLoop"
        
        DispatchQueue.global().async {
            printCurrentThread(filterString: "RunLoop", flagString: 1)
            self.performSelector(onMainThread: #selector(self.testPerformSelector), with: nil, waitUntilDone: false)
            printCurrentThread(filterString: "RunLoop", flagString: 3)
        }
    }
    
    @objc func testPerformSelector() {
        printCurrentThread(filterString: "RunLoop", flagString: 2)
    }
}































    /*
     打印结果为 1、3。原因是：
     1. performSelector:withObject:afterDelay: 的本质是拿到当前线程的 RunLoop 往它里面添加 timer
     2.RunLoop 和线程是一一对应关系，子线程默认没有开启 RunLoop
     3.当前 performSelector:withObject:afterDelay: 在子线程执行, 所以 2 不会打印。
     */
