//
//  UserCell.swift
//  SocialApp
//
//  Created by Mahrukh khan on 9/19/19.
//  Copyright © 2019 Mahrukh khan. All rights reserved.
//

import UIKit
import Firebase

 
class UserCell: UITableViewCell {
    
    var message: Message? {
        didSet {
          setupname()
            detailTextLabel?.text = message?.Text
            if let seconds = message?.timeStamp?.doubleValue{
                let timeStampDate = Date(timeIntervalSince1970 : seconds)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm:ss a"
                timeLabel.text = dateFormatter.string(from: timeStampDate)

            }
            
        }
    }
    
    private func setupname(){
      
        if let id = message?.chatPartnerID() {
            let ref = Database.database().reference().child("Users").child(id)
            ref.observeSingleEvent(of: .value) { (snapshot) in
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    self.textLabel?.text = dictionary["Username"] as? String
                }
            }
            
        }
    }
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        addSubview(timeLabel)
        
        timeLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        timeLabel.heightAnchor.constraint(equalTo: textLabel!.heightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
