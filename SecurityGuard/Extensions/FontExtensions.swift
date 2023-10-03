//
//  FontExtensions.swift
//  SecurityGuard
//
//  Created by Arash Zeinoddini on 8/27/23.
//

import Foundation
import UIKit

extension UIFont {
    
    struct CustomFont {
        
        var fontFamily: String
        
        static let defaultFontSize: CGFloat = 12
        func Normal(withSize size: CGFloat = CustomFont.defaultFontSize) -> UIFont? {
            return UIFont(name: "\(fontFamily)", size: size)
        }
    }
    
    class var BYekan: CustomFont {
        return CustomFont(fontFamily: "B Yekan")
    }
}
