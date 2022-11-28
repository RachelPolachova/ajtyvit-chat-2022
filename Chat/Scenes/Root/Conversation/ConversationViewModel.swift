//
//  ConversationViewModel.swift
//  Chat
//
//  Created by Rachel Polachova on 07/11/2022.
//

import Combine
import Foundation

class ConversationViewModel: ObservableObject {
    @Published var messages: [DbMessageModel] = []
    @Published var users: Set<UserModel> = []
    
    
    var messageFieldValue: String = ""
    let group: GroupModel
    let authService = AuthService()
    
    private let chatService = ChatService()
    private let userService = UserService()
    private var disposeBag = Set<AnyCancellable>()
    
    init(group: GroupModel) {
        print("conversation viewmodel init.")
        self.group = group
        
        startObservingMessageDb()
        fetchUsersDetails()
    }
    
    private func startObservingMessageDb() {
        chatService.messageDbChangesPublisher(chatId: group.id)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("observe messages completion: \(completion)")
            } receiveValue: { newMessages in
                newMessages.forEach { self.messages.insert($0, at: 0) }
            }
            .store(in: &disposeBag)

    }
    
    private func fetchUsersDetails() {
        
        guard let uid = authService.uid else { return }
        
        let otherMembers = group.members.filter { $0 != uid }
        
        otherMembers.forEach { member in
            userService.usersDetails(uid: member)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    print("user details fetch completion: \(completion) for user: \(member)")
                } receiveValue: { memberData in
                    self.users.insert(memberData)
                }
                .store(in: &disposeBag)
        }
    }
    
    func sendMessage() {
        print("sending message: \(messageFieldValue)")
        
        guard let uid = authService.uid else { return }
            
        let message = DbMessageModel(id: UUID().uuidString,
                                     senderId: uid,
                                     text: messageFieldValue,
                                     sentAt: Date().timeIntervalSince1970)
        
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
