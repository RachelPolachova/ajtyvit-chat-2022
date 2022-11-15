//
//  ChatApp.swift
//  Chat
//
//  Created by Rachel Polachova on 02/11/2022.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct ChatApp: App {
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var viewModel = ChatAppViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if viewModel.userIsSignedIn {
                    RootView()
                } else {
                    SignUpView()
                }
            }
        }
    }
}
