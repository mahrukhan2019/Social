//
//  ChatMessageCellCollectionViewCell.swift
//  SocialApp
//
//  Created by Mahrukh khan on 9/20/19.
//  Copyright © 2019 Mahrukh khan. All rights reserved.
//

import UIKit

class ChatMessageCellCollectionViewCell: UICollectionViewCell {
    
    let textView: UITextView = {
        let textv = UITextView()
        textv.font = UIFont.systemFont(ofSize: 16)
        textv.backgroundColor = UIColor.clear
        textv.translatesAutoresizingMaskIntoConstraints = false
        textv.isEditable = false
        return textv
    }()
    
    var bubblewidthAnchor: NSLayoutConstraint?
        var bubblerightAnchor: NSLayoutConstraint?
        var bubbleleftAnchor: NSLayoutConstraint?
    static let blueColor = UIColor.blue
    
    let bubbleView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()
    
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
       //bubble View
        addSubview(bubbleView)
        
        
        bubblerightAnchor = bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)
        bubbleleftAnchor = bubbleView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8)
        bubblerightAnchor?.isActive = true
        bubbleleftAnchor?.isActive = false
        bubbleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bubblewidthAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 200)
        bubblewidthAnchor?.isActive = true
        bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        
        
        
        //textView
        addSubview(textView)
      
       // textView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        textView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 8).isActive = true

        textView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
       // textView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        textView.rightAnchor.constraint(equalTo: bubbleView.rightAnchor).isActive = true
        textView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    



}
