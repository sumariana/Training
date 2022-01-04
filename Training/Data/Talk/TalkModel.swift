//
//  TalkModel.swift
//  Training
//
//  Created by TimedoorMSI on 18/12/21.
//

import Foundation
import RealmSwift

struct TalkResponse: Codable{
    var status: Int?
    var items: [TalkItems]
    var error: ErrorPerResponse?
}

struct SendMessageResponse: Codable{
    var status: Int?
    var messageId: Int?
    var error: ErrorPerResponse?
}

struct TalkItems: Codable{
    var talkId: Int?=nil
    var messageId: Int?=nil
    var userId: Int?=nil
    var message: String?=nil
    var mediaId: Int?=nil
    var mediaSize: String?=nil
    var imageSize: String?=nil
    var mediaUrl: String?=nil
    var mediaType: Int?=nil
    var time: String?=nil
    var messageKind: Int?=nil
}

class TalkLocalItems: Object{
    @objc dynamic var talkId: Int=0
    @objc dynamic var messageId: Int=0
    @objc dynamic var userId: Int=0
    @objc dynamic var message: String=""
    @objc dynamic var mediaId: Int=0
    @objc dynamic var mediaSize: String=""
    @objc dynamic var imageSize: String=""
    @objc dynamic var mediaUrl: String=""
    @objc dynamic var mediaType: Int=0
    @objc dynamic var time: String=""
    @objc dynamic var messageKind: Int=0
}
