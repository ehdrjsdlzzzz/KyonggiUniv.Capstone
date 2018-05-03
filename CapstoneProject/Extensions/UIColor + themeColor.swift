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
//    static var themeWhite: UIColor {
//        return UIColor(hex: 0xF5F2DC)
//    }
    // Second Theme
    static var themeDarkBlue: UIColor {
        return UIColor(hex: 0x012E40)
    }
    static var themeDeepBlueGreen: UIColor {
        return UIColor(hex: 0x1e4e59)
    }
    static var themeLightBlueGreen: UIColor {
        return UIColor(hex: 0x618c88)
    }
    static var themeOpaqueGray: UIColor {
        return UIColor(hex: 0xbfb8aa)
    }
    static var themeLightSkin: UIColor {
        return UIColor(hex: 0xf2e2ce)
    }
    convenience init(hex: Int){
        self.init(red: CGFloat((hex & 0xFF0000) >> 16) / 255.0, green: CGFloat((hex & 0x00FF00) >> 8) / 255.0, blue: CGFloat(hex & 0x0000FF) / 255.0, alpha: 1)
    }
}
