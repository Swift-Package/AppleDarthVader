# 🌈 ConcurrencyEvolution     关于 Swift 并发特性进化



更加平易近人的 Concurrency 默认使用 @MainActor，减少显式的 isolation 标记
更加直观的 async 函数默认在 caller 的上下文里执行让 class 类型里可以用更简洁直观的方式去实现没有数据竞争的逻辑
新增 @concurrent 函数注解把任务派发到全局任务池前两个功能都是可以手动开启和关闭的
由于前面两个功能开启后非 actor 环境下的 async 函数全部都会派发到 @MainActor 执行导致主线程负载变大
所以新增 @concurrent 可以制定任务派发到全局线程






# 🌈 Swift 并发编程实战手册
## 0.Swift 中的 MainActor 用法				https://www.avanderlee.com/swift/mainactor-dispatch-main-thread/
## Swift 6.2 中易于上手的并发编程			https://www.avanderlee.com/concurrency/approachable-concurrency-in-swift-6-2-a-clear-guide/
## Swift 中的 async/await 详解及代码示例	https://www.avanderlee.com/swift/async-await/
##
##

