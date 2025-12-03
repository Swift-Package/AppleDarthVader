//
//  ObservableWithStateView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/12/2.
//

// 教程来源:在 SwiftUI 层级结构中初始化 @Observable 类 - https://nilcoalescing.com/blog/InitializingObservableClassesWithinTheSwiftUIHierarchy/

import SwiftUI

// 即使我们只是将可观察类赋值给视图结构体中的一个存储属性 SwiftUI 会在这些属性发生变化时自动刷新所有依赖于这些属性的视图
// 正因如此我们可能不太容易理解为什么需要将模型存储在视图结构体中 @State
@Observable
fileprivate class DataModel {
	var count = 0
	
	init() {
		print("DataModel initialized")
	}
}

fileprivate struct ObservableWithStateView: View {
	
	private let dataModel = DataModel()
	
    var body: some View {
		VStack { 
			Text(verbatim: "\(dataModel.count)")
			
			Button { 
				dataModel.count += 1
			} label: { 
				Text(verbatim: "Increment")
			}
			.font(.title2)
			.buttonStyle(.borderedProminent)
		}
    }
}

#Preview {
	ObservableWithStateView()
}

// MARK: - 视图刷新丢失状态
fileprivate struct LostStateView: View {
	
	@State private var tint = Color.accentColor
	
	var body: some View {
		NavigationStack { 
			LostStateCountView()
				.tint(tint)
				.toolbar { 
					ColorPicker("Tint Color", selection: $tint)// 每次色调颜色改变时导致 body 重建并且 dataModel 重新创建导致状态丢失
						.labelsHidden()
				}
		}
	}
}

fileprivate struct LostStateCountView: View {
	
	private let dataModel = DataModel()
	
	var body: some View {
		VStack(spacing: 16) {
			Text(verbatim: "计数器状态将在切换颜色后丢失")
			Text(verbatim: "\(dataModel.count)")
			
			Button { 
				dataModel.count += 1
			} label: { 
				Text(verbatim: "Increment")
			}
			.font(.title2)
			.buttonStyle(.borderedProminent)
		}
	}
}

#Preview("视图刷新丢失状态") {
	LostStateView()
}

// MARK: - 使用 @State 保留状态
fileprivate struct StateView: View {
	
	@State private var tint = Color.accentColor
	
	var body: some View {
		NavigationStack { 
			StateCountView()
				.tint(tint)
				.toolbar { 
					ColorPicker("Tint Color", selection: $tint)
						.labelsHidden()
				}
		}
	}
}

fileprivate struct StateCountView: View {
	
	@State private var dataModel = DataModel()
	
	var body: some View {
		VStack(spacing: 16) {
			Text(verbatim: "计数器状态一直保持")
			Text(verbatim: "\(dataModel.count)")
			
			Button { 
				dataModel.count += 1
			} label: { 
				Text(verbatim: "Increment")
			}
			.font(.title2)
			.buttonStyle(.borderedProminent)
		}
	}
}

#Preview("视图刷新记住状态") {
	StateView()
}

// MARK: - 关于初始化
// 在决定何时何地执行可观察类初始化时需要记住的一点是即使模型的状态在视图结构重新创建时会保持不变（当它被初始化为状态属性的默认值时）
// 但每次视图初始化器运行时仍然会调用模型的初始化器
// 当 tint 改变时 body 重新计算导致 StateCountView 初始化器被调用 DataModel 初始化方法也被调用
// 这一点需要牢记因为 @Observable类初始化器中的任何繁重逻辑都可能多次运行降低应用程序性能,因为 SwiftUI 依赖于视图初始化器非常便宜
// 如果我们的可观察类初始化逻辑不够快速和简单我们可以将该工作移至任务修改器中从而推迟创建模型

// MARK: - 使用 @State 保留状态并延迟初始化
fileprivate struct LazyStateView: View {
	
	@State private var tint = Color.accentColor
	
	var body: some View {
		NavigationStack { 
			LazyStateCountView()
				.tint(tint)
				.toolbar { 
					ColorPicker("Tint Color", selection: $tint)
						.labelsHidden()
				}
		}
	}
}

fileprivate struct LazyStateCountView: View {
	
	@State private var dataModel: DataModel?
	
	var body: some View {
		VStack(spacing: 16) {
			Text(verbatim: "计数器状态一直保持")
			Text(verbatim: "\(dataModel?.count, default: "0")")
			
			Button { 
				dataModel?.count += 1
			} label: { 
				Text(verbatim: "Increment")
			}
			.font(.title2)
			.buttonStyle(.borderedProminent)
		}
		.task {
			dataModel = DataModel()
		}
	}
}

#Preview("使用 @State 保留状态并延迟初始化仅仅初始化一次") {
	LazyStateView()
}

// MARK: - task id
@Observable
fileprivate class DataModelID {
	
	var text: String
	
	init(id: UUID) {
		text = "ID: \(id)"
		print("DataModel initialized for id: (\(text)")
	}
}

fileprivate struct LazyIDStateView: View {
	
	@State private var id = UUID()
	
	var body: some View {
		NavigationStack { 
			IDView(id: id)
				.toolbar { 
					Button { 
						id = UUID()
					} label: {
						Image(systemName: "arrow.trianglehead.2.clockwise")
					}
				}
		}
	}
}

fileprivate struct IDView: View {
	
	let id: UUID
	@State private var dataModel: DataModelID?
	
	var body: some View {
		Text(dataModel?.text ?? "")
			.task(id: id) { 
				dataModel = DataModelID(id: id)
			}
	}
}

#Preview("task id") {
	LazyIDStateView()
}

// 延迟创建可观察模型还可以让我们根据传递给视图的值对其进行配置
// 但重要的是要使用task()带有id参数的修饰符以便在该值更改时任务重新运行

// MARK: - 初始化 App 结构体中的可观察状态
// 需要注意的是在 WindowGroup 场景视图中初始化的状态仅限于该场景,在支持多场景的设备上每个窗口都会获得一份全新的状态副本
// 如果我们想要在所有场景之间共享状态可以在App结构体中初始化可观察模型然后将其传递给场景环境
// 这样每个场景都将读写同一个共享状态。这对于应用程序范围的数据来说是一个不错的选择，但对于场景特定的状态（例如选择或导航）则不适用
// 即使 App 结构体初始化器应该在每个应用程序生命周期中只运行一次但最好还是用 @State 来标记可观察模型或者至少用 static 声明将其设为单例以 100% 确保它不会在任何意外情况下被重置
// 如果我们想要延迟应用程序全局状态的初始化就不能像设置视图状态那样简单地通过 task 修饰符来赋值
// 附加到根视图的任务会在每个场景中运行一次而不是在每次应用程序启动时运行一次
// 为了确保状态只初始化一次我们需要一个额外的标志或其他机制来保护初始化过程

@Observable
fileprivate class AppDataModel {
	var count = 0
}

fileprivate struct ObservableExampleApp: App {
	
	@State private var dataModel = AppDataModel()
	
	var body: some Scene {
		WindowGroup {
			ContentView()
				.environment(dataModel)
		}
	}
}

fileprivate struct ContentView: View {
	var body: some View {
		CountView()
	}
}

fileprivate struct CountView: View {
	
	@Environment(AppDataModel.self) private var dataModel
	
	var body: some View {
		VStack(spacing: 30) {
			Text("Count: \(dataModel.count)")
				.font(.title)
			
			Button("Increment") {
				dataModel.count += 1
			}
			.font(.title2)
			.buttonStyle(.borderedProminent)
		}
	}
}
