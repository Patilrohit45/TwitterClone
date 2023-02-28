//
//  TweetService.swift
//  Twitter_Clone
//
//  Created by Rohit Patil on 23/01/23.
//

import Foundation
import SwiftUI
import Firebase




struct TweetService{
    private let service = UserService()
    let vm = AuthViewModel()
    var currentUser:User?
    func uploadTweet(caption:String , completion:@escaping(Bool)->Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
            
        let data = ["uid":uid,
                    "caption":caption,
                    "likes":0,
                    "timestamp":Timestamp(date: Date())] as [String : Any]
        
        Firestore.firestore().collection("tweets").document()
            .setData(data) { error in
                if let error = error {
                    print("DEBUG: Failed to upload tweet")
                    completion(false)
                }
                
                completion(true)
            }
        
    }
    func fetchTweets(completion:@escaping([Tweet])->Void){
        Firestore.firestore().collection("tweets")
            .order(by:"timestamp",descending: true)
            .getDocuments { snapshots, _ in
            guard let documents = snapshots?.documents else { return }
            let tweets = documents.compactMap({try? $0.data(as: Tweet.self)})
            completion(tweets)
        }
    }
    
    func  fetchTweets(forUid uid:String,completion:@escaping([Tweet])->Void){
        Firestore.firestore().collection("tweets")
            .whereField("uid",isEqualTo: uid)
            .getDocuments { snapshots, _ in
            guard let documents = snapshots?.documents else { return }
            let tweets = documents.compactMap({try? $0.data(as: Tweet.self)})
                completion(tweets.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue()  }))
        }
    }
    

}
// MARK: - Likes and Unlikes
extension TweetService{
    mutating func likeTweet(_ tweet:Tweet,completion:@escaping(Bool)->Void){
        var notificationArray = [NotifcationsModel]()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        let user = vm.currentUser
 
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        Firestore.firestore().collection("tweets").document(tweetId)
            .updateData(["likes":tweet.likes+1]){_ in
                userLikesRef.document(tweetId).setData([:]) { _ in
                   completion(true)
                }
            }
        
        let currentUserNotification = Firestore.firestore().collection("Notifications")
            .document(uid)
//           .collection(tweet.uid)
//            .document()

        let notificationData = NotifcationsModel(id: nil, fullname: user?.fullname ?? "", fromId: uid, toId: tweet.uid, tweetId: tweetId, profileImageUrl:user?.profileImageUrl ?? "", timestamp: Timestamp.init(date: Date()))

        try? currentUserNotification.setData(from:notificationData){ error in
            if let error = error{
                print("DEBUG: Failed to save message \(error.localizedDescription)")
                return
            }
            print("DEBUG: Successfully saved current user NotificationData")
        }
        fetchNotification() { snap in
            notificationArray = snap
        }

        
       

    }
    
    func unlikeTweet(_ tweet:Tweet,completion:@escaping()->Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        guard tweet.likes > 0 else { return }
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        
        Firestore.firestore().collection("tweets").document(tweetId)
            .updateData(["likes":tweet.likes-1]){_ in
                userLikesRef.document(tweetId).delete { _ in
                    completion()
                }
            }
    }
    
    func checkIfUserLikedTweet(_ tweet:Tweet,completion:@escaping(Bool)->Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("user-likes")
            .document(tweetId).getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                completion(snapshot.exists)
            }
    }
    func fetchLikedTweets(forUid uid:String,completion:@escaping([Tweet])->Void){
        var tweets = [Tweet]()
        Firestore.firestore().collection("users").document(uid).collection("user-likes").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else {return}
            
            documents.forEach { doc in
                let tweetID = doc.documentID
                
                Firestore.firestore().collection("tweets")
                    .document(tweetID)
                    .getDocument { snapshot, _ in
                        guard let tweet = try? snapshot?.data(as: Tweet.self) else { return }
                        tweets.append(tweet)
                            
                        completion(tweets)
                    }
            }
        }
    }
    
    func fetchNotification(completion:@escaping([NotifcationsModel])->Void){
        var notifications = [NotifcationsModel]()
        guard let uid = Auth.auth().currentUser?.uid else { return }
    //    let user = vm.currentUser
      
       
        Firestore.firestore().collection("Notifications")
            .document(uid)
           // .whereField("uid", isNotEqualTo: uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                
                guard let notification = try? snapshot.data(as: NotifcationsModel.self) else { return }
               print("DEBUG : NotificationData = \(notification)")
                notifications.append(notification)
                completion(notifications)
            }
    }
}
