//
//  ChatService.swift
//  Chat
//
//  Created by Rachel Polachova on 21/11/2022.
//

import Combine
import Foundation
import FirebaseFirestore
import FirebaseFirestoreCombineSwift

class ChatService {
    
    func createGroup(name: String, members: [String]) -> AnyPublisher<(), Error> {
        let newGroup = GroupModel(id: UUID().uuidString,
                                  name: name,
                                  members: members,
                                  recentMessage: nil)
        
        return Firestore.firestore()
            .collection("groups")
            .document(newGroup.id)
            .setData(from: newGroup)
            .eraseToAnyPublisher()
    }
    
    func groupsChangesPublisher(for uid: String) -> AnyPublisher<[GroupModel], Error> {
        Firestore.firestore()
            .collection("groups")
            .whereField("members", arrayContains: uid)
            .snapshotPublisher()
            .map { snapshot in
                let documentsDict = snapshot.documentChanges.map { $0.document.data() }
                let documentJsons = documentsDict.compactMap { try? JSONSerialization.data(withJSONObject: $0) }
                let groups = documentJsons.compactMap { try? JSONDecoder().decode(GroupModel.self, from: $0) }
            }
            .eraseToAnyPublisher()
    }
    
    func messageDbChangesPublisher(chatId: String) -> AnyPublisher<[DbMessageModel], Error> {
        Firestore.firestore()
            .collection("messages")
            .document(chatId)
            .collection("messages")
            .order(by: "sentAt", descending: false)
            .snapshotPublisher()
            .map({ snapshot in
                
                let addedDocuments = snapshot.documentChanges.filter { $0.type == .added }
                
                let documentsDict = addedDocuments.map { $0.document.data() }
                // .map funkcia je len krajsia verzia for-in cykly nizsie
//                var documentsDictinFoorLoop = [QueryDocumentSnapshot]()
//                for doc in addedDocuments {
//                    documentsDictinFoorLoop.append(doc.document.data())
//                }
                
                let documentsJsons = documentsDict.compactMap { try? JSONSerialization.data(withJSONObject: $0) }
                let chatModels = documentsJsons.compactMap { try? JSONDecoder().decode(DbMessageModel.self, from: $0) }
                
                return chatModels
            })
            .eraseToAnyPublisher()
    }
    
    func sendMessage(_ message: DbMessageModel, chatId: String) -> AnyPublisher<Void, Error> {
        return Firestore.firestore()
            .collection("messages")
            .document(chatId)
            .collection("messages")
            .document()
            .setData(from: message)
            .eraseToAnyPublisher()
            
//            .setData([
//                "senderId": message.senderId,
//                "sentAt": message.sentAt,
//                "text": message.text
//            ])
    }
    
}
