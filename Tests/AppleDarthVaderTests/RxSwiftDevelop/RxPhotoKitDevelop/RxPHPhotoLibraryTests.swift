//
//  RxPHPhotoLibraryTests.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/9/21.
//

@testable import AppleDarthVader
import Testing
import UIKit
import Photos

struct RxPHPhotoLibraryTests {

    @Test func savePhoto() async throws {
        let status = PHPhotoLibrary.authorizationStatus(for: .addOnly)
            guard status == .authorized else {
                return
            }
        do {
            let myImage = UIImage.init(named: "DarthVader")!
            let assetId = try await PhotoWriter.init().savePhoto(myImage)
            print("✅ Saved with id: \(assetId)")
        } catch {
            print("❌ Save failed: \(error)")
        }
    }
}
