//
//  Introduction.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/9/7.
//

import Testing
import Combine
import Foundation

nonisolated(unsafe) var subscriptions = Set<AnyCancellable>()

@Suite("1 发布者和订阅者入门指南")
struct CombineLearnTests {
    @Test("使用发布者") func subscriber() async throws {
        let myNotification = Notification.Name("MyNotification")
        let publisher = NotificationCenter.default.publisher(for: myNotification, object: nil)
        let subscription = publisher.sink { _ in
            print("通知发布 订阅者收到")
        }
        
        NotificationCenter.default.post(name: myNotification, object: nil)
        subscription.cancel()
    }

    @Test("单个值发布者Just") func just() {
        let just = Just("Hello world!")
        _ = just.sink(receiveCompletion: {
                print("完成收到单个值发布者发布的值", $0)
            }, receiveValue: { str in
                print("收到单个值发布者发布的值", str)
            })
        
        _ = just.sink(receiveCompletion: {
                print("Received completion (another)", $0)
            }, receiveValue: {
                print("Received value (another)", $0)
            })
    }

    @Test("Assign赋值KVO属性") func assign() {
        class SomeObject {
            var value: String = "" {
                didSet {
                    print(value)
                }
            }
        }
        
        let object = SomeObject()
        
        let publisher = ["Hello", "world"].publisher
        _ = publisher.assign(to: \.value, on: object)
    }

    @Test("Assign变体") func assignVariant() {
        class SomeObject {
            @Published var value = 0
        }
        
        let object = SomeObject()
        
        // 使用$访问底层发布者
        _ = object.$value.sink {
            print($0)
        }
        
        (0...10).publisher.assign(to: &object.$value)// ⚠️这个结果在Swift Testing环境下是错误的 在Playground环境下正确的输出应该是 0 0 1 2 3 4 5 6 7 8 9
        
        class MyObject {
            @Published var word: String = ""
            var subscriptions = Set<AnyCancellable>()
            
            init() {
                ["A", "B", "C"].publisher
                    .assign(to: \.word, on: self)
                    .store(in: &subscriptions)
            }
        }
        // 官方文档解释了上面的方法会导致循环引用应该使用下面的方案解决
        class MyObject1 {
            @Published var word: String = ""
            var subscriptions = Set<AnyCancellable>()
            
            init() {
                ["A", "B", "C"].publisher
                    .assign(to: &$word)
            }
        }
    }

    @Test("创建自定义订阅者") func customSubscriber() {
        final class IntSubscriber: Subscriber {
            typealias Input = Int
            typealias Failure = Never
            
            // MARK: - 订阅时最多接受三个值
            func receive(subscription: any Subscription) {
                subscription.request(.max(3))// ⚠️表示在订阅时就能接受三个值
            }
            
            func receive(_ input: Int) -> Subscribers.Demand {
                print("收到值 ", input)
                if input == 3 {// 收到3时调整订阅需求再多接受2次值
                    return .max(2)
                } else {
                    return .none// 表示在收到一次值时不调整需求不再接收值
                }
                // return .max(1)// 表示收到一次值后订阅套餐都还要再加一次(就是一直接受下一个值)
                // return .unlimited// 表示尽量给我值
            }
            
            func receive(completion: Subscribers.Completion<Never>) {
                print("收到完成事件 ", completion)
            }
        }
        
        let publisher = (1...8).publisher
        
        let sub = IntSubscriber()
        publisher.subscribe(sub)
    }

    @Test("Future") func future() async {
        // 这份代码需要在工程中进行测试
        // 工厂函数创建一个Future，指定在三秒延迟后增加您传递的整数
        func futureIncrement(integer: Int, afterDelay delay: TimeInterval) -> Future<Int, Never> {
            Future<Int, Never>.init { promise in
                print("Original")// 代码在订阅前就会打印这一行
                DispatchQueue.global().asyncAfter(wallDeadline: .now() + delay) {
                    promise(.success(integer + 1))
                }
            }
        }
        
        let future = futureIncrement(integer: 1, afterDelay: 3)
        future.sink {
            print($0)
        } receiveValue: {
            print($0)
        }.store(in: &subscriptions)
        
        future
          .sink(receiveCompletion: { print("Second", $0) },
                receiveValue: { print("Second", $0) })
          .store(in: &subscriptions)
    }
    // ——— Example of: Future ———
    // Original
    // 2
    // finished
    // Second 2
    // Second finished
    // 在指定的延迟后，第二个订阅会收到相同的值
    // Future 不会重新执行其 Promise 而是共享或重放其输出
    // 代码会Original在订阅发生之前立即打印这是因为 Future 是贪婪的,也就是说一旦创建就会立即执行,不像普通的惰性发布者那样需要订阅者
}
