//
//  MicrosoftTranslateAPI.swift
//  cocao
//
//  Created by Josh Wolff on 2/17/18.
//  Copyright © 2018 jw1. All rights reserved.
//


import Foundation

private func getToken(key: String, completion block: @escaping (NSData?, URLResponse?, NSError?) -> Void) {
    
    let request = NSMutableURLRequest(url: NSURL(string: "https://api.cognitive.microsoft.com/sts/v1.0/issueToken")! as URL)
    request.httpMethod = "POST"
    request.addValue(key, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
    
    let session = URLSession.shared
    let task = session.dataTask(with: request as URLRequest)
    
    task.resume()
}

private func msTranslate(token: String, translate text: String, toLang lang: String, completion block: (NSData?, URLResponse?, NSError?) -> Void) {
    
    let c = NSURLComponents(string: "http://api.microsofttranslator.com/v2/Http.svc/Translate")
    
    c?.queryItems = [
        URLQueryItem(name: "text", value: text),
        URLQueryItem(name: "to", value: lang)
    ]
    
    guard let url = c?.url else {
        return
    }
    
    let request = NSMutableURLRequest(url: url)
    request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    let session = URLSession.shared
    let task = session.dataTask(with: request as URLRequest)
    
    task.resume()
}

private func extract(text: NSString) -> String? {
    
    guard let regex = try? NSRegularExpression(pattern: "^<string[^>]*>(.*?)</string>$", options: .dotMatchesLineSeparators) else {
        return nil
    }
    
    return regex.stringByReplacingMatches(in: text as String, options: [], range: NSRange(location: 0, length: text.length), withTemplate: "$1")
}

enum AzureMicrosoftTranslatorError: Error {
    case TokenParseError
    case TextParseError
    case APIKeyIsNotInitialized
}

public class AzureMicrosoftTranslator: NSObject {
    
    static let sharedTranslator = AzureMicrosoftTranslator()
    
    // Please remember to initialize
    static var key: String = "7e07c5154f7444b4aadc9b9b5e5d626b"
    
    class func translate(text: String, toLang lang: String, completion block: @escaping (String?, URLResponse?, NSError?) -> Void) {
        
//        guard let key = keyString else {
//            block(nil, nil, AzureMicrosoftTranslatorError.APIKeyIsNotInitialized as NSError)
//            return
//        }
        
        print("key")
        
        getToken(key: key) { (data, response, error) in
            print("get token completed")
            if let error = error {
                print("KEY ERROR")
                block(nil, response, error)
                return
            }
            
          
            
            guard let data = data, let token = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue) as? String else {
                print("TOKEN PARSE RESULT")
                block(nil, response, AzureMicrosoftTranslatorError.TokenParseError as NSError)
                return
            }
            
            print("translate not called")
            msTranslate(token: token, translate: text, toLang: lang) { (data, response, error) in
                print("translate called")
                if let error = error {
                    print("ERORROROR")
                    block(nil, response, error)
                    return
                }
                
                guard let data = data,
                    let xml = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue),
                    let result = extract(text: xml) else {
                        print("DATA ERROR")
                        block(nil, response, AzureMicrosoftTranslatorError.TextParseError as NSError)
                        return
                }
                print("RESULTATDOOOOOOO - IN ZE CLASS")
                print("\(result)")
                
                block(result, response, nil)
            }
        }
    }
}
