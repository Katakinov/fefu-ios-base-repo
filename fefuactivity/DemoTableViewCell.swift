import UIKit

class DemoTableViewCell: UITableViewCell {
    
    @IBOutlet var activityKm: UILabel!
    @IBOutlet var activityHours: UILabel!
    @IBOutlet var activityName: UILabel!
    @IBOutlet var activityAgo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
