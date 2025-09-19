//
//  AnyLayoutView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/9/16.
//

// AnyLayout and Custom Layouts in iOS 16 - https://www.youtube.com/watch?v=WD7ebJZ7PaI
// Composing custom layouts with SwiftUI - Xcode 官方文档

import SwiftUI

// MARK: - 展示的色块数据
struct MyColors {
    
    var color: Color
    var width: CGFloat
    var height: CGFloat
    
    static var allColors: [MyColors] {
        [
            .init(color: .red, width: 60, height: 75),
            .init(color: .teal, width: 100, height: 100),
            .init(color: .purple, width: 40, height: 80),
            .init(color: .indigo, width: 120, height: 100),
        ]
    }
}

// MARK: - 三种不同的布局枚举
enum LayoutType: Int, CaseIterable {
    
    case hStack
    case vStack
    case zStack
    case altStack
    
    var index: Int {
        LayoutType.allCases.firstIndex(where: { $0 == self })!
    }
    
    var layout: any Layout {
        switch self {
        case .hStack:
            return HStackLayout(alignment: .top, spacing: 0)
        case .vStack:
            return VStackLayout(alignment: .trailing)
        case .zStack:
            return ZStackLayout(alignment: .center)
        case .altStack:
            return AlternateStackLayout()
        }
    }
}

struct AnyLayoutView: View {
    
    @State private var layoutType = LayoutType.hStack
    
    var body: some View {
        let layout = AnyLayout(layoutType.layout)
        NavigationStack {
            layout {
                ForEach(MyColors.allColors, id:\.color) { mycolor in
                    mycolor.color
                        .frame(width: mycolor.width, height: mycolor.height)
                    
                }
            }
            .padding()
            .navigationTitle("AnyLayout")
            .animation(.default, value: layoutType)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if layoutType.index < LayoutType.allCases.count - 1 {
                            layoutType = LayoutType.allCases[layoutType.index + 1]
                        } else {
                            layoutType = LayoutType.allCases[0]
                        }
                    } label: {
                        Image(systemName: "circle.grid.3x3.circle.fill")
                    }
                }
            }
        }
    }
}

#Preview {
    AnyLayoutView()
}
