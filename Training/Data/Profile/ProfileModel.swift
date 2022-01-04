//
//  ProfileModel.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 25/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import Foundation

struct BaseProfileModel: Codable {
    let data: ProfileModel
}

struct ProfileModel: Codable {
    let userId: Int
    let email: String?
    let hobby: String?
    let aboutMe: String
    let age: Int?
    let imageUrl: String?
    let imageId: Int
    let residence: String
    let personality: Int
    let userStatus: Int
    let password: String?
    let imageSize: String?
    let birthday: String?
    let nickname: String
    let job: Int
    let status : Int
    let gender: Int
    let error: ErrorPerResponse!
}

struct DeleteAccountResponse: Codable {
    var status: Int? = nil
    var error: ErrorPerResponse? = nil
}

struct ProfileRequest: Encodable{
    var nickname: String?
    var birthday: String?
    var residence: String?
    var gender: Int?
    var job: Int?
    var personality: Int?
    var hobby: String?
    var about_me: String?
    var image_id: Int?
    var language = "en"
}
