//
//  UIColorExtensions.swift
//  Assesment Test
//
//  Created by Kalyan Thakur on 23/03/21.
//

import UIKit
import SwiftCake

extension UIColor {
    
    /// Colors changed here will affect on entire app
    
    class var appGreen: UIColor {
        return UIColor(r: 0, g: 186, b: 48)
    }
    class var appOrange: UIColor {
        return UIColor(r: 245, g: 150, b: 13)
    }
    class var appBlue: UIColor {
        return UIColor.init(hex: "3479B2")!
    }
    class var appThemeColor: UIColor {
        return UIColor.init(hex: "11A8FD")!
    }
    class var appLightGreen: UIColor {
        return UIColor(r: 52, g: 80, b: 56)
    }
    
    class var appLightPink: UIColor {
        return UIColor(r: 100, g: 58, b: 57)
    }
    
    class var appBackground: UIColor {
        return UIColor(r: 235, g: 235, b: 235)
    }
    
    class var appGray: UIColor {
        return UIColor(r: 153, g: 153, b: 153)
    }
    
    class var appLightGray: UIColor {
        return UIColor(r: 238, g: 238, b: 238)
    }
    
    class var appDarkGray: UIColor {
        return UIColor(r: 99, g: 100, b: 102)
    }
    
    class var appRed: UIColor {
        return UIColor(r: 253, g: 44, b: 58).withAlphaComponent(0.75)
    }
    
    class var appGold: UIColor {
        return UIColor(r: 255, g: 205, b: 38)
    }
    
    class var appWhiteWithAlpha: UIColor {
        return UIColor.white.withAlphaComponent(0.75)
    }
    
    class var appDarkTextAlpha: UIColor {
        return UIColor(r: 20, g: 20, b: 20).withAlphaComponent(0.9)
    }
    
    class var holeTextColor: UIColor {
        return UIColor(hex: "666466")!
    }
    
    class func constant(_ constant: Int) -> UIColor {
        switch constant {
        case 1:
            return UIColor.appGray
        case 2:
            return UIColor.appGreen
        case 3:
            return UIColor.appDarkGray
        case 4:
            return UIColor.appBackground
        case 5:
            return UIColor.appRed
        case 10:
            return UIColor.appWhiteWithAlpha
        case 11:
            return UIColor.appWhiteWithAlpha
        default:
            // For debug purpose
            return UIColor.green
        }
    }
    
}
