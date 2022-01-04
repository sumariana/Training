//
//  LoginPresenter.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 19/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class LoginPresenter {

    // MARK: Properties
    
    var view: LoginViewProtocol!
    
    var handler: LoginAPI!
    
    
    // MARK: Initialize
    
    init(_ view: LoginViewProtocol) {
        self.view = view
        self.handler = LoginAPI(self)
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    
    func login(email: String, password: String) {
        _ = handler.login(email: email, password: password)
        .subscribe(onNext: { response in
            if(response.status == 1){
                User.shared.saveUserCredential(model: response)
                self.view.buildView()
            }else{
                self.view.buildError(response.error)
            }
        }, onError: { _error in
           self.view.buildError(nil)
        }, onCompleted: nil, onDisposed: nil)
    }
}
