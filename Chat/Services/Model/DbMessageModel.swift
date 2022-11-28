//
//  DbMessageModel.swift
//  Chat
//
//  Created by Rachel Polachova on 21/11/2022.
//

import Foundation

struct DbMessageModel: Encodable, Decodable, Identifiable {
    let id: String
    let senderId: String
    let text: String
    let sentAt: TimeInterval
}
