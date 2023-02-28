//
//  ChatMessage.swift
//  Twitter_Clone
//
//  Created by Rohit Patil on 27/01/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


struct FirebaseConstants{
    static let fromId = "fromId"
    static  let toId = "toId"
    static let text = "text"
}

struct ChatMessage:Codable,Identifiable{
    @DocumentID var id:String?
    let fromId, toId, text:String
    let timestamp:Date
    
}
