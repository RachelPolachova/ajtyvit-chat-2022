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

protocol Storing {
    func getReference() -> StorageReferencing
}

protocol StorageReferencing {
    func child(withPath: String) -> StorageReferencing
    func putData(_ data: Data, metadata: StorageMetadata?) -> Future<StorageMetadata, Error>
    func getData(maxSize: Int64) -> Future<Data, Error>
    func downloadURL() -> Future<URL, Error>
}

extension Storage: Storing {
    func getReference() -> StorageReferencing {
        return self.reference()
    }
}

extension StorageReference: StorageReferencing {
    func child(withPath: String) -> StorageReferencing {
        return self.child(withPath)
    }
}

protocol Firestoring {
    func collection(collectionPath: String) -> CollectionReferencing
}

extension Firestore: Firestoring {
    func collection(collectionPath: String) -> CollectionReferencing {
        return self.collection(collectionPath)
    }
}

protocol CollectionReferencing {
    func document(documentPath: String) -> DocumentReferencing
}

extension CollectionReference: CollectionReferencing {
    func document(documentPath: String) -> DocumentReferencing {
        return self.document(documentPath)
    }
}

protocol DocumentReferencing {
    func updateData(_ documentData: [String : Any]) -> Future<Void, Error>
}

extension DocumentReference: DocumentReferencing {
    
}

class SettingsService {
    
    enum StorageError: Error {
        case invalidUid
    }
    
    private var disposeBag = Set<AnyCancellable>()
    
    private let storage: Storing
    private let firestore: Firestoring
    private let authService: AuthServing
    
    convenience init() {
        self.init(storage: Storage.storage(),
                  firestore: Firestore.firestore(),
                  authService: AuthService())
    }
    
    init(storage: Storing, firestore: Firestoring, authService: AuthServing) {
        self.storage = storage
        self.firestore = firestore
        self.authService = authService
    }
    
    private func updateUserProfilePicUrl(ref: StorageReferencing, uid: String) {
        ref.downloadURL()
            .sink { completion in
                print("download URL completion: \(completion)")
            } receiveValue: { [weak self] url in
                guard let self = self else { return }
                
                print("url: \(url)")
                
                self.firestore.collection(collectionPath: "users")
                    .document(documentPath: uid)
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
    
    
    func uploadImage(imageData: Data) -> AnyPublisher<Void, Error> {
        guard let uid = self.authService.uid else {
            return Fail(error: StorageError.invalidUid)
                .eraseToAnyPublisher()
        }
        
        let ref = storage.getReference().child(withPath: "profilePictures/\(uid).jpg")
        
        return Future { [weak self] promise in
            guard let self = self else { return }
            
            ref.putData(imageData, metadata: nil)
                .sink { [weak self] completion in
                    switch completion {
                    case .finished:
                        self?.updateUserProfilePicUrl(ref: ref, uid: uid)
                        promise(.success(()))
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
    
    func downloadImage() -> AnyPublisher<Data, Error> {
        guard let uid = Auth.auth().currentUser?.uid else {
            return Fail(outputType: Data.self, failure: StorageError.invalidUid)
                .eraseToAnyPublisher()
        }
        
        let ref = storage.getReference().child(withPath: "profilePictures/\(uid).jpg")
        
        return ref.getData(maxSize: 3 * 1024 * 1024)
            .eraseToAnyPublisher()
    }
}
