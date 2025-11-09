//
//  StateObjectView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/8/2.
//

import SwiftUI

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
    
    @StateObject var viewModel: StateObjectViewModel = StateObjectViewModel()
    
    @State var path: [String] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            List(viewModel.heroName, id: \.self) { hero in
                Text(hero)
            }
            .navigationTitle("漫威英雄")
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
    
    @StateObject var viewModel: StateObjectViewModel
    
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
