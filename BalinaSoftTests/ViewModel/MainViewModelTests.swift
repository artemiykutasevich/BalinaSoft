//
//  MainViewModelTests.swift
//  BalinaSoftTests
//
//  Created by Artem Kutasevich on 5.05.22.
//

import XCTest
@testable import BalinaSoft

class MainViewModelTests: XCTestCase {
    
    var viewModel: MainViewModel!
    
    override func setUp() {
        viewModel = MainViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func testViewModelContainsTapeOfImages() {
        XCTAssertNotNil(viewModel.tapeOfImages)
    }
    
    func testUpdatingImagesUpdateCurrentPage() {
        viewModel.currentPage = 0
        viewModel.updateImages()
        XCTAssertEqual(viewModel.currentPage, 1)
    }
}
