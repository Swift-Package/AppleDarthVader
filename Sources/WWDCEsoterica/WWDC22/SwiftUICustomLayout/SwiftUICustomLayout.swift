//
//  SwiftUICustomLayout.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/9/7.
//

import SwiftUI

struct Pet: Identifiable, Equatable {
    let type: String
    var votes: Int = 0
    var id: String { type }
    
    nonisolated(unsafe) static var exampleData: [Pet] = [
        Pet(type: "Cat", votes: 25),
        Pet(type: "Goldfish", votes: 9),
        Pet(type: "Dog", votes: 16),
    ]
}

struct SwiftUICustomLayout: View {
    
    let totalVotes = 50
    
    @State private var pets = Pet.exampleData
    
    var body: some View {
        Grid(alignment: .leading) {
            ForEach(pets) { pet in
                GridRow {
                    Text(pet.type)
                    ProgressView(value: Double(pet.votes), total: Double(totalVotes))
                    Text("\(pet.votes)")
                        .gridColumnAlignment(.trailing)
                }
                // Divider() // 可以用这一行替换下面的3行代码
                GridRow {
                    Divider().gridCellColumns(3)// 跨越多列的分割线
                }
            }
            
            HStack {
                Text("Delicious").font(.caption)
                Image("20x20_avocado").alignmentGuide(.lastTextBaseline) { dimensions in
                    dimensions[.bottom] * 0.926
                }
                Text("Avocado Toast").layoutPriority(1)
            }
        }
    }
}

#Preview {
    SwiftUICustomLayout()
}
