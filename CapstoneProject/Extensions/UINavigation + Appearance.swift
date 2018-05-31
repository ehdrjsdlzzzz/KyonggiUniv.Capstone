//
//  UINavigation + Appearance.swift
//  CapstoneProject
//
//  Created by 이동건 on 2018. 5. 31..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

extension UINavigationController {
    func setupSelectViewController() {
        navigationBar.isTranslucent = false
        navigationBar.prefersLargeTitles = true
        navigationBar.shadowImage = UIImage()
        navigationBar.barTintColor = UIColor.themeLightSkin
        navigationBar.tintColor = UIColor.themeDarkBlue
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.themeDarkBlue]
        navigationBar.largeTitleTextAttributes = textAttributes
        
    }
}
