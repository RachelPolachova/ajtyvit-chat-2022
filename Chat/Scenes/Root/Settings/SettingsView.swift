//
//  SettingsView.swift
//  Chat
//
//  Created by Rachel Polachova on 09/11/2022.
//

import SwiftUI
import PhotosUI

struct SettingsView: View {
    @StateObject var viewModel = SettingsViewModel()
    
    var body: some View {
        VStack {
            
            /// TODO: IMPROVE UX
            if let image = viewModel.image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
            } else {
                Image(systemName: "photo.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
            }
            
            PhotosPicker(selection: $viewModel.selectedItem, matching: .images) {
                Text("Change profile picture")
            }
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            Spacer()
            
            Button("Sign out") {
                viewModel.signOut()
            }
            .buttonStyle(MainButtonStyle())
            .padding(.horizontal, 30)
            .padding(.bottom, 20)
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
