//
//  BotInteractionViewController.swift
//  cocao
//
//  Created by Josh Wolff on 2/17/18.
//  Copyright © 2018 jw1. All rights reserved.
//

import Foundation
import UIKit

class BotInteractionViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var botGraphic: UIImageView!
    @IBOutlet weak var chatContent : UIView!
    @IBOutlet weak var microphoneButton: UIButton!

    //private var embeddedChatViewController : ChatTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.embeddedChatViewController.loadConversation()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueEmbedChat") {
            let embeddedChatViewController = segue.destination  as! ChatTableViewController
            embeddedChatViewController.loadConversation()
            
            // Pass data to secondViewController before the transition
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
  

}
