//
//  HTTPError.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 20/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import Foundation
import UIKit

enum HTTPStatusCode: Int {
    case badRequest = 400
    case unauthorized = 401
    case badValidation = 422
    case internalServerError = 500
    case parsingError = 501
}
