//
//  AlternateLayoutView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/9/16.
//

// MARK: - 要看懂这个项目先查看 - AnyLayoutView 项目

import SwiftUI

// MARK: - 自定义交错布局
struct AlternateStackLayout: Layout {
    // MARK: - 报告复合布局视图的大小
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        guard !subviews.isEmpty else { return .zero }
        let subviewSizes = subviews.map { $0.sizeThatFits(.unspecified) }// 获取所有子视图的建议尺寸
        let allWidths = subviewSizes.map { $0.width }
        
        // 偶数列最大宽度
        let evenWidthMax = allWidths.enumerated()
            .filter { $0.0.isMultiple(of: 2) }// 只要偶数
            .map { $0.1 }                     // 偶数列宽度
            .max()
        
        // 奇数列最大宽度
        let oddWidthMax = allWidths.enumerated()
            .filter { !$0.0.isMultiple(of: 2) }// 只要奇数
            .map { $0.1 }                     // 奇数列宽度
            .max()
        
        
        let totalHeight = subviewSizes.map { $0.height }.reduce(0, +)
        
        // 因为有可能只有一个子视图所以第二个不能强制解包
        return CGSize(width: evenWidthMax! + (oddWidthMax ?? 0), height: totalHeight)
    }
    
    // MARK: - 为容器的子视图分配位置
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        guard !subviews.isEmpty else { return }
        let subviewSizes = subviews.map { $0.sizeThatFits(.unspecified) }// 获取所有子视图的建议尺寸
        let allWidths = subviewSizes.map { $0.width }
        
        // 偶数列最大宽度
        let evenWidthMax = allWidths.enumerated()
            .filter { $0.0.isMultiple(of: 2) }// 只要偶数
            .map { $0.1 }                     // 偶数列宽度
            .max()
        
        let evenX = bounds.minX
        let oddX = bounds.minX + evenWidthMax!
        var y = bounds.minY
        
        for (index, subview) in subviews.enumerated() {
            let subviewSize = subviewSizes[index]
            let proposedSize = ProposedViewSize(width: subviewSize.width, height: subviewSize.height)
            
            if index.isMultiple(of: 2) {
                subview.place(at: .init(x: evenX, y: y), anchor: .topLeading, proposal: proposedSize)
            } else {
                subview.place(at: .init(x: oddX, y: y), anchor: .topLeading, proposal: proposedSize)
            }
            
            y += subviewSize.height
        }
    }
}
