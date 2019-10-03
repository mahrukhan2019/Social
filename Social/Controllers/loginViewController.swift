//
//  loginViewController.swift
//  Social
//
//  Created by Mahrukh on 10/2/19.
//  Copyright © 2019 Mahrukh. All rights reserved.
//

import UIKit
import Firebase

class loginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var emailOutlet: UITextField!
    @IBOutlet weak var passwordOutlet: UITextField!
    
    @IBAction func LoginButton(_ sender: UIButton) {
    
       
       //if the outlets are empty don't do anything
       if( emailOutlet.text == "" || passwordOutlet.text == ""){
           
       }
           //otherwise continue
       else {
           //////////////////////////////////////////////////////////////////////
                //assign the variables to the text fields
           if  let email = emailOutlet.text, let password = passwordOutlet.text{
                //////////////////////////////////////////////////////////////////////
         Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
             guard let strongSelf = self else { return }
             // ...
           if let error = error {
            print(error)
             return
           }
            strongSelf.parent?.dismiss(animated: true) {
                strongSelf.performSegue(withIdentifier: "go", sender: self)

            }

            }
               
         
           }
        
                            
       }
       
   }
    
    
    
    

}
