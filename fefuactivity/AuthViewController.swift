//
//  AuthViewController.swift
//  fefuactivity
//
//  Created by wsr3 on 26.11.2021.
//

import UIKit

class AuthViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func passwordEye(_ sender: UIButton) {
        if passwordField.isSecureTextEntry == true {
            passwordField.isSecureTextEntry = false
        }
        else{
            passwordField.isSecureTextEntry = true
        }
    }
    
}
