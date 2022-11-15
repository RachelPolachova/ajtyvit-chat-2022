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
        
        var localizedDescription: String {
            switch self {
            case .invalidEmail:
                return "Invalid e-mail"
            case .network:
                return "Something went wrong."
            }
        }
    }
    
    @Published var error: SignInError?
    
    var email = ""
    var password = ""
    
    private let authService = AuthService()
    
    init() {
        print("sign in init")
    }
    
    func signIn() {
        
        guard email.isValidEmail else {
            error = .invalidEmail
            return
        }
        
        print("sign in: \(email), \(password)")
        
        authService.signIn(with: email, password: password) { networkError in
            if let _ = networkError {
                self.error = .network
            }
        }
    }
}
