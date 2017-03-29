//
//  GalleryCollectionViewLayout.swift
//  Picsfeed
//
//  Created by Annie Ton-Nu on 3/29/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import UIKit

class GalleryCollectionViewLayout: UICollectionViewFlowLayout {

    var columns = 2
    let spacing: CGFloat = 1.0  //will still look clean on smaller device, system determines points
    
    var screenWidth : CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var itemWidth : CGFloat {
        let availableScreen = screenWidth - (CGFloat(self.columns) * self.spacing)
        return availableScreen / CGFloat(self.columns)
    }
    
    init(columns: Int = 2) {
        self.columns = columns
        
        super.init()  //reason for this here because we need to assign all of it's variables first before we change the values. Patern: start with child, initialize parent, then change 
        
        self.minimumLineSpacing = spacing
        self.minimumInteritemSpacing = spacing
        self.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
        
    }
    
}
