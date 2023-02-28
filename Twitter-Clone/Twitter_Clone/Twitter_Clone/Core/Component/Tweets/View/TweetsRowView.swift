//
//  TweetsRowView.swift
//  TwitterClone
//
//  Created by Rohit Patil on 13/01/23.
//

import SwiftUI
import Kingfisher

struct TweetsRowView: View {
    @ObservedObject var  viewModel:TweetRowViewModel

    init(tweet:Tweet){
        self.viewModel = TweetRowViewModel(tweet: tweet)
    }
    
    var body: some View {
      
        VStack(alignment:.leading)
        {
            //Profile image + userInfo + Tweet
            if let user = viewModel.tweet.user{
                HStack(alignment: .top, spacing: 12){
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 56, height: 56)
                    
                    //User Info and Tweet Caption
                    VStack(alignment:.leading,spacing: 4){
                        //User info
                        HStack{
                            Text(user.fullname)
                                .font(.subheadline).bold()
                            
                            Text("@\(user.username)")
                                .foregroundColor(.gray)
                                .font(.caption)
                            Text("2w")
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                       
                        
                        //Tweet Caption
                        Text(viewModel.tweet.caption)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                    }
                }
            }
           
            //action buttons
            HStack{
                //FirstButton
                Button {
                    //action goes here.
                } label: {
                    Image(systemName: "bubble.left")
                        .font(.subheadline)
                }
                Spacer()
                //SecondButton
                Button {
                    //action goes here.
                } label: {
                    Image(systemName: "arrow.2.squarepath")
                        .font(.subheadline)
                }
                Spacer()
                //ThirdButton
                Button {
                    viewModel.tweet.didLike ?? false ? viewModel.unLikeTweet() : viewModel.likeTweet()
                } label: {
                    Image(systemName: viewModel.tweet.didLike ?? false ? "heart.fill" : "heart")
                        .font(.subheadline)
                        .foregroundColor(viewModel.tweet.didLike ?? false ? .red : .gray)
                }
                Spacer()
                //FourthButton
                Button {
                    //action goes here.
                } label: {
                    Image(systemName: "bookmark")
                        .font(.subheadline)
                }

            }
            .padding()
            .foregroundColor(.gray)
            
            Divider()
        }
      
    }
}
//
//struct TweetsRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        TweetsRowView()
//    }
//}
