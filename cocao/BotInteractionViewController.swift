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
    
    @IBOutlet weak var cameraPicker : UIView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(collectImage), name: NSNotification.Name(rawValue: "collectImage"), object: nil)
        self.cameraPicker.isHidden = true
    }
    
    @objc func collectImage (image: UIImage) {
        // later change and send to AWS Rekognition
        if (ChatConstantsAndFunctions.imagesTaken.count != 0) {
            self.botGraphic.image = ChatConstantsAndFunctions.imagesTaken[ChatConstantsAndFunctions.imagesTaken.count - 1]
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueEmbedChat") {
            let embeddedChatViewController = segue.destination  as! ChatTableViewController
            //embeddedChatViewController.loadConversation()
        }
        if (segue.identifier == "segueImagePicker") {
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
  

}
