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
