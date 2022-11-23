//
//  GroupModel.swift
//  Chat
//
//  Created by Rachel Polachova on 23/11/2022.
//

import Foundation

struct GroupModel: Identifiable, Encodable {
    let id: String
    let name: String
    // members uid
    let members: [String]
    let recentMessage: DbMessageModel?
}
