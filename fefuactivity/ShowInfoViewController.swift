//
//  ShowInfoViewController.swift
//  fefuactivity
//
//  Created by wsr1 on 20.01.2022.
//

import UIKit
import CoreLocation

class ShowInfoViewController: UIViewController {
    
    var activityNameInfo = ""
    var kilometr = ""
    var laterTime = ""
    var durationTime = ""
    
    @IBOutlet weak var activityName: UILabel!
    @IBOutlet weak var activityDistance: UILabel!
    @IBOutlet weak var activityLaterTime: UILabel!
    @IBOutlet weak var activityTimeInfo: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        activityDistance.text = kilometr + "км"
        activityLaterTime.text = laterTime + "минут"
        activityTimeInfo.text = durationTime + "минут назад"
        activityName.text = activityNameInfo
    }
    
}
