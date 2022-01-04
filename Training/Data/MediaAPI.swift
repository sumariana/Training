//
//  MediaAPI.swift
//  Training
//
//  Created by TimedoorMSI on 23/12/21.
//

import Foundation

import Alamofire
import Foundation
import RxSwift

class MediaAPI: APIRequest {
    // MARK: Properties

    var presenter: MediaPresenterProtocol

    // MARK: Initialize

    init(_ presenter: MediaPresenterProtocol) {
        self.presenter = presenter
    }

    // MARK: Methods

    func postImage(image: UIImage, location: String!) -> Observable<MediaModel> {
        let parameters: [String: Any] = [
            "location": location!,
        ]
        
        let request = postUrl(key: APIConstant.imageUpload.rawValue, query: parameters, isWithToken: true)

        return SessionManager.default.rx.encodeMultipartUpload(to: request, method: .post, headers: getMultipartHeader(), data: { multipart in
            let imageData = image.jpegData(compressionQuality: 0.0)
            multipart.append(imageData!, withName: "image", fileName: "image.jpg", mimeType: "image/*")
        })
    }
    
    func postVideo(video: Data) -> Observable<MediaModelVideo> {
        
        let request = postUrl(key: APIConstant.imageUpload.rawValue, isWithToken: true)

        return SessionManager.default.rx.encodeMultipartUpload(to: request, method: .post, headers: getMultipartHeader(), data: { multipart in
            multipart.append(video, withName: "image", fileName: "image.jpg", mimeType: "image/*")
        })
    }
}
