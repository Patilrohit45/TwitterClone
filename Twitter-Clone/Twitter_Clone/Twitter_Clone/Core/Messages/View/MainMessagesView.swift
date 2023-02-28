//
//  MessagesView.swift
//  TwitterClone
//
//  Created by Rohit Patil on 13/01/23.
//

import SwiftUI
import Firebase
import Kingfisher

struct MainMessagesView: View {
    @ObservedObject var viewModel = MainMessageViewModel()
    @State private var showMessageView = false
    @State var currentUser:User?
    @State var shouldNavigateToChatLogView = false
    private var chatLogViewModel = ChatLogViewModel(user:nil)
    var body: some View {
            ZStack(alignment:.bottom){
                VStack{
                    ScrollView{
                        VStack{
                            messageView
                            NavigationLink("", isActive: $shouldNavigateToChatLogView) {
                                ChatLogView(viewModel: chatLogViewModel)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .overlay(newMessageButtonView,alignment: .bottom)
                .navigationBarHidden(true)
            }
        }
    
    private var messageView:some View{
        ScrollView{
            ForEach(viewModel.recentMessages){recentMessage in
                VStack{
                    Button{
                        let uid = Auth.auth().currentUser?.uid == recentMessage.fromId ? recentMessage.toId:recentMessage.fromId
                
                        self.currentUser = .init(id: uid, username: "", fullname: recentMessage.fullname, profileImageUrl:recentMessage.profileImageUrl, email: "")
                        
                        self.chatLogViewModel.user = self.currentUser
                        self.chatLogViewModel.fetchMessages()
                        self.shouldNavigateToChatLogView.toggle()
                        
                    } label: {
                        HStack(spacing:16){
                            KFImage(URL(string: recentMessage.profileImageUrl))
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width:64,height:64)
                                .overlay(RoundedRectangle(cornerRadius: 64)
                                            .stroke(Color.black,lineWidth: 1))
                                .shadow(radius: 5)
                                
                            
                            VStack(alignment:.leading){
                                Text(recentMessage.fullname)
                                    .font(.system(size: 16,weight: .bold))
                                    .foregroundColor(Color(.label))
                                    .multilineTextAlignment(.leading)
                                    
                                Text(recentMessage.text)
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(.lightGray))
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer()
                            
                            Text(recentMessage.timeAgo)
                                .font(.system(size: 14,weight: .semibold))
                                .foregroundColor(Color.gray)
                                
                        }
                    }

                    Divider()
                        .padding(.vertical,8)
                }.padding(.horizontal)
            }.padding(.bottom,50)
        }
    }
    
    private var newMessageButtonView: some View{
        Button {
            showMessageView.toggle()
        } label: {
            HStack{
                Text(" + New Message")
                    .font(.headline)
                    .frame(width:300,height: 20)
                    .padding()
            }
            .background(Color(.systemBlue))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .padding()
        }
        .fullScreenCover(isPresented: $showMessageView) {
            CreateNewMessageView(didSelectNewUser: { user in
                print("DEBUG: User email is \(user.fullname)")
                self.shouldNavigateToChatLogView.toggle()
                self.currentUser = user
                self.chatLogViewModel.user = user
                self.chatLogViewModel.fetchMessages()
            })
        }
    }
    
}


struct MainMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessagesView()
    }
}
//
//extension MainMessagesView{
//
//    var MessageRowView:some View{
//        HStack(spacing:16){
//            Image(systemName: "person.fill")
//                .font(.system(size: 32))
//                .clipShape(Circle())
//                .foregroundColor(Color(.systemBlue))
//                .padding(8)
//                .overlay(RoundedRectangle(cornerRadius:44).stroke(Color.black,lineWidth:1))
//
//
//            VStack(alignment:.leading){
//                Text("Username")
//                    .font(.system(size: 16,weight: .bold))
//
//                Text("Message sent to user")
//                    .font(.system(size: 14))
//                    .foregroundColor(Color(.lightGray))
//            }
//            Spacer()
//
//            Text("2W")
//                .padding()
//                .foregroundColor(.gray)
//
//        }
//
//    }
//}
