//
//  GalleryViewController.swift
//  Picsfeed
//
//  Created by Annie Ton-Nu on 3/29/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import UIKit

protocol GalleryViewControllerDelegate : class {
    func galleryController(didSelect image: UIImage)
}


class GalleryViewController: UIViewController {
    
    weak var delegate : GalleryViewControllerDelegate?

    @IBOutlet weak var colletionView: UICollectionView!
    
    var allPosts = [Post]() {
        didSet {
            self.colletionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.colletionView.dataSource = self
        colletionView.delegate = self
        self.colletionView.collectionViewLayout = GalleryCollectionViewLayout(columns: 3)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        update()
    }
    
    func update(){
        CloudKit.shared.getPosts { (posts) in
            if let posts = posts {
                self.allPosts = posts
            }
        }
    }
    
}


//MARK: UICollectionViewDataSource Extension
extension GalleryViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = colletionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.identifier, for: indexPath) as! GalleryCell
        
        cell.post = self.allPosts[indexPath.row]  //cell.post = currentPost
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = self.delegate else { return }
        
        let selectedPost = self.allPosts[indexPath.row]
        
        delegate.galleryController(didSelect: selectedPost.image)
        
        
    }
    
}
    
    
