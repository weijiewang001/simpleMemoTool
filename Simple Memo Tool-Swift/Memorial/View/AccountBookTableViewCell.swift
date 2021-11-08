

import UIKit

class AccountBookTableViewCell: UITableViewCell {

    @IBOutlet weak var contentLab: UILabel!
    @IBOutlet weak var typeLab: UILabel!
    @IBOutlet weak var moneyLab: UILabel!
    @IBOutlet weak var timeLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
