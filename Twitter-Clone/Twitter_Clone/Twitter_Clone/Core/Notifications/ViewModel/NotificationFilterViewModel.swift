//
//  NotificationFilterViewModel.swift
//  Twitter_Clone
//
//  Created by Rohit Patil on 31/01/23.
//

import Foundation


enum NotificationFilterViewModel:Int,CaseIterable{
    
    case all
    case verified
    case mentions
    
    var title:String{
        switch self{
        case .all : return "All"
        case .verified: return "Verified"
            case .mentions: return "Mentions"
        }
    }
}
