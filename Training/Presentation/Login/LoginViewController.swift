//
//  LoginViewController.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 11/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import UIKit
import RxSwift

class LoginViewController: BaseViewController {

    // MARK: Properties
    
    @IBOutlet weak var emailTextField: CommonTextField!
    
    @IBOutlet weak var passwordTextField: CommonTextField!
    
    
    var presenter: LoginPresenterProtocol!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = LoginPresenter(self)
    }
    
    
    // MARK: Actions
    
    @IBAction func SignInTouchUpInside(_ sender: Any) {
        do{
            let _email = try emailTextField.validatedText(validationType: ValidatorType.email)
            let _password = try passwordTextField.validatedText(validationType: ValidatorType.requiredField(field: "password".localized))
            loginAPI(_email, _password)
            //
        }catch(let error){
            showErrorFormAlert(for: (error as! ValidationError).message)
        }
        
    }
    
    func loginAPI(_ email: String, _ password: String ){
        onProcess()
        presenter.login(email: email, password: password)
    }
}

extension LoginViewController: LoginViewProtocol {
    func buildView() {
        endProcess()
        let controller = MainTabViewController.instantiateStoryboard()
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
    }
    
    func buildError(_ error: ErrorPerResponse?) {
        //showHTTPError(code: error.errorCode ?? 0)
        print("error kesini")
        endProcess()
        showAPIError(error)
    }
    
    
}
