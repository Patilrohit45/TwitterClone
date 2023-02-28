//
//  RecentMessage.swift
//  Twitter_Clone
//
//  Created by Rohit Patil on 27/01/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct RecentMessage:Codable,Identifiable{
    
    @DocumentID var id:String?
    
   
    let text, fullname: String
    let fromId, toId: String
    let  profileImageUrl: String
    let timestamp:Date
    
    var timeAgo:String{
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: timestamp, relativeTo: Date())
    }
    
}

