//
//  Subject.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/9/7.
//

import Combine
import Testing

// MARK: - Subject - 使非 Combine 命令式代码能够将值发送给 Combine 订阅者

@Suite("2 Subject主题入门指南")
struct Subject {
    @Test("PassthroughSubject") func passthroughSubject() async throws {
        enum MyError: Error {
            case test
        }

        // MARK: - 自定义订阅者

        final class StringSubscriber: Subscriber {
            typealias Input = String
            typealias Failure = MyError

            func receive(subscription: any Subscription) {
                subscription.request(.max(2))
            }

            func receive(_ input: String) -> Subscribers.Demand {
                print("收到值 ", input)
                return input == "World" ? .max(1) : .none // 收到World时设置新的最大值为3因为原始为2
            }

            func receive(completion: Subscribers.Completion<MyError>) {
                print("收到完成事件", completion)
            }
        }

        let subscriber = StringSubscriber()

        let subject = PassthroughSubject<String, MyError>()

        // 创建自定义订阅者的订阅
        subject.subscribe(subscriber)

        // 创建另一个普通订阅
        let subscription = subject.sink { completion in
            print("sink收到完成事件 ", completion)
        } receiveValue: { value in
            print("sink收到值 ", value)
        }

        subject.send("Hello")
        subject.send("World")

        // 取消普通订阅
        subscription.cancel()

        subject.send("订阅还在吗?")

        subject.send(completion: .failure(MyError.test))

        subject.send(completion: .finished)

        subject.send("最后的值")
    }

    @Test("CurrentValueSubject - 在命令式代码中查看发布者的当前值") func currentValueSubject() {
        var subscriptions = Set<AnyCancellable>()

        let subject = CurrentValueSubject<Int, Never>(0)
        subject.sink(receiveValue: { print("sink \($0)") })
            .store(in: &subscriptions)

        subject.send(1)
        subject.send(2)

        print(subject.value)

        subject.value = 3
        print(subject.value)
    }

    @Test("动态调整需求") func dynamically() {
        final class IntSubscriber: Subscriber {
            typealias Input = Int
            typealias Failure = Never

            func receive(subscription: any Subscription) {
                subscription.request(.max(2))
            }

            func receive(_ input: Int) -> Subscribers.Demand {
                print("自定义订阅者收到值 \(input)")
                switch input {
                case 1:
                    return .max(2) // 收到1时最初2加上2 得到4
                case 3:
                    return .max(1) // 收到3时4加上1 得到5
                default:
                    return .none
                }
            }

            func receive(completion: Subscribers.Completion<Never>) {
                print("自定义订阅者收到完成事件 \(completion)")
            }
        }

        let subscriber = IntSubscriber()

        let subject = PassthroughSubject<Int, Never>()
        subject.subscribe(subscriber)

        subject.send(1)
        subject.send(2)
        subject.send(3)
        subject.send(4)
        subject.send(5)
        subject.send(6)
    }
}
