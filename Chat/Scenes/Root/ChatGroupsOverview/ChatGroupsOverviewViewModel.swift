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

    private var disposeBag = Set<AnyCancellable>()
//    private var addFriendCancellable: AnyCancellable?
    
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
        
        chatService.createGroup(name: nameTextField, members: [uidTextField, currentUid])
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
            .store(in: &disposeBag)
        
        
        nameTextField = ""
        uidTextField = ""
    }
    
    private func startObservingGroups() {
        guard let currentUid = authService.uid else { return }
        
        chatService.groupsChangesPublisher(for: currentUid)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("observing groups failed: \(error)")
                }
            }, receiveValue: { newGroups in
                
                newGroups.forEach { group in
                    if let existingIndex = self.groups.firstIndex(where: { $0.id == group.id }) {
                        self.groups.remove(at: existingIndex)
                    }
                    
                    self.groups.insert(group, at: 0)
                }
            })
            .store(in: &disposeBag)
        
    }
}
