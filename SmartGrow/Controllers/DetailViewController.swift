//
//  DetailViewController.swift
//  SmartGrow
//
//  Created by box on 30/12/2023.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imgLeft: UINavigationItem!
    
    @IBOutlet weak var imgCenter: UINavigationItem!
    
    @IBOutlet weak var imgRight: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let NavBar_Home = UIImage(named: "NavBar_GoBack")
        let NavBar_Logo = UIImage(named: "NavBar_Logo")
        //let NavBar_Search = UIImage(named: "NavBar_Search")
        
        //Setting up Black tint with property
        imgLeft.leftBarButtonItem = UIBarButtonItem(image: NavBar_Home, style: .plain, target: self, action: #selector(goBack))
        imgLeft.leftBarButtonItem?.tintColor = .black

        imgCenter.titleView = UIImageView(image: NavBar_Logo);
        //imgRight.rightBarButtonItem = UIBarButtonItem(image: NavBar_Search, style: .plain, target: nil, action: nil);
        //imgRight.rightBarButtonItem?.tintColor = .black
  }
    
    @objc func goBack() {
      navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
