//
//  UIView+extension.swift
//  Instagrid
//
//  Created by Steve Bernard on 11/11/2019.
//  Copyright © 2019 Steve Bernard. All rights reserved.
//


import Foundation
import UIKit

extension UIView {

    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        let image = renderer.image { ctx in
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
        return image
    }
}
