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

protocol AuthServing {
    var uid: String? { get }
}

class AuthService: AuthServing {
    
    private var disposeBag = Set<AnyCancellable>()
       
    var uid: String? {
        return Auth.auth().currentUser?.uid
    }
    
    func authStatePublisher() -> AnyPublisher<User?, Never> {
        return Auth.auth().authStateDidChangePublisher()
    }
    
    func signUp(with email: String, password: String) -> AnyPublisher<(), Error> {
        return Future { promise in
            Auth.auth().createUser(withEmail: email, password: password)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("finished")
                        promise(.success(()))
                    case .failure(let error):
                        print("error: \(error)")
                        promise(.failure(error))
                    }
                } receiveValue: { [weak self] authData in
                    let email = authData.user.email ?? "unknown"
                    let uid = authData.user.uid
                    let user = UserModel(uid: uid, email: email, photoUrl: nil)
                    
                    self?.addUserToFiresstore(user)
                }
                .store(in: &self.disposeBag)
        }
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
    private func addUserToFiresstore(_ user: UserModel) {
        return Firestore.firestore()
            .collection("users")
            .document(user.uid)
            .setData(from: user)
            .sink { completion in
                print("adding user to firestore completion: \(completion)")
            } receiveValue: { _ in
                //
            }
            .store(in: &disposeBag)
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
