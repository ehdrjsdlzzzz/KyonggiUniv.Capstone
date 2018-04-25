//
//  UIColor + themeColor.swift
//  CapstoneProject
//
//  Created by 이동건 on 2018. 4. 19..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

extension UIColor {
    static var themeDark: UIColor {
        return UIColor(hex: 0x454445)
    }
    static var themeLightGreen: UIColor {
        return UIColor(hex: 0x009494)
    }
    static var themeGreen: UIColor {
        return UIColor(hex: 0x00585E)
    }
    static var themeWhite: UIColor {
        return UIColor(hex: 0xF5F2DC)
    }
    convenience init(hex: Int){
        self.init(red: CGFloat((hex & 0xFF0000) >> 16) / 255.0, green: CGFloat((hex & 0x00FF00) >> 8) / 255.0, blue: CGFloat(hex & 0x0000FF) / 255.0, alpha: 1)
    }
}
