//
//  CreateNewMessageView.swift
//  Twitter_Clone
//
//  Created by Rohit Patil on 25/01/23.
//

import SwiftUI
import Kingfisher

struct CreateNewMessageView: View {
    
    let didSelectNewUser: (User) -> ()
    @ObservedObject var viewModel = MainMessageViewModel()
    @Environment(\.presentationMode) var presentaionMode
    var body: some View {
        NavigationView{
            ScrollView{
                ForEach(viewModel.UserList){user in
                    Button {
                        presentaionMode.wrappedValue.dismiss()
                        didSelectNewUser(user)
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
                        .padding(.vertical,8)
                        .foregroundColor(.black)
//                        MessageRowView(user: user)
//                            .padding(.vertical,8)
//                            .foregroundColor(.black)
                    }

                }
            }.navigationTitle("New Message")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button {
                            presentaionMode.wrappedValue.dismiss()
                        } label: {
                            Text("Cancel")
                        }

                    }
                }
        }
    }
}

//struct CreateNewMessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateNewMessageView()
//    }
//}



