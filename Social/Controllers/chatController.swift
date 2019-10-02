//
//  chatController.swift
//  SocialApp
//
//  Created by Mahrukh khan on 9/16/19.
//  Copyright © 2019 Mahrukh khan. All rights reserved.
//

import UIKit
import Firebase

class chatController: UICollectionViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout {
    
    var messages = [Message]()
    let cellid = "cellid"
    var userid = Auth.auth().currentUser?.uid
    var containerViewbottomancor : NSLayoutConstraint?
    
    var userlist: UserList? {
        didSet {
            navigationItem.title = userlist?.name
            observeMessage()
        }
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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBarItem.isEnabled = false
        tabBarController?.tabBar.isHidden = true

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Messages", style: .plain, target: self, action: #selector(gotoMessages))
 
 
        collectionView?.alwaysBounceVertical = true
        collectionView?.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(ChatMessageCellCollectionViewCell.self, forCellWithReuseIdentifier: cellid)
        collectionView?.keyboardDismissMode = .interactive
        //   setupComponent()
        setupKeyboardObservers1()
        
        
    }
    
    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter message..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    let sendButton:UIButton = {
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: .normal)
        sendButton.setTitleColor(UIColor.blue, for:.normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        return sendButton
    }()
    
   
    lazy var inputContainerView: UIView = {
        
        let containerView = UIView()
        containerView.frame = CGRect(x:0, y:0, width: self.view.frame.width, height: 50)
        containerView.backgroundColor = UIColor.white
        
        
        
        //sendbutton
        
        containerView.addSubview(self.sendButton)
        
        //x,y,w,h constraint anchors for input textfield
        self.sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 8).isActive = true
        self.sendButton.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        self.sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        self.sendButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //-----------------------------------Add input textfield--------------------------------
        containerView.addSubview(self.inputTextField)
        //x,y,w,h constraint anchors for input textfield
        self.inputTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        self.inputTextField.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        self.inputTextField.rightAnchor.constraint(equalTo: self.sendButton.leftAnchor, constant: 8).isActive = true
        self.inputTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
       
        
        
        //-------------------Add a line separating input container and messages view --------------
        let separatorLineView = UIView()
        separatorLineView.backgroundColor = UIColor.black
        separatorLineView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(separatorLineView)
        //x,y,w,h constraint anchors for separatorLine
        separatorLineView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        separatorLineView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        separatorLineView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        separatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
      
        
      
        return containerView
    }()
    override var inputAccessoryView: UIView?{
        get{
            return inputContainerView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        
        get{
            return true
        }
    }
    
    
    
    func setupKeyboardObservers1(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    @objc func handleKeyboardDidShow(notification: Notification){
        if messages.count > 0{
            let index = messages.count - 1
            let indexPath = NSIndexPath(item: index, section: 0)
            self.collectionView?.scrollToItem(at: indexPath as IndexPath, at: .top, animated: true)
        }
        
    }
    
    func observeMessage(){
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let userMessRef = Database.database().reference().child("UserMessages").child(uid)
        userMessRef.observe(.childAdded, with: { (snapshot) in
            
            let meskey = snapshot.key
            print(meskey)
            
            let userMessRef1 = Database.database().reference().child("UserMessages").child(uid).child(meskey)
            userMessRef1.observe(.childAdded, with: { (snapshot1) in
            
                let meskey2 = snapshot1.key
                print("meskey2")
                print(meskey2)

                let userMessRef2 = Database.database().reference().child("Messages").child(meskey2)
                userMessRef2.observeSingleEvent(of: .value, with: { (snapshot2) in
                    
                    guard let dictionary = snapshot2.value as? [String: AnyObject] else {
                                       return
                                   }
                    let message = Message()
                    message.fromID = dictionary["fromID"] as? String
                    message.Text = dictionary["Text"]  as? String
                    message.toId = dictionary["toId"]  as? String
                    message.timeStamp = dictionary["timeStamp"]  as? NSNumber
                    
                   if message.chatPartnerID() == self.userlist?.id
                    {
                        self.messages.append(message)
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                        
                    }
                }, withCancel: nil)
              
            }, withCancel: nil)
            
        }, withCancel: nil)
    }
    
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        
    }
    
  
    
    @objc func gotoMessages(){
        
    dismiss(animated: true){
            self.present(messagetableViewController(), animated: true, completion: nil)
        }
 
 
    }
 
    @objc func handleKeyboardwillshow (notification: NSNotification){
        let keyFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let screenframe = keyFrame.cgRectValue
        let keyboardduration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        containerViewbottomancor?.constant = -screenframe.height
        UIView.animate(withDuration: keyboardduration!) {
            self.view.layoutIfNeeded()
        }
        
        
    }
    @objc func handleKeyboardwillhide(notification: NSNotification){
        let keyboardduration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        containerViewbottomancor?.constant = 0
        UIView.animate(withDuration: keyboardduration!) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if inputTextField.text!.isEmpty{
          return false
        }
        else {
        handleSend()
            
        return true
        }
    }
    @objc func handleSend (){
        if inputTextField.text!.isEmpty{
            
        }
        else {
        let ref = Database.database().reference().child("Messages")
        let childref = ref.childByAutoId()
        let toId = userlist?.id
        let fromID = Auth.auth().currentUser!.uid
        let timeStamp : NSNumber = NSNumber(value: Int(NSDate().timeIntervalSince1970))
        let values = ["Text" : inputTextField.text!, "toId" : toId!, "fromID": fromID, "timeStamp" : timeStamp] as [String : Any]
        //childref.updateChildValues(values)
        
        let messageid = childref.key
        childref.updateChildValues(values) { (nil, ref)  in
            self.inputTextField.text = nil
            
            let reference = Database.database().reference().child("UserMessages")
            let childref2 = reference.child(fromID).child(toId!)
            childref2.updateChildValues([messageid! : 1])
            
            let recipient = Database.database().reference().child("UserMessages").child(toId!).child(fromID)
            recipient.updateChildValues([messageid! : 1])
        }
        
        }
    }
    
    //collectionView
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! ChatMessageCellCollectionViewCell
        
        let message = messages[indexPath.item]
        cell.textView.text = message.Text
        
        if message.fromID == Auth.auth().currentUser?.uid {
            //outgoing
            cell.bubbleView.backgroundColor = ChatMessageCellCollectionViewCell.blueColor
            cell.textView.textColor = UIColor.white
            cell.bubblerightAnchor?.isActive = true
            cell.bubbleleftAnchor?.isActive = false
        }
        else {
            //incoming
            cell.bubbleView.backgroundColor = UIColor.lightGray
            cell.textView.textColor = UIColor.black
            cell.bubblerightAnchor?.isActive = false
            cell.bubbleleftAnchor?.isActive = true
            
        }
        
        
        
        cell.bubblewidthAnchor?.constant = estimateFrameForText(text: message.Text!).width + 32
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 80
        if let text = messages[indexPath.row].Text {
            height = estimateFrameForText(text: text).height + 20
        }
        
        let width = UIScreen.main.bounds.width
        
        return CGSize(width: width, height: height)
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    
    
    
    //private
    private func estimateFrameForText(text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil )
    }
    
}


