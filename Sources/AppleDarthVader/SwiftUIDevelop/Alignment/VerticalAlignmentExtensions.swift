//
//  VerticalAlignmentExtensions.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/8/17.
//

// WWDC19 - 利用 SwiftUI 构建自定视图 - 不同容器之间元素对齐

import SwiftUI

public extension VerticalAlignment {
    enum MidStarAndTitle: AlignmentID {
        public static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.bottom]
        }
    }
    
    static let midStarAndTitle = VerticalAlignment(MidStarAndTitle.self)
}

struct VerticalAlignmentExtensionsView: View {
    var body: some View {
        List {
            HStack(alignment: .midStarAndTitle) {
                VStack {
                    Text("⭐️⭐️⭐️⭐️⭐️")
                        .alignmentGuide(.midStarAndTitle) { dimensions in
                            dimensions[.bottom] / 2
                        }
                    Text("5 Stars")
                }.font(.caption)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Avocado Toast")
                            .font(.title)
                            .alignmentGuide(.midStarAndTitle) { dimensions in
                                dimensions[.bottom] / 2
                            }
                        Spacer()
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.red)
                            .frame(width: 20, height: 20)
                    }
                    Text("Ingredients: Avocado, Almond Butter, Bread")
                        .font(.caption)
                        .lineLimit(1)
                }
            }
        }
    }
}

// MARK: - 现在这个MidStarAndTitle扩展好像已经没有用了SwiftUI可能已经修改了元素对齐的行为了 - 2025年8月17日于深圳固戍实验
struct VerticalAlignmentExtensionsView1: View {
    var body: some View {
        List {
            HStack {
                VStack {
                    Text("⭐️⭐️⭐️⭐️⭐️")
                    Text("5 Stars")
                }.font(.caption)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Avocado Toast")
                            .font(.title)
                        Spacer()
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.red)
                            .frame(width: 20, height: 20)
                    }
                    Text("Ingredients: Avocado, Almond Butter, Bread")
                        .font(.caption)
                        .lineLimit(1)
                }
            }
        }
    }
}

#Preview {
    VerticalAlignmentExtensionsView()
    VerticalAlignmentExtensionsView1()
}
