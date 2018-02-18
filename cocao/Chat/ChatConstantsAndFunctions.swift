//
//  ChatConstantsAndFunctions.swift
//  cocao
//
//  Created by Josh Wolff on 2/17/18.
//  Copyright © 2018 jw1. All rights reserved.
//

import Foundation
import UIKit

public class ChatConstantsAndFunctions {
    
    static let computerId = "COMPUTER"
    static let userId = "joshwolff7"
    
    static let GOOGLE_API_KEY = "AIzaSyD8YIsBN5wIOpoDQOlVrU_LMwxglP7igjQ"
    
    static let leftComputerConstant = CGFloat(8)
    static let rightComputerConstant = CGFloat(82)
    
    static let leftHumanConstant = CGFloat(82)
    static let rightHumanConstant = CGFloat(8)
    
    static var newChats : [ChatMessage] = []
    
    static var languageChosen = "ESPAÑOL"
    static var languageChosenApple = "es_MX"
    static var languageChosenGoogle = "es"
    
    static let englishLanguage = "ENGLISH"
    static let englishLanguageApple = "en_US"
    static let englishLanguageGoogle = "en"
    
    static let spanishLanguage = "ESPAÑOL"
    static let spanishLanguageApple = "es_MX"
    static let spanishLanguageGoogle = "es"
    
    static let chineseLanguage = "中文"
    static let chineseLanguageApple = "zh_Hant"
    static let chineseLanguageGoogle = "zh-TW"
    
    static let koreanLanguage = "한국어"
    static let koreanLanguageApple = "ko_KR"
    static let koreanLanguageGoogle = "ko"

    static let frenchLanguage = "FRANÇAIS"
    static let frenchLanguageApple = "fr"
    static let frenchLanguageGoogle = "fr"
    
    static let dutchLanguage = "NEDERLANDS"
    static let dutchLanguageApple = "nl"
    static let dutchLanguageGoogle = "nl"
    
    static let germanLanguage = "DEUTSCHE"
    static let germanLanguageApple = "de"
    static let germanLanguageGoogle = "de"
    
    static let russianLanguage = "РУССКИЙ"
    static let russianLanguageApple = "ru_MD"
    static let russianLanguageGoogle = "ru"
    
    static let hindiLanguage = "हिंदी"
    static let hindiLanguageApple = "hi"
    static let hindiLanguageGoogle = "hi"
    
    static let arabicLanguage = "عربى"
    static let arabicLanguageApple = "ar_IQ"
    static let arabicLanguageGoogle = "ar"
    
    static let hebrewLanguage = "עִברִית"
    static let hebrewLanguageApple = "he"
    static let hebrewLanguageGoogle = "iw"
    
    static let languages : [String] = [spanishLanguage, englishLanguage, chineseLanguage, koreanLanguage, frenchLanguage, dutchLanguage, germanLanguage, russianLanguage, hindiLanguage, arabicLanguage, hebrewLanguage]
    static let appleCodeDictionary : [String: String] = [spanishLanguage: spanishLanguageApple, englishLanguage: englishLanguageApple, chineseLanguage: chineseLanguageApple, koreanLanguage: koreanLanguageApple, frenchLanguage: frenchLanguageApple, dutchLanguage: dutchLanguageApple, germanLanguage: germanLanguageApple, russianLanguage: russianLanguageApple, hindiLanguage: hindiLanguageApple, arabicLanguage: arabicLanguageApple, hebrewLanguage: hebrewLanguageApple]
     static let googleCodeDictionary : [String: String] = [spanishLanguage: spanishLanguageGoogle, englishLanguage: englishLanguageGoogle, chineseLanguage: chineseLanguageGoogle, koreanLanguage: koreanLanguageGoogle, frenchLanguage: frenchLanguageGoogle, dutchLanguage: dutchLanguageGoogle, germanLanguage: germanLanguageGoogle, russianLanguage: russianLanguageGoogle, hindiLanguage: hindiLanguageGoogle, arabicLanguage: arabicLanguageGoogle, hebrewLanguage: hebrewLanguageGoogle]
    
    class func speaking () {
        
    }
    
    
}
