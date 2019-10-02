//
//  getusernameViewController.swift
//  Social
//
//  Created by Mahrukh on 9/29/19.
//  Copyright © 2019 Mahrukh. All rights reserved.
//

import UIKit
import Firebase

class getusernameViewController: UIViewController {

    @IBOutlet weak var getNameUser: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()

            }
    

    @IBAction func registerButton(_ sender: UIButton) {
        let userID = Auth.auth().currentUser!.uid
        let name = getNameUser.text!
        
        
        Database.database().reference().child("Users").child(userID).child("Username").setValue(name)
        
        
        self.performSegue(withIdentifier: "go", sender: self)
    }
    
}
