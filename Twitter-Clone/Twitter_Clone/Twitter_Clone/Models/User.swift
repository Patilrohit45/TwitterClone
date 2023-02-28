//
//  User.swift
//  Twitter_Clone
//
//  Created by Rohit Patil on 23/01/23.
//

import FirebaseFirestoreSwift
import Firebase

struct User:Identifiable,Decodable{
    @DocumentID var id:String?
    let username:String
    let fullname:String
    let profileImageUrl:String
    let email:String
    
    var isCurrentUser:Bool { return Auth.auth().currentUser?.uid == id}
}
