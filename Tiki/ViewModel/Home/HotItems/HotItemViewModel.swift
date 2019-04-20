//
//  HotItemViewModel.swift
//  Tiki
//
//  Created by Mac on 4/19/19.
//  Copyright © 2019 Truong Hoang Minh. All rights reserved.
//
import UIKit

class HotItemViewModel {
    var icon: String = ""
    var title: String = ""
    var widthItem: CGFloat = 110.0
    var minwidthItem: CGFloat = 110.0
    var heightItem: CGFloat = 175.0
    var color: String = ""
    
    init(hotItemModel: HotItemModel, index: Int) {
        self.icon = hotItemModel.icon
        self.title = hotItemModel.keyword
        self.color = BackgroundTitleColor.getBackgroundTitleColor(index: index % BackgroundTitleColor.allCases.count)
        
        // Calculate with of items anh title will show
        let calculateWidthAndTitle = calculateWidthTitle(title: hotItemModel.keyword.trimmingCharacters(in: .whitespacesAndNewlines))
        self.widthItem = calculateWidthAndTitle.widthItem
        self.title = calculateWidthAndTitle.titleShow
    }
    
    init() {}
    
    func calculateWidthTitle(title: String) -> (widthItem: CGFloat, titleShow: String) {
        var widthItem: CGFloat = 0
        var titleShow: String = ""
        let titleArray = title.components(separatedBy: " ")
        if titleArray.count == 1{
            widthItem = calculateWidth(title: title)
            titleShow = title
        }else{
            let seperateTitleResult = seperateTitle(titleArray: titleArray)
            let firstLineWidth = calculateWidth(title: seperateTitleResult.firstLineString)
            let secondLineWith = calculateWidth(title: seperateTitleResult.secondLineString)
            widthItem = max(firstLineWidth, secondLineWith)
            titleShow = String.init(format: "%@\n%@", seperateTitleResult.firstLineString, seperateTitleResult.secondLineString)
        }
        return (widthItem: widthItem, titleShow: titleShow)
    }
    
    func calculateWidth(title: String) -> CGFloat {
        let widthTitle = title.width(withConstraintedHeight: 14, font: UIFont.systemFont(ofSize: 14)) + 16
        return max(widthTitle,self.minwidthItem)
    }
    
    func seperateTitle(titleArray: [String]) -> (firstLineString: String, secondLineString: String) {
        var firstLineString: String = "", secondLineString: String = ""
        var firstLineIndex: Int = 0, secondLineIndex: Int = titleArray.count - 1
        
        while  firstLineIndex <= secondLineIndex {
            if firstLineString.count <= secondLineString.count {
                firstLineString += firstLineString == "" ? titleArray[firstLineIndex] : " " + titleArray[firstLineIndex]
                firstLineIndex += 1
            } else {
                secondLineString = (secondLineString == "" ? titleArray[secondLineIndex] : titleArray[secondLineIndex] + " ") + secondLineString
                secondLineIndex -= 1
            }
        }
        return (firstLineString: firstLineString, secondLineString: secondLineString)
    }
}
