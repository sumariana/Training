//
//  LoginModel.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 20/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import Foundation

struct BaseLoginModel: Codable {
    var accessToken: String!
    var refreshToken: String!
    var status: Int!
    var userId: Int!
    var error: ErrorPerResponse!
}

struct LoginModel: Codable {
    var accessToken: String!
    var refreshToken: String!
    var status: Int!
    var userId: Int!
}
