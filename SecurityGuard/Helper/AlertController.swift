//
//  AlertController.swift
//  SecurityGuard
//
//  Created by Arash Zeinoddini on 8/10/23.
//

import Foundation
import UIKit

class AlertController {
    static let shared = AlertController()
    private init() {}
    func present(in controller: UIViewController, title: String = "Alert", message: String, completation: (()->())? = nil) {
        let titleLocalized = NSLocalizedString(title, comment: "")
        let messageLocalized = NSLocalizedString(message, comment: "")
        let okLocalizedTitle = NSLocalizedString("OK", comment: "")
        
        let alert = UIAlertController(title: titleLocalized, message: messageLocalized, preferredStyle: .alert)
        let okButton = UIAlertAction(title: okLocalizedTitle, style: .default) {_ in
            completation?()
        }
        alert.addAction(okButton)

        controller.present(alert, animated: true)
    }
}
