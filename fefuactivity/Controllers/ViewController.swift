//
//  ViewController.swift
//  fefuactivity
//
//  Created by Andrew L on 04.10.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var regBut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        title=""
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        regBut.layer.cornerRadius = 15
        
    }

}

