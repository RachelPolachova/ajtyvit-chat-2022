//
//  ChatAppViewModel.swift
//  Chat
//
//  Created by Rachel Polachova on 14/11/2022.
//

import Combine
import Foundation

class ChatAppViewModel: ObservableObject {
    @Published var userIsSignedIn = false
    
    private let authService = AuthService()
    private var disposeBag = Set<AnyCancellable>()
    
    init() {
        observeAuthChanges()
    }
    
    private func observeAuthChanges() {
//        Auth.auth().addStateDidChangeListener { _, user in
//            DispatchQueue.main.async {
//                self.userIsSignedIn = user != nil
//            }
//        }
        
        authService.authStatePublisher()
            .sink { _ in
                //
            } receiveValue: { user in
                self.userIsSignedIn = user != nil
            }
            .store(in: &disposeBag)

        
    }
}
