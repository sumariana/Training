//
//  ErrorModel.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 11/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import Foundation

struct BaseError: Codable, Error {
    var error: ErrorModel = ErrorModel()
}

struct ErrorModel: Error, Codable {
    var title: String = ""
    var code: Int = 0
    var errors: [ErrorDetail] = [ErrorDetail]()
    
    init() {
    }
    
    init(code: Int) {
        self.code = code
    }
}

struct ErrorDetail: Codable
{
    var title: String = ""
    var message: String = ""
}

struct ErrorPerResponse: Codable,Error{
    var errorCode: Int?
    var errorTitle: String?
    var errorMessage: String?
}


