//
//  FeedModel.swift
//  Training
//
//  Created by TimedoorMSI on 03/12/21.
//

import Foundation

struct FeedResponse: Codable {
    var status: Int?
    var lastLoginTime: String?
    var error: ErrorPerResponse?
    var items: [FeedItem]
}

struct FeedItem: Codable {
    var userId: Int? = nil
    var nickname: String? = nil
    var imageId: Int? = nil
    var imageSize: String? = nil
    var imageUrl: String?
    var gender: Int? = nil
    var age: Int? = nil
    var job: Int? = nil
    var residence: String? = nil
    var personality: Int? = nil
    var hobby: String? = nil
    var aboutMe : String? = nil
    var userStatus: Int? = nil
    var email: String? = nil
    var password: String? = nil
    var birthday: String? = nil
}
