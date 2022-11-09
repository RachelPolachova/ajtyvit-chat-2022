//
//  SignUpViewModel.swift
//  Chat
//
//  Created by Rachel Polachova on 07/11/2022.
//

import Foundation
import FirebaseAuth

class SignUpViewModel: ObservableObject {
    
    enum FieldError: Error {
        case invalidEmail
        case invalidPassword
        case passwordsDontMatch
        
        var localizedDescription: String {
            switch self {
            case .invalidEmail:
                return "E-mail is not valid."
            case .invalidPassword:
                return "At least 6 chars required."
            case .passwordsDontMatch:
                return "Doesnt match."
            }
        }
    }
    
    @Published var error: FieldError?
    
    var email = ""
    var password1 = ""
    var password2 = ""
    
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
        
        Auth.auth().createUser(withEmail: email, password: password1) { authResult, error in
            print("authresult: \(authResult?.user)")
            print("error: \(error)")
        }
        
        print("signing up with: \(email), \(password1), \(password2)")
    }
}
