#  <#Title#>



更加平易近人的 Concurrency默认使用 @MainActor，减少显式的 isolation 标记更加直观的 async 函数，默认在 caller 的上下文里执行，让 class 类型里可以用更简洁直观的方式去实现没有数据竞争的逻辑新增 @concurrent 函数注解，把任务派发到全局任务池前两个功能都是可以手动开启和关闭的，由于前面两个功能开启后，非 actor 环境下的 async 函数全部都会派发到 @MainActor 执行，导致主线程负载变大，所以新增 @concurrent 可以制定任务派发到全局线程。这几套组合拳下来大大加强了 Concurrency 的易用性
