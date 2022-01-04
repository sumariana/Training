//
//  ImageResponse.swift
//  Training
//
//  Created by TimedoorMSI on 26/11/21.
//

import Foundation

struct ImageResponse: Codable {
    let status: Int?
    let imageId: Int?
    let error: ErrorPerResponse?
}
