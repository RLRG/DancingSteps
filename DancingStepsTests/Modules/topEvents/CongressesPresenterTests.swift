//
//  CongressesPresenterTests.swift
//  DancingStepsTests
//
//  Created by Rodrigo López-Romero Guijarro on 20/09/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import XCTest
import RxSwift

@testable import DancingSteps

class CongressesPresenterTests: XCTestCase {
    
    // MARK: - CONFIGURATION
    
    var sut: CongressesPresenter!
    var view: MockCongressesTableViewController!
    var viewCell: MockCongressCellView!
    var getCongressesUseCase: MockGetCongressesUseCase!
    
    override func setUp() {
        super.setUp()
        view = MockCongressesTableViewController()
        viewCell = MockCongressCellView()
        getCongressesUseCase = MockGetCongressesUseCase()
        sut = CongressesPresenter(getCongressesUseCase: getCongressesUseCase)
        sut.congressesView = view
        
        sut.viewIsReady()
    }
    
    override func tearDown() {
        sut = nil
        view = nil
        viewCell = nil
        getCongressesUseCase = nil
        super.tearDown()
    }
    
    // MARK: - TESTS
    
    func testTrueTest() {
        XCTAssertTrue(true)
    }
    
    func testPresenterLoadsAllCongresses() {
        XCTAssertTrue(sut.congresses.value.count == 3)
    }
    
    func testPresenterLoadsTheFirstCongress() {
        XCTAssertEqual(sut.congresses.value[0].name, "Cong1")
    }
    
    func testConfigureCellNotifyView() {
        sut.configure(cell: viewCell, forRowAt: 1)
        XCTAssertEqual(viewCell.nameToDisplay, "Cong2")
        XCTAssertEqual(viewCell.imageUrlToDisplay, "testingUrl/Cong2")
    }
    
    func testConfigureEventDetailsScreenSetTheProper() {
        sut.configureEventDetailsScreen(forRowAt: 2)
        XCTAssertFalse(view.errorGettingCongresses)
        XCTAssertEqual(view.congressToDisplay!.name, sut.congresses.value[2].name)
    }
    
    // MARK: - MOCKS
    
    class MockCongressesTableViewController: CongressesTableViewProtocol {
        var congressToDisplay:Congress? = nil
        var errorGettingCongresses = false
        
        func displayEventDetailsScreen(forCongress congress: Congress) {
            congressToDisplay = congress
        }
        
        func displayNetworkError() {
            errorGettingCongresses = true
        }
    }
    
    class MockCongressCellView: CongressCellView {
        var nameToDisplay = ""
        var imageUrlToDisplay = ""
        
        func display(name: String, imageUrl: String) {
            nameToDisplay = name
            imageUrlToDisplay = imageUrl
        }
    }
    
    class MockGetCongressesUseCase: GetCongressesProtocol {
        func congresses() -> Observable<[Congress]> {
            return Utils.myFrom(TestData.congresses)
        }
    }
    
}
