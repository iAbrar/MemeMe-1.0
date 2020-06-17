//
//  MemesDetailViewController.swift
//  Meme 1.1
//
//  Created by imac on 6/16/20.
//  Copyright © 2020 Abrar. All rights reserved.
//

import UIKit

class MemesDetailViewController: UIViewController {
   
    // MARK: Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
    var memes: Meme!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
     
        self.tabBarController?.tabBar.isHidden = true
        
        self.imageView.image = memes.memedImage
    }
    
    
    
    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.topText.text = self.memes.topText
//        self.bottomText.text = self.memes.bottomText
//        self.tabBarController?.tabBar.isHidden = true
//
//        self.imageView.image = memes.memedImage
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}
