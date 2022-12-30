////
////  ConversationViewModelTests.swift
////  ChatTests
////
////  Created by Rachel Polachova on 28.11.2022.
////
//
//import XCTest
//@testable import Chat
//
//final class ConversationViewModelTests: XCTestCase {
//    
//    private var sut: ConversationViewModel!
//    private var chatServiceMock: ChatServiceMock!
//    private var authServiceMock: AuthServiceMock!
//    private let groupMock = GroupModel(id: "123",
//                                       name: "name",
//                                       members: ["aa", "bb"],
//                                       recentMessage: nil)
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//        try super.setUpWithError()
//        
//        chatServiceMock = ChatServiceMock()
//        authServiceMock = AuthServiceMock()
//        
//        self.sut = ConversationViewModel(group: groupMock,
//                                         chatService: chatServiceMock,
//                                         authService: authServiceMock)
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        chatServiceMock = nil
//        authServiceMock = nil
//        sut = nil
//        
//        try super.tearDownWithError()
//    }
//    
////    MARK: - sendMessage
//    func test_sendMessage_sendMessageSuccess_messageFieldValueClearedTrue() {
//        let asyncExpectation = expectation(description: "async expectation")
//        asyncExpectation.isInverted = true
//        
//        authServiceMock.uidMock = "123"
//        sut.messageFieldValue = "serdtfyguhj"
//        
//        sut.sendMessage()
//        
//        self.chatServiceMock.sendMessagePublisherMock.send(completion: .finished)
//        
//        waitForExpectations(timeout: 0.5)
//        
//        XCTAssertEqual(sut.messageFieldValue, "")
//    }
//    
//    func test_sendMessage_sendMessageFailure_messageFieldValueClearedTrue() {
//        let asyncExpectation = expectation(description: "async expectation")
//        asyncExpectation.isInverted = true
//        
//        let expectedMessageFieldValue = "567yhbdaw"
//        let errorMock = NSError(domain: "chat.test", code: 1)
//        authServiceMock.uidMock = "123"
//        sut.messageFieldValue = expectedMessageFieldValue
//        
//        sut.sendMessage()
//        
//        self.chatServiceMock.sendMessagePublisherMock.send(completion: .failure(errorMock))
//        
//        waitForExpectations(timeout: 0.5)
//        
//        XCTAssertEqual(sut.messageFieldValue, expectedMessageFieldValue)
//    }
//    
//    func test_sendMessage_uidNilTrue_sendMessageCalledFalse_messageFieldValueClearedFalse() {
//        let expectedMessageFieldValue = "dtrfyguh"
//        sut.messageFieldValue = expectedMessageFieldValue
//        
//        XCTAssertNil(chatServiceMock.sendMessageCalledWithMesage)
//        XCTAssertNil(chatServiceMock.sendMessageCalledWithChatId)
//        XCTAssertEqual(sut.messageFieldValue, expectedMessageFieldValue)
//    }
//    
//    func test_sendMessage_calledWithCorrectArguments() {
//        let expectedUid = "xgfchgjhj"
//        authServiceMock.uidMock = expectedUid
//        let expectedText = "tryftguyhujk"
//        sut.messageFieldValue = expectedText
//        
//        sut.sendMessage()
//        
//        XCTAssertEqual(chatServiceMock.sendMessageCalledWithChatId, groupMock.id)
//        XCTAssertEqual(chatServiceMock.sendMessageCalledWithMesage?.senderId, expectedUid)
//        XCTAssertEqual(chatServiceMock.sendMessageCalledWithMesage?.text, expectedText)
//    }
//    
////    MARK: - startObservingMessageDb
//    
//    func test_startObservingMessageDb_newMessagesInsertedAtCorrectIndex() {
//        let asyncExpectation = expectation(description: "async expectation")
//        asyncExpectation.isInverted = true
//        let messagesMock = [
//            DbMessageModel(id: "123", senderId: "321", text: "yugbjk", sentAt: .pi),
//            .init(id: "aaa", senderId: "vvv", text: "ijoi", sentAt: .nan) // iny sposob ako inicializovat
//        ]
//        
//        /// startObservingMessageDb called in init (setupWithError)
//        
//        chatServiceMock.messageDbChangesPublisherMock.send(messagesMock)
//        
//        waitForExpectations(timeout: 0.5)
//        
//        XCTAssertEqual(sut.messages.count, 2)
//        XCTAssertEqual(sut.messages[0], messagesMock[1])
//        XCTAssertEqual(sut.messages[1], messagesMock[0])
//    }
//}
//
//extension DbMessageModel: Equatable {
//    public static func == (lhs: DbMessageModel, rhs: DbMessageModel) -> Bool {
//        return lhs.id == rhs.id
//    }
//}
