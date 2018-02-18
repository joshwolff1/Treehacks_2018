//
//  ChatCellStruct.swift
//  cocao
//
//  Created by Josh Wolff on 2/17/18.
//  Copyright © 2018 jw1. All rights reserved.
//

import Foundation
import UIKit


struct ChatMessage : Equatable {
    
    static func ==(lhs: ChatMessage, rhs: ChatMessage) -> Bool {
        return (lhs._userId == rhs._userId) && (lhs._message == rhs._message)
    }
    
    
    var _userId: String?
    var _message: String?
    var _chatId: String?
    
    static func fetchChats() -> [ChatMessage]
    {
        var chatMessages = [ChatMessage]()
        
        let message1 = ChatMessage(_userId: ChatConstantsAndFunctions.computerId, _message: "Welcome to cocao!", _chatId: "1")
        chatMessages.append(message1)
        let message2 = ChatMessage(_userId: ChatConstantsAndFunctions.computerId, _message: "Select your language and ask away!", _chatId: "2")
        chatMessages.append(message2)
        
        for chat in ChatConstantsAndFunctions.newChats {
            chatMessages.append(chat)
        }
        
        return chatMessages
    }
    
}
