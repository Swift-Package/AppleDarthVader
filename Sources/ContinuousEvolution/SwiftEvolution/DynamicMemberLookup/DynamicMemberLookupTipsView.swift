//
//  DynamicMemberLookupTipsView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/9/8.
//

// Pragma Conference 2023 - Swift and You - John Sundell - https://www.youtube.com/watch?v=WTL6lxGRmrQ

import SwiftUI

struct DynamicMemberLookupTipsView: View {
    
    var media: [Media] = [Photo.init(name: "Photo1", url: URL(string: "https://example.com/photo1")!, size: CGSize(width: 100, height: 100)),
                          Video.init(name: "Video1", url: URL(string: "https://example.com/video1")!, length: 120)]
    
    var mediaV: [MediaType] = [.photo(Photo.init(name: "VPhoto1", url: URL(string: "https://example.com/photo1")!, size: CGSize(width: 100, height: 100))),
                               .video(Video.init(name: "VVideo1", url: URL(string: "https://example.com/video1")!, length: 120))]
    
    var body: some View {
        VStack {
            Text("Hello Apple")
        }
        .onAppear {
            // MARK: - 2.但是这样如果有第三种类型就会出现隐藏错误
            for content in media {
                if let photo = content as? Photo {
                    print("Photo: \(photo.name), Size: \(photo.size)")
                } else if let video = content as? Video {
                    print("Video: \(video.name), Length: \(video.length) seconds")
                }
            }
            let names = media.map(\.name)
            print(names)
            
            // MARK: - 4.使用枚举强关联类型
            for content in mediaV {
                switch content {
                case .photo(let photo):
                    print("Photo: \(photo.name), Size: \(photo.size)")
                case .video(let video):
                    print("Video: \(video.name), Length: \(video.length) seconds")
                }
            }
            
            // MARK: - 5.但是这里就要复杂一些
            let namesV = mediaV.map {
                switch $0 {
                case .photo(let photo):
                    return photo.name
                case .video(let video):
                    return video.name
                }
            }
            
            print(namesV)
            
            // MARK: - 7.使用 @dynamicMemberLookup 来简化访问
            let namesD = mediaV.map(\.name)
            print(namesD)
        }
    }
}

#Preview {
    DynamicMemberLookupTipsView()
}

struct Photo: Media {
    var name: String
    var url : URL
    var size: CGSize
}

struct Video: Media {
    var name: String
    var url : URL
    var length: TimeInterval
}

// MARK: - 1.上面两个类型可以提取共性协议
protocol Media {
    var name: String { get }
    var url : URL { get }
}

// MARK: - 3.使用枚举类型可以避免隐藏错误
// MARK: - 6.我们使用 @dynamicMemberLookup 来实现类似协议的功能
@dynamicMemberLookup
enum MediaType {
    case photo(Photo)
    case video(Video)
}

extension MediaType {
    subscript<T>(dynamicMember keyPath: KeyPath<Media, T>) -> T {
        switch self {
        case .photo(let photo):
            photo[keyPath: keyPath]
        case .video(let video):
            video[keyPath: keyPath]
        }
    }
}
