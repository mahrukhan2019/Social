//
//  recentCallsTableViewController.swift
//  SocialApp
//
//  Created by Mahrukh khan on 9/24/19.
//  Copyright © 2019 Mahrukh khan. All rights reserved.
//

import UIKit
import Firebase

class recentCallsTableViewController: UITableViewController {
    
    var headingColor: UIColor?
  
    var deletenumber: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        getrecentdata()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
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
    
    var recents = [recent]()
    func getrecentdata() {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        
        let ref = Database.database().reference().child("UserRecentMessages").child(uid)
        
        ref.observe(.childAdded, with: { (snapshot) in
            
            let messageid = snapshot.key
            let messageref = Database.database().reference().child("UserRecentMessages").child(uid).child(messageid)
           
            messageref.observeSingleEvent(of: .value, with: { (snapshot) in
                 if let value = snapshot.value as? NSDictionary {
                let recentcall = recent()
                recentcall.phone = value["PhoneNumber"] as? String
                self.recents.append(recentcall)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                }
                
                
            }, withCancel: nil)
          
        }, withCancel: nil)
      
  
        
        
    }
        
        
        
        
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recents.count
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
     
        let recentcall = recents[indexPath.row]
        
        cell.textLabel?.text = recentcall.phone
        
     
     return cell
     }
     
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recentcall = self.recents[indexPath.row]
        let number = recentcall.phone
        
        
        guard (Auth.auth().currentUser?.uid) != nil else {
                    return
                }
            guard let phonenumber = number, let url = URL(string: "TEL://\(phonenumber)") else {
                       return
                   }
   
            UIApplication.shared.open(url)

        }
        
        
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
           
           return true
       }
       
       override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           
           

           guard let uid = Auth.auth().currentUser?.uid else {
               return
           }
           
        guard let number = recents[indexPath.row].phone else {
            return
        }
        
               
        let ref = Database.database().reference().child("UserRecentMessages").child(uid).child(number)
     
                   
        ref.removeValue()
        
                   self.recents.remove(at: indexPath.row)
                        self.tableView.deleteRows(at: [indexPath], with: .automatic)
                   
       
               
               
               
           
       }
       
    
}
