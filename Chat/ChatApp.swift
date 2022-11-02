//
//  ChatApp.swift
//  Chat
//
//  Created by Rachel Polachova on 02/11/2022.
//

import SwiftUI

@main
struct ChatApp: App {
    var body: some Scene {
        WindowGroup {
            VStack {
                MessageView(message: MessageModel(content: "I am the current user.", isCurrentUser: true))
                MessageView(message: MessageModel(content: "I am a friend.", isCurrentUser: false))
            }
//            ContentView()
        }
    }
}
