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


    @IBOutlet weak var swipeSquare: UIView!
    @IBOutlet weak var buttonImport1: UIButton!
    @IBOutlet weak var buttonImport2: UIButton!
    @IBOutlet weak var buttonImport3: UIButton!
    @IBOutlet weak var buttonImport4: UIButton!
    @IBOutlet weak var viewLayout1: UIButton!
    @IBOutlet weak var viewLayout2: UIButton!
    @IBOutlet weak var viewLayout3: UIButton!
    var currentButton: UIButton?

    @IBAction func changeLayout(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            layoutChoice(choice: "Layout1")
        case 2:
            layoutChoice(choice: "Layout2")
        case 3:
            layoutChoice(choice: "Layout3")
        default:
            break
        }
    }

    @IBAction func ButtonImportPhoto1(_ sender: UIButton) {
        currentButton = sender
        addNewPicture()
    }

    @IBAction func swipeSquareActionV2(_ sender: UISwipeGestureRecognizer) {
        let translationUP = CGAffineTransform(translationX: 0, y: -180)
        UIView.animate(withDuration: 0.5) {
            self.swipeSquare.transform = translationUP
            self.swipeSquare.alpha = 0
            self.sharePhoto()
        }
    }

    func sharePhoto() {
        let activityController = UIActivityViewController(activityItems: [buttonImport1.image(for: .normal)!], applicationActivities: nil)
        activityController.completionWithItemsHandler = {
            (activity, success, items, error) in
            if (!success) {
                self.swipeSquare.transform = .identity
                self.swipeSquare.alpha = 1
            }
            else {
                self.swipeSquare.transform = .identity
                self.swipeSquare.alpha = 1
            }
        }
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
            if let buttonSelected = currentButton {
                buttonSelected.setImage(image, for: .normal)
            }
        }
        
        self.dismiss(animated: true, completion: nil)
    }

    func layoutChoice(choice: String) {
        switch choice {
        case "Layout1":
            buttonImport1.isHidden = false
            buttonImport2.isHidden = true
            buttonImport3.isHidden = false
            buttonImport4.isHidden = false
            viewLayout1.setImage(UIImage(named: "Selected"), for: .normal)
            viewLayout2.setImage(UIImage(named: ""), for: .normal)
            viewLayout3.setImage(UIImage(named: ""), for: .normal)
        case "Layout2":
            buttonImport1.isHidden = false
            buttonImport2.isHidden = false
            buttonImport3.isHidden = false
            buttonImport4.isHidden = true
            viewLayout1.setImage(UIImage(named: ""), for: .normal)
            viewLayout2.setImage(UIImage(named: "Selected"), for: .normal)
            viewLayout3.setImage(UIImage(named: ""), for: .normal)
        case "Layout3":
            buttonImport1.isHidden = false
            buttonImport2.isHidden = false
            buttonImport3.isHidden = false
            buttonImport4.isHidden = false
            viewLayout1.setImage(UIImage(named: ""), for: .normal)
            viewLayout2.setImage(UIImage(named: ""), for: .normal)
            viewLayout3.setImage(UIImage(named: "Selected"), for: .normal)
        default:
            break
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // code
    }
}
