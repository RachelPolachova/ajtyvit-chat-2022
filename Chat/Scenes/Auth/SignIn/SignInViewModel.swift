//
//  SignInViewModel.swift
//  Chat
//
//  Created by Rachel Polachova on 09/11/2022.
//

import Foundation

class SignInViewModel: ObservableObject {

    enum SignInError: Error {
        case invalidEmail, network
    }
    
    @Published var error: SignInError?
    
    var email = ""
    var password = ""
    
    init() {
        print("sign in init")
    }
    
    func signIn() {
        
        guard email.isValidEmail else {
            error = .invalidEmail
            return
        }
        
        print("sign in: \(email), \(password)")
    }
    
}
