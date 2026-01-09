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

	@Test func testParseBuffer() {
		var bytes: [Int8] = [0, 1, -1, 127, -128]
		
		bytes.withUnsafeMutableBufferPointer { buf in
			parse_buffer(buf.baseAddress, buf.count)
		}
		
		#expect(bytes == [1, 2, 0, -128, -127])
		
		var bytes1: [Int8] = [0, 1, 2, 3, 4]
		
		bytes1.withUnsafeMutableBufferPointer { buf in
			parse_buffer(buf.baseAddress, buf.count)
		}
		
		#expect(bytes1 == [1, 2, 3, 4, 5])
	}
}
