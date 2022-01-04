//
//  RegisterModel.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 18/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import Foundation

struct BaseRegisterModel: Codable {
    var data: RegisterModel!
}

struct RegisterModel: Codable {
    var status : Int?
    var accessToken: String?
    var userId: Int?
    var error: ErrorPerResponse?
}
