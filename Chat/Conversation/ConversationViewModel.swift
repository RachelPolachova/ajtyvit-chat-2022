//
//  ConversationViewModel.swift
//  Chat
//
//  Created by Rachel Polachova on 07/11/2022.
//

import Foundation

class ConversationViewModel: ObservableObject {
    @Published var messages: [MessageModel] = []
    
    var messageFieldValue: String = ""
    
    private var mockedMessages = [
        MessageModel(content: "dawijojdoi aa 3", isCurrentUser: true),
        MessageModel(content: "dawijojdoi aa 2", isCurrentUser: true),
        MessageModel(content: "dawijojdoi aa", isCurrentUser: true),
        MessageModel(content: "ADajidoajio", isCurrentUser: true),
        MessageModel(content: "Ojiodawjoid2", isCurrentUser: false),
        MessageModel(content: "adjio 92999 ", isCurrentUser: true),
        MessageModel(content: "4th", isCurrentUser: true),
        MessageModel(content: "Really.", isCurrentUser: false),
        MessageModel(content: "I am a friend.", isCurrentUser: false),
        MessageModel(content: "I am the current user.", isCurrentUser: true),
    ]
    
    init() {
        print("conversation viewmodel init.")
        
        mockMessages()
    }
    
    func sendMessage() {
        print("sending message: \(messageFieldValue)")
    }
    
    private func mockMessages() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            
            if let poppedMessage = self?.mockedMessages.popLast() {
                print("adding: \(poppedMessage)")
                self?.messages.insert(poppedMessage, at: 0)
                self?.mockMessages()
            }
        }
        
    }
}
