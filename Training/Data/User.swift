//
//  User.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 20/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import Foundation
import UIKit

class User {
    var pref = UserDefaults.standard
    
    public static let shared = User()
}

extension User {
    func saveUserCredential(model: BaseLoginModel) {
        pref.set(model.accessToken, forKey: Constants.accessToken)
        pref.set(model.userId, forKey: Constants.userId)
    }
    
    func logout() {
        guard let domain = Bundle.main.bundleIdentifier else {
            return
        }
        pref.removePersistentDomain(forName: domain)
        pref.synchronize()
    }
    
    func isLogin() -> Bool {
        if token().isEmpty {
            return false
        } else {
            return true
        }
    }
    
    func token() -> String {
        return pref.string(forKey: Constants.accessToken) ?? ""
    }
    
    func userId() -> String{
        return pref.string(forKey: Constants.userId) ?? ""
    }
    
    func refreshToken() -> String {
        return ""
    }
}
