//
//  HomeModel.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 21/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import Foundation

struct BaseHomeModel: Codable {
    var data: [HomeModel] = []
}

struct HomeModel: Codable {
    var id: Int
    var name: String
    var description: String
    var imageUrl: String
}
