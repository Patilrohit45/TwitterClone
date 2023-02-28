//
//  ChatLogViewModel.swift
//  Twitter_Clone
//
//  Created by Rohit Patil on 25/01/23.
//

import Foundation
import Firebase


class ChatLogViewModel:ObservableObject{
    @Published var chatText = ""
    @Published var chatMessages = [ChatMessage]()
    @Published var errorMessage = ""
    @Published var count = 0
  var user:User?

    init(user:User?){
        self.user = user
        fetchMessages()
    }
    var firestoreListner:ListenerRegistration?
  func fetchMessages(){
        
        guard let fromId = Auth.auth().currentUser?.uid else { return }
    
        guard let toId = user?.id else { return }
        firestoreListner?.remove()
        chatMessages.removeAll()
       firestoreListner =  Firestore.firestore().collection("messages")
            .document(fromId)
            .collection(toId)
            .order(by: "timestamp")
            .addSnapshotListener{ querySnapshot, error in
                if let error = error{
                    self.errorMessage = error.localizedDescription
                    print("DEBUG: Failed to fetch message \(error.localizedDescription)")
                    return
                }
                querySnapshot?.documentChanges.forEach({ change in
                    if change.type == .added{
                        if let cm = try? change.document.data(as: ChatMessage.self){
                            self.chatMessages.append(cm)
                        }
                    }
                })
                DispatchQueue.main.async {
                    self.count += 1
                }
           
            }
    }
    
    func handleSend(){
       // print(chatText)
        
        guard let fromId = Auth.auth().currentUser?.uid else { return }
    
        guard let toId = user?.id else { return }
        
       let document =  Firestore.firestore().collection("messages")
            .document(fromId)
            .collection(toId)
            .document()
        
        let messageData = ChatMessage(id: nil, fromId: fromId, toId: toId, text: chatText, timestamp: Date())
    
        
        try? document.setData(from:messageData){ error in
            if let error = error{
                self.errorMessage = error.localizedDescription
                print("DEBUG: Failed to save message \(error.localizedDescription)")
                return
            }
            print("DEBUG: Successfully saved current user sending message")
            
            self.persistRecentMessage()
            
            self.chatText = ""
            self.count += 1
        }
        
    let recipientMessageDocument =  Firestore.firestore().collection("messages")
             .document(toId)
             .collection(fromId)
             .document()
        
       try? recipientMessageDocument.setData(from:messageData){ error in
            if let error = error{
                self.errorMessage = error.localizedDescription
                print("DEBUG: Failed to save message \(error.localizedDescription)")
                return
            }
            print("DEBUG: Successfully saved recipient message")
           self.persistRecentMessage()
        }
    }
    
    private func persistRecentMessage(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let toId = user?.id else { return }
       let document =  Firestore.firestore()
            .collection("recent_messages")
            .document(uid)
            .collection("messages")
            .document(toId)
        
        let data = [
            "timestamp": Timestamp(),
            FirebaseConstants.text:self.chatText,
            FirebaseConstants.fromId:uid,
            FirebaseConstants.toId : toId,
            "profileImageUrl":user?.profileImageUrl ?? "",
            "fullname":user?.fullname ?? ""
        ] as [String : Any]
        
        //you'll need to save another very simillar dictonary for the recipient of this message ..how?
        
        document.setData(data) { error in
            if let error = error {
                print("DEBUG: Failed to save recent message: \(error.localizedDescription)")
                return
            }
            
        }
    }
}
