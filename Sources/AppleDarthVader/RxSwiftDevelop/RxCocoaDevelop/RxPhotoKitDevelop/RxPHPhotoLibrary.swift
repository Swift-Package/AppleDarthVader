//
//  RxPHPhotoLibrary.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

// 该RxSwift扩展来自kodeco网站 - RxSwift书籍教程项目 Combinestagram

import Photos
import RxSwift
import UIKit

extension PHPhotoLibrary {
    static var authorized: Observable<Bool> {
        return Observable.create { observer in
            if authorizationStatus() == .authorized {
                observer.onNext(true)
                observer.onCompleted()
            } else {
                observer.onNext(false)
                requestAuthorization { newStatus in
                    observer.onNext(newStatus == .authorized)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
}

public class PhotoWriter {
    enum Errors: Error {
        case couldNotSavePhoto
    }

    static func save(_ image: UIImage) -> Single<String> {
        return Single.create(subscribe: { observer in
            var savedAssetId: String?
            PHPhotoLibrary.shared().performChanges({
                let request = PHAssetChangeRequest.creationRequestForAsset(from: image)
                savedAssetId = request.placeholderForCreatedAsset?.localIdentifier
            }, completionHandler: { success, error in
                DispatchQueue.main.async {
                    if success, let id = savedAssetId {
                        observer(.success(id))
                    } else {
                        observer(.failure(error ?? Errors.couldNotSavePhoto))
                    }
                }
            })
            return Disposables.create()
        })
    }
}
