//
//  SignInView.swift
//  Chat
//
//  Created by Rachel Polachova on 09/11/2022.
//

import SwiftUI

struct SignInView: View {
    
    private enum FieldInFocus {
        case email, password
    }
    
    @StateObject var viewModel = SignInViewModel()
    @FocusState private var fieldInFocus: FieldInFocus?
    
    var body: some View {
        VStack {
            Spacer()
            
            if let error = viewModel.error {
                Text(error.localizedDescription)
                    .foregroundColor(.red)
            }
            
            TextField("e-mail", text: $viewModel.email)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding(10)
                .focused($fieldInFocus, equals: .email)
                .keyboardType(.emailAddress)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(viewModel.error == .invalidEmail ? .red : .gray)
                }
                .onSubmit {
                    fieldInFocus = .password
                    print("email submit")
                }
            
            SecureField("Password", text: $viewModel.password)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding(10)
                .focused($fieldInFocus, equals: .password)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(.gray)
                }
                .onSubmit {
                    print("password 1 submit")
                }
            
            Spacer()
            
            Button("Sign in") {
                viewModel.signIn()
            }
            .buttonStyle(MainButtonStyle())
//            .padding(20)
        }
        .padding(.horizontal, 30)
    }
}

//struct SignInView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignInView()
//    }
//}
