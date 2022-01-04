//
//  URLRequest+Extensions.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 25/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import Foundation

extension URLRequest {
    func withToken() -> URLRequest {
        var request = self
        request.addValue("Bearer \(User.shared.token())", forHTTPHeaderField: "Authorization")
        return request
    }
    
    func asFormURLEncoded() -> URLRequest {
        var request = self
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        return request
    }
}
