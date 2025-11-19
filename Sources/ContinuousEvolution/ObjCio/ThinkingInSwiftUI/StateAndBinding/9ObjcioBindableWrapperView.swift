//
//  ObjcioBindableWrapperView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/10.
//

import SwiftUI

// MARK: - Bindable 属性包装器要解决的问题
// SwiftUI 的基于宏的对象观察模型在绑定⽅⾯提出了⼀个挑战
// ⽤于构建绑定的 $ 语法依赖于属性包装器的 projectedValue 值
// 由于在使⽤ @Observable 宏时通常不再需要使⽤属性包装器因此我们⽆法像使⽤ @ObservedObject 属性包装器时那样以相同的⽅式创建绑定
// 为了解决这个问题，SwiftUI 引⼊了 Bindable 包装器，你可以将它作为属性包装器使⽤也可以直接以内联的⽅式使⽤
// 例如作为属性包装器使⽤时

// MARK: - 使用 ObservedObject 包装器并使用 $ 绑定
fileprivate final class OldModel: ObservableObject {
	@Published var value = 0
}

fileprivate struct OldCounter: View {
	
	@ObservedObject var model: OldModel
	
	var body: some View {
		Stepper("\(model.value)", value: $model.value)
	}
}

#Preview("使用 ObservedObject 包装器并使用 $ 绑定") {
	@Previewable @State var model = OldModel()
	OldCounter(model: model)
}

// MARK: - 使用 Observable 宏后的旧绑定包装器不可用
@Observable
fileprivate final class OModel {
	var value = 0
}

fileprivate struct OCounter: View {
	
	// 不可用 因为需要符合 ObservableObject 才可以使用这个包装器器
	// @ObservedObject var model: OModel
	@State var model: OModel
	
	var body: some View {
		Stepper("\(model.value)", value: $model.value)
	}
}

#Preview("Observable 宏结合 State 包装器,但是这种方式并不推荐") {
	@Previewable @State var model = OModel()
	OCounter(model: model)
}

fileprivate struct OldFatelCounter: View {
	
	@Binding var model: OldModel
	
	var body: some View {
		Stepper("\(model.value)", value: $model.value)
	}
}

#Preview("使用旧的 Binding 包装器不可用") {
	@Previewable @State var model = OldModel()
	OldFatelCounter(model: $model)
}


fileprivate struct CounterX: View {
	
	@Bindable var model: OModel
	
	var body: some View {
		Stepper("\(model.value)", value: $model.value)
	}
}

#Preview("使用新的 Bindable 包装器") {
	CounterX(model: OModel())
}

@Observable
fileprivate final class Model {
	
	nonisolated(unsafe) static let shared = Model()
	
	var value = 0
}

fileprivate struct Counter: View {
	
	@Bindable var model: Model
	
	var body: some View {
		Stepper("\(model.value)", value: $model.value)
	}
}

#Preview {
	Counter(model: Model.shared)
}

fileprivate struct ContentView: View {
	
	var model = Model.shared
	
	var body: some View {
		Stepper("\(model.value)", value: Bindable(model).value)
	}
}

#Preview("ContentView") {
	ContentView()
}

fileprivate struct CounterSugar: View {
	
	var model: Model { _model.wrappedValue }
	var _model: Bindable<Model>
	
	init(model: Model) {
		_model = Bindable(wrappedValue: model)
	}
	var body: some View {
		Stepper("\(model.value)", value: _model.projectedValue[dynamicMember: \.value])
	}
}

#Preview("CounterSugar") {
	CounterSugar(model: Model.shared)
}
