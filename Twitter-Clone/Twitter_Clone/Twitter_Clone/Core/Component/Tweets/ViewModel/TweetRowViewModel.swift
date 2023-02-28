//
//  TweetRowViewModel.swift
//  Twitter_Clone
//
//  Created by Rohit Patil on 23/01/23.
//

import Foundation


class TweetRowViewModel:ObservableObject{
    
   @Published var tweet:Tweet
    private var service = TweetService()
    
    init(tweet:Tweet){
        self.tweet = tweet
        self.checkIfUserLikedTweet()
    }
    
    func likeTweet(){
        service.likeTweet(tweet){ _ in 
            self.tweet.didLike = true
        }
    }
    
    func checkIfUserLikedTweet(){
        service.checkIfUserLikedTweet(tweet) { didLike in
            if didLike{
                self.tweet.didLike = true
            }
        }
    }
    
    func unLikeTweet(){
        service.unlikeTweet(tweet) {
            self.tweet.didLike = false
        }
    }
}
