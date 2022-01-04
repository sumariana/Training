//
//  LoginAPI.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 20/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class LoginAPI: APIRequest {
    
    // MARK: Initialize
    
    var presenter: LoginPresenterProtocol
    
    init(_ presenter: LoginPresenterProtocol) {
        self.presenter = presenter
    }
    
    
    // MARK: Methods
    
    func login(email: String, password: String) -> Observable<BaseLoginModel> {
        let parameters: [String: Any] = [
            "login_id": email,
            "password": password,
            "language":"en"
        ]
        let request = get(key: APIConstant.login.rawValue, query: parameters)
        return Alamofire.request(request).rx.response()
    }
}
