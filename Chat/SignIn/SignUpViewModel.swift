//
//  SignUpViewModel.swift
//  Chat
//
//  Created by Rachel Polachova on 07/11/2022.
//

import Foundation

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
        
        print("signing up with: \(email), \(password1), \(password2)")
    }
    
    
    
}

extension String {
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
