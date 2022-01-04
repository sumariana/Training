//
//  UIViewController+Extensions.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 20/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

extension UIViewController {
    func showErrorBox(msg: String) {
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            print(action)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showHTTPError(code: Int) {
        switch code {
        case HTTPStatusCode.badRequest.rawValue:
            showErrorBox(msg: "BAD REQUEST")
        case HTTPStatusCode.badValidation.rawValue:
            showErrorBox(msg: "BAD VALIDATION")
        case HTTPStatusCode.unauthorized.rawValue:
            showErrorBox(msg: "UNAUTHORIZED")
        default:
            showErrorBox(msg: "Internal Server Error")
        }
    }
    
    func showAPIError(_ error: ErrorPerResponse?){
        showErrorBox(msg: error?.errorMessage ?? "")
    }
    
    func onProcess() {
        SVProgressHUD.show()
    }
    
    func endProcess() {
        SVProgressHUD.dismiss()
    }
}
