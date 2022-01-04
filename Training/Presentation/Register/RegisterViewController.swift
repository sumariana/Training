//
//  RegisterViewController.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 11/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import UIKit
import SVProgressHUD

class RegisterViewController: UIViewController {

    //
    // MARK: Properties
    
    @IBOutlet weak var usernameTV: CommonTextField!

    @IBOutlet weak var emailTV: CommonTextField!
    
    @IBOutlet weak var PasswordTV: CommonTextField!
    
    var presenter: RegisterPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = RegisterPresenter(self)
    }
    
    @IBAction func registerTouchUpInside(_ sender: Any) {
        guard let name = usernameTV.text else { return }
        guard let email = emailTV.text else { return }
        guard let password = PasswordTV.text else { return }
//
        self.presenter.registering(name, email, password)
        onProcess()
    }
}

extension RegisterViewController: RegisterViewProtocol {
    func buildView() {
        endProcess()
        let controller = MainTabViewController.instantiateStoryboard()
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
    }
    
    func buildError(_ error: ErrorPerResponse?) {
        //showHTTPError(code: error.errorCode ?? 0)
        endProcess()
        showAPIError(error)
    }
    
    
}
