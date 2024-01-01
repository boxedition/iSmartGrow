//
//  DeviceTableViewCell.swift
//  SmartGrow
//
//  Created by box on 30/12/2023.
//

import UIKit

class DeviceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
    //A way easier to call in the ViewController
    static let identifier = "DeviceTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "DeviceTableViewCell", bundle: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
