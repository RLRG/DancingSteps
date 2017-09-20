//
//  VideosPresenterTests.swift
//  DancingStepsTests
//
//  Created by Rodrigo López-Romero Guijarro on 19/09/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import XCTest
import RxSwift

@testable import DancingSteps

class VideosPresenterTests: XCTestCase {
    
    // MARK: - CONFIGURATION
    
    var sut: VideosPresenter!
    var view: TestableVideosTableVC!
    var cellView: TestableVideoCellView!
    var getStylesUseCase: TestableGetDanceStylesUseCase!
    var getVideosUseCase: TestableGetVideosUseCase!
    
    override func setUp() {
        super.setUp()
        view = TestableVideosTableVC()
        cellView = TestableVideoCellView()
        getStylesUseCase = TestableGetDanceStylesUseCase()
        getVideosUseCase = TestableGetVideosUseCase()
        sut = VideosPresenter(getVideosUseCase: getVideosUseCase, getDanceStylesUseCase: getStylesUseCase)
        sut.videosTableVC = view
    }
    
    override func tearDown() {
        view = nil
        getStylesUseCase = nil
        getVideosUseCase = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: - TESTS
    
    func testTrueTest() {
        XCTAssertTrue(true)
    }
    
    func testViewReadyLoadsVideosFromUseCase() {
        sut.viewIsReady()
        XCTAssertTrue(sut.videos.value.count == 3)
    }
    
    func testGetDanceStylesLoadsStyles() {
        sut.getDanceStyles()
        XCTAssertTrue(sut.styles.value.count == 2)
    }
    
    func testConfigureCellCallsViewDisplay() {
        sut.viewIsReady()
        sut.getDanceStyles()
        sut.configure(cell: cellView, forSectionAt: 0, forRowAt: 0)
        XCTAssertEqual(cellView.cellName, TestData.videos[0].title)
    }
    
    func testConfigureVideoScreenCallsView() {
        sut.viewIsReady()
        sut.getDanceStyles()
        sut.configureVideoScreen(forIndexAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(view.displayVideoScreenInvoked)
    }
    
    // MARK: - MOCKS
    
    class TestableVideosTableVC : VideosTableVCProtocol {
        var displayVideoScreenInvoked = false
        
        func displayVideoScreen(withVideoTitle title: String) {
            displayVideoScreenInvoked = true
        }
    }
    
    class TestableVideoCellView : VideoCellView {
        var cellName = ""
        
        func display(name: String) {
            cellName = name
        }
    }
    
    class TestableGetDanceStylesUseCase: GetDanceStylesProtocol {
        func getDanceStyles() -> Observable<[Style]> {
            return Utils.myFrom(TestData.styles)
        }
    }
    
    class TestableGetVideosUseCase : GetVideosProtocol {
        func getAllVideos() -> Observable<[Video]> {
            return Utils.myFrom(TestData.videos)
        }
    }
}
