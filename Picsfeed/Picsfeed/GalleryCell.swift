//
//  GalleryCell.swift
//  Picsfeed
//
//  Created by Annie Ton-Nu on 3/29/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import UIKit

class GalleryCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    var post: Post! {//gallery cell should never exist without post, hence force unwrapp
        didSet {
            self.imageView.image = post.image
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageView.image = nil
    }

}
