//
//  SettingsService.swift
//  Chat
//
//  Created by Rachel Polachova on 14/11/2022.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseStorageCombineSwift
import FirebaseFirestore
import FirebaseFirestoreCombineSwift
import Combine

class SettingsService {
    
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
    
    func uploadImage(imageData: Data) -> AnyPublisher<Void, Error> {
        guard let uid = Auth.auth().currentUser?.uid else {
            return Fail(error: StorageError.invalidUid)
                .eraseToAnyPublisher()
        }
        
        let ref = Storage.storage().reference().child("profilePictures/\(uid).jpg")
        
        return Future { [weak self] promise in
            guard let self = self else { return }
            
            ref.putData(imageData)
                .sink { [weak self] completion in
                    switch completion {
                    case .finished:
                        self?.updateUserProfilePicUrl(ref: ref, uid: uid)
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: { _ in
                    //
                }
                .store(in: &self.disposeBag)
        }
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
    
    private func updateUserProfilePicUrl(ref: StorageReference, uid: String) {
        ref.downloadURL()
            .sink { completion in
                print("download URL completion: \(completion)")
            } receiveValue: { [weak self] url in
                guard let self = self else { return }
                
                print("url: \(url)")
                
                Firestore.firestore().collection("users")
                    .document(uid)
                    .updateData(["photoUrl": url.absoluteString])
                    .sink { completion in
                        print("update profile pic completion: \(completion)")
                    } receiveValue: { _ in
                        //
                    }
                    .store(in: &self.disposeBag)
            }
            .store(in: &disposeBag)
    }
}
