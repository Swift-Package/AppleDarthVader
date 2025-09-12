//
//  PureCLibraryTests.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/9/7.
//

import Testing
@testable import PureCLibrary

struct PureCLibraryTests {
    
    class A {
        
        var pr = 0
        
        func callCAdd() {
            pr = Int(add(12, 12))
        }
    }

    @Test func example() {
        let a = A.init()
        a.callCAdd()
        
        print("调用C函数相加 12 + 12 = " + "\(a.pr)")
    }
}
