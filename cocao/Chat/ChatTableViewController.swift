//
//  ChatTableViewController.swift
//  cocao
//
//  Created by Josh Wolff on 2/17/18.
//  Copyright © 2018 jw1. All rights reserved.
//

import Foundation
import UIKit

class ChatTableViewController : UITableViewController {
    
    var chats : [ChatMessage] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.prepareTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(loadChats), name: NSNotification.Name(rawValue: "loadChats"), object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "") {

        }
    }
    
    func prepareTableView () {
        
        tableView.allowsSelection = false
        tableView.reloadData()
        tableView.separatorStyle  = .none
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.loadConversation()
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:  "ChatCell", for: indexPath) as! ChatCell
        cell.chatMessage = self.chats[indexPath.row]
        return
    }
    
    func loadConversation() {
        print("this has been called343")
        self.chats = []
        // TEMPORARY CHATS
        self.chats = ChatMessage.fetchChats()
        self.tableView.reloadData()
    }
    
    @objc func loadChats(notification: NSNotification) {
        print("this has been called")
        self.chats = []
        // TEMPORARY CHATS
        self.chats = ChatMessage.fetchChats()
        self.tableView.reloadData()
    }
    
}

// MARK: - UITableViewDataSource

extension ChatTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.chats.count != 0) {
            return self.chats.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:  "ChatCell", for: indexPath) as! ChatCell
        cell.chatMessage = self.chats[indexPath.row]
        return cell
    }
}

