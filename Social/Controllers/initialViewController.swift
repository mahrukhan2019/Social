//
//  initialViewController.swift
//  Social
//
//  Created by Mahrukh on 9/28/19.
//  Copyright © 2019 Mahrukh. All rights reserved.
//

import UIKit

class initialViewController: UIViewController {
    
    override func viewDidLoad() {
        definesPresentationContext = true

        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton(_ sender: UIButton) {

        performSegue(withIdentifier: "go", sender: self )
    }
    @IBAction func registerButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "go1", sender: self )
}
    
}
