//
//  ImageUploader.swift
//  Twitter_Clone
//
//  Created by Rohit Patil on 20/01/23.
//

import Firebase
import UIKit
import FirebaseFirestore
import FirebaseStorage

struct ImageUploader{
    
    static func uploadImage(image:UIImage, completion: @escaping(String) -> Void){
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_image/\(filename)")
        
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error{
                print("DEBUG: Failed to upload image with error: \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { imageUrl, _ in
                guard let imageURL = imageUrl?.absoluteString else { return }
                
                completion(imageURL)
                        
            }
        }
    }
}
