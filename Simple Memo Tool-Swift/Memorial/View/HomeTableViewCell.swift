//
//  HomeTableViewCell.swift
//  Memorial
//
//  Created by TBC on 2021/5/14.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var contentBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        contentBtn.layer.cornerRadius = 10
        contentBtn.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
