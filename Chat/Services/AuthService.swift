//
//  AuthService.swift
//  Chat
//
//  Created by Rachel Polachova on 14/11/2022.
//

import Combine
import Foundation
import FirebaseAuth
import FirebaseAuthCombineSwift
import FirebaseFirestore
import FirebaseStorageCombineSwift

class AuthService {
    
    var uid: String? {
        return Auth.auth().currentUser?.uid
    }
    
    func authStatePublisher() -> AnyPublisher<User?, Never> {
        return Auth.auth().authStateDidChangePublisher()
    }
    
    func signUp(with email: String, password: String) -> AnyPublisher<AuthDataResult, Error> {
        return Auth.auth().createUser(withEmail: email, password: password)
            .eraseToAnyPublisher()
    }
    
    func signIn(with email: String, password: String) -> AnyPublisher<AuthDataResult, Error> {
        return Auth.auth().signIn(withEmail: email, password: password)
            .eraseToAnyPublisher()
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
// TODO: finish sign up and update the users collection
    private func addUserToFiresStore(_ user: UserModel) -> AnyPublisher<(), Error> {
        return Firestore.firestore()
            .collection("users")
            .document(user.uid)
            .setData(from: user)
            .eraseToAnyPublisher()
    }
    
    
// - LEGACY, completion blocks
//    func signUp(with email: String, password: String, completion: @escaping ((Error?) -> Void)) {
//        Auth.auth().createUser(withEmail: email, password: password) { authResult, networkError in
//            completion(networkError)
//        }
//    }
//
//    func signIn(with email: String, password: String, completion: @escaping ((Error?) -> Void)) {
//        Auth.auth().signIn(withEmail: email, password: password) { _, networkError in
//            completion(networkError)
//        }
//    }
}
