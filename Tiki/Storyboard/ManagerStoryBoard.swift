//
//  ManagerStoryBoard.swift
//  Tiki
//
//  Created by Mac on 4/19/19.
//  Copyright © 2019 Truong Hoang Minh. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    //MARK: Home Storyboard
    class func homeStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Home", bundle: Bundle.main)
    }
    
    class func homeViewController() -> HomeViewController? {
        return homeStoryboard().instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
    }
    
}
