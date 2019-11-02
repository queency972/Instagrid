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


    @IBOutlet weak var swipeView: UIButton!
    @IBOutlet weak var buttonImport1: UIButton!
    @IBOutlet weak var buttonImport2: UIButton!
    @IBOutlet weak var buttonImport3: UIButton!
    @IBOutlet weak var buttonImport4: UIButton!
    @IBOutlet weak var viewLayout1: UIButton!
    @IBOutlet weak var viewLayout2: UIButton!
    @IBOutlet weak var viewLayout3: UIButton!


    @IBAction func layout1(_ sender: Any) {
        buttonImport1.isHidden = false
        buttonImport2.isHidden = true
        buttonImport3.isHidden = false
        buttonImport4.isHidden = false
        viewLayout1.setImage(UIImage(named: "Selected"), for: .normal)
        viewLayout2.setImage(UIImage(named: ""), for: .normal)
        viewLayout3.setImage(UIImage(named: ""), for: .normal)
    }

    @IBAction func layout2(_ sender: Any) {
        buttonImport1.isHidden = false
        buttonImport2.isHidden = false
        buttonImport3.isHidden = false
        buttonImport4.isHidden = true
        viewLayout1.setImage(UIImage(named: ""), for: .normal)
        viewLayout2.setImage(UIImage(named: "Selected"), for: .normal)
        viewLayout3.setImage(UIImage(named: ""), for: .normal)
    }

    @IBAction func layout3(_ sender: Any) {
        buttonImport1.isHidden = false
        buttonImport2.isHidden = false
        buttonImport3.isHidden = false
        buttonImport4.isHidden = false
        viewLayout1.setImage(UIImage(named: ""), for: .normal)
        viewLayout2.setImage(UIImage(named: ""), for: .normal)
        viewLayout3.setImage(UIImage(named: "Selected"), for: .normal)
    }

    @IBAction func ButtonImportPhoto1(_ sender: Any) {
        addNewPicture()
    }

    @IBAction func swipeActionV2(_ sender: Any) {
        self.swipeView.transform = CGAffineTransform(translationX: 0, y: -200)
        self.sharePhoto()
        self.swipeView.transform = .identity
    }

    func sharePhoto() {
        let activityController =  UIActivityViewController(activityItems: [buttonImport1!], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
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
            buttonImport1.setImage(image, for: .normal)
        }
        
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // code
    }
}
