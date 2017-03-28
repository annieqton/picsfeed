//
//  CloudKit.swift
//  Picsfeed
//
//  Created by Annie Ton-Nu on 3/27/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import Foundation
import CloudKit


typealias PostCompletion = (Bool) -> ()

class CloudKit {
    
    static let shared = CloudKit()
    
    let container = CKContainer.default()
    
    var privateDatabase : CKDatabase {
        return container.privateCloudDatabase
    }
    
    func save(post: Post, completion: @escaping PostCompletion) {  //instance method of CloudKit. to access this method from anywhere, use CloudKit.Shared.save
        do {
            if let record = try Post.recordFor(post: post) {
                
                privateDatabase.save(record, completionHandler: { (record, error) in
                    
                    if error != nil {
                        completion(false)
                    }
                    
                    
                    if let record = record {
                        print(record)
                        completion(true)
                    } else {
                        completion(false)
                    }
                    
                })
                
            }
        } catch {
            print(error)
        }
        
    }
    
    
    
}
