//
//  CustomView.swift
//  Maps
//
//  Created by Alex on 25/11/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit

@IBDesignable class CustomView: UIView {
    
    // MARK: - Inspectable Properties From Interface Builder
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
}

