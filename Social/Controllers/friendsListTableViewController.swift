//
//  friendsListTableViewController.swift
//  SocialApp
//
//  Created by Mahrukh khan on 9/23/19.
//  Copyright © 2019 Mahrukh khan. All rights reserved.
//

import UIKit
import Firebase

class friendsListTableViewController: UITableViewController {
    var headingColor: UIColor?

    var greenCOl = UIColor(red: 120, green: 166, blue: 148, alpha: 1.0)
    
    var friends = [UserList]()
    var messageControl: messagetableViewController?
    
    
    @IBAction func addFriend(_ sender: Any) {
        let addFriendController = friendsViewController()
        present(UINavigationController(rootViewController : addFriendController), animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        navigationItem.title = "Friends"
        fetchUser()
        
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
    
    func fetchUser(){
        let userid = Auth.auth().currentUser?.uid
        
        Database.database().reference().child("Users").child(userid!).child("Friends").observe(.childAdded, with: { (snapshot) in
            
            // Get user value
            if let value = snapshot.value as? NSDictionary  {
                let user = UserList()
                user.id = snapshot.key
                user.name = value["Username"] as? String
                user.email = value["email"] as? String
                
                self.friends.append(user)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        })
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friends.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        let user = friends[indexPath.row]
        print(user)
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        // Configure the cell...
        
        return cell
    }
    
    func showChatController(userlist : UserList) {
        
        let ChatController = chatController(collectionViewLayout: UICollectionViewFlowLayout())
        let naviController = UINavigationController(rootViewController: ChatController)
        ChatController.userlist = userlist
        present(naviController, animated: true, completion: nil)

        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.messageControl?.showChatController(userlist: user)
       let user = self.friends[indexPath.row]
            self.showChatController(userlist: user)

        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
