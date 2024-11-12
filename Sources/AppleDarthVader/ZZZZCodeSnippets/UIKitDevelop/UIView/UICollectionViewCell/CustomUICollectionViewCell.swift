//
//  CustomUICollectionViewCell.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/5.
//

import UIKit

class CustomUICollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "CustomUICollectionViewCellIdentifier"
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - UI元素
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        // contentView.addSubview(bookCoverView)

        layoutSubviews()
        contentView.setNeedsUpdateConstraints()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let imageWidthRatio: CGFloat = traitCollection.userInterfaceIdiom == .pad ? 1 / 8 : 1 / 4

        NSLayoutConstraint.activate([
        ])
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            
        ])
        
        super.updateConstraints()
    }
}
