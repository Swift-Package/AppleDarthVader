//
//  ObjectWillChangeView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/9/6.
//

// Swift 5.9 @Observation - https://www.youtube.com/watch?v=vcP6NxixziY

import SwiftUI

private class Counter: ObservableObject {
    // @Published var count = 0
    var count = 0

    func countUp() {
        count += 1
        objectWillChange.send() // 不使用 @Published 时需要手动发送通知
    }

    func countReset() {
        count = 0
        objectWillChange.send()
    }
}

struct ObjectWillChangeView: View {
    @StateObject private var counter = Counter()

    var body: some View {
        VStack {
            Text(counter.count.description)
            Button {
                counter.countUp()
            } label: {
                Text("Count Up")
            }

            Button {
                counter.countReset()
            } label: {
                Text("Count Reset")
            }
        }
    }
}

#Preview {
    ObjectWillChangeView()
}
