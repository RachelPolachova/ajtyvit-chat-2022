//
//  ChatAppViewModel.swift
//  Chat
//
//  Created by Rachel Polachova on 14/11/2022.
//

import Foundation
import FirebaseAuth

class ChatAppViewModel: ObservableObject {
    @Published var userIsSignedIn = false
    
    init() {
        observeAuthChanges()
    }
    
    private func observeAuthChanges() {
        Auth.auth().addStateDidChangeListener { _, user in
            DispatchQueue.main.async {
                self.userIsSignedIn = user != nil
            }
        }
    }
}
