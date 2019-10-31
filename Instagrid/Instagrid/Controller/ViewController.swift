//
//  ViewController.swift
//  Instagrid
//
//  Created by Steve Bernard on 15/10/2019.
//  Copyright © 2019 Steve Bernard. All rights reserved.
//

import Photos
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var btn3: UIButton!

    @IBAction func buttonImport(_ sender: Any) {
        addNewPicture()
    }

    func addNewPicture() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {

            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            myPickerController.allowsEditing = false
            self.present(myPickerController, animated: true)
        }
    }

     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
           // myImageView2.isHidden = true
            // myImageView1.image = image

            btn3.setImage(image, for: .normal)
       }
        
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}


