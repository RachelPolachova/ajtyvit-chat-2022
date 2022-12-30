////
////  StorageMock.swift
////  ChatTests
////
////  Created by Rachel Polachova on 30.11.2022.
////
//
//import Combine
//import Foundation
//@testable import Chat
//@testable import FirebaseStorage
//
//
//class StorageMock: Storing {
//    
//    private(set) var storageReferenceMock = StorageReferenceMock()
//    
//    func getReference() -> StorageReferencing {
//        return storageReferenceMock
//    }
//}
//
//class StorageReferenceMock: StorageReferencing {
//    
//    var childMock: StorageReferenceMock?
//    
//    var putDataPromiseMock: ((Future<StorageMetadata, Error>.Promise) -> Void)!
//    var getDataPromiseMock: ((Future<Data, Error>.Promise) -> Void)!
//    var downloadUrlPromiseMock: ((Future<URL, Error>.Promise) -> Void)!
//    
//    func child(withPath: String) -> StorageReferencing {
//        return childMock!
//    }
//    
//    func putData(_ data: Data, metadata: FirebaseStorage.StorageMetadata?) -> Future<StorageMetadata, Error> {
//        return Future<StorageMetadata, Error>(putDataPromiseMock!)
//    }
//    
//    func getData(maxSize: Int64) -> Future<Data, Error> {
//        return Future<Data, Error>(getDataPromiseMock)
//    }
//    
//    func downloadURL() -> Future<URL, Error> {
//        return Future<URL, Error>(downloadUrlPromiseMock)
//    }
//}
