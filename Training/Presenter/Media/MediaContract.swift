//
//  MediaContract.swift
//  Training
//
//  Created by TimedoorMSI on 23/12/21.
//

import Foundation
import UIKit

protocol MediaProtocol{
    func showSuccess(imageId: Int)
    func showError(_ error: ErrorPerResponse)
}

protocol MediaPresenterProtocol{
    func uploadImage(location: String!, image: UIImage!)
    func uploadVideo(video: Data)
}
