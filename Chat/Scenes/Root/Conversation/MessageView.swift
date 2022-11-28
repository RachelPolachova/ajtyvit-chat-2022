//
//  MessageView.swift
//  Chat
//
//  Created by Rachel Polachova on 02/11/2022.
//

import SwiftUI

struct MessageView: View {
    
    let viewModel: MessageViewModel
    
    var body: some View {
        HStack(alignment: .top) {
            
            switch viewModel.message.user {
            case .current:
                Spacer()
                MessageContentView(message: viewModel.message)
                
            case .other(let userModel):
                
                if let photoUrl = userModel?.photoUrl {
                    AsyncImage(url: URL(string: photoUrl)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                    
                } else {
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                }
                
                MessageContentView(message: viewModel.message)
                Spacer()
            }
        }
    }
}

//struct MessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageView(message: MessageModel(content: "aaa", isCurrentUser: false))
//    }
//}
