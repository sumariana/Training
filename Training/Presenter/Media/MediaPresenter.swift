//
//  MediaPresenter.swift
//  Training
//
//  Created by TimedoorMSI on 23/12/21.
//

import Foundation
import UIKit

class MediaPresenter {
    var view: MediaProtocol

    var handler: MediaAPI!

    init(_ view: MediaProtocol) {
        self.view = view
        handler = MediaAPI(self)
    }
}

extension MediaPresenter: MediaPresenterProtocol {
    func uploadVideo(video: Data) {
        print("upload Video Presenter")
        _ = handler.postVideo(video: video)
            .subscribe(onNext: { response in
                if response.status == 1 {
                    self.view.showSuccess(imageId: response.videoId)
                } else {
                    self.view.showError(response.error)
                }
            }, onError: { _error in
                self.view.showError(_error as! ErrorPerResponse)
            }, onCompleted: nil, onDisposed: nil)
    }
    
    func uploadImage(location: String!, image: UIImage!) {
        print("upload Image Presenter")
        _ = handler.postImage(image: image, location: location)
            .subscribe(onNext: { response in
                if response.status == 1 {
                    self.view.showSuccess(imageId: response.imageId)
                } else {
                    self.view.showError(response.error)
                }
            }, onError: { _error in
                self.view.showError(_error as! ErrorPerResponse)
            }, onCompleted: nil, onDisposed: nil)
    }
}
