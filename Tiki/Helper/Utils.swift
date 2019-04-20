//
//  Utils.swift
//  Tiki
//
//  Created by Hoang Minh Truong on 4/19/19.
//  Copyright © 2019 Truong Hoang Minh. All rights reserved.
//

import UIKit

class Utils {
    
    static func showAlert(title: String, message: String, viewController : UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
