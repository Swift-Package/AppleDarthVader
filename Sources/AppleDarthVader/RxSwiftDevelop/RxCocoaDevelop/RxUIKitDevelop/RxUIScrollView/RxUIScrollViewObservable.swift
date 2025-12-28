//
//  RxUIScrollViewObservable.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import UIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: UIScrollView {
    var xOffset: Observable<CGFloat> {
        return contentOffset.map { $0.x }
    }
}
