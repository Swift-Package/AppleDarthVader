//
//  RxUICollectionViewParallax.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

// https://www.youtube.com/watch?v=mLXfpg0h_HU Stefano Mondino - RxSwift for UI

import RxCocoa
import RxSwift
import UIKit

/// UICollectionView仿微信朋友圈首页背景推动视差效果
extension Reactive where Base: UICollectionView {
    func scrollToIndexPath(animated: Bool = true) -> Binder<IndexPath> {
        return Binder(base) { base, indexPath in
            base.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
        }
    }

    func parallax(amount: CGFloat = 3.4) -> Observable<CGFloat> {
        return base.rx.contentOffset.map { -$0.y / amount }.map { min(0, $0) }
    }

    func bindParallax(top: NSLayoutConstraint, height: NSLayoutConstraint) -> Disposable {
        let h = height.constant
        let offset = base.rx.contentOffset.map { -$0.y }
        return Disposables.create(offset.map { min(0, $0 / 3.0) }.bind(to: top.rx.constant), offset.map { max(h, $0 + h) }.bind(to: height.rx.constant))
    }
}
