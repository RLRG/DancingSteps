//
//  VideosTableViewControllerTests.swift
//  DancingStepsTests
//
//  Created by Rodrigo López-Romero Guijarro on 18/09/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import XCTest
@testable import DancingSteps
import RxSwift

class VideosTableViewControllerTests: XCTestCase {
    
    var sut: VideosTableViewController! // System Under Test: ViewController !!
    var presenter: TestableVideosPresenter!
    
    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "StylesTableViewController") as! VideosTableViewController
        presenter = TestableVideosPresenter(getVideosUseCase: TestableGetVideosUseCase(), getDanceStylesUseCase: TestableGetDanceStylesUseCase())
        sut.presenter = presenter
    }
    
    override func tearDown() {
        sut = nil
        presenter = nil
        super.tearDown()
    }
    
    func testTrueTest() {
        XCTAssertTrue(true)
    }
    
    func testPresenterIsInformedWhenViewIsReady() {

        // 2. ACT
        // sut.viewDidLoad() <<------- DON'T DO THIS !!!! WHAT WE SHOULD DO IS:
        _ = sut.view // --> ViewController does the job to call viewDidLoad !

        // 3. ASSERT (we want to check that the viewReady method was called)
        XCTAssertTrue(presenter.viewReadyInvoked)
    }
    
    // INNER CLASS !! BE CAREFUL, IT IS NOT A PROTOCOL, WE CAN CREATE A SUBCLASS
    // TEST DOUBLE: SPY TYPE
    class TestableVideosPresenter: VideosPresenter {
        var viewReadyInvoked = false

        override func viewIsReady() {
            viewReadyInvoked = true
        }
    }

    class TestableGetVideosUseCase : GetVideosProtocol {
        func getAllVideos() -> Observable<[Video]> {
            let observable = Observable<[Video]>.create { observer in
                observer.onCompleted()
                return Disposables.create()
            }
            return observable
        }
    }

    class TestableGetDanceStylesUseCase: GetDanceStylesProtocol {
        func getDanceStyles() -> Observable<[Style]> {
            let observable = Observable<[Style]>.create { observer in
                observer.onCompleted()
                return Disposables.create()
            }
            return observable
        }
    }
    
}
