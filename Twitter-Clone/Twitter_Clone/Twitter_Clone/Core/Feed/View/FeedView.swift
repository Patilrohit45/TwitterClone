//
//  FeedView.swift
//  TwitterClone
//
//  Created by Rohit Patil on 13/01/23.
//

import SwiftUI

struct FeedView: View {
    @State private var showTweetView = false
    @ObservedObject var viewModel = FeedViewModel()
    var body: some View {
        ZStack(alignment:.bottomTrailing){
            ScrollView{
                LazyVStack{
                    ForEach(viewModel.tweets){ tweet in
                        TweetsRowView(tweet: tweet)
                            .padding()
                    }
                }
            }
            Button {
                showTweetView.toggle()
            } label: {
                Image(systemName: "pencil")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width:28,height:28)
                    .padding()
            }
            .background(Color(.systemBlue))
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
            .fullScreenCover(isPresented: $showTweetView) {
               NewTweetView()
            }
        }
//        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
