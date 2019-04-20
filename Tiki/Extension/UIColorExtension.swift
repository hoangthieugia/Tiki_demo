//
//  UIColorExtension.swift
//  Tiki
//
//  Created by Hoang Minh Truong on 4/19/19.
//  Copyright © 2019 Truong Hoang Minh. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func UIColorFromRGB(colorCode: String, alpha: Float = 1.0) -> UIColor {
        let scanner = Scanner(string:colorCode)
        var color:UInt32 = 0;
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = CGFloat(Float(Int(color >> 16) & mask)/255.0)
        let g = CGFloat(Float(Int(color >> 8) & mask)/255.0)
        let b = CGFloat(Float(Int(color) & mask)/255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: CGFloat(alpha))
    }
    
}
