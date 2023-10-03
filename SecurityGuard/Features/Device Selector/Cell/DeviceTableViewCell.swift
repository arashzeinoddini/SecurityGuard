//
//  DeviceTableViewCell.swift
//  SecurityGuard
//
//  Created by Arash Zeinoddini on 9/11/23.
//

import UIKit

class DeviceTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
