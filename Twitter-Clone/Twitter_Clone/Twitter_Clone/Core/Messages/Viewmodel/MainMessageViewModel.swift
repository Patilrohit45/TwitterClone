//
//  MessageViewModel.swift
//  Twitter_Clone
//
//  Created by Rohit Patil on 25/01/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift



class MainMessageViewModel:ObservableObject{
    
    @Published var users = [User]()
    @Published var recentMessages = [RecentMessage]()
    let service = UserService()
    
    var UserList:[User]{
        return users
    }
    
    init(){
        fetchUsers()
        fetchRecentMessages()
    }
    
    func fetchUsers(){
        service.fetchUsers { users in
            
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            Firestore.firestore().collection("users")
                .whereField("uid",isNotEqualTo: uid)
                .getDocuments { snapshots, _ in
                    guard let documents = snapshots?.documents else { return }
                    let users = documents.compactMap({try? $0.data(as: User.self)})
                    self.users = users
                }
           
           // print("DEBUG: User \(users)")
        }
    }

    private var firestoreListner:ListenerRegistration?
   func fetchRecentMessages(){
       
       guard let uid = Auth.auth().currentUser?.uid else { return }
        
       firestoreListner?.remove()
       self.recentMessages.removeAll()
       
       firestoreListner = Firestore.firestore().collection("recent_messages")
           .document(uid)
           .collection("messages")
           .order(by: "timestamp")
           .addSnapshotListener { querySnapshot, error in
               if let error = error{
                   print("DEBUG: Failed to fetch recent messages: \(error.localizedDescription)")
                   return
               }
               querySnapshot?.documentChanges.forEach({ change in
                       let docId = change.document.documentID
                   if let index = self.recentMessages.firstIndex(where: { rm in
                       return rm.id == docId
                   }){
                       self.recentMessages.remove(at: index)
                   }
                   if let rm = try? change.document.data(as: RecentMessage.self){
                       self.recentMessages.insert(rm, at: 0)
                   }
               })
           }
       
    }
    
}
