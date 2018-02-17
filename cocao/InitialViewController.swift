//
//  ViewController.swift
//  cocao
//
//  Created by Josh Wolff on 2/17/18.
//  Copyright © 2018 jw1. All rights reserved.
//

import UIKit
import Foundation

class InitialViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var logoImage : UIImageView!
    @IBOutlet weak var enterButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let touchedLogo = UITapGestureRecognizer(target: self, action: #selector(touchedLogoAction))
        self.logoImage.isUserInteractionEnabled = true
        self.logoImage.addGestureRecognizer(touchedLogo)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @objc func touchedLogoAction (tapGR: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "segueEnter", sender: AnyObject.self)
    }
    
    @IBAction func didEnterMain() {
        self.performSegue(withIdentifier: "segueEnter", sender: AnyObject.self)
    }


}

