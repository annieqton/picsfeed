//
//  UIExtensions.swift
//  Picsfeed
//
//  Created by Annie Ton-Nu on 3/28/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import UIKit


extension UIImage {
    
    func resize(size: CGSize) -> UIImage? {  //CG is core graphic, comes from UIKit.  resize is an instance method
        UIGraphicsBeginImageContext(size)
        
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))  //self.draw is a instance of UIImage
        
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return resizedImage
        
    }

    var path: URL {  //path is a compute property
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Error getting documents directory")
        }
        return documentsDirectory.appendingPathComponent("image")  //taking image and hand it to disk and then tell cloudkit to take it from disk
    
    }




}
