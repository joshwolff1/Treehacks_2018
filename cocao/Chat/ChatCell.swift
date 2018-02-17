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

    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    
    
    // create rest of outlets

    var chatMessage : ChatMessage!{
        didSet {
            self.updateUI()
        }
    }

    func updateUI() {

    }

}
