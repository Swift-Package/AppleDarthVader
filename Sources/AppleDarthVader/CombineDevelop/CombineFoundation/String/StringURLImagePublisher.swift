//
//  StringURLImagePublisher.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import Combine
import UIKit

extension String: ImagePublisher {
    /// 通过字符串生成图片发布者
    /// - Returns: 图片发布者 "name".imagePublisher().assign(to: \.image, on: UIImageView.init()).store(in: &cancellables)
    public func imagePublisher() -> AnyPublisher<UIImage?, Never> {
        if let url = URL(string: self), url.scheme == "https" {
            return url.imagePublisher()
        } else {
            return Just(UIImage(named: self)).eraseToAnyPublisher()
        }
    }
}
