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
}

typealias FilterCompletion = (UIImage) -> ()

class Filters {
    // var as an instance living on a class
    static var originalImage = UIImage()
    
    
    
}

//Filters.originalImage
