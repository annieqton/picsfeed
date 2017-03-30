//
//  FilterCell.swift
//  Picsfeed
//
//  Created by Annie Ton-Nu on 3/30/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import UIKit

class FilterCell: UICollectionViewCell {
    
    var originalImage : UIImage?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
    
}
