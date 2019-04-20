//
//  Enum.swift
//  Tiki
//
//  Created by Hoang Minh Truong on 4/19/19.
//  Copyright © 2019 Truong Hoang Minh. All rights reserved.
//

import Foundation

//MARK: - Info of HotItem
enum LinkAPI: String {
    case apiHotItems = "https://tiki-mobile.s3-ap-southeast-1.amazonaws.com/ios/keywords.json"
}

enum BackgroundTitleColor: String, CaseIterable{
    case color1 = "16702e"
    case color2 = "005a51"
    case color3 = "996c00"
    case color4 = "5c0a6b"
    case color5 = "006d90"
    case color6 = "974e06"
    case color7 = "99272e"
    case color8 = "89221f"
    case color9 = "00345d"
    
    static func getBackgroundTitleColor(index: Int) -> String {
        switch index {
        case 0:
            return self.color1.rawValue
        case 1:
            return self.color2.rawValue
        case 2:
            return self.color3.rawValue
        case 3:
            return self.color4.rawValue
        case 4:
            return self.color5.rawValue
        case 5:
            return self.color6.rawValue
        case 6:
            return self.color7.rawValue
        case 7:
            return self.color8.rawValue
        default:
            return self.color9.rawValue
        }
    }
}
