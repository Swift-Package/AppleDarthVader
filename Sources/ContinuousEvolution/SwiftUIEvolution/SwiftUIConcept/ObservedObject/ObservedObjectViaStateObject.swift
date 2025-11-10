//
//  ObservedObjectViaStateObject.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/8/31.
//

// 教程来源: - DONT'T Make this MISTAKE || StateObject vs ObservedObject | What's the Difference? - AppStuff
// 教程来源: - SwiftUI State Management: StateObject vs ObservedObject with ObservableObject - Yogesh Patel

import SwiftUI

fileprivate class CounterViewModel: ObservableObject {
    
    @Published var count = 5
    
    func increaseCount() {
        count += 1
    }
    
    nonisolated(unsafe) static let shared = CounterViewModel()
}

// MARK: - ObservedObject 和 StateObject 的区别
fileprivate struct ObservedObjectViaStateObjectView: View {
    
    @State private var randomNumber = 0
    
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

// MARK: - 使用 ObservedObject 持有一个内部初始化的属性数据会被破坏
fileprivate struct ObservedObjectView: View {
    
    @ObservedObject var viewModel = CounterViewModel()      // 每次视图刷新就被破坏了
    @ObservedObject var viewModel1 = CounterViewModel.shared// 外部管理的数据源始终存在
    
    var body: some View {
        VStack {
            Text("Count: \(viewModel.count)")
            Text("Count: \(viewModel1.count)")
            Button {
                viewModel.increaseCount()
                viewModel1.increaseCount()
            } label: {
                Text("Increase @ObservedObject ViewModel Count")
            }
        }
    }
}

// MARK: - 使用 StateObject 数据不会被破坏
fileprivate struct ViaStateObjectView: View {
    
    @StateObject var viewModel = CounterViewModel()
    // ⚠️如果这个再传递给子视图,重新渲染 View 时子视图的 viewModel 依然保持之前的数据
    // 无论子视图用 @StateObject 还是 @ObservedObject 都会保留数据
    
    var body: some View {
        VStack {
            Text("Count: \(viewModel.count)")
            
            Button {
                viewModel.increaseCount()
            } label: {
                Text("Increase @StateObject ViewModel Count")
            }
            
            ViaStateObjectChildView(viewModel: viewModel)
                .padding()
                .background(.gray)
        }
    }
}

fileprivate struct ViaStateObjectChildView: View {
    
    @ObservedObject var viewModel: CounterViewModel// ⚠️子视图用 @ObservedObject 接收父视图传递过来的数据, 使用 @StateObject 也可以但是不推荐
    
    var body: some View {
        VStack {
            Text("Count: \(viewModel.count)")
            
            Button {
                viewModel.increaseCount()
            } label: {
                Text("Increase @StateObject ViewModel Count")
            }
        }
    }
}

#Preview {
    ObservedObjectViaStateObjectView()
}
