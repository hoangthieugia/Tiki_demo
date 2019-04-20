//
//  HotItemCell.swift
//  Tiki
//
//  Created by Mac on 4/19/19.
//  Copyright © 2019 Truong Hoang Minh. All rights reserved.
//

import UIKit
import SDWebImage

class HotItemCell: UICollectionViewCell {
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewBgTitle: UIView!
    var itemViewModel : HotItemViewModel! {
        didSet {
            self.lblTitle.text = itemViewModel.title
            self.viewBgTitle.backgroundColor = UIColor.UIColorFromRGB(colorCode: itemViewModel.color)
            if let url = URL(string: itemViewModel.icon) {
                self.imgIcon.sd_setImage(with: url, completed: nil)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBgTitle.layer.cornerRadius = 8
        viewBgTitle.clipsToBounds = true
        // Initialization code
    }

}
