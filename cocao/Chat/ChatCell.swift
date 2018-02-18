//
//  ChatCell.swift
//  cocao
//
//  Created by Josh Wolff on 2/17/18.
//  Copyright © 2018 jw1. All rights reserved.
//

import Foundation
import UIKit

class ChatCell: UITableViewCell {
    
    @IBOutlet weak var computerIcon: UIImageView!
    @IBOutlet weak var humanIcon: UIImageView!
    @IBOutlet weak var separatorView: UIView!
    
    @IBOutlet weak var chatText: UILabel!
    
    @IBOutlet var leftTextConstraint: NSLayoutConstraint!
    @IBOutlet var leftImageToTextConstraint: NSLayoutConstraint!
    
    @IBOutlet var rightTextConstraint: NSLayoutConstraint!
    @IBOutlet var rightImageToTextConstraint: NSLayoutConstraint!
    
    @IBOutlet var textWidth: NSLayoutConstraint!

    var chatMessage : ChatMessage!{
        didSet {
            self.updateUI()
        }
    }

    func updateUI() {
        
        self.separatorView.isHidden = true
        
        self.chatText?.layer.cornerRadius = 5
        self.chatText?.layer.masksToBounds = true
        self.chatText?.text = " " + self.chatMessage._message!
        
        if self.chatMessage._userId != ChatConstantsAndFunctions.computerId {
            
            self.rightTextConstraint.constant = ChatConstantsAndFunctions.rightHumanConstant
            self.rightImageToTextConstraint.constant = ChatConstantsAndFunctions.rightHumanConstant
          
            self.leftTextConstraint.constant = ChatConstantsAndFunctions.leftHumanConstant
            self.leftImageToTextConstraint.constant = ChatConstantsAndFunctions.leftHumanConstant
            
            self.humanIcon.isHidden = false
            self.computerIcon.isHidden = true

        } else {
            
            self.rightTextConstraint.constant = ChatConstantsAndFunctions.rightComputerConstant
            self.rightImageToTextConstraint.constant = ChatConstantsAndFunctions.rightComputerConstant
            
            self.leftTextConstraint.constant = ChatConstantsAndFunctions.leftComputerConstant
            self.leftImageToTextConstraint.constant = ChatConstantsAndFunctions.leftComputerConstant
            
            self.computerIcon.isHidden = false
            self.humanIcon.isHidden = true
        }
    }

}
