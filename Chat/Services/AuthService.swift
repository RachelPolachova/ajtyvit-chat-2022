//
//  AuthService.swift
//  Chat
//
//  Created by Rachel Polachova on 14/11/2022.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    func signUp(with email: String, password: String, completion: @escaping ((Error?) -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, networkError in
            completion(networkError)
        }
    }
    
    func signIn(with email: String, password: String, completion: @escaping ((Error?) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { _, networkError in    
            completion(networkError)
        }
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
}
