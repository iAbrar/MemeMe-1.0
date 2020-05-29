//
//  ViewController.swift
//  Image Picker
//
//  Created by imac on 5/27/20.
//  Copyright © 2020 Abrar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    // Outlets
    @IBOutlet weak var imagePickerView: UIImageView!
    
// Text Field Delegate objects
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
    }
    
    // Hide time and battary in the top 
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // Import image from album
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Import image from camera
//    @IBAction func pickAnImageFromCamera(_ sender: Any) {
//
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = .camera
//        present(imagePicker, animated: true, completion: nil)
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.image = image
            dismiss(animated: true, completion: nil)
        }
       
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

