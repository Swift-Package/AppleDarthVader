//
//  StateObjectWrongUseView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/10/21.
//

// StateObject 初始化器的错误用法 - https://www.youtube.com/watch?v=pGn0-5mV4ec
// 博客文章 - https://jaredsinclair.com/2024/03/14/state-object-autoclosure.html

import SwiftUI

fileprivate struct StateObjectWrongUseView: View {
    var body: some View {
        Text("Apple")
    }
}

#Preview {
    StateObjectWrongUseView()
}

fileprivate struct MovieDetailsView: View {
    
    @StateObject var viewModel: MovieDetailsViewModel
    
    init(movie: Movie) {
        let viewModel = MovieDetailsViewModel(movie: movie)
        _viewModel = StateObject(wrappedValue: viewModel)
        // MARK: - ⚠️上面两行的写法是错误的,要使用下面的一行代码才是正确的
        _viewModel = StateObject(wrappedValue: MovieDetailsViewModel(movie: movie))
    }
    
    var body: some View {
        
    }
}

fileprivate class MovieDetailsViewModel: ObservableObject {
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
}

fileprivate class Movie {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
