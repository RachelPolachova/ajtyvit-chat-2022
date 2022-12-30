////
////  SettingsServiceTests.swift
////  ChatTests
////
////  Created by Rachel Polachova on 30.11.2022.
////
//
//import XCTest
//
//@testable import Chat
//@testable import FirebaseStorage
//
//class SettingsServiceTests: XCTestCase {
//
//    private var sut: SettingsService!
//    private var storageMock: StorageMock!
//    private var firestoreMock: FirestoreMock!
//    private var authServiceMock: AuthServiceMock!
//
//    override func setUpWithError() throws {
//        try super.setUpWithError()
//
//        storageMock = StorageMock()
//        firestoreMock = FirestoreMock()
//        authServiceMock = AuthServiceMock()
//        sut = SettingsService(storage: storageMock,
//                              firestore: firestoreMock,
//                              authService: authServiceMock)
//    }
//
//    override func tearDownWithError() throws {
//        storageMock = nil
//        sut = nil
//
//        try super.tearDownWithError()
//    }
//
//    func test_uploadImage_putDataSuccess_profilePicUpdatedInFirestore() {
//        authServiceMock.uidMock = "aaaa"
//        let storageChildRefMock = StorageReferenceMock()
//        storageMock.storageReferenceMock.childMock = storageChildRefMock
//
//        storageChildRefMock.putDataPromiseMock = { sth in
//            sth(.success(.init()))
//        }
//
//        sut.uploadImage(imageData: Data())
//    }
//}
