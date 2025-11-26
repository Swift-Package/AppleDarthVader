//
//  ObjCioEnvironmentAnnouncementsView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/26.
//

import SwiftUI

@Observable
final class UserModel {
	var name: String = ""
}

fileprivate struct ObjCioEnvironmentAnnouncementsView: View {
	
	// @Environment var userModel: UserModel?
	
    var body: some View {
		
    }
}

#Preview {
	ObjCioEnvironmentAnnouncementsView()
}

// 在 iOS 17 中环境对象都应该使⽤新的 @Observable 宏并且对应的属性应该使⽤我们在本章中⼀直使⽤的 @Environment 属性包装器进⾏声明
// 唯⼀的区别是我们可以使⽤环境对象的类型作为键⽽⽆需声明⼀个单独的键类型来遵守 EnvironmentKey 协议
// 我们还可以将环境对象的属性声明为⾮可选类型,在这种情况下我们必须保证环境中存在该对象,否则当我们尝试访问环境属性时应⽤程序将崩溃
// 使⽤对象的类型作为环境键⾮常⽅便但并不是绝对必要的
// 我们还可以像在本章前⾯所做的那样定义⼀个环境键并使⽤此显式键将对象传递到视图树中
// 如果我们想要针对 iOS 17 之前的平台我们必须使⽤两个不同的API
// @EnvironmentObject 属性包装器⽤于从环境中读取对象，⽽ environmentObject 修饰器⽤于将对象设置在环境中,这些API也依赖于对象的类型作为键
// 但是对象必须遵循 ObservableObject 协议,就像状态对象或观察对象⼀样
// 当使⽤ @EnvironmentObject 时没有办法将属性声明为可选类型
// 如果在环境中没有设置过指定类型的对象，当我们访问 @EnvironmentObject 属性时代码将会崩溃
// MARK: - 统一依赖注入点
// ⼀个有⽤的技巧是将所有的环境对象设置器⾄少捆绑到⼀个单独的辅助⽅法中
//extension View {
//	func injectDependencies() -> some View {
//		environmentObject(UserModel())
//			.environmentObject(Database())
//	}
//}
// 我们不仅可以在 app 的根视图上使⽤这个辅助⽅法也可以将所有依赖项注⼊到预览中同时仍然能够在本地对依赖项进⾏覆盖
// #Preview {
//		Nested()
//			.environmentObject(UserModel.mock())
//			.injectDependencies()
//	}
//}
// 环境对象对⼦类也能⽣效即使 UserModel.mock() 返回的是 UserModel 的⼦类 Nested 视图仍然能够正确读取它
