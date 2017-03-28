//
//  Post.swift
//  Picsfeed
//
//  Created by Annie Ton-Nu on 3/28/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import UIKit
import CloudKit


class Post {
    let image: UIImage
    
    init(image: UIImage){
        self.image = image
    }
    
}

enum PostError: Error {
    case writingImageData
    case writingDataToDisk
}


extension Post {
    
    class func recordFor(post: Post) throws -> CKRecord? {  //class method. wont' be referenced to self
        guard let data = UIImageJPEGRepresentation(post.image, 0.7) else { throw PostError.writingImageData }
        //0.7 is the compression (range from 0 - 1)
        
        do {
            try data.write(to: post.image.path)
            
            let asset = CKAsset(fileURL: post.image.path)
            
            let record = CKRecord(recordType: "Post")
            record.setValue(asset, forKey: "image")
            
            return record
            
        } catch {
            throw PostError.writingDataToDisk
        }
    }
    
}
