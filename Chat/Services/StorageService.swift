//
//  StorageService.swift
//  Chat
//
//  Created by Rachel Polachova on 14/11/2022.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseStorageCombineSwift
import Combine

class StorageService {
    
    enum StorageError: Error {
        case invalidUid
    }
    
    private var disposeBag = Set<AnyCancellable>()
    
    func downloadImage() -> AnyPublisher<Data, Error> {
        guard let uid = Auth.auth().currentUser?.uid else {
            return Fail(outputType: Data.self, failure: StorageError.invalidUid)
                .eraseToAnyPublisher()
        }
        
        let ref = Storage.storage().reference().child("profilePictures/\(uid).jpg")
        
        return ref.getData(maxSize: 3 * 1024 * 1024)
            .eraseToAnyPublisher()
    }
    
    func uploadImage(imageData: Data) -> AnyPublisher<StorageMetadata, Error> {
        guard let uid = Auth.auth().currentUser?.uid else {
            return Fail(outputType: StorageMetadata.self, failure: StorageError.invalidUid)
                .eraseToAnyPublisher()
        }
        
        let ref = Storage.storage().reference().child("profilePictures/\(uid).jpg")
        
        return ref.putData(imageData)
            .eraseToAnyPublisher()
        
//            .sink { completion in
//                switch completion {
//                case .finished:
//                    print("finished successfuly")
//                case .failure(let error):
//                    print("failed to upload with error: \(error)")
//                }
//            } receiveValue: { _ in
//                //
//            }
//            .store(in: &disposeBag)

            
//            .putData(imageData) { _, error in
//            if let error = error {
//                print("failed to upload image: \(error)")
//            } else {
//                print("upload of the image was success.")
//            }
//        }
    }
}
