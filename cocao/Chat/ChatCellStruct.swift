//
//  ChatCellStruct.swift
//  cocao
//
//  Created by Josh Wolff on 2/17/18.
//  Copyright © 2018 jw1. All rights reserved.
//

import Foundation
import UIKit


struct ChatMessage {
    
    var _userId: String?
    var _message: String?
    var _chatId: String?
    
    static func fetchChats() -> [ChatMessage]
    {
        let chatMessages = [ChatMessage]()
        
        return chatMessages
    }
    
}
