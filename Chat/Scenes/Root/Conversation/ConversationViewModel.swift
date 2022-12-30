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
    
    var authService: AuthServing
    
    private let chatService: ChatServing
    private let userService = UserService()
    private var disposeBag = Set<AnyCancellable>()
    
    convenience init(group: GroupModel) {
        self.init(group: group, chatService: ChatService(), authService: AuthService())
    }
    
    init(group: GroupModel, chatService: ChatServing, authService: AuthServing) {
        print("conversation viewmodel init.")
        self.group = group
        self.chatService = chatService
        self.authService = authService
        
        startObservingMessageDb()
        fetchUsersDetails()
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
                    self.messageFieldValue = ""
                    print("send message finished.")
                case .failure(let error):
                    print("send message failed \(error)")
                }
            } receiveValue: { _ in
                //
            }
            .store(in: &disposeBag)
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
}
