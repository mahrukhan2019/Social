//
//  settingControllerViewController.swift
//  SocialApp
//
//  Created by Mahrukh khan on 9/12/19.
//  Copyright © 2019 Mahrukh khan. All rights reserved.
//

import UIKit
import Firebase



class settingControllerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // var color = [UIColor.red, UIColor.blue, UIColor.green, UIColor.cyan, UIColor.yellow,UIColor(red: 120, green: 166, blue: 148, alpha: 1.0)]
    var colorName = ["Choose a Theme", "White","Red", "Blue", "Green", "Cyan", "Yellow", "Dark Green", "Purple", "Magenta", "Black"]
    var selected = 0
    var chosenBackground: UIColor?
    var chosentextColor: UIColor?
    var backgroundColor: UIColor?
    var textColor: UIColor?
    // @IBOutlet weak var titleText: UILabel!
    // @IBOutlet weak var headingView: UIView!
    
    @IBOutlet weak var nameOfUser: UITextField!
    @IBOutlet weak var colorPicker: UIPickerView!
    
    
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colorName.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = row
        
        
        if(selected == 1){
            backgroundColor = UIColor.white
            textColor = UIColor.black
            chosenBackground = backgroundColor
            chosentextColor = textColor
            let colorData : NSData = try! NSKeyedArchiver.archivedData(withRootObject: chosenBackground!, requiringSecureCoding: true) as NSData
            let textData : NSData = try! NSKeyedArchiver.archivedData(withRootObject: textColor!, requiringSecureCoding: true) as NSData
            
            UserDefaults.standard.set(colorData, forKey: "chosenBackground")
            
            UserDefaults.standard.set(textData , forKey: "chosenText")
          
            navigation()

            
        }
        else if(selected == 2){
            backgroundColor = UIColor.red
            textColor = UIColor.white
            chosenBackground = backgroundColor
            chosentextColor = textColor
            
            let colorData : NSData = try! NSKeyedArchiver.archivedData(withRootObject: chosenBackground!, requiringSecureCoding: true) as NSData
            let textData : NSData = try! NSKeyedArchiver.archivedData(withRootObject: textColor!, requiringSecureCoding: true) as NSData
            
            UserDefaults.standard.set(colorData, forKey: "chosenBackground")
            
            UserDefaults.standard.set(textData , forKey: "chosenText")
          navigation()

            
        }
        else if(selected == 3){
            backgroundColor = UIColor.blue
            textColor = UIColor.white
            chosenBackground = backgroundColor
            chosentextColor = textColor
            let colorData : NSData = try! NSKeyedArchiver.archivedData(withRootObject: chosenBackground!, requiringSecureCoding: true) as NSData
            let textData : NSData = try! NSKeyedArchiver.archivedData(withRootObject: textColor!, requiringSecureCoding: true) as NSData
            
            UserDefaults.standard.set(colorData, forKey: "chosenBackground")
            
            UserDefaults.standard.set(textData , forKey: "chosenText")
            
            navigation()

            
        }
        else if(selected == 4){
            backgroundColor = UIColor.green
            textColor = UIColor.black
            chosenBackground = backgroundColor
            chosentextColor = textColor
            let colorData : NSData = try! NSKeyedArchiver.archivedData(withRootObject: chosenBackground!, requiringSecureCoding: true) as NSData
            let textData : NSData = try! NSKeyedArchiver.archivedData(withRootObject: textColor!, requiringSecureCoding: true) as NSData
            
            UserDefaults.standard.set(colorData, forKey: "chosenBackground")
            
            UserDefaults.standard.set(textData , forKey: "chosenText")
           
            navigation()

            
        }
        else if(selected == 5){
            backgroundColor = UIColor.cyan
            textColor = UIColor.black
            chosenBackground = backgroundColor
            chosentextColor = textColor
            let colorData : NSData = try! NSKeyedArchiver.archivedData(withRootObject: chosenBackground!, requiringSecureCoding: true) as NSData
            let textData : NSData = try! NSKeyedArchiver.archivedData(withRootObject: textColor!, requiringSecureCoding: true) as NSData
            
            UserDefaults.standard.set(colorData, forKey: "chosenBackground")
            
            UserDefaults.standard.set(textData , forKey: "chosenText")
            
            navigation()

            
        }
        else if(selected == 6){
            backgroundColor = UIColor.yellow
            textColor = UIColor.black
            chosenBackground = backgroundColor
            chosentextColor = textColor
            let colorData : NSData = try! NSKeyedArchiver.archivedData(withRootObject: chosenBackground!, requiringSecureCoding: true) as NSData
            let textData : NSData = try! NSKeyedArchiver.archivedData(withRootObject: textColor!, requiringSecureCoding: true) as NSData
            
            UserDefaults.standard.set(colorData, forKey: "chosenBackground")
            
            UserDefaults.standard.set(textData , forKey: "chosenText")
           
            navigation()

        }
        else if(selected == 7){
            backgroundColor = UIColor(red:0.44, green:0.58, blue:0.51, alpha:1.0)
            textColor = UIColor.white
            chosenBackground = backgroundColor
            chosentextColor = textColor
            let colorData : NSData = try! NSKeyedArchiver.archivedData(withRootObject: chosenBackground!, requiringSecureCoding: true) as NSData
            let textData : NSData = try! NSKeyedArchiver.archivedData(withRootObject: textColor!, requiringSecureCoding: true) as NSData
            
            UserDefaults.standard.set(colorData, forKey: "chosenBackground")
            
            UserDefaults.standard.set(textData , forKey: "chosenText")
           
            navigation()

            
        }
        else if(selected == 8) {
            backgroundColor = UIColor.purple
            textColor = UIColor.white
            chosenBackground = backgroundColor
            chosentextColor = textColor
            let colorData : NSData = try! NSKeyedArchiver.archivedData(withRootObject: chosenBackground!, requiringSecureCoding: true) as NSData
            let textData : NSData = try! NSKeyedArchiver.archivedData(withRootObject: textColor!, requiringSecureCoding: true) as NSData
            
            UserDefaults.standard.set(colorData, forKey: "chosenBackground")
            
            UserDefaults.standard.set(textData , forKey: "chosenText")
            
            navigation()

        }
        else if(selected == 9) {
            backgroundColor = UIColor.magenta
            textColor = UIColor.black
            chosenBackground = backgroundColor
            chosentextColor = textColor
            let colorData : NSData = try! NSKeyedArchiver.archivedData(withRootObject: chosenBackground!, requiringSecureCoding: true) as NSData
            let textData : NSData = try! NSKeyedArchiver.archivedData(withRootObject: textColor!, requiringSecureCoding: true) as NSData
            
            UserDefaults.standard.set(colorData, forKey: "chosenBackground")
            
            UserDefaults.standard.set(textData , forKey: "chosenText")
           navigation()

            
        }
        else if (selected == 10) {
            backgroundColor = UIColor.black
            textColor = UIColor.white
            chosenBackground = backgroundColor
            chosentextColor = textColor
            let colorData : NSData = try! NSKeyedArchiver.archivedData(withRootObject: chosenBackground!, requiringSecureCoding: true) as NSData
            let textData : NSData = try! NSKeyedArchiver.archivedData(withRootObject: textColor!, requiringSecureCoding: true) as NSData
            
            UserDefaults.standard.set(colorData, forKey: "chosenBackground")
            
            UserDefaults.standard.set(textData , forKey: "chosenText")
            
            navigation()

            
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colorName[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.colorPicker.delegate = self
        self.colorPicker.dataSource = self
        getUsername()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
        
        
        navigation()
    }
    @IBOutlet weak var logoutoutlet: UIButton!
    
    func navigation() {
        if let loadedData = UserDefaults.standard.data(forKey: "chosenBackground"), let backColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: loadedData), let loadedData1 = UserDefaults.standard.data(forKey: "chosenText"),let textColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: loadedData1)
            
        {
            
            navigationController?.navigationBar.barTintColor = backColor
            
            let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: textColor]
            self.navigationController?.navigationBar.titleTextAttributes = titleDict as?         [NSAttributedString.Key : Any]
            logoutoutlet.backgroundColor = backColor
            logoutoutlet.setTitleColor(textColor, for: .normal)
            
           
        }
        
    }
    
    func getUsername() {
        
        let userID = Auth.auth().currentUser?.uid
        Database.database().reference().child("Users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let username = value?["Username"] as? String ?? ""
            self.nameOfUser.text = username
        }  )
        
    }
    
    @IBAction func handleLogout(_ sender: UIButton) {
        //let loginController = loginViewController()
        do{
            try Auth.auth().signOut()
            dismiss(animated: true) {
                self.performSegue(withIdentifier: "go", sender: self)
            }
            
        } catch let logouterror {
            print(logouterror)
            
        }
        
        
    }
    
    
    
    
    
    
}
