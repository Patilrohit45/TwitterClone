//
//  NewTweetView.swift
//  TwitterClone
//
//  Created by Rohit Patil on 16/01/23.
//

import SwiftUI
import Kingfisher

struct NewTweetView: View {
    @State private var caption = ""
    @Environment(\.presentationMode) var presentaionMode
    @EnvironmentObject var authViewModel:AuthViewModel
    @ObservedObject var viewModel = UploadTweetViewModel()
    var body: some View {
        VStack{
            HStack{
                Button {
                    presentaionMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color(.systemBlue))
                }
                Spacer()
                Button {
                    viewModel.uploadTweet(withCaption: caption)
                } label: {
                    Text("Tweet")
                        .bold()
                        .padding(.horizontal)
                        .padding(.vertical,8)
                        .background(Color(.systemBlue))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                
            }
            .padding()
            HStack(alignment:.top){
                if let user = authViewModel.currentUser{
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 64, height: 64)
                }
                
                    TextArea("What's happening?",text: $caption)
                    
            }
            .padding()
        }
        .onReceive(viewModel.$didUploadTweet) { success in
            if success{
                presentaionMode.wrappedValue.dismiss()
            }
        }
    }
}

struct NewTweetView_Previews: PreviewProvider {
    static var previews: some View {
        NewTweetView()
    }
}
