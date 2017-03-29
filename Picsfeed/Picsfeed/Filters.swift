//
//  Filters.swift
//  Picsfeed
//
//  Created by Annie Ton-Nu on 3/28/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import UIKit


enum FilterName : String {
    case vintage = "CIPhotoEffectTransfer"
    case blackAndWhite = "CIPhotoEffectMono"
    case crystallize = "CICrystallize"
    case lineOverlay = "CILineOverlay"
    case comicEffect = "CIComicEffect"
}


typealias FilterCompletion = (UIImage?) -> ()

class Filters {
    
    static var originalImage = UIImage()  // var as an instance living on a class
    
    class func filter(name: FilterName, image: UIImage, completion: @escaping FilterCompletion) {  //not thread safe, move off main line
        
        OperationQueue().addOperation {
            guard let filter = CIFilter(name: name.rawValue) else { fatalError("Failed to create CIFilter")}
            
            let coreImage = CIImage(image: image)
            filter.setValue(coreImage, forKey: kCIInputImageKey)
            
            //GPU Context, stays same for GPU context
            let options = [kCIContextWorkingColorSpace: NSNull()] //NSNull is an object representing Nil, it's stored in the heap.
            guard let eaglContext = EAGLContext(api: .openGLES2) else { fatalError("Failed to create EAGLContext.") }
            
            let ciContext = CIContext(eaglContext: eaglContext, options: options)
            
            //Get final image from using GPU
            guard let outputImage = filter.outputImage else { fatalError("Failed to get output image from Filters.") }
            
            if let cgImage = ciContext.createCGImage(outputImage, from: outputImage.extent) {
                
                let finalImage = UIImage(cgImage: cgImage)
                
                OperationQueue.main.addOperation {
                    completion(finalImage)
                }
                
            } else {
                OperationQueue.main.addOperation {
                    completion(nil)
                }
            }
            
        }
        
    }

}



