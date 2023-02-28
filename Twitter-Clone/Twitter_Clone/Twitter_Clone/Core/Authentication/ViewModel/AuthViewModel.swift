//
//  AuthViewModel.swift
//  Twitter_Clone
//
//  Created by Rohit Patil on 20/01/23.
//

import SwiftUI
import Firebase


class AuthViewModel:ObservableObject{
    @Published var userSession:FirebaseAuth.User?
    @Published var didAuthenticateUser = false
    @Published var currentUser:User?
    @ObservedObject var viewModel = MainMessageViewModel()
    private var tempUserSession: FirebaseAuth.User?
    private let service = UserService()
    
    init(){
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
       // self.viewModel.fetchRecentMessages()
       // print("DEBUG: User session is  \(String(describing: self.userSession?.uid))")
    }
    
    func login(withEmail email:String, password:String){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error{
                print("DEBUG: Failed to sign in with error \(error.localizedDescription)")
                return
            }
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
          self.viewModel.fetchRecentMessages()
        }
        
    }
    
    func register(withEmail email:String, password:String, fullname:String, username:String){
       // print("DEBUG: Register with email \(email)")
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error{
                print("DEBUG: Failed to register with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
           // self.userSession = user
            self.tempUserSession = user
            
            print("DEBUG: Registered user successfully")
            print("DEBUG: User is \(String(describing: self.userSession))")
            
            //storing date into database.
            let data = ["email":email,
                        "username":username.lowercased(),
                        "fullname":fullname,
                        "uid":user.uid]
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { _ in
                    self.didAuthenticateUser = true
                    print("DEBUG: Did upload user data...")
                }
            
//            let db = Firestore.firestore()
//                db.collection("users").addDocument(data: ["email":email,
//                                                        "username":username.lowercased(),
//                                                        "fullname":fullname,
//                                                          "uid":result!.user.uid]) { (error) in
//                                    if error != nil {
//                                        print("DEBUG:ERRORR \(String(describing: error?.localizedDescription))")
//                                }
//
//                                }
        }
    }
    
    func signOut(){
        userSession = nil
        try? Auth.auth().signOut()
       
    }
    
    
    func uploadProfileImage(_ image:UIImage){
        guard let uid = tempUserSession?.uid else {return}
        
        ImageUploader.uploadImage(image: image) { profileImageUrl in
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["profileImageUrl":profileImageUrl]){ _ in
                    self.userSession = self.tempUserSession
                    self.fetchUser()
                }
        }
    }
    
    func fetchUser(){
        guard let uid = self.userSession?.uid else { return }
        
        service.fetchUser(withUid: uid) { user in
            self.currentUser = user
        }
    }
}
