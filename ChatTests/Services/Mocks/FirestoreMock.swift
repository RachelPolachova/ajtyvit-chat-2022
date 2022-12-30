//
//  FirestoreMock.swift
//  ChatTests
//
//  Created by Rachel Polachova on 30.11.2022.
//

import Foundation
@testable import Chat

class FirestoreMock: Firestoring {
    func collection(collectionPath: String) -> Chat.CollectionReferencing {
        fatalError()
    }
}
