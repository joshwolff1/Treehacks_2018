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
import ROGoogleTranslate
import CoreLocation
import AVFoundation

// This is the main class, used for the chat view controller.
class BotInteractionViewController: UIViewController, UIGestureRecognizerDelegate, SFSpeechRecognizerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var botGraphic: UIImageView!
    @IBOutlet weak var chatContent : UIView!
    
    @IBOutlet weak var microphoneButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    @IBOutlet weak var recordedResponse: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var languagePicker: UIPickerView!
    
    private var languageChosen = ChatConstantsAndFunctions.languageChosen
    
    private var queryText = ""
    private var translatedText = ""
    private var queryResponse = ""
    private var isFinalQuery = false
    
    private var locManager = CLLocationManager()
    private var currentLocation : CLLocation!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.hideResponseUI()
        self.setUpUI()
        self.setUpSpeechRecognition()
        
        self.setUpLocation()
        self.setUpPickerView()
    }
    
    //    MARK:- LOCATION PROTOCOL AND RELEVANT CODE
    
    func setUpLocation () {
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestAlwaysAuthorization()
        locManager.startUpdatingLocation()
        locManager.requestLocation()
        locManager.distanceFilter = kCLLocationAccuracyBest
        self.locManager.requestLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.currentLocation = locManager.location
        
        if (self.currentLocation == nil) {return}
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            locManager.requestLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let alertController = UIAlertController(title: "Location Error", message: "Failed to update current location.", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        return
    }
    
    //    MARK:- SPEECH RECOGNITION FUNCTIONS
    
    func setUpSpeechRecognition () {
        
      
        self.microphoneButton.isEnabled = false  //2
        //3
        
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
        self.stopRecordingButton.isHidden = true
        self.sendButton.isHidden = true
        self.cancelButton.isHidden = true
        self.chatContent.isHidden = false
    }
    
    func showResponseUI () {
        self.recordedResponse.isHidden = false
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
        
        var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
        var recognitionTask: SFSpeechRecognitionTask?
        
        let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: ChatConstantsAndFunctions.appleCodeDictionary[self.languageChosen]!))
        speechRecognizer?.delegate = self
        
        //        self.isFinalQuery = false
        
        let audioEngine = AVAudioEngine()
        
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
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        guard let recognitionRequestNew = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequestNew.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest!, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if ((result != nil) && (!self.isFinalQuery)) {
                
                print("HERE IS THE RESULT")
                print("\(result?.bestTranscription.formattedString)")
                isFinal = (result?.isFinal)!
                
                self.queryText = (result?.bestTranscription.formattedString)!
                self.recordResponse(response: self.queryText)
            }
            // error != nil
            if self.isFinalQuery {
                do {try audioSession.setActive(false) } catch {
                
                }
                audioEngine.stop()
                
                print("didStop")
                inputNode.removeTap(onBus: 0)
                recognitionRequest = nil
                recognitionTask = nil
                self.microphoneButton.isEnabled = true
                
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            recognitionRequest?.append(buffer)
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
    
    func translateQueryToEnglish (text: String) {
        let params = ROGoogleTranslateParams(source: ChatConstantsAndFunctions.googleCodeDictionary[self.languageChosen]!,
                                             target: ChatConstantsAndFunctions.englishLanguageGoogle,
                                             text:   text)
        
        let translator = ROGoogleTranslate()
        translator.apiKey = ChatConstantsAndFunctions.GOOGLE_API_KEY
        print("\(params)")
        translator.translate(params: params) { (result) in
            print("WITHIN TRANSLATION FUNCITON")
            print("Translation: \(result)")
            self.translatedText = result
        }
    }
    
    func translateResultToLanguage (text: String) {
        
        let params = ROGoogleTranslateParams(source: ChatConstantsAndFunctions.englishLanguageGoogle,
                                             target: ChatConstantsAndFunctions.googleCodeDictionary[self.languageChosen]!,
                                             text:   text)
        
        let translator = ROGoogleTranslate()
        translator.apiKey = ChatConstantsAndFunctions.GOOGLE_API_KEY
        print("\(params)")
        
        translator.translate(params: params) { (result) in
            let queryResponseChat = ChatMessage(_userId: ChatConstantsAndFunctions.computerId, _message: result, _chatId: String(describing: ChatMessage.fetchChats().count))
            ChatConstantsAndFunctions.newChats.append(queryResponseChat)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadChats"), object: nil)
            self.textToSpeech(text: result, language: ChatConstantsAndFunctions.appleCodeDictionary[self.languageChosen]!)
            print("WITHIN TRANSLATION FUNCITON")
            print("Translation: \(result)")
        }
    }
    
    // Text To Speech
    func textToSpeech (text: String, language: String) {
        let synth = AVSpeechSynthesizer()
        var myUtterance = AVSpeechUtterance(string: text)
        myUtterance.voice = AVSpeechSynthesisVoice(language: language)
        myUtterance.rate = 0.4
        synth.speak(myUtterance)
        
    }
    
    func queryHoundify(aQuery: String) {
        HoundTextSearch.instance().search(withQuery: aQuery, requestInfo: nil, completionHandler:
            { (error: Error?, myQuery: String, houndServer: HoundDataHoundServer?, dictionary: [String : Any]?, requestInfo: [String : Any]?) in
                if houndServer != nil, let dictionary = dictionary, let response = houndServer {
                    if let commandResult = response.allResults?.firstObject() as? HoundDataCommandResult {
                        print(commandResult["SpokenResponse"]!)
                        if (self.languageChosen != ChatConstantsAndFunctions.englishLanguage) {
                            self.translateResultToLanguage(text: commandResult["SpokenResponse"]! as! String)
                        } else {
                            let queryResponseChat = ChatMessage(_userId: ChatConstantsAndFunctions.computerId, _message: commandResult["SpokenResponse"]! as! String, _chatId: String(describing: ChatMessage.fetchChats().count))
                            ChatConstantsAndFunctions.newChats.append(queryResponseChat)
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadChats"), object: nil)
                            self.textToSpeech(text: commandResult["SpokenResponse"]! as! String, language: ChatConstantsAndFunctions.appleCodeDictionary[self.languageChosen]!)
                        }
                    }
                    
                }
        }
        )
    }
    
    //    MARK:- PICKER PROTOCOL STUBS
    
    func setUpPickerView () {
        self.languagePicker.delegate = self
        self.languagePicker.dataSource = self
        self.languagePicker.backgroundColor = UIColor.lightGray
        self.languagePicker.layer.cornerRadius = 5
        self.languagePicker.layer.masksToBounds = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ChatConstantsAndFunctions.languages.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ChatConstantsAndFunctions.languages[row]
    }
    
    // Catpure the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.languageChosen = ChatConstantsAndFunctions.languages[row]
        print("\(self.languageChosen)")
        return
    }
    
    
    
    //  MARK:- IB ACTIONS
    
    @IBAction func recordText () {
        
        self.queryText = ""
        self.isFinalQuery = false
        self.microphoneButton.isHidden = true
        self.stopRecordingButton.isHidden = false
        self.startRecording()
        
    }
    
    @IBAction func stopRecording () {
        self.microphoneButton.isHidden = false
        self.stopRecordingButton.isHidden = true
        self.isFinalQuery = true
        
        
        print("TRANSLATION")
        print(self.queryText)
        
        self.stopRecordingButton.isHidden = true
        self.cancelButton.isHidden = false
        self.sendButton.isHidden = false
        
        if (self.languageChosen != ChatConstantsAndFunctions.englishLanguage) {
            self.translateQueryToEnglish(text: self.queryText)
        } else {
            self.translatedText = self.queryText
        }
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
        self.queryResponse = ""
        self.recordedResponse.text = ""
    }
    
    @IBAction func sendResponse () {
        let newChat = ChatMessage(_userId: ChatConstantsAndFunctions.userId, _message: self.recordedResponse.text, _chatId: String(describing: ChatMessage.fetchChats().count))
        ChatConstantsAndFunctions.newChats.append(newChat)
        self.queryHoundify(aQuery: self.translatedText)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadChats"), object: nil)
        self.hideResponseUI()
    }
    
}
