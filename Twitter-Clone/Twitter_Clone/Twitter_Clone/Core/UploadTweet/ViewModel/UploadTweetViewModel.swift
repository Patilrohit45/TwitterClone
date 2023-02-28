//
//  UploadTweetViewModel.swift
//  Twitter_Clone
//
//  Created by Rohit Patil on 23/01/23.
//

import Foundation

class UploadTweetViewModel:ObservableObject{
    @Published  var didUploadTweet = false
    let service = TweetService()
    func uploadTweet(withCaption caption:String){
        service.uploadTweet(caption: caption) { success in
            if success{
                //dismiss screen
                self.didUploadTweet = true
            }else{
                //show error massege to user..
            }
        }
        
    }
}
