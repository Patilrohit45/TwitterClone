//
//  ExploreViewModel.swift
//  Twitter_Clone
//
//  Created by Rohit Patil on 23/01/23.
//

import Foundation


class ExploreViewModel:ObservableObject{
    @Published var users = [User]()
    @Published var searchText = ""
    
    let service = UserService()
    
    var searchableUsers:[User]{
        if searchText.isEmpty{
            return users
        }else{
            let lowerCasedQuery = searchText.lowercased()
            
            return users.filter {
                $0.username.contains(lowerCasedQuery) ||
                $0.fullname.lowercased().contains(lowerCasedQuery)
            }
        }
    }
    
    init(){
     fetchUsers()
    }
    
    func fetchUsers(){
        service.fetchUsers { users in
            self.users = users
           // print("DEBUG: User \(users)")
        }
    }
}
