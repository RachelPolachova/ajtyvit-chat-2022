//
//  MessageModel.swift
//  Chat
//
//  Created by Rachel Polachova on 02/11/2022.
//

import Foundation
import SwiftUI

struct MessageModel {
    let content: String
    let isCurrentUser: Bool
    
    var primaryColor: Color {
        return isCurrentUser ? .blue : .gray
    }
    
    var secondaryColor: Color {
        return isCurrentUser ? .white : .black
    }
}
