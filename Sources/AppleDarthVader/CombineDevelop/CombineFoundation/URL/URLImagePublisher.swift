//
//  URLImagePublisher.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import Combine
import UIKit

extension URL: ImagePublisher {
    /// 通过URL生成图片发布者
    /// - Returns: 图片发布者
    public func imagePublisher() -> AnyPublisher<UIImage?, Never> {
        URLSession.shared.dataTaskPublisher(for: self)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
