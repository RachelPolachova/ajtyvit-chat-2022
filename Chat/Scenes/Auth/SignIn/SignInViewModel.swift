//
//  SignInViewModel.swift
//  Chat
//
//  Created by Rachel Polachova on 09/11/2022.
//

import Combine
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
    private var disposeBag = Set<AnyCancellable>()
    
    init() {
        print("sign in init")
    }
    
    func signIn() {
        
        guard email.isValidEmail else {
            error = .invalidEmail
            return
        }
        
        print("sign in: \(email), \(password)")
        
        authService.signIn(with: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure = completion {
                    self.error = .network
                }
            } receiveValue: { _ in
                //
            }
            .store(in: &disposeBag)
    }
}
