//
//  HotItemsViewModel.swift
//  Tiki
//
//  Created by Mac on 4/19/19.
//  Copyright © 2019 Truong Hoang Minh. All rights reserved.
//

import ObjectMapper

class HotItemsViewModel {
    var hotItemsViewModel: [HotItemViewModel] = []
    
    //MARK: - API
    func getCourse(completion: @escaping (_ success: Bool) -> ()) {
        API.sharedInstance.getHotItems() { (response) in
            if response != nil {
                
                guard let hotItemsModel = Mapper<HotItemsModel>().map(JSON: response as! [String : Any]) else {
                    return
                }
                self.bindingToViewModel(hotItemsModel: hotItemsModel.items)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    //MARK: - BindingToViewModel
    func bindingToViewModel(hotItemsModel : [HotItemModel]) {
//        self.hotItemsViewModel = hotItemsModel.map { (hotItemModel) -> HotItemViewModel in
//            return HotItemViewModel.init(hotItemModel: hotItemModel)
//        }
        for (index, hotItemModel) in hotItemsModel.enumerated(){
            self.hotItemsViewModel.append(HotItemViewModel.init(hotItemModel: hotItemModel, index: index))
        }
    }
}
