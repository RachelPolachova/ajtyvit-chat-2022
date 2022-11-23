//
//  ChatGroupsOverviewViewModel.swift
//  Chat
//
//  Created by Rachel Polachova on 23/11/2022.
//

import Combine
import Foundation

class ChatGroupsOverviewViewModel: ObservableObject {
    
    @Published var groups = [GroupModel]()
    
    var nameTextField = ""
    var uidTextField = ""
    
    private let chatService = ChatService()
    private let authService = AuthService()

    //    private var disposeBag = Set<AnyCancellable>()
    private var addFriendCancellable: AnyCancellable?
    
    init() {
        startObservingGroups()
    }
    
    func canceled() {
        print("add friend - canceled")
        nameTextField = ""
        uidTextField = ""
    }
    
    func addFriend() {
        print("add friend: \(nameTextField), \(uidTextField)")
        
        guard let currentUid = authService.uid else { return }
        
        addFriendCancellable = chatService.createGroup(name: nameTextField, members: [uidTextField, currentUid])
            .sink { completion in
                switch completion {
                case .finished:
                    print("successfuly created group")
                case .failure(let error):
                    print("failed to create a group: \(error)")
                }
            } receiveValue: { _ in
                //
            }
        
        
        nameTextField = ""
        uidTextField = ""
    }
    
    private func startObservingGroups() {
        
    }
}
