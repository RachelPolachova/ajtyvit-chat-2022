//
//  ConversationViewModel.swift
//  Chat
//
//  Created by Rachel Polachova on 07/11/2022.
//

import Combine
import Foundation

class ConversationViewModel: ObservableObject {
    @Published var messages: [MessageModel] = []
    
    
    var messageFieldValue: String = ""
    let group: GroupModel
    
    private let chatService = ChatService()
    private let authService = AuthService()
    private var disposeBag = Set<AnyCancellable>()
    
    init(group: GroupModel) {
        print("conversation viewmodel init.")
        self.group = group
        
        startObservingMessageDb()
    }
    
    private func startObservingMessageDb() {
        chatService.messageDbChangesPublisher(chatId: group.id)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("observe messages completion: \(completion)")
            } receiveValue: { newMessages in
                guard let uid = self.authService.uid else { return }
                
                newMessages
                    .map { MessageModel(content: $0.text,
                                        isCurrentUser: $0.senderId == uid) }
                    .forEach { self.messages.insert($0, at: 0) }
            }
            .store(in: &disposeBag)

    }
    
    func sendMessage() {
        print("sending message: \(messageFieldValue)")
        
        guard let uid = authService.uid else { return }
        
        let message = DbMessageModel(senderId: uid, text: messageFieldValue, sentAt: Date().timeIntervalSince1970)
        
        chatService.sendMessage(message, chatId: group.id)
            .sink { completion in
                switch completion {
                case .finished:
                    print("send message finished.")
                case .failure(let error):
                    print("send message failed \(error)")
                }
            } receiveValue: { _ in
                //
            }
            .store(in: &disposeBag)
        
        messageFieldValue = ""
    }
    
//    private func mockMessages() {
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
//
//            if let poppedMessage = self?.mockedMessages.popLast() {
//                print("adding: \(poppedMessage)")
//                self?.messages.insert(poppedMessage, at: 0)
//                self?.mockMessages()
//            }
//        }
//        
//    }
}
