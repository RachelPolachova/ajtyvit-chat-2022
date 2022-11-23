//
//  RootView.swift
//  Chat
//
//  Created by Rachel Polachova on 09/11/2022.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            ChatGroupsOverviewView()
                .tabItem {
                    VStack {
                        Image(systemName: "message")
                        Text("Chat")
                    }
                }
            
            SettingsView()
                .tabItem {
                    VStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                }
        }
    }
}

//struct RootView_Previews: PreviewProvider {
//    static var previews: some View {
//        RootView()
//    }
//}
