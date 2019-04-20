//
//  HotItemsCell.swift
//  Tiki
//
//  Created by Hoang Minh Truong on 4/19/19.
//  Copyright © 2019 Truong Hoang Minh. All rights reserved.
//

import UIKit

class HotItemsCell: UITableViewCell {
    @IBOutlet weak var hotItemCollectionView: UICollectionView!
    private let hotItemCellId = "HotItemCell"
    private let padding: CGFloat = 16.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hotItemCollectionView.contentInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        hotItemCollectionView.register(UINib.init(nibName: hotItemCellId, bundle: Bundle.main), forCellWithReuseIdentifier: hotItemCellId)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCollectionViewDataSourceDelegate
        <D: UICollectionViewDataSource & UICollectionViewDelegate>
        (dataSourceDelegate: D, forRow row: Int) {
        hotItemCollectionView.delegate = dataSourceDelegate
        hotItemCollectionView.dataSource = dataSourceDelegate
        hotItemCollectionView.tag = row
        hotItemCollectionView.reloadData()
    }
}
