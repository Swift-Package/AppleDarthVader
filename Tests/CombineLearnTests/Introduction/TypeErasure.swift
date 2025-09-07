//
//  TypeErasure.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/9/7.
//

import Testing
import Combine

struct TypeErasure {
    @Test("类型擦除") func typeErasure() {
        let subject = PassthroughSubject<Int, Never>()
        let publisher = subject.eraseToAnyPublisher()
        
        publisher
            .sink(receiveValue: { print($0) })
            .store(in: &subscriptions)
        
        subject.send(0)
    }
}
// 您想要为发布者使用类型擦除的一个例子是，您想要使用一对公共和私有属性，允许这些属性的所有者在私有发布者上发送值
// 并允许外部调用者仅访问公共发布者进行订阅但不能发送值
