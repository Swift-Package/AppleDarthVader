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
    
    // MARK: - WWDC25 - Xcode 新功能
    var isCameraAuthorized: Bool {
        get async {
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            
            var isAuthorized = status == .authorized
            
            if status == .notDetermined {
                isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
            }
            
            return isAuthorized
        }
    }
}
