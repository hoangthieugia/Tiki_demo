//
//  HotItemModel.swift
//  Tiki
//
//  Created by Mac on 4/19/19.
//  Copyright © 2019 Truong Hoang Minh. All rights reserved.
//

import ObjectMapper

struct HotItemModel: Mappable {
    var icon: String = ""
    var keyword: String = ""
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        icon <- map["icon"]
        keyword <- map["keyword"]
    }
}

struct HotItemsModel: Mappable {
    var items: [HotItemModel] = []
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map){
        items <- map["keywords"]
    }
}
