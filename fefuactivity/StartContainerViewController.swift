//
//  StartContainerViewController.swift
//  fefuactivity
//
//  Created by wsr3 on 06.12.2021.
//

import UIKit
import CoreData

class StartContainerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myMapCellLabelArrayActivityName.count
    }
    
    @IBOutlet weak var startMapActivity: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var activityName: UILabel!
    @IBOutlet weak var activityDistance: UILabel!
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyMapActivityCollectionViewCell
        
        cell.myMapCellLabel.text = myMapCellLabelArrayActivityName[indexPath.row]
        cell.myMapCellLabel.layer.cornerRadius = 50.0
        return cell

        
    }
    
    var OurTimer = Timer()
    var TimerDisplayed = 0
    var TimerPointPause = false
    
    var myMapCellLabelArrayActivityName:[String] = ["Велосипед", "Бег", "Прыг", "Лыжи"]
    
    
    private let fefuCoreData = FEFUCoreDataContainer.instance

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func selectActivityTypes(_ sender: UIButton) {
        activityName.text = myMapCellLabelArrayActivityName[1]
        }

    
    @IBAction func startButtonMapActivity(_ sender: UIButton) {
        startMapActivity.isHidden = true
        OurTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Action), userInfo: nil, repeats: true)
        //activityName.text = myMapCellLabelArrayActivityName
    }
    
    @IBAction func pauseButton(_ sender: UIButton) {
        //OurTimer.invalidate()
        if TimerPointPause == false {
            OurTimer.invalidate()
            TimerPointPause = true
        } else {
            OurTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Action), userInfo: nil, repeats: true)
            TimerPointPause = false
        }
    }
    @IBAction func stopButtonMapActivity(_ sender: Any) {
        OurTimer.invalidate()
        TimerDisplayed = 0
        timeLabel.text = "0"
        
        let context = fefuCoreData.context
        
        let activityNameFinish = CDActivity(context: context)
        activityNameFinish.name = activityName.text
        activityNameFinish.time = timeLabel.text
        
        fefuCoreData.saveContext()
    }
    
    @objc func Action() {
        TimerDisplayed += 1
        timeLabel.text = String(TimerDisplayed)
    }
    
}
