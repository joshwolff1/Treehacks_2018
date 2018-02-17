//
//  ViewController.swift
//  cocao
//
//  Created by Josh Wolff on 2/17/18.
//  Copyright © 2018 jw1. All rights reserved.
//

import UIKit
import Foundation

class InitialViewController: UIViewController {
    
    @IBOutlet weak var enterButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func didEnterMain() {
        self.performSegue(withIdentifier: "segueEnter", sender: AnyObject.self)
    }


}

