//
//  UserStatsView.swift
//  TwitterClone
//
//  Created by Rohit Patil on 16/01/23.
//

import SwiftUI

struct UserStatsView: View {
    var body: some View {
        HStack(spacing:24){
            HStack(spacing:4){
               Text("850")
                    .font(.subheadline)
                    .bold()
                
                Text("Following")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            HStack{
                Text("6.9M")
                     .font(.subheadline)
                     .bold()
                 
                 Text("Followers")
                     .font(.caption)
                     .foregroundColor(.gray)
            }
        }
    }
}

struct UserStatsView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatsView()
    }
}
