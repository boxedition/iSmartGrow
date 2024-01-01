//
//  DevicesViewController.swift
//  SmartGrow
//
//  Created by box on 29/10/2023.
//

import UIKit

struct Device {
    var imei: String
    var label: String?
}

class DevicesViewController: UIViewController {

    @IBOutlet weak var DevicesCollectionView: UICollectionView!
    
    //Dummy data
    let data: [Device] = [
        Device(imei: "Salsa"),
        Device(imei: "Coentros"),
        Device(imei: "Alface"),
        Device(imei: "Batatas"),
        Device(imei: "Maceira"),
        Device(imei: "Laranjeira"),
        Device(imei: "Rosas"),
        Device(imei: "Orquideas"),
    ]
    
    var extimatedWidth = 150
    var extimatedHeight = 215
    var cellMarginSize = 16.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.DevicesCollectionView.delegate = self;
        self.DevicesCollectionView.dataSource = self
        //Register Cells
        self.DevicesCollectionView.register(UINib(nibName: "DevicesCell", bundle: nil), forCellWithReuseIdentifier: "DevicesCell")
        
        //setup Grid View
        self.setupGridView()
    }
    
    func setupGridView(){
        let flow = DevicesCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
        flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
    }
    

}

extension DevicesViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print("Data Count", self.data.count)
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DevicesCell", for: indexPath) as! DevicesCell
        cell.setCellData(name: self.data[indexPath.row].imei, status: "self.data[indexPath.row].status?")
        //print("Cell", self.data[indexPath.row].name, self.data[indexPath.row].status)
        return cell
    }
    
}

extension DevicesViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        //let width = self.calculateWidth()
        let width = CGFloat(extimatedWidth)
        let height = CGFloat(extimatedHeight)
        //print("w - h", width , width*1.2)
        return CGSize(width: width, height: height)
    }
    func calculateWidth()->CGFloat{
        let extimatedWidth = CGFloat(extimatedWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width) / extimatedWidth)
        
        let margin = CGFloat(cellMarginSize * 2)
        let width = (self.view.frame.size.width - CGFloat(cellMarginSize * (cellCount - 1)) - margin) / cellCount
        
        return width
    }
}
