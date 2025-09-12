//
//  ForLoopTipsView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/9/7.
//

// So You Think You Know Swift? - Nick Lockwood - https://www.youtube.com/watch?v=smkRzwANNQ8

import SwiftUI

struct ForLoopTipsView: View {
    
    let strings = ["Apple", "", "Vader"]
    let optStrings = ["Darth", nil, "Apple"]
    let values: [Any] = ["A", 42, "B", 3.14, "C"]
    
    var body: some View {
        VStack {
            Text("Hello Apple")
        }
        .onAppear {
            for string in strings where !string.isEmpty {
                print(string)
            }
        }
        .onAppear {
            for case let string? in optStrings {
                print(string)
            }
        }
        .onAppear {
            for case let string as String in values {
                print(string)
            }
        }
    }
}

#Preview {
    ForLoopTipsView()
}
