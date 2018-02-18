//
//  ChatImagePicker.swift
//  cocao
//
//  Created by Josh Wolff on 2/17/18.
//  Copyright © 2018 jw1. All rights reserved.
//

import Foundation
import UIKit

// THIS CLASS IS NO LONGER USED WITHIN THE PROJECT BUT MAY BE NECESSARY FOR COMPILATION, TEMPORARILY.
class ChatImagePicker: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.takePicture()
        _ = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(timerCalled), userInfo: nil, repeats: true)
        
    }
    
    @objc func timerCalled(timer: Timer) {
        self.takePicture()
    }
    
    func takePicture () {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerControllerSourceType.camera
        picker.cameraDevice = UIImagePickerControllerCameraDevice.front
        picker.showsCameraControls = false
        self.present(picker, animated: false, completion: picker.takePicture)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:  [String : Any]) {
        
        var currentImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        currentImage = UIImage(data: UIImagePNGRepresentation(currentImage)!)!
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "collectImage"), object: nil)
        
        picker.dismiss(animated: true, completion:  nil)
    }
}
