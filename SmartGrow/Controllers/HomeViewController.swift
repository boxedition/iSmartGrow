//
//  ViewController.swift
//  SmartGrow
//
//  Created by box on 26/10/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var imgLeft: UINavigationItem!
    
    @IBOutlet weak var imgCenter: UINavigationItem!
    
    @IBOutlet weak var imgRight: UINavigationItem!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load images from assets
        let NavBar_Home = UIImage(named: "NavBar_Home")
        let NavBar_Logo = UIImage(named: "NavBar_Logo")
        let NavBar_Search = UIImage(named: "NavBar_Search")
        
        imgLeft.leftBarButtonItem = UIBarButtonItem(image: NavBar_Home, style: .plain, target: nil, action: nil);
        imgCenter.titleView = UIImageView(image: NavBar_Logo);
        imgRight.rightBarButtonItem = UIBarButtonItem(image: NavBar_Search, style: .plain, target: nil, action: nil);
        
        // Do any additional setup after loading the view.
    }


}

