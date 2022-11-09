//
//  SignUpView.swift
//  Chat
//
//  Created by Rachel Polachova on 07/11/2022.
//

import SwiftUI

struct SignUpView: View {
    
    private enum Field {
        case username
        case password1
        case password2
    }
    
    /// OBSERVED OBJECT EXAMPLE!
    @StateObject var viewModel = SignUpViewModel()
    
    @FocusState private var fieldInFocus: Field?
    
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
                .focused($fieldInFocus, equals: .username)
                .keyboardType(.emailAddress)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(viewModel.error == .invalidEmail ? .red : .gray)
                }
                .onSubmit {
                    fieldInFocus = .password1
                    print("email submit")
                }
            
            SecureField("Password", text: $viewModel.password1)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding(10)
                .focused($fieldInFocus, equals: .password1)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        // ternary operator condition
                        .strokeBorder(viewModel.error == .invalidPassword ? .red : .gray)
                }
                .onSubmit {
                    fieldInFocus = .password2
                    print("password 1 submit")
                }
            
            SecureField("Password again", text: $viewModel.password2)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding(10)
                .focused($fieldInFocus, equals: .password2)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(viewModel.error == .passwordsDontMatch ? .red : .gray)
                }
                .onSubmit {
                    viewModel.signUp()
                }
            
            NavigationLink {
                SignInView()
            } label: {
                Text("Already have an account?")
            }
            
            Spacer()
            
            Button("Sign up") {
                viewModel.signUp()
            }
            .buttonStyle(MainButtonStyle())
//            .padding(20)
//            .background(Color.green)
        }
        .padding(.horizontal, 30)
    }
}

//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView()
//    }
//}
