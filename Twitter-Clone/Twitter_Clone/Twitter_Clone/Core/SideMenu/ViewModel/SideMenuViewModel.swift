//
//  SideMenuViewModel.swift
//  TwitterClone
//
//  Created by Rohit Patil on 16/01/23.
//

import Foundation


enum SideMenuViewModel:Int,CaseIterable{
    
    case profile
    case lists
    case bookmarks
    case logout
    
    var titile:String{
        switch self{
            case .profile:return "Profile"
            case .lists:return "Lists"
            case .bookmarks:return "Bookmark"
            case .logout:return "Logout"
        }
    }
    
    var imageName:String{
        switch self{
            case .profile:return "person"
            case .lists:return "list.bullet"
            case .bookmarks:return "bookmark"
            case .logout:return "arrow.left.square"
        }
        
    }
    
    
}
