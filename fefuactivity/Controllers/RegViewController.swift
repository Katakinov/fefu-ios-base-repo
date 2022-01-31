//
//  RegViewController.swift
//  fefuactivity
//
//  Created by wsr3 on 26.11.2021.
//

import UIKit

class RegViewController: UIViewController {

    @IBOutlet weak var passwordField1: UITextField!
    @IBOutlet weak var againBut: UIButton!
    @IBOutlet weak var passwordField2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        againBut.layer.cornerRadius = 15
        
    }
    
    @IBAction func passwordEye1(_ sender: UIButton) {
        if passwordField1.isSecureTextEntry == true {
            passwordField1.isSecureTextEntry = false
        }
        else{
            passwordField1.isSecureTextEntry = true
        }
    }
    
    @IBAction func passwordEye2(_ sender: UIButton) {
        if passwordField2.isSecureTextEntry == true {
            passwordField2.isSecureTextEntry = false
        }
        else{
            passwordField2.isSecureTextEntry = true
        }
    }
}
