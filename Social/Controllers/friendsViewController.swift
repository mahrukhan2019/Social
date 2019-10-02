//
//  friendsViewController.swift
//  SocialApp
//
//  Created by Mahrukh khan on 9/12/19.
//  Copyright © 2019 Mahrukh khan. All rights reserved.
//

import UIKit
import Firebase

class friendsViewController: UIViewController {
    
    var getName = ""
     let nameofFriend: UITextField = UITextField(frame: CGRect(x: 44, y: 115, width: 300, height: 30))
     let submitButton: UIButton = UIButton(frame: CGRect(x: 150, y: 200, width: 70, height: 50))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        //navigation bar
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))

        setup()
        
    }
override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
    navigation()
    }

  func navigation() {
         if let loadedData = UserDefaults.standard.data(forKey: "chosenBackground"), let backColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: loadedData), let loadedData1 = UserDefaults.standard.data(forKey: "chosenText"),let textColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: loadedData1)
             
         {
             navigationController?.navigationBar.barTintColor = backColor
             
             let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: textColor]
             self.navigationController?.navigationBar.titleTextAttributes = titleDict as?         [NSAttributedString.Key : Any]
         }
         
     }
    func setup() {
        
        //text field
        nameofFriend.placeholder = "Enter Username of friend..."
        nameofFriend.font = UIFont.systemFont(ofSize: 25)
        nameofFriend.borderStyle = UITextField.BorderStyle.roundedRect
        view.addSubview(nameofFriend)
            
        
        //button
        submitButton.setTitle("Search", for: .normal)
        submitButton.backgroundColor = UIColor.blue
        submitButton.setTitleColor(UIColor.white, for: .normal)
        submitButton.addTarget(self, action: #selector(search), for: .touchUpInside)
        view.addSubview(submitButton)
        

    }
 
    
    @objc func search() {
       
        let userID = Auth.auth().currentUser?.uid
        Database.database().reference().child("Users").observe(.childAdded, with: { (snapshot)  in
                // Get user value
            self.getName = self.nameofFriend.text!
            
                let value = snapshot.value as? NSDictionary
                let user = FriendsList()
            user.id = snapshot.key
            if value!["Username"] as? String == self.getName {
                
                
                    user.name = value?["Username"] as? String
                    user.email = value?["email"] as? String
                   // let username = user.name
                Database.database().reference().child("Users").child(userID!).child("Friends").child(user.id!).child("Username").setValue(user.name)
                Database.database().reference().child("Users").child(userID!).child("Friends").child(user.id!).child("email").setValue(user.email)


               // Database.database().reference().child("Users").child(userID!).child("Friends").child(username!).child("email").setValue(user.email)
               // Database.database().reference().child("Users").child(userID!).child("Friends").child(username!).child("username").setValue(user.name)
                
                    self.dismiss(animated: true, completion: nil)
                
            }
            else {
                print("not found")
            }
            
            }  )
  
    }
 
   
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
}
