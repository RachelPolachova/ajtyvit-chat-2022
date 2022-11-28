//
//  MessageViewModel.swift
//  Chat
//
//  Created by Rachel Polachova on 28.11.2022.
//

import Foundation

class MessageViewModel {
    
    let message: MessageModel
    
    init(dbMessage: DbMessageModel, members: Set<UserModel>, authService: AuthService) {
        let uid = authService.uid ?? ""
        
        if dbMessage.senderId == uid {
            self.message = MessageModel(content: dbMessage.text, user: .current)
        } else {
            let sender = members.first(where: { $0.uid == dbMessage.senderId })
            self.message = MessageModel(content: dbMessage.text, user: .other(sender))
        }
    }
}
