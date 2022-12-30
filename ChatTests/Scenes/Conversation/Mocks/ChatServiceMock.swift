////
////  ChatServiceMock.swift
////  ChatTests
////
////  Created by Rachel Polachova on 28.11.2022.
////
//
//import Combine
//import Foundation
//
//@testable import Chat
//
//class ChatServiceMock: ChatServing {
//    
//    let createGroupPublisherMock = PassthroughSubject<Void, Error>()
//    let groupsChangesPublisherMock = PassthroughSubject<[GroupModel], Error>()
//    let messageDbChangesPublisherMock = PassthroughSubject<[DbMessageModel], Error>()
//    let sendMessagePublisherMock = PassthroughSubject<Void, Error>()
//    
//    private(set) var createGroupCalledWithMembers = [String]()
//    private(set) var addMessageToGroupCalled = false
//    
//    private(set) var sendMessageCalledWithMesage: DbMessageModel?
//    private(set) var sendMessageCalledWithChatId: String?
//    
//    func createGroup(name: String, members: [String]) -> AnyPublisher<(), Error> {
//        createGroupCalledWithMembers.append(contentsOf: members)
//        return createGroupPublisherMock.eraseToAnyPublisher()
//    }
//    
//    func addMessageToGroup(with id: String, message: DbMessageModel) {
//        addMessageToGroupCalled = true
//    }
//    
//    func groupsChangesPublisher(for uid: String) -> AnyPublisher<[GroupModel], Error> {
//        return groupsChangesPublisherMock.eraseToAnyPublisher()
//    }
//    
//    func messageDbChangesPublisher(chatId: String) -> AnyPublisher<[DbMessageModel], Error> {
//        return messageDbChangesPublisherMock.eraseToAnyPublisher()
//    }
//    
//    func sendMessage(_ message: DbMessageModel, chatId: String) -> AnyPublisher<Void, Error> {
//        sendMessageCalledWithMesage = message
//        sendMessageCalledWithChatId = chatId
//        return sendMessagePublisherMock.eraseToAnyPublisher()
//    }
//}
