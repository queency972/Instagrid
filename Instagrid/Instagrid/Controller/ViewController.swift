//
//  ViewController.swift
//  Instagrid
//
//  Created by Steve Bernard on 15/10/2019.
//  Copyright © 2019 Steve Bernard. All rights reserved.
//

import Photos
import UIKit

class ViewController: UIViewController  {


    @IBOutlet weak var swipeSquare: UIView!
    @IBOutlet weak var buttonImport1: UIButton!
    @IBOutlet weak var buttonImport2: UIButton!
    @IBOutlet weak var buttonImport3: UIButton!
    @IBOutlet weak var buttonImport4: UIButton!
    @IBOutlet weak var viewLayout1: UIButton!
    @IBOutlet weak var viewLayout2: UIButton!
    @IBOutlet weak var viewLayout3: UIButton!
    var currentButton: UIButton?

    // var allowing to know if the device is Landscape mode.
    var isLandscape: Bool {
        return UIDevice.current.orientation.isValidInterfaceOrientation
            ? UIDevice.current.orientation.isLandscape
            : UIApplication.shared.statusBarOrientation.isLandscape
    }


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

    // var allowing to have the sender (Image)
    @IBAction func ButtonImportPhoto1(_ sender: UIButton) {
        currentButton = sender
        addNewPicture()
    }

    // Allowing to make a swipe Up or Left.
    @IBAction func swipeSquareActionV3(_ sender: UISwipeGestureRecognizer) {
        if UIDevice.current.orientation.isPortrait {
            if sender.direction == .up {
                UIView.animate(withDuration: 0.5) {
                    self.swipeSquare.transform = CGAffineTransform(translationX: 0, y: -300)
                    self.swipeSquare.alpha = 0
                    self.sharePhoto()
                }
            }
        }
        else if UIDevice.current.orientation.isLandscape {
            if sender.direction == .left {
                UIView.animate(withDuration: 0.5) {
                    self.swipeSquare.transform = CGAffineTransform(translationX: -300, y: 0)
                    self.swipeSquare.alpha = 0
                    self.sharePhoto()
                }
            }
        }
    }

    // Allowing to share the picture with closure
    func sharePhoto() {
        let image = swipeSquare.asImage()
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
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

    // Allowing add a picture.
    func addNewPicture() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            myPickerController.allowsEditing = false
            present(myPickerController, animated: true)
        }
    }

    // Switch on different Layout via parameters.
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

    // At loading, setup viewLayout3 by default and run func SetSwipe
    override func viewDidLoad() {
        super.viewDidLoad()
        viewLayout3.setImage(UIImage(named: "Selected"), for: .normal)
        setSwipe()
    }

    // Check in live what is the device's position
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        setSwipe()
    }

    // Setup swipe (Up or Left)
    func setSwipe() {
        if !isLandscape {
            let upSwipeGesture = UISwipeGestureRecognizer(target: self, action:#selector(swipeSquareActionV3(_:)))
            upSwipeGesture.direction = .up
            self.view.addGestureRecognizer(upSwipeGesture)
            print("Portrait Mode !")
        }
        else  {
            let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action:#selector(swipeSquareActionV3(_:)))
            leftSwipeGesture.direction = .left
            self.view.addGestureRecognizer(leftSwipeGesture)
            print("LandScape Mode !")
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // func allowing to define the picture.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if let buttonSelected = currentButton {
                buttonSelected.setImage(image, for: .normal)
            }
        }

        self.dismiss(animated: true, completion: nil)
    }

}
