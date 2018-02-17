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
        
        let message1 = ChatMessage(_userId: ChatConstantsAndFunctions.computerId, _message: "Hello, how are you doing?", _chatId: "1")
        chatMessages.append(message1)
        let message2 = ChatMessage(_userId: ChatConstantsAndFunctions.userId, _message: "Doing well, and you?", _chatId: "2")
        chatMessages.append(message2)
        let message3 = ChatMessage(_userId: ChatConstantsAndFunctions.computerId, _message: "I can't complain. What are you doing today?", _chatId: "3")
        chatMessages.append(message3)
        let message4 = ChatMessage(_userId: ChatConstantsAndFunctions.userId, _message: "Nothing.", _chatId: "4")
        chatMessages.append(message4)
        let message5 = ChatMessage(_userId: ChatConstantsAndFunctions.computerId, _message: "Lol. Loser.", _chatId: "5")
        chatMessages.append(message5)
        
        return chatMessages
    }
    
}
