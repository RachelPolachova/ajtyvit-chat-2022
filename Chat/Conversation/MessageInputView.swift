//
//  MessageInputView.swift
//  Chat
//
//  Created by Rachel Polachova on 07/11/2022.
//

import SwiftUI

struct MessageInputView: View {
    
    @ObservedObject var viewModel: ConversationViewModel
    
    var body: some View {
        
        HStack {
            TextField("Enter message", text: $viewModel.messageFieldValue)
                .onSubmit {
                    print("on submit")
                    viewModel.sendMessage()
                }
            
            Button {
                print("button pressed")
                viewModel.sendMessage()
            } label: {
                Image(systemName: "paperplane")
            }
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 10)
    }
}

//struct MessageInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageInputView()
//    }
//}
