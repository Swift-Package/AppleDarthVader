//
//  UIImageAsync.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import UIKit

public extension UIImage {
    // 该扩展来自WWDC21 认识Swift中的async/await
    @available(iOS 15.0, *)
    var thumbnail: UIImage? {
        get async {
            await byPreparingThumbnail(ofSize: .init(width: 40, height: 40))
        }
    }
}
