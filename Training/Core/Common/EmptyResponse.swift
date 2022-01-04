//
//  EmptyResponse.swift
//  Training
//
//  Created by TimedoorMSI on 26/11/21.
//

import Foundation

struct EmptyResponse : Codable{
    let status: Int?
    let error: ErrorPerResponse?
}
