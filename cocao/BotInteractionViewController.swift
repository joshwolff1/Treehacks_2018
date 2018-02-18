//
//  BotInteractionViewController.swift
//  cocao
//
//  Created by Josh Wolff on 2/17/18.
//  Copyright © 2018 jw1. All rights reserved.
//

import Foundation
import UIKit
import Speech
import HoundifySDK

class BotInteractionViewController: UIViewController, UIGestureRecognizerDelegate, SFSpeechRecognizerDelegate {
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var botGraphic: UIImageView!
    @IBOutlet weak var chatContent : UIView!
    @IBOutlet weak var microphoneButton: UIButton!
    
    @IBOutlet weak var recordedResponse: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ko_KR"))  // CHANGE WITH LANGUAGE LATER
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.hideResponseUI()
        self.setUpUI()
        self.setUpSpeechRecognition()
        
    }
    
    func setUpSpeechRecognition () {
        
        self.microphoneButton.isEnabled = false  //2
        self.speechRecognizer?.delegate = self  //3
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in  //4
            
            var isButtonEnabled = false
            
            if (authStatus == .authorized) {
                isButtonEnabled = true
            }
            
            OperationQueue.main.addOperation() {
                self.microphoneButton.isEnabled = isButtonEnabled
            }
        }
        
    }
    
    func setUpUI () {
        self.recordedResponse.layer.cornerRadius = 5
        self.recordedResponse.layer.masksToBounds = true
    }
    
    func hideResponseUI () {
        self.recordedResponse.isHidden = true
        self.sendButton.isHidden = true
        self.cancelButton.isHidden = true
        self.chatContent.isHidden = false
    }
    
    func showResponseUI () {
        self.recordedResponse.isHidden = false
        self.sendButton.isHidden = false
        self.cancelButton.isHidden = false
        self.chatContent.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueEmbedChat") {
//            let embeddedChatViewController = segue.destination  as! ChatTableViewController
//            embeddedChatViewController.loadConversation()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func startRecording() {
        
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                
                print("HERE IS THE RESULT")
                print("\(result?.bestTranscription.formattedString)")
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.microphoneButton.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            self.microphoneButton.isEnabled = true
        } else {
            self.microphoneButton.isEnabled = false
        }
    }
    
//    func translateQueryToEnglish () {
//        var params = ROGoogleTranslateParams(source: "en",
//                                             target: "en",
//                                             text:   "Here you can add your sentence you want to be translated")
//
//        let translator = ROGoogleTranslate(with: "API Key here")
//
//        translator.translate(params: params) { (result) in
//            print("Translation: \(result)")
//        }
//    }
    
//    func recordHoundify () {
//        Houndify.instance().presentListeningViewController(in: self,
//                                                           from: nil,
//                                                           style: nil,
//                                                           requestInfo: [:],
//                                                           responseHandler:
//            { (error: Error?, response: Any?, dictionary: [String : Any]?, requestInfo: [String : Any]?) in
//
//                var responseData : String = ""
//                if  let serverData = response as? HoundDataHoundServer,
//                    let commandResult = serverData.allResults?.firstObject() as? HoundDataCommandResult,
//                    let nativeData = commandResult["NativeData"]
//                {
//                    let myStringDict = nativeData as? [String : AnyObject]
//                    responseData = myStringDict!["FormattedTranscription"]! as! String
//                    print(myStringDict!["FormattedTranscription"]!)
//
//                }
//                self.recordResponse(response: responseData)
//                self.dismissSearch()
//            }
//        )
//    }
    
    func queryHoundify(aQuery: String) {
        HoundTextSearch.instance().search(withQuery: aQuery, requestInfo: nil, completionHandler:
            { (error: Error?, myQuery: String, houndServer: HoundDataHoundServer?, dictionary: [String : Any]?, requestInfo: [String : Any]?) in
                    if houndServer != nil, let dictionary = dictionary, let response = houndServer {
                        if let commandResult = response.allResults?.firstObject() as? HoundDataCommandResult {
                            print(commandResult["SpokenResponse"]!)
                        }
                    
                }
            }
        )
    }
    
    
//  MARK:- IB ACTIONS
    
    @IBAction func recordText () {
//        self.recordHoundify()
        self.queryHoundify(aQuery: "Where is the nearest hospital?")
    }
    
    fileprivate func dismissSearch() {
        Houndify.instance().dismissListeningViewController(animated: true, completionHandler: nil)
    }
    
    func recordResponse (response: String) {
        self.showResponseUI()
        self.recordedResponse.text = " " + response
    }
    
    @IBAction func cancelResponse () {
        self.hideResponseUI()
        self.recordedResponse.text = ""
    }
    
    @IBAction func sendResponse () {
        let newChat = ChatMessage(_userId: ChatConstantsAndFunctions.userId, _message: self.recordedResponse.text, _chatId: String(describing: ChatMessage.fetchChats().count))
        ChatConstantsAndFunctions.newChats.append(newChat)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadChats"), object: nil)
        self.hideResponseUI()
    }
    
}
