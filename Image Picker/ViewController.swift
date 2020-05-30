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
    
    // Struct
    struct Meme {
        var topText: String
        var bottomText: String
        let originalImage: UIImage
        let memedImage: UIImage
    }
    
    // Properties
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  -5
    ]
    
    // Outlets
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set text for each field
        configure(textField: self.topText, withText: "TOP")
        configure(textField: self.bottomText, withText: "BOTTOM")

        
        //Disabling the camera button in simulator
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        //Disable Share Button
        shareButton.isEnabled = false

        // Set the delegates
        self.topText.delegate = self
         self.bottomText.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
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
    @IBAction func pickAnImageFromCamera(_ sender: Any) {

        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.image = image
            //Enable Share Button
            shareButton.isEnabled = true
            dismiss(animated: true, completion: nil)
        }
       
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
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
    
    //Fix issue of disapearing keyboard
    @objc func keyboardWillShow(_ notification:Notification) {
        if self.bottomText.isFirstResponder {
        view.frame.origin.y = -getKeyboardHeight(notification)
        }
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Save the meme
    func save() {
        // Create the meme
        _ = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
    }
    func generateMemedImage() -> UIImage {
        
        // Hide toolbar and navbar
        navigationController?.setToolbarHidden(true, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: true)
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        navigationController?.setToolbarHidden(false, animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        return memedImage
    }
    
    // Share the meme
    @IBAction func Share(_ sender: Any) {
        let sharedImage = generateMemedImage()
        // generate the meme
        let activityController = UIActivityViewController(activityItems:    [sharedImage], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
        
        activityController.completionWithItemsHandler = { (activity, success, items, error) in
            if(success) {
                self.save()
            }
        }
    }
    
    // Discard a meme (reset view)
    @IBAction func discardMeme(_ sender: Any) {
        shareButton.isEnabled = false
        imagePickerView.image = nil
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
    }
    
    //
    func configure(textField: UITextField, withText text: String) {
        textField.text = text
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
    }
}
