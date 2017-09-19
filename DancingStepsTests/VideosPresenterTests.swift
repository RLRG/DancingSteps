//
//  VideosPresenterTests.swift
//  DancingStepsTests
//
//  Created by Rodrigo López-Romero Guijarro on 19/09/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import XCTest
@testable import DancingSteps
import RxSwift

class VideosPresenterTests: XCTestCase {
    
    var sut: VideosPresenter!
    var view: TestableVideosTableVC!
    
    override func setUp() {
        super.setUp()
        view = TestableVideosTableVC()
        sut = VideosPresenter(getVideosUseCase: TestableGetVideosUseCase(), getDanceStylesUseCase: TestableGetDanceStylesUseCase())
        sut.videosTableVC = view
    }
    
    override func tearDown() {
        view = nil
        sut = nil
        super.tearDown()
    }
    
    func testTrueTest() {
        XCTAssertTrue(true)
    }
    
    // TODO: PROGRAM TESTS FOR THE PRESENTER HERE !!!!!!!!
    
    class TestableVideosTableVC : VideosTableVCProtocol {
        
        func displayVideoScreen(withVideoTitle title: String) {
            
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
