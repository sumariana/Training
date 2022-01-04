//
//  RegisterPresenter.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 13/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

final class RegisterPresenter: RegisterPresenterProtocol {
    
    // MARK: Properties
    
    var view: RegisterViewProtocol!
    
    var registerHandler: RegisterAPI!
    
    // MARK: Initialize
    
    init(_ view: RegisterViewProtocol) {
        self.view = view
        self.registerHandler = RegisterAPI(self)
    }
    
    // MARK: RegisterPresenterProtocol
    
    func registering(_ name: String, _ email: String, _ password: String) {
        _ = self.registerHandler.register(name,email, password)
        .subscribe(onNext: { result in
            User.shared.saveUserCredential(model: result)
            self.view.buildView()
        }, onError: { _error in
            self.view.buildError(nil)
        }, onCompleted: nil, onDisposed: nil)
    }
}
