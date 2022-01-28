import UIKit
import MapKit

class MyActivityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var emptyState: UIView!
    @IBOutlet var tableView: UITableView!
    
    //@IBOutlet var titleHidden: [UITextView]!
    var currentKM: String = "0"
    var currentTime: String = "00"
    var currentActivityName: String = "название"
    var currentAgo: String = "00"
    var indexForOne = 1
    let activityKm = ["14.5", "22.1", "12", "1"]
    let activityHours = ["1", "2", "2", "21"]
    let activityName = ["bicycle", "run", "ski", "skate"]
    let activityAgo = ["12", "2", "23", "0"]
    var sectionName = ["October 21 2021", "December 31 2022", "November 21 2019", "January 31 2010"]
    //var sectionNumber = ["1", "2", "3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*self.navigationController?.setNavigationBarHidden(false, animated: true)*/
        
        let nib = UINib(nibName: "DemoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DemoTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier
        {
            case "ShowInfo":
            if let vc = segue.destination as? ShowInfoViewController{
                vc.kilometr = activityKm[1]
                vc.laterTime = activityAgo[1]
                vc.durationTime = activityHours[1]
            }
            default:
                break
        }
    }*/
    
    @IBAction func startActivityButton(_ sender: UIButton) {
        emptyState.isHidden = true
        tableView.isHidden = false
    }
    //tableView func
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityKm.count
    }
    
    /*func tableView(_ tableView: UITableView, numberOfSectionInTable section: Int) -> Int {
        return sectionNumber
    }*/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DemoTableViewCell",
                                                 for: indexPath) as! DemoTableViewCell
        cell.activityKm.text = activityKm[indexPath.row] + " km"
        cell.activityHours.text = activityHours[indexPath.row] + " hours"
        cell.activityName.text = activityName[indexPath.row]
        cell.activityAgo.text = activityAgo[indexPath.row] + " hours ago"
        return cell
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*let vc = [activityKm[indexPath.row], activityAgo[indexPath.row], activityHours[indexPath.row]]*/
        self.performSegue(withIdentifier: "ShowInfo", sender: indexPath)
    }*/

    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowInfo", sender: self)
        let infocell = tableView.dequeueReusableCell(withIdentifier: "DemoTableViewCell",
                                                     for: indexPath) as! DemoTableViewCell
        infocell.activityKm.text = activityKm[indexPath.row] + " km"
        
    }*/
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = self.sectionName[section]
        return section
    }
    //let section = self.sectionName[section]
    //return section
    //return "section"
    /*let i = 0
        while i < sectionName.count{
        return "\(sectionName[i])"
    }*/
    //return "\(sectionName[i])"
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionName.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*let vc = segue.destination as! ShowInfoViewController*/
        performSegue(withIdentifier: "ShowInfo", sender: tableView.cellForRow(at: indexPath))
        
        
        
        
        currentActivityName = activityName[indexPath.row]
        currentTime = activityHours[indexPath.row]
        currentKM = activityKm[indexPath.row]
        currentAgo = activityAgo[indexPath.row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowInfo" else { return }
        guard let destination = segue.destination as? ShowInfoViewController else { return }
        destination.activityNameInfo = String(currentActivityName)
        destination.durationTime = String(currentTime)
        destination.kilometr = String(currentKM)
        destination.laterTime = String(currentAgo)
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC: ShowInfoViewController = segue.destination as! ShowInfoViewController
        
        destinationVC.activityTimeInfo.text = String(currentTime)
        destinationVC.activityLaterTime.text = String(currentAgo)
        destinationVC.activityDistance.text = String(currentKM)
    }*/
}
