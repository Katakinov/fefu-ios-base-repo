import UIKit

class MyActivityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet var tableView: UITableView!
    
    //@IBOutlet var titleHidden: [UITextView]!
    let activityKm = ["14.5", "22.1"]
    let activityHours = ["1", "2"]
    let activityName = ["bicycle", "run"]
    let activityAgo = ["12", "2"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "DemoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DemoTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //tableView func
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityKm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DemoTableViewCell",
                                                 for: indexPath) as! DemoTableViewCell
        cell.activityKm.text = activityKm[indexPath.row] + "km"
        cell.activityHours.text = activityHours[indexPath.row] + "hours"
        cell.activityName.text = activityName[indexPath.row]
        cell.activityAgo.text = activityAgo[indexPath.row]
        return cell
    }
}
