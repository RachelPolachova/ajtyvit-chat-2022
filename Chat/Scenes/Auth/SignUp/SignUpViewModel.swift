//
//  SignUpViewModel.swift
//  Chat
//
//  Created by Rachel Polachova on 07/11/2022.
//

import Foundation

class SignUpViewModel: ObservableObject {
    
    @Published var error: SignUpError?
    
    var email = ""
    var password1 = ""
    var password2 = ""
    
    private let authService = AuthService()
    
    func signUp() {
        print("sign up pressed")
        
        guard email.isValidEmail else {
            error = .invalidEmail

            print("email is not valid.")
            return
        }
        
        guard password1.count > 5 else {
            error = .invalidPassword
            
            print("at lest 6 characters.")
            return
        }
        
        guard password1 == password2 else {
            error = .passwordsDontMatch
            print("passwords do not match")
            return
        }
        
        error = nil
        
        authService.signUp(with: email, password: password1) { networkError in
            if let networkError = networkError {
                self.error = .network(networkError)
            }
        }
        
        print("signing up with: \(email), \(password1), \(password2)")
    }
}
