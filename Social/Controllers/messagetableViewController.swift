//
//  messagetableViewController.swift
//  
//
//  Created by Mahrukh khan on 9/9/19.
//

import UIKit
import Firebase

class messagetableViewController: UITableViewController{
    
    
    
    
    var headingColor: UIColor?
    
    
    let cellId = "cellId"
    var username = ""
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
        navigation()
        let uid = Auth.auth().currentUser?.uid
        
        if (uid == nil){
            self.handleLogout()
        }
        else {
            
            username = getUsername()
            self.messages.removeAll()
            self.messagesDictionary.removeAll()
            self.tableView.reloadData()
            
            
        }
        
        
        tableView.allowsMultipleSelectionDuringEditing = true
        
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
        
        
        
    }
    
    func navigation() {
        if let loadedData = UserDefaults.standard.data(forKey: "chosenBackground"), let backColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: loadedData), let loadedData1 = UserDefaults.standard.data(forKey: "chosenText"),let textColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: loadedData1)
            
        {
            
            navigationController?.navigationBar.barTintColor = backColor
            
            let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: textColor]
            self.navigationController?.navigationBar.titleTextAttributes = titleDict as?         [NSAttributedString.Key : Any]
            
        }
        
    }
    
    
    var  messages = [Message]()
    var messagesDictionary = [String: Message]()
    
    func observeuserMessages() {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let ref = Database.database().reference().child("UserMessages").child(uid)
        ref.observe(.childAdded, with: { (snapshot) in
            
            let messageid = snapshot.key
            let messagereference = Database.database().reference().child("UserMessages").child(messageid)
            
            messagereference.observe(.childAdded, with: { (snapsho) in
                
                
                let messageid2 = snapsho.key
                
                let messagereference1 = Database.database().reference().child("UserMessages").child(messageid).child(messageid2)
                
                messagereference1.observe(.childAdded, with: { (snapshot1) in
                    
                    let messageid3 = snapshot1.key
                    
                    
                    let mesref = Database.database().reference().child("Messages").child(messageid3)
                    
                    mesref.observeSingleEvent(of: .value, with: { (snap3) in
                        
                        
                        if let dictionary = snap3.value as? [String: AnyObject] {
                            let message = Message()
                            
                            message.Text = dictionary["Text"] as? String
                            message.fromID = dictionary["fromID"] as? String
                            message.toId = dictionary["toId"] as? String
                            message.timeStamp = dictionary["timeStamp"] as? NSNumber
                            
                            //self.messages.append(message)
                            if let chatPartnerid = message.chatPartnerID(){
                                self.messagesDictionary[chatPartnerid] = message
                               
                            }
                            self.attemptReloadOfTable()
                            
                        }
                        
                        
                    }, withCancel: nil)
    
                })
                
            }, withCancel: nil)
            
            
        })
        
    //
        ref.observe(.childRemoved, with: { (snap) in
            
            self.messagesDictionary.removeValue(forKey: snap.key)
            self.attemptReloadOfTable()
        
        }, withCancel: nil)
        
    }
    
    
    
    
    var timer: Timer?
    func attemptReloadOfTable(){
      self.timer?.invalidate()
      self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.reloadTimer), userInfo: nil, repeats: false)
      
      
      }
    @objc func reloadTimer(){
        
        
        self.messages = Array(self.messagesDictionary.values)
        self.messages.sort(by: { (m1, m2) -> Bool in
         return (m1.timeStamp?.intValue)! > (m2.timeStamp?.intValue)!
          })
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
  
    
    func handleLogout (){
        
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "go", sender: self)
        } catch let logouterror {
            print(logouterror)
        }
    }
    
    
    func getUsername() -> String{
        
        
        observeuserMessages()
        
        
        var username1 = ""
        
        let userID = Auth.auth().currentUser?.uid
        Database.database().reference().child("Users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            username1 = value?["Username"] as? String ?? ""
            self.navigationItem.title = username1
            
        }  )
        
        
        return username1
    }
    
    
    func showChatController(userlist : UserList) {
        
        let ChatController = chatController(collectionViewLayout: UICollectionViewFlowLayout())
        let naviController = UINavigationController(rootViewController: ChatController)
        ChatController.userlist = userlist
        present(naviController, animated: true, completion: nil)
        
        
    }
    
    
    
    
    
    
    
    //tableview
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        let message = messages[indexPath.row]
        cell.selectionStyle = .default
    cell.message = message
        return cell
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let message = self.messages[indexPath.row]
        guard let chatPartnerId = message.chatPartnerID() else {
            return
        }
        let ref = Database.database().reference().child("Users").child(chatPartnerId)
        ref.observeSingleEvent(of: .value) { (snapshot) in
            
            guard let dictionary = snapshot.value as? [String: AnyObject]
                else {
                    return
            }
            
            let user = UserList()
            user.name = dictionary["Username"] as? String
            user.email = dictionary["email"] as? String
            user.id = chatPartnerId
            self.showChatController(userlist: user)
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let message = self.messages[indexPath.row]
        if let chatPartnerID = message.chatPartnerID(){
            
            Database.database().reference().child("UserMessages").child(uid).child(chatPartnerID).removeValue { (error, ref) in
                
                if error != nil {
                    print("error deleting", error!)
                    return
                }
                
               // self.messages.remove(at: indexPath.row)
                //self.tableView.deleteRows(at: [indexPath], with: .automatic)
                self.messagesDictionary.removeValue(forKey: chatPartnerID)
                self.attemptReloadOfTable()
            }
            
            
        }
    }
    
    
    
    
}

