//
//  RegisterContract.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 13/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import Foundation

protocol RegisterViewProtocol {
    func buildView()
    func buildError(_ error: ErrorPerResponse?)
}

protocol RegisterPresenterProtocol {
    func registering(_ name: String, _ email: String, _ password: String)
}
