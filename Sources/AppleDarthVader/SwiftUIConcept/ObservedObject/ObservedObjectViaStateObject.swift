//
//  ObservedObjectViaStateObject.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/8/31.
//

import SwiftUI

class CounterViewModel: ObservableObject {
    
    @Published var count = 5
    
    func increaseCount() {
        count += 1
    }
}

// MARK: - ObservedObject 和 StateObject 的区别
struct ObservedObjectViaStateObjectView: View {
    
    @State var randomNumber = 0
    
    var body: some View {
        VStack {
            VStack {
                Text("RandomNumber \(randomNumber)")
                
                Button {
                    randomNumber = (1...100).randomElement()!
                } label: {
                    Text("改变 State 刷新整个视图")
                }
            }
            
            ObservedObjectView()
                .padding()
            
            
            ViaStateObjectView()
                .padding()
        }
    }
}

// MARK: - 使用ObservedObject
struct ObservedObjectView: View {
    
    @ObservedObject var viewModel = CounterViewModel()
    
    var body: some View {
        VStack {
            Text("Count: \(viewModel.count)")
            
            Button {
                viewModel.increaseCount()
            } label: {
                Text("Increase ViewModel Count")
            }
        }
    }
}

// MARK: - 使用StateObject 数据不会被破坏
struct ViaStateObjectView: View {
    
    @StateObject var viewModel = CounterViewModel()// ⚠️如果这个再传递给子视图,重新渲染View时子视图的viewModel依然保持之前的数据,无论子视图用 @StateObject 还是 @ObservedObject 都会保留数据
    
    var body: some View {
        VStack {
            Text("Count: \(viewModel.count)")
            
            Button {
                viewModel.increaseCount()
            } label: {
                Text("Increase ViewModel Count")
            }
        }
    }
}

#Preview {
    ObservedObjectViaStateObjectView()
}
