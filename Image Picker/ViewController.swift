//
//  ViewController.swift
//  Image Picker
//
//  Created by imac on 5/27/20.
//  Copyright © 2020 Abrar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    // MARK: Properties
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  5
    ]
    
    // Outlets
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
// Text Field Delegate objects
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set text for each field
        self.topText.text = "TOP"
        self.topText.defaultTextAttributes = memeTextAttributes
        self.topText.textAlignment = .center
        
        self.bottomText.text = "BOTTOM"
        self.bottomText.defaultTextAttributes = memeTextAttributes
        self.bottomText.textAlignment = .center
        
        //Disabling the camera button in simulator
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)

        // Set the delegate
        self.topText.delegate = self
         self.bottomText.delegate = self
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
    
   
    
    // MARK: Text Field Delegate Methods
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        // Figure out what the new text will be, if we return true
//        var newText = textField.text! as NSString
//        newText = newText.replacingCharacters(in: range, with: string) as NSString
//
//
//        self.topText.text = String(newText.length)
//
//        // returning true gives the text field permission to change its text
//        return true;
//    }
    
    //Remove default text
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField.text == "TOP" || textField.text == "BOTTOM")
        {
             textField.text = ""
        }
    }
    
    //keyboard dismissed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
}

