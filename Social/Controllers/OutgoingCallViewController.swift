//
//  OutgoingCallViewController.swift
//  SocialApp
//
//  Created by Mahrukh khan on 9/23/19.
//  Copyright © 2019 Mahrukh khan. All rights reserved.
//

import UIKit
import Firebase


class OutgoingCallViewController: UIViewController {
   
   @IBOutlet weak var numberOutlet: UITextField!
    var headingColor: UIColor?

    var phoneNumber = ""
    
    @IBOutlet weak var one1: UIButton!
    @IBOutlet weak var two2: UIButton!
    @IBOutlet weak var three3: UIButton!
    @IBOutlet weak var four4: UIButton!
    @IBOutlet weak var five5: UIButton!
    @IBOutlet weak var six6: UIButton!
    @IBOutlet weak var seven7: UIButton!
    @IBOutlet weak var eight8: UIButton!
    @IBOutlet weak var nine9: UIButton!
    @IBOutlet weak var zero0: UIButton!
    @IBOutlet weak var starout: UIButton!
    @IBOutlet weak var hastagout: UIButton!
    @IBOutlet weak var starlabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    numberOutlet.isUserInteractionEnabled = false
    
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
        navigation()
    }
    
    func navigation() {
        if let loadedData = UserDefaults.standard.data(forKey: "chosenBackground"), let backColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: loadedData), let loadedData1 = UserDefaults.standard.data(forKey: "chosenText"),let textColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: loadedData1)
            
        {
            one1.backgroundColor = backColor
            one1.setTitleColor(textColor, for: .normal)
            two2.backgroundColor = backColor
            two2.setTitleColor(textColor, for: .normal)
            three3.backgroundColor = backColor
            three3.setTitleColor(textColor, for: .normal)
            four4.backgroundColor = backColor
            four4.setTitleColor(textColor, for: .normal)
            five5.backgroundColor = backColor
            five5.setTitleColor(textColor, for: .normal)
            six6.backgroundColor = backColor
            six6.setTitleColor(textColor, for: .normal)
            seven7.backgroundColor = backColor
            seven7.setTitleColor(textColor, for: .normal)
            eight8.backgroundColor = backColor
            eight8.setTitleColor(textColor, for: .normal)
            nine9.backgroundColor = backColor
            nine9.setTitleColor(textColor, for: .normal)
            zero0.backgroundColor = backColor
            zero0.setTitleColor(textColor, for: .normal)
            starout.backgroundColor = backColor
            starlabel.textColor = textColor
            hastagout.backgroundColor = backColor
            hastagout.setTitleColor(textColor, for: .normal)
        }
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
   

        return false
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     numberOutlet.resignFirstResponder()
        
    }
    
    
    @IBAction func outCallButton(_ sender: UIButton) {
        phoneNumber = numberOutlet.text!
        if(phoneNumber == "")
        {
        }
        else{
            guard let uid = Auth.auth().currentUser?.uid else {
                    return
                }
            guard let phonenumber = numberOutlet?.text, let url = URL(string: "TEL://\(phonenumber)") else {
                       return
                   }
           let ref2 = Database.database().reference().child("UserRecentMessages").child(uid).child(phonenumber)
                
            ref2.updateChildValues(["PhoneNumber": phonenumber])
            UIApplication.shared.open(url)

        }
    }
    
 
    
    @IBAction func erase(_ sender: UIButton) {
    let number = numberOutlet.text!
        let newNum = String(number.dropLast())
    numberOutlet.text = newNum
      
    }
    
//numbers
   
     
    @IBAction func one(_ sender: UIButton) {
        let letter = "1"
        phoneNumber = (numberOutlet?.text)!
        phoneNumber.append(letter)
        numberOutlet.text = phoneNumber
        
    }
    
    @IBAction func two(_ sender: UIButton) {
        let letter = "2"
        phoneNumber = (numberOutlet?.text)!
        phoneNumber.append(letter)
        numberOutlet.text = phoneNumber
      
    }
    
    @IBAction func three(_ sender: UIButton) {
    let letter = "3"
        phoneNumber = (numberOutlet?.text)!
        phoneNumber.append(letter)
        numberOutlet.text = phoneNumber
       
    }
    
    
    @IBAction func four(_ sender: UIButton) {
         let letter = "4"
        phoneNumber = (numberOutlet?.text)!
        phoneNumber.append(letter)
        numberOutlet.text = phoneNumber
       
    }
    
    @IBAction func five(_ sender: UIButton) {
        let letter = "5"
        phoneNumber = (numberOutlet?.text)!
        phoneNumber.append(letter)
        numberOutlet.text = phoneNumber
        
    }
    

    @IBAction func six(_ sender: UIButton) {
         let letter = "6"
        phoneNumber = (numberOutlet?.text)!
        phoneNumber.append(letter)
        numberOutlet.text = phoneNumber
        
    }

    @IBAction func seven(_ sender: UIButton) {
         let letter = "7"
        phoneNumber = (numberOutlet?.text)!
        phoneNumber.append(letter)
        numberOutlet.text = phoneNumber
        
    }
    
    @IBAction func eight(_ sender: UIButton) {
         let letter = "8"
        phoneNumber = (numberOutlet?.text)!
        phoneNumber.append(letter)
        numberOutlet.text = phoneNumber
        
    }
    
    @IBAction func nine(_ sender: UIButton) {
         let letter = "9"
        phoneNumber = (numberOutlet?.text)!
        phoneNumber.append(letter)
        numberOutlet.text = phoneNumber
        
    }
    

    @IBAction func zero(_ sender: UIButton) {
         let letter = "0"
        phoneNumber = (numberOutlet?.text)!
        phoneNumber.append(letter)
        numberOutlet.text = phoneNumber
        
    }
    

    @IBAction func star(_ sender: UIButton) {
         let letter = "*"
        phoneNumber = (numberOutlet?.text)!
        phoneNumber.append(letter)
        numberOutlet.text = phoneNumber
        
    }
    
    @IBAction func hashtag(_ sender: UIButton) {
        let letter = "#"
        phoneNumber = (numberOutlet?.text)!
        phoneNumber.append(letter)
        numberOutlet.text = phoneNumber
        
    }
    


}
