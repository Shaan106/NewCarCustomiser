//
//  CarCustomiserUITests.swift
//  CarCustomiserUITests
//
//  Created by Aasmaan Yadav on 21/01/21.
//

import XCTest

class CarCustomiserUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWhenBoughtTiresAndExhaustandWeightPackageOtherPackagesDisabled() throws {
        //arrange
        let app = XCUIApplication()
        app.launch()
        
        //act
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.switches["Exhaust Package (cost: 500)"]/*[[".cells.switches[\"Exhaust Package (cost: 500)\"]",".switches[\"Exhaust Package (cost: 500)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.switches["Tires Package (cost: 250)"]/*[[".cells[\"Tires Package (cost: 250)\"].switches[\"Tires Package (cost: 250)\"]",".switches[\"Tires Package (cost: 250)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.switches["Weight Package (cost: 250)"]/*[[".cells[\"Weight Package (cost: 250)\"].switches[\"Weight Package (cost: 250)\"]",".switches[\"Weight Package (cost: 250)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        //assert
        
        XCTAssertEqual(tablesQuery/*@START_MENU_TOKEN@*/.switches["Engine Package (cost: 750)"]/*[[".cells[\"Engine Package (cost: 750)\"].switches[\"Engine Package (cost: 750)\"]",".switches[\"Engine Package (cost: 750)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.isEnabled, false)
    }
    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
