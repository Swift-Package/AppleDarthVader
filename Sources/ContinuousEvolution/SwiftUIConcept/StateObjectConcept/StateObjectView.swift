//
//  StateObjectView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/8/2.
//

import SwiftUI

// MARK: - 视图模型
fileprivate class StateObjectViewModel: ObservableObject {
    
    @Published var heroName: [String] = []
    
    init() {
        heroName = ["Thor", "Ironman"]
    }
    
    func addNewHero(_ name: String) {
        heroName.append(name)
    }
}

fileprivate struct StateObjectView: View {
    
    @State var path: [String] = []
    @StateObject var viewModel = StateObjectViewModel()
    
    var body: some View {
        NavigationStack(path: $path) {
            List(viewModel.heroName, id: \.self) { hero in
                Text(hero)
            }
            .toolbar {
                Button {
                    viewModel.addNewHero("Caption")
                } label: {
                    Image(systemName: "plus")
                }
            }
            .toolbar(content: {
                Button {
                    path.append("Favorite")
                } label: {
                    Image(systemName: "heart")
                }
            })
            .navigationDestination(for: String.self) { _ in
                FavoriteView(viewModel: viewModel)
            }
        }
    }
}

fileprivate struct FavoriteView: View {
    
    @ObservedObject var viewModel: StateObjectViewModel// 应该使用 ObservedObject 接受父视图传递过来的数据
    
    var body: some View {
        List(viewModel.heroName, id: \.self) { hero in
            Text(hero)
        }
        .navigationTitle("漫威英雄收藏页面")
        .toolbar {
            Button {
                viewModel.addNewHero("Caption")
            } label: {
                Image(systemName: "plus")
            }
        }
    }
}

#Preview {
    StateObjectView()
}

// MARK: - 视图模型
fileprivate class SwiftUIInitConceptViewModel: ObservableObject {
	init() {
		print("ViewModel 初始化")
	}
}

// MARK: - 子视图
fileprivate struct SwiftUIInitConceptChildView: View {
	
	@StateObject private var viewModel = SwiftUIInitConceptViewModel() // ⚠️StateObject标记不会每次重新创建
	let isActive: Bool
	
	// MARK: - 自定义初始化器
	init(isActive: Bool) {
		self.isActive = isActive
		print("子视图重新初始化")
	}
	
	var body: some View {
		Text("SwiftUI")
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.ignoresSafeArea()
			.background(isActive ? .red : .blue)
	}
}

// MARK: - 主视图
fileprivate struct SwiftUIInitConcept: View {
	
	@State private var isActive = false
	
	var body: some View {
		SwiftUIInitConceptChildView(isActive: isActive)
			.onTapGesture {
				isActive.toggle()
			}
	}
}

#Preview("StateObject标记不会每次重新创建") {
	SwiftUIInitConcept()
}
