//
//  RegisterAPI.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 14/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

final class RegisterAPI: APIRequest {
    
    // MARK: Properties
    
    var presenter: RegisterPresenterProtocol
    
    
    // MARK: Init
    
    init(_ presenter: RegisterPresenterProtocol) {
        self.presenter = presenter
    }
    
    
    // MARK: Methods
    
    func register(_ name: String, _ email: String, _ password: String) -> Observable<BaseLoginModel> {
        
        let parameters: [String: Any] = [
            "nickname": name,
            "login_id": email,
            "password": password,
        ]
        let request = get(key: APIConstant.register.rawValue,query: parameters)
        return Alamofire.request(request).rx.response()
    }
}
