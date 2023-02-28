//
//  Notification.swift
//  Twitter_Clone
//
//  Created by Rohit Patil on 31/01/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift



struct NotifcationsModel:Codable,Identifiable{
    @DocumentID var id:String?
    let fullname:String
    let fromId, toId, tweetId:String
    let profileImageUrl:String
    let timestamp:Timestamp
    
}

