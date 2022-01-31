//
//  AuthViewController.swift
//  fefuactivity
//
//  Created by wsr3 on 26.11.2021.
//

import UIKit

class AuthViewController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var againBut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        againBut.layer.cornerRadius = 15
    }
    
    @IBAction func passwordEye(_ sender: UIButton) {
        if passwordField.isSecureTextEntry == true {
            passwordField.isSecureTextEntry = false
        }
        else{
            passwordField.isSecureTextEntry = true
        }
    }
    
    @IBAction func didTapContinue(_ sender: Any){
            let login = loginField.text ?? ""
            let password = passwordField.text ?? ""
            
            let body = LogModel(login: login, password: password)
            
            do {
                let requestBody = try Auth.encoder.encode(body)
                let queue = DispatchQueue.global(qos: .utility)
                
                Auth.login(requestBody) { user in
                    queue.async {
                        UserDefaults.standard.set(user.token, forKey: "token")
                    }
                    
    //                DispatchQueue.main.async {
    //                    let vc = ListlViewController(nibName: "TableView", bundle: nil)
    //                    vc.modalPresentationStyle = .fullScreen
    //                    self.present(vc, animated: true, completion: nil)
    //                }
                
                } errors: { err in
                    print("Something wrong \(err)")
                }
                
            } catch {
                print(error)
            }
        }
}
