//
//  HomeViewController.swift
//  Picsfeed
//
//  Created by Annie Ton-Nu on 3/27/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let filterNames = [FilterName.vintage, FilterName.blackAndWhite, FilterName.comicEffect, FilterName.crystallize, FilterName.lineOverlay]
    
    let imagePicker = UIImagePickerController()  //imagePicker property is set to UIImagePickerController instance
    
    @IBOutlet weak var imageView: UIImageView!  //outlet is connected to storyboard
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var filterButtonTopConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var postButtonBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {  //because viewDidLoad existed in parent class, we have to mark with override
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        filterButtonTopConstraint.constant = 8
        postButtonBottomConstraint.constant = 8
        
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    func presentImagePickerWith(sourceType: UIImagePickerControllerSourceType){  //this is a method on HomeViewController
        
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = sourceType
        self.present(self.imagePicker, animated: true, completion: nil)  //telling homeviewcontroller to present imagePicker controller animated
        self.imagePicker.allowsEditing = true
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {  // imagePickerControllerDidCancel is a optional delegate
        self.dismiss(animated: true, completion: nil)  //if the user is presented with an image picker and hit the cancel button, we dissmiss the image picker, not the HomeViewController.  self is type scope, referring to HomeviewController and it would still work when we take self.  off.
        //this is the HomeViewVontroller telling the UIImagePickerController to dismiss
    }
    
    
    //Use the UIImagePickerController and its delegate to use the camera to set the image view's image.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView.image = originalImage
            Filters.originalImage = originalImage
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func imageTapped(_ sender: Any) {
        print("User Tapped Image!")
        self.presentActionSheet()
    }
    
    
    @IBAction func postButtonPressed(_ sender: Any) {
        
        if let image = self.imageView.image {
            let newPost = Post(image: image, date: Date())  //getting the current date
            CloudKit.shared.save(post: newPost, completion: { (success) in
                
                if success {
                    print("Save Post successfully to CloudKit")
                } else {
                    print("We did NOT succesfully save to CloudKit...")
                }
            })
        }
        
    }
    
    
    @IBAction func filterButtonPressed(_ sender: Any) {
        
        var filteredImageCollection: [UIImage?] = []
        
        guard let image = self.imageView.image else { return }
        
        let alertController = UIAlertController(title: "Filter", message: "Please select a filter", preferredStyle: .alert)
        
        
        //        let undoAction = UIAlertAction(title: "Undo Action", style: .destructive) { (action) in
        //
        //            if filteredImageCollection.count <= 2 {
        //                self.imageView.image = Filters.originalImage
        //            } else {
        //                filteredImageCollection.popLast()
        //                self.imageView.image = filteredImageCollection.last!
        //                print(filteredImageCollection)
        //            }
        //        }
        //
        
        let resetAction = UIAlertAction(title: "Reset Image", style: .destructive) { (action) in
            self.imageView.image = Filters.originalImage
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let blackAndWhiteAction = UIAlertAction(title: "Black & White", style: .default) { (action) in
            Filters.filter(name: .blackAndWhite, image: image, completion: { (filteredImage) in
                self.imageView.image = filteredImage
                filteredImageCollection.append(filteredImage!)
            })
        }
        
        
        let vintageAction = UIAlertAction(title: "Vintage", style: .default) { (action) in
            Filters.filter(name: .vintage, image: image, completion: { (filteredImage) in
                self.imageView.image = filteredImage
                filteredImageCollection.append(filteredImage!)
            })
        }
        
        
        let crystallizeAction = UIAlertAction(title: "Crystallize", style: .default) { (action) in
            Filters.filter(name: .crystallize, image: image, completion: { (filteredImage) in
                self.imageView.image = filteredImage
                filteredImageCollection.append(filteredImage!)
            })
        }
        
        
        let lineOverlayAction = UIAlertAction(title: "Line Overlay", style: .default) { (action) in
            Filters.filter(name: .lineOverlay, image: image, completion: { (filteredImage) in
                self.imageView.image = filteredImage
                filteredImageCollection.append(filteredImage!)
            })
        }
        
        
        let comicEffectAction = UIAlertAction(title: "Comic Effect", style: .default) { (action) in
            Filters.filter(name: .comicEffect, image: image, completion: { (filteredImage) in
                self.imageView.image = filteredImage
                filteredImageCollection.append(filteredImage!)
            })
        }
        
        
        
        alertController.addAction(blackAndWhiteAction)
        alertController.addAction(vintageAction)
        alertController.addAction(crystallizeAction)
        alertController.addAction(lineOverlayAction)
        alertController.addAction(comicEffectAction)
        alertController.addAction(resetAction)
        //        alertController.addAction(undoAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    func presentActionSheet() {
        
        let actionSheetController = UIAlertController(title: "Source", message: "Please Select Source Type", preferredStyle: .actionSheet)  //using UIAlertController initilizer taking parameters(title, message and preferredStyle) to return an instance of the UIAlertController
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            self.presentImagePickerWith(sourceType: .camera)
        }  //UIAlertAction initializer takes in 3 parameters (title as string, style as enum, trailing closure that defines the functionality for this action)
        
        let photoAction = UIAlertAction(title: "Photo Library", style: .default) { (action) in
            self.presentImagePickerWith(sourceType: .photoLibrary)
        }
        
        // check to see if device allows camera. it shows the camera gray out
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            cameraAction.isEnabled = false
        }
        
        actionSheetController.addAction(cameraAction)
        actionSheetController.addAction(photoAction)
        actionSheetController.addAction(cancelAction)
        
        self.present(actionSheetController, animated: true, completion: nil)
        
    }
    
    
}

//MARK: UICollectionView DataSource
extension HomeViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let filterCell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.identifier, for: indexPath) as! FilterCell
        
        guard let originalImage = Filters.originalImage else { return filterCell }
        
        guard let resizedImage = originalImage.resize(size: CGSize(width: 75, height: 75)) else { return filterCell }
        
        let filterName = self.filterNames[indexPath.row]
        
        Filters.filter(name: filterName, image: resizedImage) { (filteredImage) in
            filterCell.imageView.image = filteredImage
        }
        
        return filterCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterNames.count
    }
}



