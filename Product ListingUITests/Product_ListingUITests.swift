//
//  Product_ListingUITests.swift
//  Product ListingUITests
//
//  Created by Razvan Julian on 18/04/2018.
//  Copyright © 2018 Razvan Julian. All rights reserved.
//

import XCTest

class Product_ListingUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
//    let app = XCUIApplication()
//    let exerciseListingNavigationBar = app.navigationBars["Exercise Listing"]
//    let blackSquareButton = exerciseListingNavigationBar.buttons["black square"]
//    blackSquareButton.twoFingerTap()
//    exerciseListingNavigationBar.buttons["four black squares"].twoFingerTap()
//
//    let collectionViewsQuery = app.collectionViews
//    collectionViewsQuery.children(matching: .cell).element(boundBy: 3).children(matching: .other).element.swipeUp()
//    collectionViewsQuery.children(matching: .cell).element(boundBy: 5).children(matching: .other).element.swipeUp()
//
//    let collectionView = app.otherElements.containing(.navigationBar, identifier:"Exercise Listing").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element
//    collectionView.swipeUp()
//    collectionViewsQuery.children(matching: .cell).element(boundBy: 9).children(matching: .other).element.swipeUp()
//    blackSquareButton.twoFingerTap()
//    collectionView.swipeUp()
//    collectionViewsQuery.children(matching: .cell).element(boundBy: 2).children(matching: .other).element.swipeUp()
//
//    let element = collectionViewsQuery.children(matching: .cell).element(boundBy: 1).children(matching: .other).element
//    element.twoFingerTap()
//    element.twoFingerTap()
//    element.swipeUp()

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
