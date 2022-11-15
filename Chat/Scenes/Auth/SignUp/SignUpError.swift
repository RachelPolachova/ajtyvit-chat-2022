//
//  SignUpError.swift
//  Chat
//
//  Created by Rachel Polachova on 14/11/2022.
//

import Foundation

enum SignUpError: Error, Equatable {
    case invalidEmail
    case invalidPassword
    case passwordsDontMatch
    case network(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidEmail:
            return "E-mail is not valid."
        case .invalidPassword:
            return "At least 6 chars required."
        case .passwordsDontMatch:
            return "Doesnt match."
        case .network(let error):
            return error.localizedDescription
        }
    }
    
    static func == (lhs: SignUpError, rhs: SignUpError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidEmail, .invalidEmail):
            return true
        case (.invalidPassword, .invalidPassword):
            return true
        case (.passwordsDontMatch, .passwordsDontMatch):
            return true
        case (.network(_), .network(_)):
            return true
        default:
            return false
        }
    }
}
