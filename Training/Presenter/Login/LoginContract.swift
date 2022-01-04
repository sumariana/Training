//
//  LoginContract.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 19/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import Foundation

protocol LoginViewProtocol {
    func buildView()
    func buildError(_ error: ErrorPerResponse?)
}

protocol LoginPresenterProtocol {
    func login(email: String, password: String)
}
