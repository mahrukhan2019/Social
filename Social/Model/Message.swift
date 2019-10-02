//
//  Message.swift
//  SocialApp
//
//  Created by Mahrukh khan on 9/19/19.
//  Copyright © 2019 Mahrukh khan. All rights reserved.
//

import UIKit
import Firebase

class Message: NSObject {
    var toId: String?
    var fromID: String?
    var timeStamp: NSNumber?
    var Text: String?

    func chatPartnerID() -> String? {
    if fromID == Auth.auth().currentUser?.uid {
            return toId
        }
        else {
           return fromID
        }
        
    }
    
}
