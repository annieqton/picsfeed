//
//  HomeViewController.swift
//  Picsfeed
//
//  Created by Annie Ton-Nu on 3/27/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()  //imagecPicker property is set to UIImagePickerController instance
    
    @IBOutlet weak var imageView: UIImageView!  //outlet is connected to storyboard
    
    override func viewDidLoad() {  //because viewDidLoad existed in parent class, we have to mark with override
        super.viewDidLoad()
        
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
        
        print("Info: \(info)")

        //UIImagePickerControllerOriginalImage
        
        let chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage  //self.imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.image = chosenImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func imageTapped(_ sender: Any) {
        print("User Tapped Image!")
        self.presentActionSheet()
    }
    
    @IBAction func postButtonPressed(_ sender: Any) {
        
        if let image = self.imageView.image {
            let newPost = Post(image: image)
            CloudKit.shared.save(post: newPost, completion: { (success) in
                
                if success {
                    print("Save Post successfully to CloudKit")
                } else {
                    print("We did NOT succesfully save to CloudKit...")
                }
            })
        }
        
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


