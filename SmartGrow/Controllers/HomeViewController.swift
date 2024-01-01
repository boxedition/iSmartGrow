//
//  ViewController.swift
//  SmartGrow
//
//  Created by box on 26/10/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var imgLeft: UINavigationItem!
    
    @IBOutlet weak var imgCenter: UINavigationItem!
    
    @IBOutlet weak var imgRight: UINavigationItem!
    
    // Codable protocol to automatically handle the decoding and encoding of JSON data to and from Swift objects.
    struct Device: Codable {
        let id: Int
        let imei: String
        let label: String?
        let imgPath: String?
        let objPath: String?
        let isWaterActive: Bool
        let createdAt: String
        let updatedAt: String

        enum CodingKeys: String, CodingKey {
            case id, imei, label, imgPath = "img_path", objPath = "obj_path", isWaterActive = "is_water_active", createdAt = "created_at", updatedAt = "updated_at"
        }
    }
    
    let data: [Device] = [
        Device(id: 2, imei: "SomeDevice", label: nil, imgPath: nil, objPath: nil, isWaterActive: false, createdAt: "2023-12-29T13:07:18.000000Z", updatedAt: "2023-12-29T13:07:18.000000Z"),
        Device(id: 1, imei: "f412fa654a10", label: nil, imgPath: "images/1703593986.jpg", objPath: "objects/1703593972.zip", isWaterActive: false, createdAt: "2023-12-10T09:04:33.000000Z", updatedAt: "2023-12-26T12:33:06.000000Z")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(DeviceTableViewCell.nib(), forCellReuseIdentifier: DeviceTableViewCell.identifier)
        // Load images from assets
        let NavBar_Home = UIImage(named: "NavBar_Home")
        let NavBar_Logo = UIImage(named: "NavBar_Logo")
        let NavBar_Search = UIImage(named: "NavBar_Search")
        
        //Setting up Black tint with property
        imgLeft.leftBarButtonItem = UIBarButtonItem(image: NavBar_Home, style: .plain, target: nil, action: nil);
        imgLeft.leftBarButtonItem?.tintColor = .black

        imgCenter.titleView = UIImageView(image: NavBar_Logo);
        imgRight.rightBarButtonItem = UIBarButtonItem(image: NavBar_Search, style: .plain, target: nil, action: nil);
        imgRight.rightBarButtonItem?.tintColor = .black
    }


}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    //Selected Item
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Print Selected item
        //print(data[indexPath.row])
        
        //Navigate to a different Screen
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "DetailView")
        view.navigationItem.title = data[indexPath.row].imei
        navigationController?.pushViewController(view, animated: true)
    }
    
    //Number of items
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeviceTableViewCell.identifier, for: indexPath) as! DeviceTableViewCell
        cell.cellImage.image = UIImage(systemName: "square.fill")
        cell.cellLabel.text = data[indexPath.row].imei
        return cell
    }
    
    
}
