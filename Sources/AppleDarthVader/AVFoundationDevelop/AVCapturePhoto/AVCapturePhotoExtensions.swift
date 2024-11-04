//
//  AVCapturePhotoExtensions.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import AVFoundation

public extension AVCapturePhoto {
    func stupidOSChangePreviewCGImageRepresentation() -> CGImage? {
        return previewCGImageRepresentation()
    }
}
