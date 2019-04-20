//
//  HomeViewController.swift
//  Tiki
//
//  Created by Mac on 4/19/19.
//  Copyright © 2019 Truong Hoang Minh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    //MARK: Declare
    private var viewModel: HotItemsViewModel = HotItemsViewModel()
    private let hotItemsCellId = "HotItemsCell"
    private let hotItemCellId = "HotItemCell"
    private let spacing: CGFloat = 16.0
    
    @IBOutlet weak var mainTableView: UITableView!
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        getHotItems()
        // Do any additional setup after loading the view.
    }
    
    //MARK: User Defined
    func setupViews() {
        self.title = "Home"
        mainTableView.register(UINib.init(nibName: hotItemsCellId, bundle: Bundle.main), forCellReuseIdentifier: hotItemsCellId)
        mainTableView.separatorStyle = .none
    }
    
    //MARK: Call API
    
    func getHotItems() {
        viewModel.getCourse(completion: { [weak self] (success) in
            guard let strongSelf = self else {
                return
            }
            if success {
                strongSelf.mainTableView.reloadSections(IndexSet(integersIn: 0...0), with: .none)
            } else {
               Utils.showAlert(title: "Alert", message: "Load data fail", viewController: strongSelf)
            }
        })
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: hotItemsCellId, for: indexPath) as! HotItemsCell
        cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.hotItemsViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: hotItemCellId, for: indexPath) as! HotItemCell
        cell.itemViewModel = viewModel.hotItemsViewModel[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = viewModel.hotItemsViewModel[indexPath.row]
        return CGSize(width: item.widthItem, height: item.heightItem)
    }
}
