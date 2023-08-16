//
//  PaddedTextField.swift
//  SecurityGuard
//
//  Created by Arash Zeinoddini on 8/7/23.
//

import UIKit

class PaddedTextField: UITextField {

    // Padding for left and right edges
    @IBInspectable var leftPadding: CGFloat = 0
    @IBInspectable var rightPadding: CGFloat = 0
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: rightPadding))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: rightPadding))
    }

}
