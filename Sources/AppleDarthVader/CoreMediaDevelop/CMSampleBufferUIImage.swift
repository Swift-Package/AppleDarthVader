//
//  CMSampleBufferUIImage.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

// https://www.youtube.com/watch?v=Zv4cJf5qdu0

import AVFoundation
import UIKit

public extension CMSampleBuffer {
    /// 从摄像头捕获设备回调的缓冲数据中提取出图片对象
    /// - Returns: 图片对象
    @MainActor func convertToUIImageOrNil() -> UIImage? {
        if let pixelBuffer = CMSampleBufferGetImageBuffer(self) {
            let context = CIContext()
            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
            let imageRect = CGRect(x: 0, y: 0, width: CVPixelBufferGetWidth(pixelBuffer), height: CVPixelBufferGetHeight(pixelBuffer))
            if let image = context.createCGImage(ciImage, from: imageRect) {
                return UIImage(cgImage: image, scale: UIScreen.main.scale, orientation: .right)
            }
        }
        return nil
    }
}
