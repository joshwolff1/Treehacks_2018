//
//  TempHound.swift
//  cocao
//
//  Created by Josh Wolff on 2/17/18.
//  Copyright © 2018 jw1. All rights reserved.
//

import Foundation
import UIKit

import HoundifySDK

class TempHound: UIViewController {

    @IBOutlet weak var recordButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad(  )

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    @IBAction func didStartRecording() {
        Houndify.instance().presentListeningViewController(in: self,
                                                           from: nil,
                                                           style: nil,
                                                           requestInfo: [:],
                                                           responseHandler:
            { (error: Error?, response: Any?, dictionary: [String : Any]?, requestInfo: [String : Any]?) in


                if  let serverData = response as? HoundDataHoundServer,
                    let commandResult = serverData.allResults?.firstObject() as? HoundDataCommandResult,
                    let nativeData = commandResult["NativeData"]
                {
                    let myStringDict = nativeData as? [String : AnyObject]
                    let test = myStringDict!["FormattedTranscription"]! as! String
                    print(myStringDict!["FormattedTranscription"]!)
                   
                }

                self.dismissSearch()
            }
        )
    }
    
    fileprivate func dismissSearch() {
        Houndify.instance().dismissListeningViewController(animated: true, completionHandler: nil)
    }

    @IBAction func didPressAndHoldRecording() {
        print("done")
    }

}

