//
//  SettingsViewModel.swift
//  Chat
//
//  Created by Rachel Polachova on 09/11/2022.
//

import Foundation
import SwiftUI
import PhotosUI
import Combine

class SettingsViewModel: ObservableObject {
    
    @Published var image: Image?
    @Published var errorMessage: String?
    
    private let authService = AuthService()
    private let storageService = StorageService()
    private var disposeBag = Set<AnyCancellable>()
    
    var selectedItem: PhotosPickerItem? {
        didSet {
            guard let selectedItem = selectedItem else { return }
            
            _ = loadTransferable(from: selectedItem)
        }
    }
    
    init() {
        downloadImage()
    }
    
    func signOut() {
        do {
            try authService.signOut()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: Data.self) { result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let imageData?):
                    
                    self.uploadImage(imageData: imageData)
                    guard let uiImage = UIImage(data: imageData) else { return } // UIKit image
                    
                    self.image = Image(uiImage: uiImage) // SwiftUI image
                    
                case .success(nil):
                    print("success, image nil")
                    self.image = nil
                case .failure(let error):
                    print("error: \(error)")
                    self.errorMessage = error.localizedDescription
                }
            }
            
            
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let image?):
//                    print("success with image")
//                    self.image = image
//                case .success(nil):
//                    print("succes, image nil")
//                    self.image = nil
//                case .failure(let error):
//                    print("error")
//                    self.errorMessage = error.localizedDescription
//                }
//            }
        }
    }
    
    private func downloadImage() {
        storageService.downloadImage()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("downloaded image successfuly.")
                case .failure(let error):
                    print("failed to download image: \(error)")
                }
            } receiveValue: { imageData in
                guard let uiImage = UIImage(data: imageData) else { return } // UIKit image
                
                self.image = Image(uiImage: uiImage) // SwiftUI image
            }
            .store(in: &disposeBag)
    }
    
    private func uploadImage(imageData: Data) {
        self.storageService.uploadImage(imageData: imageData)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("uploaded image successfuly")
                case .failure(let error):
                    print("failed to upload to the image")
//                    DispatchQueue.main.async {
                        self.errorMessage = error.localizedDescription
//                    }
                }
            } receiveValue: { _ in
                //
            }.store(in: &disposeBag)
    }
}
