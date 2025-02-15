//
//  CustomUITableViewCell.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/5.
//

import UIKit

class CustomUITableViewCell: UITableViewCell {
    @available(*, unavailable)
    required init?(coder _: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        accessoryType = .disclosureIndicator
        layoutSubviews()
        contentView.setNeedsUpdateConstraints()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let _: CGFloat = traitCollection.userInterfaceIdiom == .pad ? 1 / 8 : 1 / 4
    }

    override func updateConstraints() {
        super.updateConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
