import UIKit
import CoreData

class MyActivityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var emptyState: UIView!
    @IBOutlet var tableView: UITableView!
    
    //@IBOutlet var titleHidden: [UITextView]!
    //var indexForOne = 1
    //let activityKm = ["14.5", "22.1", "12", "1"]
    //let activityHours = ["1", "2", "2", "21"]
    //let activityName = ["bicycle", "run", "ski", "skate"]
    //let activityAgo = ["12", "2", "23", "0"]
    //var sectionName: [String] = ["October 21 2021", "December 31 2022", "October 21 2021", "December 31 2022"]
    var sectionNumber = 3
    
    struct ActivitiesTableViewCellViewModel {
        let duration = Int()
        let name = String()
        let distance = Int()
    }
    
    struct ActivitiesTableViewModel {
        let date: String
        let activities: [ActivitiesTableViewCellViewModel]
    }
    
    private var data: [ActivitiesTableViewModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        let nib = UINib(nibName: "DemoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DemoTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    private func fetch() {
        let context = FEFUCoreDataContainer.instance.context
        
        let activityRequest: NSFetchRequest<CDActivity> = CDActivity.fetchRequest()
        
        do {
            let rawActivities = try context.fetch(activityRequest)
            
            let activitesViewModels: [ActivitiesTableViewCellViewModel] = rawActivities.map { rawActivities in return ActivitiesTableViewCellViewModel()
            }
            self.data = [ActivitiesTableViewModel(date: "23.10", activities: )]
            print(rawActivities)
        } catch {
            print(error)
        }
    }
    
    
    
    @IBAction func startActivityButton(_ sender: UIButton) {
        emptyState.isHidden = true
        tableView.isHidden = false
    }
    //tableView func
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityKm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DemoTableViewCell",
                                                 for: indexPath) as! DemoTableViewCell
        cell.activityKm.text = activityKm[indexPath.row] + " km"
        cell.activityHours.text = activityHours[indexPath.row] + " hours"
        cell.activityName.text = activityName[indexPath.row]
        cell.activityAgo.text = activityAgo[indexPath.row] + " hours ago"
        return cell
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        activityKm = indexPath.row
        self.performSegue(withIdentifier: "ShowInfo", sender: self)
    }*/
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowInfo", sender: self)
        let infocell = tableView.dequeueReusableCell(withIdentifier: "DemoTableViewCell",
                                                     for: indexPath) as! DemoTableViewCell
        infocell.activityKm.text = activityKm[indexPath.row] + " km"
        
    }*/
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(sectionName[sectionNumber])"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexForOne = indexPath.row
        performSegue(withIdentifier: "ShowInfo", sender: self)
    }
}
