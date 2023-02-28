//
//  Tweet.swift
//  Twitter_Clone
//
//  Created by Rohit Patil on 23/01/23.
//

import FirebaseFirestoreSwift
import Firebase

struct Tweet:Identifiable,Decodable{
    
    @DocumentID var id:String?
    let caption:String
    let timestamp:Timestamp
    let uid:String
    var likes:Int
    
    var user:User?
    var didLike:Bool? = false
}
