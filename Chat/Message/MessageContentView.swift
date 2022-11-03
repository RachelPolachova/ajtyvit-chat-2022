//
//  MessageContentView.swift
//  Chat
//
//  Created by Rachel Polachova on 02/11/2022.
//

import SwiftUI

struct MessageContentView: View {
    
    var message: MessageModel
    
    var body: some View {
        Text(message.content)
            .padding(15)
            .background(message.primaryColor)
            .foregroundColor(message.secondaryColor)
            .cornerRadius(20)
    }
}

struct MessageContentView_Previews: PreviewProvider {
    static var previews: some View {
        MessageContentView(message: MessageModel(content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas eget.",
                                                 isCurrentUser: true))
    }
}
