//
//  SignupViewController.swift
//  Social
//
//  Created by Mahrukh on 9/28/19.
//  Copyright © 2019 Mahrukh. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //////////////////////////////////////////////////////////////////////
    //variables
    //var name:String?
   // var email:String?
   // var password:String?
    //////////////////////////////////////////////////////////////////////
    //outlets
    @IBOutlet weak var emailOutlet: UITextField!
    @IBOutlet weak var passwordOutlet: UITextField!
    //////////////////////////////////////////////////////////////////////
    //functions
    @IBAction func registerButton(_ sender: UIButton) {
     
        
        //if the outlets are empty don't do anything
        if( emailOutlet.text == "" || passwordOutlet.text == ""){
            
        }
            //otherwise continue
        else {
            //////////////////////////////////////////////////////////////////////
                 //assign the variables to the text fields
            if  let email = emailOutlet.text, let password = passwordOutlet.text{
                 //////////////////////////////////////////////////////////////////////
            //sign up user
            Auth.auth().createUser(withEmail: email, password: password, completion: { authResult, error in
                // ...
                guard let _ = authResult?.user, error == nil else {
                  return
                }
                    //user is found
                let uid = Auth.auth().currentUser?.uid
                let dictionary = ["email": email]
                Database.database().reference().child("Users").child(uid!).setValue(dictionary)
                self.parent?.dismiss(animated: true) {
                self.performSegue(withIdentifier: "go", sender: self)
                }
                }
                
            )
            //////////////////////////////////////////////////////////////////////
            }
        }
        
    }
    
}
