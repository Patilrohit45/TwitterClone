//
//  MessageRowView.swift
//  Twitter_Clone
//
//  Created by Rohit Patil on 25/01/23.
//

import SwiftUI
import Kingfisher

struct MessageRowView: View {
    @ObservedObject var viewModel = MainMessageViewModel()
    let user:User
    var body: some View {
        VStack{
            NavigationLink {
                Text("Destination")
            } label: {
                HStack(spacing:16){
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width:56,height:56)
                        
                    
                    VStack(alignment:.leading){
                        Text(user.username)
                            .font(.system(size: 16,weight: .bold))
                        
                        Text("Message sent to user")
                            .font(.system(size: 14))
                            .foregroundColor(Color(.lightGray))
                    }
                    Spacer()
                    
                    Text("2W")
                        .padding()
                        .foregroundColor(.gray)
                        
                }
            }

            Divider()
        }
    }
}

//struct MessageRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageRowView()
//    }
//}
