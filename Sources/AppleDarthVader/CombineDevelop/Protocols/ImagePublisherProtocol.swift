//
//  ImagePublisherProtocol.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import Combine
import UIKit

public protocol ImagePublisher {
    func imagePublisher() -> AnyPublisher<UIImage?, Never>
}
