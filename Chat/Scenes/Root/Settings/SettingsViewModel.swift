//
//  SettingsViewModel.swift
//  Chat
//
//  Created by Rachel Polachova on 09/11/2022.
//

import Foundation
import SwiftUI
import PhotosUI

class SettingsViewModel: ObservableObject {
    
    @Published var image: Image?
    @Published var errorMessage: String?
    
    var selectedItem: PhotosPickerItem? {
        didSet {
            guard let selectedItem = selectedItem else { return }
            
            _ = loadTransferable(from: selectedItem)
        }
    }
    
    func signOut() {
        print("sign out called.")
    }
    
    
    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: Image.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image?):
                    print("success with image")
                    self.image = image
                case .success(nil):
                    print("succes, image nil")
                    self.image = nil
                case .failure(let error):
                    print("error")
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
