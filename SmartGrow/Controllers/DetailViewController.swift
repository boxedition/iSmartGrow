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
    
    var imei: String?
    @IBOutlet weak var Device: UILabel!
    @IBOutlet weak var Temperature: UILabel!
    @IBOutlet weak var Humidity: UILabel!
    @IBOutlet weak var WaterLvl: UILabel!
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var plantImg: UIImageView!
    @IBOutlet weak var btnRegar: UIButton!
    
    struct Log: Codable {
        let id: Int
        let arduino_id: Int
        let temperature: String
        let humidity: String
        let soil_value: String
        let soil_percentage: String
        let created_at: String
        let updated_at: String
    }
    
    struct Img: Codable {
        let imei: String
        let img_base64: String
    }
    
    @IBAction func regar(_ sender: Any) {
        switchWater()
    }
    
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
        performPostRequest()
        getImg()
        
        //imgRight.rightBarButtonItem = UIBarButtonItem(image: NavBar_Search, style: .plain, target: nil, action: nil);
        //imgRight.rightBarButtonItem?.tintColor = .black
    }
    
    func updateLabels(temp: String, hum: String, water: String) {
        // Access the values from the JSON response and update labels
        DispatchQueue.main.async {
            self.Device.text = self.imei
            self.Temperature.text = temp
            self.Humidity.text = hum
            self.WaterLvl.text = "\(water)%"
        }
    }
    
    
    func updateBtn() {
        // Access the values from the JSON response and update labels
        DispatchQueue.main.async {
            if self.btnRegar.tintColor == UIColor.red {
                self.btnRegar.tintColor = UIColor.blue
                self.btnRegar.setTitle("Regar", for: UIControl.State.normal)
            } else {
                self.btnRegar.tintColor = UIColor.red
                self.btnRegar.setTitle("Parar Rega", for: UIControl.State.normal)
            }
        }
    }
    
    
    func displayImage(from base64String: String, maxWidth: CGFloat, maxHeight: CGFloat) {
            // Convert the base64 string to Data
            if let data = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) {
                // Create a UIImage from the Data
                if let originalImage = UIImage(data: data) {
                    // Calculate the aspect ratio to maintain the image's proportions
                    let aspectRatio = originalImage.size.width / originalImage.size.height

                    // Calculate the scaled size based on the maxWidth and maxHeight
                    var scaledSize = CGSize(width: min(originalImage.size.width, maxWidth),
                                            height: min(originalImage.size.height, maxHeight))

                    // Adjust the scaled size to maintain the aspect ratio
                    if aspectRatio > 1 {
                        scaledSize.height = scaledSize.width / aspectRatio
                    } else {
                        scaledSize.width = scaledSize.height * aspectRatio
                    }

                    // Resize the image to the scaled size
                    let resizedImage = originalImage.resized(to: scaledSize)

                    // Set the UIImage to the UIImageView
                    DispatchQueue.main.async {
                        self.plantImg.image = resizedImage
                    }

                    // Set the content mode to scale the image proportionally
                    self.plantImg.contentMode = .scaleAspectFit
                } else {
                    print("Failed to create UIImage from data.")
                }
            } else {
                print("Failed to convert base64 string to data.")
            }
        }
    
    func getImg() {
        // Define the URL
        guard let url = URL(string: "https://api.boxdev.site/api/arduino/image") else {
            print("Invalid URL")
            return
        }
        
        // Create the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Set the parameters as JSON data
        let parameters = ["imei": imei]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print("Error encoding parameters: \(error.localizedDescription)")
            return
        }
        
        // Set the request headers if needed
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create the URLSession task
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            // Handle the response data if needed
            if let data = data {
                do {
                    let img = try JSONDecoder().decode(Img.self, from: data)
                    self.displayImage(from: img.img_base64, maxWidth: 80, maxHeight: 250)
                    // Handle the response accordingly
                } catch let error {
                    print("Error decoding response data: \(error.localizedDescription)")
                }
            }
        }
        
        // Resume the task to initiate the request
        task.resume()
    }
    
    func switchWater() {
        // Define the URL
        guard let url = URL(string: "https://api.boxdev.site/api/arduino/water/switch") else {
            print("Invalid URL")
            return
        }
        
        // Create the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Set the parameters as JSON data
        let parameters = ["imei": imei]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print("Error encoding parameters: \(error.localizedDescription)")
            return
        }
        
        // Set the request headers if needed
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create the URLSession task
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            // Handle the response data if needed
            if let data = data {
                do {
                    self.updateBtn()
                    // Handle the response accordingly
                } catch let error {
                    print("Error decoding response data: \(error.localizedDescription)")
                }
            }
        }
        
        // Resume the task to initiate the request
        task.resume()
    }


    func performPostRequest() {
            // Define the URL
            guard let url = URL(string: "https://api.boxdev.site/api/arduino/log/recent") else {
                print("Invalid URL")
                return
            }

            // Create the URLRequest
            var request = URLRequest(url: url)
            request.httpMethod = "POST"

            // Set the parameters as JSON data
            let parameters = ["imei": imei]
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch let error {
                print("Error encoding parameters: \(error.localizedDescription)")
                return
            }

            // Set the request headers if needed
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            // Create the URLSession task
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }

                // Handle the response data if needed
                if let data = data {
                    do {
                        let plant = try JSONDecoder().decode([Log].self, from: data)
                        self.updateLabels(temp: plant[0].temperature, hum: plant[0].humidity, water: plant[0].soil_percentage)
                        // Handle the response accordingly
                    } catch let error {
                        print("Error decoding response data: \(error.localizedDescription)")
                    }
                }
            }

            // Resume the task to initiate the request
            task.resume()
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

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }
}
