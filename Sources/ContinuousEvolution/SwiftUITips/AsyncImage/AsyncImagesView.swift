//
//  AsyncImagesView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2026/1/4.
//

import SwiftUI

fileprivate struct AsyncImages: View {
	
	let imageURL = "https://images.unsplash.com/photo-1516822477961-1427b7790e80?w=375"
	
	var body: some View {
		VStack {
			AsyncImage(url: URL(string: imageURL)) { image in
				image
					.resizable()
					.scaledToFit()
					.clipShape(RoundedRectangle(cornerRadius: 8))
					.padding()
			} placeholder: {
				ProgressView()
			}
			
			AsyncImage(url: URL(string: imageURL), scale: 1.0) { phase in
				switch phase {
				case .empty:
					ProgressView()
				case .success(let image):
					image
						.resizable()
						.scaledToFit()
						.clipShape(RoundedRectangle(cornerRadius: 8))
						.padding()
				case .failure(_):
					Text("加载失败了")
				@unknown default:
					EmptyView()
				}
			}
		}
	}
}

#Preview {
	AsyncImages()
}

fileprivate struct AsyncImageRefresh: View {
	
	let imageURL = "https://images.unsplash.com/photo-1516822477961-1427b7790e80?w=375"
	@State private var imageID = UUID()
	
	var body: some View {
		VStack {
			AsyncImage(url: URL(string: imageURL), scale: 1.0) { phase in
				switch phase {
				case .empty:
					ProgressView()
				case .success(let image):
					image
						.resizable()
						.scaledToFit()
						.clipShape(RoundedRectangle(cornerRadius: 8))
						.padding()
				case .failure(_):
					Text("加载失败了")
				@unknown default:
					EmptyView()
				}
			}
			.id(imageID)
			
			Spacer()
			
			Button {
				imageID = UUID()
			} label: {
				HStack {
					Image(systemName: "gobackward")
					Text("重新加载")
				}
				.foregroundStyle(.white)
				.padding()
				.background(.green)
				.clipShape(.capsule)
			}

		}
	}
}

#Preview {
	AsyncImageRefresh()
}
