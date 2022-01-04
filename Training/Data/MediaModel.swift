//
//  MediaModel.swift
//  Training
//
//  Created by TimedoorMSI on 23/12/21.
//

import Foundation
import UIKit
struct MediaModel: Codable {
    var status: Int!
    var imageId: Int!
    var videoId: Int?
    var error: ErrorPerResponse!
}

struct MediaModelVideo: Codable {
    var status: Int!
    var videoId: Int!
    var error: ErrorPerResponse!
}
