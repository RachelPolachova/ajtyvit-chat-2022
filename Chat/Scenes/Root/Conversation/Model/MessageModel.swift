//
//  MessageModel.swift
//  Chat
//
//  Created by Rachel Polachova on 02/11/2022.
//

import Foundation
import SwiftUI

struct MessageModel {
    
    enum User {
        case current
        case other(UserModel?)
    }
    
    let content: String
    let user: User
    
    var primaryColor: Color {
        switch user {
        case .current:
            return .blue
        case .other:
            return .gray
        }
    }
    
    var secondaryColor: Color {
        switch user {
        case .current:
            return .white
        case .other:
            return .black
        }
    }
}
