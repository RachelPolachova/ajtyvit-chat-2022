//
//  SignUpViewModel.swift
//  Chat
//
//  Created by Rachel Polachova on 07/11/2022.
//

import Combine
import Foundation

class SignUpViewModel: ObservableObject {
    
    @Published var error: SignUpError?
    
    var email = ""
    var password1 = ""
    var password2 = ""
    
    private let authService = AuthService()
    private var disposeBag = Set<AnyCancellable>()
    
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
        
        authService.signUp(with: email, password: password1)
            .sink { completion in
                if case .failure(let error) = completion {
                    self.error = .network(error)
                }
            } receiveValue: { _ in
                //
            }
            .store(in: &disposeBag)
        
        print("signing up with: \(email), \(password1), \(password2)")
    }
}
