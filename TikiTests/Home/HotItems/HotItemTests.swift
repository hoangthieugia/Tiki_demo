//
//  HotItemsTest.swift
//  TikiTests
//
//  Created by Hoang Minh Truong on 4/20/19.
//  Copyright © 2019 Truong Hoang Minh. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import Tiki

class HotItemTests: XCTestCase {
    private var hotItemViewModel: HotItemViewModel!
    private let minWidthItem: CGFloat = 110.0
    private let heightItem: CGFloat = 175.0
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    //MARK: - Test min width and height of HotItemCell
    func testInitMinWidthItem() {
        hotItemViewModel = HotItemViewModel()
        XCTAssertEqual(hotItemViewModel.minwidthItem, minWidthItem)
    }
    
    func testHeightItem() {
        hotItemViewModel = HotItemViewModel()
        XCTAssertEqual(hotItemViewModel.heightItem, heightItem)
    }
    
    //MARK: - Test func calculate Width of String and func calculate Width, Title wil show
    func testCalculateWidthSigleLine() {
        hotItemViewModel = HotItemViewModel()
        let width = hotItemViewModel.calculateWidth(title: "Hoang Minh Truong")
        let widthCompare: CGFloat = 143.0
        XCTAssertEqual(width, widthCompare)
    }
    
    func testCalculateWidthAndTitleShow() {
        hotItemViewModel = HotItemViewModel()
        let item = hotItemViewModel.calculateWidthTitle(title: "Hoang Minh Truong")
        let itemCompare : (widthItem: CGFloat, titleShow: String) = (widthItem: 110.0, titleShow: """
                                                                                                Hoang Minh
                                                                                                Truong
                                                                                                """)
        XCTAssertEqual(item.widthItem, itemCompare.widthItem)
        XCTAssertEqual(item.titleShow, itemCompare.titleShow)
    }
    
    
    //MARK: - Test multi case of Title and Width of ItemCell from keyword
    func testWidthItemWithShortSigleWord() {
        let hotItemModel = Mapper<HotItemModel>().map(JSON: ["keyword": "single", "icon": "https://tee.tikicdn.com/cache/w300/ts/product/65/af/4a/cf7f612a16299f2dc4c53d0c57569d2a.jpg"])!
        hotItemViewModel = HotItemViewModel(hotItemModel: hotItemModel, index: 0)
        let width = hotItemViewModel.widthItem
        let widthCompare = minWidthItem
        XCTAssertEqual(width, widthCompare)
    }
    
    func testWidthItemWithLongSigleWord() {
        let hotItemModel = Mapper<HotItemModel>().map(JSON: ["keyword": "abcdefghiklmnop", "icon": "https://tee.tikicdn.com/cache/w300/ts/product/65/af/4a/cf7f612a16299f2dc4c53d0c57569d2a.jpg"])!
        hotItemViewModel = HotItemViewModel(hotItemModel: hotItemModel, index: 0)
        let width = hotItemViewModel.calculateWidth(title: "abcdefghiklmnop")
        let widthCompare: CGFloat = 128.0
        XCTAssertEqual(width, widthCompare)
    }
    
    func testWidthItemWithShortMutilWord() {
        let hotItemModel = Mapper<HotItemModel>().map(JSON: ["keyword": "multi word", "icon": "https://tee.tikicdn.com/cache/w300/ts/product/65/af/4a/cf7f612a16299f2dc4c53d0c57569d2a.jpg"])!
        hotItemViewModel = HotItemViewModel(hotItemModel: hotItemModel, index: 0)
        let width = hotItemViewModel.widthItem
        let widthCompare = minWidthItem
        XCTAssertEqual(width, widthCompare)
    }
    
    func testWidthItemWithLongMultiWord() {
        let hotItemModel = Mapper<HotItemModel>().map(JSON: ["keyword": "multi word multi word multi word", "icon": "https://tee.tikicdn.com/cache/w300/ts/product/65/af/4a/cf7f612a16299f2dc4c53d0c57569d2a.jpg"])!
        hotItemViewModel = HotItemViewModel(hotItemModel: hotItemModel, index: 0)
        let width = hotItemViewModel.widthItem
        debugPrint(width)
        let widthCompare: CGFloat = 120.0
        XCTAssertEqual(width, widthCompare)
    }
    
    func testTitleShowItemWithShortSigleWord() {
        let hotItemModel = Mapper<HotItemModel>().map(JSON: ["keyword": "single", "icon": "https://tee.tikicdn.com/cache/w300/ts/product/65/af/4a/cf7f612a16299f2dc4c53d0c57569d2a.jpg"])!
        hotItemViewModel = HotItemViewModel(hotItemModel: hotItemModel, index: 0)
        let titleShow = hotItemViewModel.title
        let titleShowCompare = "single"
        XCTAssertEqual(titleShow, titleShowCompare)
    }
    
    func testTitleShowItemWithLongSigleWord() {
        let hotItemModel = Mapper<HotItemModel>().map(JSON: ["keyword": "abcdefghiklmnop", "icon": "https://tee.tikicdn.com/cache/w300/ts/product/65/af/4a/cf7f612a16299f2dc4c53d0c57569d2a.jpg"])!
        hotItemViewModel = HotItemViewModel(hotItemModel: hotItemModel, index: 0)
        let titleShow = hotItemViewModel.title
        let titleShowCompare = "abcdefghiklmnop"
        XCTAssertEqual(titleShow, titleShowCompare)
    }
    
    func testTitleShowItemWithShortMutilWord() {
        let hotItemModel = Mapper<HotItemModel>().map(JSON: ["keyword": "multi word", "icon": "https://tee.tikicdn.com/cache/w300/ts/product/65/af/4a/cf7f612a16299f2dc4c53d0c57569d2a.jpg"])!
        hotItemViewModel = HotItemViewModel(hotItemModel: hotItemModel, index: 0)
        let titleShow = hotItemViewModel.title
        let titleShowCompare = """
                                multi
                                word
                                """
        XCTAssertEqual(titleShow, titleShowCompare)
    }
    
    func testTitleShowItemWithLongMultiWord() {
        let hotItemModel = Mapper<HotItemModel>().map(JSON: ["keyword": "multi word multi word multi word", "icon": "https://tee.tikicdn.com/cache/w300/ts/product/65/af/4a/cf7f612a16299f2dc4c53d0c57569d2a.jpg"])!
        hotItemViewModel = HotItemViewModel(hotItemModel: hotItemModel, index: 0)
        let titleShow = hotItemViewModel.title
        let titleShowCompare = """
                                multi word multi
                                word multi word
                                """
        XCTAssertEqual(titleShow, titleShowCompare)
    }
    
    //MARK: - Test function get color by index
    func testBackGroundTitleColorByIndex() {
        let color = BackgroundTitleColor.getBackgroundTitleColor(index: 1)
        let colorCompare = BackgroundTitleColor.color2.rawValue
        XCTAssertEqual(color, colorCompare)
    }
    
    //MARK: - Test Color will Show
    func testBackGroundTitleColor() {
        let hotItemModel = Mapper<HotItemModel>().map(JSON: ["keyword": "multi word multi word multi word", "icon": "https://tee.tikicdn.com/cache/w300/ts/product/65/af/4a/cf7f612a16299f2dc4c53d0c57569d2a.jpg"])!
        let index = Int.random(in: 0...8)
        hotItemViewModel = HotItemViewModel(hotItemModel: hotItemModel, index: index)
        let color = hotItemViewModel.color
        let colorCompare = BackgroundTitleColor.getBackgroundTitleColor(index: index)
        XCTAssertEqual(color, colorCompare)
    }
}
