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
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 10.0
        self.layer.shouldRasterize =  true
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
    
    func setCellData (name: String, status:String){
        self.LabelName.text = name;
        self.LabelStatus.text = status;
    }

}
