

import UIKit

class MemoListTableViewCell: UITableViewCell {

    @IBOutlet weak var contentLab: UILabel!
    @IBOutlet weak var timeLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
