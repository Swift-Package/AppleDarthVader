//
//  UIImageResize.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import UIKit

@objc
public extension UIImage {
    /// 重设图片尺寸(SVG图片也不会产生边缘黑底)
    /// - Parameter size: 新尺寸
    /// - Returns: 新尺寸的图片
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            self.draw(in: .init(origin: .zero, size: size))
        }
    }

    /// 重设图片尺寸 - 为了性能该方法建议在后台线程执行
    /// - Parameter newSize: 新尺寸
    /// - Returns: 新尺寸的图片
    func resized(newSize: CGSize) -> UIImage {
        let horizontalRatio = newSize.width / size.width
        let verticalRatio = newSize.height / size.height

        let ratio = max(horizontalRatio, verticalRatio)
        return resized(ratio: ratio)
    }

    func resized(ratio: CGFloat) -> UIImage {
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        draw(in: CGRect(origin: .zero, size: newSize))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }

    func resizedToMatchScreenWidth() -> UIImage? {
        let screenWidth = UIScreen.main.bounds.width
        let widthScale = screenWidth / size.width
        let newHeight = size.height * widthScale

        UIGraphicsBeginImageContext(CGSize(width: screenWidth, height: newHeight))
        draw(in: CGRect(x: 0, y: 0, width: screenWidth, height: newHeight))

        if let resizedImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return resizedImage
        } else {
            UIGraphicsEndImageContext()
            return nil
        }
    }
}

/**
 let concurrentQueue = DispatchQueue(label: "ResizingQueue", attributes: .concurrent)
 concurrentQueue.async {
     let thumbImage = fullImage.resized(newSize: CGSize(width: 107, height: 107))
     DispatchQueue.main.async {
        使用thumbImage
     }
 }
 **/
