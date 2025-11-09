//
//  ObjcioBehindState.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/9.
//

import SwiftUI

// MARK: - 不使用 @State 包装器
fileprivate struct BehindState1: View {
    
    private var _value = State(initialValue: 0)
    private var value: Int {
        get { _value.wrappedValue } // wrappedValue 是交互时使用的值,可以视为指向状态属性实际值的指针
        nonmutating set { _value.wrappedValue = newValue }
    }
    
    var body: some View {
        Button("Increment\(value)") {
            value += 1
        }
    }
}

#Preview {
    BehindState1()
}

fileprivate struct ObjcioBehindState: View {
    
    let counter = Counter()
    
    var body: some View {
        VStack {
            counter
            counter
            
            // MARK: - 从外部改变属性是没有用的
            Button {
                counter.value = 100
                counter.$value.wrappedValue = 100
            } label: {
                Text("Change")
            }
        }
    }
}

fileprivate struct Counter: View {
    
    @State var value: Int
    
    init(initialValue: Int = 0) {
        _value = State(initialValue: initialValue)
    }
    
    var body: some View {
        Button("Counter\(value)") {
            value += 1
        }
    }
}

#Preview {
    ObjcioBehindState()
}
