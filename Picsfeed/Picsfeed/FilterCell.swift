//
//  FilterCell.swift
//  Picsfeed
//
//  Created by Annie Ton-Nu on 3/30/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import UIKit

class FilterCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    

    @IBOutlet weak var filterLabel: UILabel!

    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil

        
    }
    

    
    
}

