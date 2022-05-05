//
//  MainViewTests.swift
//  BalinaSoftTests
//
//  Created by Artem Kutasevich on 5.05.22.
//

import XCTest
@testable import BalinaSoft

class MainViewTests: XCTestCase {
    
    var view: MainView!
    
    override func setUp() {
        view = MainView()
    }
    
    override func tearDown() {
        view = nil
    }
    
    func testViewContainsViewModel() {
        XCTAssertNotNil(view.viewModel, "viewModel in MainView is nil")
    }
}
