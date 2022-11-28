//
//  UsersService.swift
//  Chat
//
//  Created by Rachel Polachova on 28.11.2022.
//

import Combine
import Foundation
import FirebaseFirestore
import FirebaseFirestoreCombineSwift

class UserService {
    
    func usersDetails(uid: String) -> AnyPublisher<UserModel, Error> {
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument()
            .compactMap { try? JSONSerialization.data(withJSONObject: $0.data() ?? [:]) }
            .decode(type: UserModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
