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
    
}

