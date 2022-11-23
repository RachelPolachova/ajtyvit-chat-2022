//
//  ChatGroupsOverviewView.swift
//  Chat
//
//  Created by Rachel Polachova on 23/11/2022.
//

import SwiftUI

struct ChatGroupsOverviewView: View {
    
    @StateObject var viewModel = ChatGroupsOverviewViewModel()
    @State var alertPresented = false
    
    var body: some View {
        NavigationView {
            List(viewModel.groups) { group in
                
                NavigationLink {
                    ConversationView(viewModel: ConversationViewModel(group: group))
                } label: {
                    VStack {
                        Text(group.name)
                            .font(.headline)
                        Text(group.recentMessage?.text ?? "No messages")
                            .font(.caption)
                    }
                }
            }
            .navigationTitle("Chat groups")
            .toolbar {
                Button("Add") {
                    alertPresented = true
                }
                .alert("Add friend", isPresented: $alertPresented) {
                    TextField("Name", text: $viewModel.nameTextField)
                    TextField("UID", text: $viewModel.uidTextField)
                    
                    Button("Cancel", role: .cancel) {
                        viewModel.canceled()
                    }
                    
                    Button("Submit") {
                        viewModel.addFriend()
                    }
                }
            }
        }
    }
}

//struct ChatGroupsOverviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatGroupsOverviewView()
//    }
//}
