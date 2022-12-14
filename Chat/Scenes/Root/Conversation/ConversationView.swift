//
//  ConversationView.swift
//  Chat
//
//  Created by Rachel Polachova on 07/11/2022.
//

import SwiftUI

struct ConversationView: View {
    
    @StateObject var viewModel = ConversationViewModel()
    
//    @State var messageField: String = ""
    
    var body: some View {
        VStack {
            /// Storyboard - UITableView
            List(viewModel.messages) { message in
                
                MessageView(message: message)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .rotationEffect(.radians(.pi))
                    .scaleEffect(x: -1, y: 1, anchor: .center)
            }
            .rotationEffect(.radians(.pi))
            .scaleEffect(x: -1, y: 1, anchor: .center)
            
            MessageInputView(viewModel: viewModel)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Conversation")
    }
}

//struct ConversationView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConversationView()
//    }
//}
