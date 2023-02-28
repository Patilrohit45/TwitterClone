//
//  NotificationsView.swift
//  TwitterClone
//
//  Created by Rohit Patil on 13/01/23.
//

import SwiftUI
import Kingfisher

struct NotificationsView: View {
    @State private var selectedFilter:NotificationFilterViewModel = .all
    @ObservedObject var viewModel = NotificationsViewModel()
    let service = TweetService()
    @Namespace var animation
    var body: some View {
        VStack{
          NotificationFilterBar
        
            Notifications
             Spacer()
        }
        .padding()
       // .navigationTitle("Notification")
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}

extension NotificationsView{
    var  NotificationFilterBar:some View {
        HStack{
            ForEach(NotificationFilterViewModel.allCases,id:\.rawValue){ item in
                VStack{
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .semibold : .regular)
                        .foregroundColor(selectedFilter == item ? .black : .gray)
                    
                    if selectedFilter == item {
                        Capsule()
                            .foregroundColor(Color(.systemBlue))
                            .frame(height:3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    }else{
                        Capsule()
                            .foregroundColor(Color(.clear))
                            .frame(height:3)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeOut){
                        self.selectedFilter = item
                    }
                }
            }
        }
        
        .overlay(Divider().offset(x:0,y:16))
    }
    
    var Notifications:some View{
       
        ScrollView{
            VStack{
                ForEach(viewModel.notifications){notification in
                    VStack(alignment:.leading)
                    {
                        //Profile image + userInfo + Tweet
                            HStack(alignment: .top, spacing: 12){
                                KFImage(URL(string: notification.profileImageUrl))
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(Circle())
                                    .frame(width: 56, height: 56)
                                
                                //User Info and Tweet Caption
                                VStack(alignment:.leading,spacing: 4){
                                    //User info
                                    HStack(spacing:10){
                                        Text(notification.fullname)
                                            .font(.caption).bold()
                                       
                                        Text("Likes your tweet.")
                                            .font(.caption2)
                                        Spacer()
                                        
                                        Text("2m ago")
                                            .foregroundColor(.gray)
                                            .font(.caption)
                                    }.padding()
                                }
                            }
                        Divider()
                    }.padding(10)
                }
            }
        }
        }
    }
       

