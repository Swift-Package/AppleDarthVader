//
//  ObjcioOnAppearView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/9.
//

import SwiftUI

fileprivate struct ObjcioOnAppearView: View {
    var body: some View {
        TabView {
            Tab {
                Text("Tab1")
                    .onAppear {
                        print("Tab1")
                    }
                    .onDisappear {
                        print("Tab1 dis")
                    }
            } label: {
                Text("Tab1")
            }
            Tab {
                Text("Tab2")
                    .onAppear {
                        print("Tab2")
                    }
                    .onDisappear {
                        print("Tab2 dis")
                    }
            } label: {
                Text("Tab2")
            }

            Tab {
                Text("Tab3")
                    .onAppear {
                        print("Tab3")
                    }
                    .onDisappear {
                        print("Tab3 dis")
                    }
            } label: {
                Text("Tab3")
            }
        }
    }
}

#Preview {
    ObjcioOnAppearView()
}

// MARK: - onAppear 注意事项
// onAppear 在每次视图出现在屏幕上时执⾏,即使渲染树中的对应节点从未消失这个钩⼦⽅法也可以对⼀个视图进⾏多次调⽤
// ⽐如在 LazyVStack 或 List 中的视图重复地滚动离开屏幕然后再回来时每次 onAppear 都会被调⽤
// 在 TabView 中切换 tab 时也是如此不仅仅是第⼀次显示某个 tab ⽽是每次切换到某个 tab 时它的 onAppear 都会被调⽤
// onDisappear 在视图从屏幕上消失时执⾏,它和 onAppear 是对应关系使⽤同样的规则
// 就算背后的节点没有消失这个⽅法也可能会被多次调⽤
// task 是前⾯两者与异步操作的结合,这个修饰器在 onAppear 会被调⽤的时间点创建⼀个新的异步任务 task 并在 onDisappear 将被调⽤的时候取消这个任务
