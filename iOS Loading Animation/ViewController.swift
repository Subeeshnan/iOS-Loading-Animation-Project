//
//  ViewController.swift
//  iOS Loading Animation
//
//  Created by SSBSOFT on 28/09/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var assetImage: UIImageView!
    
    @IBAction func start(_ sender: UIButton) {
        
        //Make start button disable
        sender.isEnabled = false
        
        getDataFromRemote(sender: sender)
    }
    
    
    func getDataFromRemote( sender: UIButton){
        
        imageRotateInit()
        
        let url = URL(string: "https://reqres.in/api/users?delay=3")!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            
            //Make start button enable
            sender.isEnabled = true
            
            guard data != nil else { return }
            
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data!) as? [String: Any] else {
                              print("Error: Cannot convert data to JSON object")
                              return
                          }
                          guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                              print("Error: Cannot convert JSON object to Pretty JSON data")
                              return
                          }
                          guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                              print("Error: Could print JSON in String")
                              return
                          }
                          
                          print(prettyPrintedJson)
            } catch {
                          print("Error: Trying to convert JSON data to string")
                          return
                      }
        
        }

        task.resume()
    }
    
    func imageRotateInit(){
        UIView.animate(withDuration: 3, animations: {
           self.assetImage.transform = self.assetImage.transform.rotated(by: CGFloat(Double.pi / 2))
        })
    }
}

