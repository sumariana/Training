//
//  PisangViewController.swift
//  Training
//
//  Created by TimedoorMSI on 06/10/21.
//

import UIKit

class PisangViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var dummyButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //myButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector())
        // Do any additional setup after loading the view.
    }
    
    @IBAction func myButtonClick(_ sender: UIButton) {
        let controller = RegisterViewController.instantiateStoryboard()
                self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func LoginClick(_ sender: UIButton) {
        let controller = LoginViewController.instantiateStoryboard()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
