//
//  NotificationsViewModel.swift
//  Twitter_Clone
//
//  Created by Rohit Patil on 06/02/23.
//

import Foundation
import SwiftUI
import Firebase

class NotificationsViewModel:ObservableObject {
    
    
    @Published var notifications = [NotifcationsModel]()
    let service = TweetService()
    
    var NotificationList:[NotifcationsModel]{
        return notifications
    }
    
    init(){
        fetchNotifications()
    }
    private var firestoreListner:ListenerRegistration?
    func fetchNotifications(){
        
        service.fetchNotification { snapshot in
            guard let uid = Auth.auth().currentUser?.uid else { return }
         Firestore.firestore().collection("Notifications")

                .getDocuments { snapshots, _ in
                    guard let documents = snapshots?.documents else { return }
                    let notification = documents.compactMap({try? $0.data(as: NotifcationsModel.self)})
                    self.notifications = notification
                }
           
        }
    }
    
    
}
