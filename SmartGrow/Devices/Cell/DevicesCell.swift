//
//  DevicesCell.swift
//  SmartGrow
//
//  Created by box on 29/10/2023.
//

import UIKit

class DevicesCell: UICollectionViewCell {

    @IBOutlet weak var LabelName: UILabel!
    @IBOutlet weak var LabelStatus: UILabel!
       
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius=10
        self.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 10.0
        self.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.layer.shouldRasterize =  true
    }
    
    func setCellData (name: String, status:String){
        self.LabelName.text = name;
        self.LabelStatus.text = status;
    }

}
