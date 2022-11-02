//
//  MessageView.swift
//  Chat
//
//  Created by Rachel Polachova on 02/11/2022.
//

import SwiftUI

struct MessageView: View {
    
    var message: MessageModel
    
    var body: some View {
        HStack(alignment: .top) {
            
            if !message.isCurrentUser {
                Image("avatar-mock1")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
            }
            
            MessageContentView(message: message)
        }
    }
}

//struct MessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageView()
//    }
//}
