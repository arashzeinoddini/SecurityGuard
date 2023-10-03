//
//  TabBarController.swift
//  SecurityGuard
//
//  Created by Arash Zeinoddini on 8/9/23.
//

import UIKit

class TabBarController: UITabBarController {
    
    @IBInspectable var initialIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        selectedIndex = initialIndex
        
        // Set the Fonts
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.BYekan.Normal(withSize: 10)!], for: .normal)
    }

}
