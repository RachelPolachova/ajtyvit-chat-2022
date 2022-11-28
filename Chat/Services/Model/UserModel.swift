//
//  UserModel.swift
//  Chat
//
//  Created by Rachel Polachova on 23.11.2022.
//

import Foundation

struct UserModel: Codable, Hashable {
    let uid: String
    let email: String
    let photoUrl: String?
}
