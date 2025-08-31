//
//  BindableView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/8/31.
//

import SwiftUI
import Observation

@Observable
class QueryViewModel {
    var query = ""
}

// MARK: - 搜索框需要一个绑定值并可以改变这个值
struct SearchField: View {
    
    @Binding var query: String
    
    var body: some View {
        TextField("Search", text: $query)
            .textFieldStyle(.roundedBorder)
            .padding()
    }
}

// MARK: - 搜索视图
struct SearchView: View {
    
    let viewModel: QueryViewModel
    
    var body: some View {
        SearchField(query: Binding(get: {
            viewModel.query
        }, set: { newValue in
            viewModel.query = newValue
        }))
    }
}

// MARK: - 使用 Bindable 简化绑定
struct BindableSearchView: View {
    
    @Bindable var viewModel: QueryViewModel
    
    var body: some View {
        SearchField(query: $viewModel.query)
    }
}


// MARK: - 主视图
struct BindableView: View {
    
    @State var viewModel = QueryViewModel()
    
    var body: some View {
        VStack {
            
            Text(viewModel.query)
            
            SearchField(query: $viewModel.query)
            
            SearchView(viewModel: viewModel)
            
            BindableSearchView(viewModel: viewModel)
        }
    }
}

#Preview {
    BindableView()
}
