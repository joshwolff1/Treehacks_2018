//
//  ChatTableViewController.swift
//  cocao
//
//  Created by Josh Wolff on 2/17/18.
//  Copyright © 2018 jw1. All rights reserved.
//

//
//  PostTableViewController.swift
//  Spontit
//
//  Created by Josh Wolff on 12/2/17.
//  Copyright © 2017 jw1. All rights reserved.
//

import Foundation
import UIKit

class ChatTableViewController : UITableViewController {
    
    var chats : [ChatMessage]?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // TEMPORARY CHATS
        self.chats = ChatMessage.fetchChats()
        
        // self.refreshPosts()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "") {

        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:  "ChatCell", for: indexPath) as! ChatCell
        cell.chatMessage = self.chats?[indexPath.row]
        
        return
        
    }
    
}

// MARK: - UITableViewDataSource

extension ChatTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (chats != nil) || (chats?.count != 0) {
            return (chats?.count)!
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:  "ChatCell", for: indexPath) as! ChatCell
        cell.chatMessage = self.chats?[indexPath.row]
        return cell
    }
}

