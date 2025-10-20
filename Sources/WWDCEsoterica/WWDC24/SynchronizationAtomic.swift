//
//  SynchronizationAtomic.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/10/18.
//

import UIKit
import Synchronization

fileprivate class ViewController: UIViewController {
    
    let counter = Atomic<Int>(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.concurrentPerform(iterations: 10) { _ in
            for _ in 0..<1_000_000 {
                counter.wrappingAdd(1, ordering: .relaxed)
            }
        }
        
        print(counter.load(ordering: .relaxed))
    }
}

final class LockingResourceManager: Sendable {
    
    let cache = Mutex<[String: Int]>([:])
    
    func save(_ number: Int, as key: String) {
        cache.withLock { cache in
            cache[key] = number
        }
    }
}
