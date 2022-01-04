//
//  MessageModel.swift
//  Training
//
//  Created by I Gusti Made Sumariana on 14/12/21.
//

import Foundation
import RealmSwift

struct MessageData : Codable{
    var status: Int
    var items: [MessageItem]?
    var error : ErrorPerResponse
}

struct MessageItem: Codable {
    var talkId: Int
    var toUserId: Int
    var messageId: Int
    var userId: Int
    var nickname: String
    var imageId: Int
    var imageSize: String?
    var imageUrl: String?
    var message: String
    var mediaType: Int
    var userStatus: Int
    var time: String
    var lastUpdateTime: String
}

class MessageLocalItem: Object{
    @objc dynamic var talkId: Int = 0
    @objc dynamic var toUserId: Int = 0
    @objc dynamic var messageId: Int = 0
    @objc dynamic var userId: Int = 0
    @objc dynamic var nickname: String = ""
    @objc dynamic var imageId: Int = 0
    @objc dynamic var imageSize: String = ""
    @objc dynamic var imageUrl: String = ""
    @objc dynamic var message: String = ""
    @objc dynamic var mediaType: Int = 0
    @objc dynamic var userStatus: Int = 0
    @objc dynamic var time: String = ""
    @objc dynamic var lastUpdateTime: String = ""
}
