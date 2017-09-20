//
//  CompleteVideoPresenterTests.swift
//  DancingStepsTests
//
//  Created by Rodrigo López-Romero Guijarro on 20/09/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import XCTest
import RxSwift

@testable import DancingSteps

class CompleteVideoPresenterTests: XCTestCase {
    
    // MARK: - CONFIGURATION
    
    var sut: CompleteVideoPresenter!
    var view: TestableCompleteVideoVC!
    var getDanceStylesUseCase: TestableGetDanceStylesUseCase!
    var saveNewVideoUseCase: TestableSaveVideoUseCase!
    
    override func setUp() {
        super.setUp()
        view = TestableCompleteVideoVC()
        getDanceStylesUseCase = TestableGetDanceStylesUseCase()
        saveNewVideoUseCase = TestableSaveVideoUseCase()
        sut = CompleteVideoPresenter(saveVideoUseCase: saveNewVideoUseCase, getDanceStylesUseCase: getDanceStylesUseCase)
        sut.completeVideoVC = view
        
        sut.getDanceStyles()
    }
    
    override func tearDown() {
        view = nil
        getDanceStylesUseCase = nil
        saveNewVideoUseCase = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: - TESTS
    
    func testTrueTest() {
        XCTAssertTrue(true)
    }
    
    func testGetDanceStylesLoadsStyles() {
        XCTAssertTrue(sut.styles.value.count == 2)
    }
    
    func testFirstDanceStyleIsLoadedSuccessfully() {
        XCTAssertEqual(sut.styles.value[0].name, "Salsa")
    }
    
    func testInteractorCalledToSaveVideo() {
        sut.saveVideo(title: "Video1", styleId: "Salsa", videoURL: URL(string: "testing/url")!)
        XCTAssertTrue(saveNewVideoUseCase.saveToVideoDBInvoked)
    }
    
    func testViewCalledWithVideoSuccessfullySaved() {
        sut.saveVideo(title: "Video1", styleId: "Salsa", videoURL: URL(string: "testing/url")!)
        XCTAssertTrue(view.videoSavedSuccessfullyInvoked)
    }
    
    // MARK: - MOCKS
    
    class TestableCompleteVideoVC: CompleteVideoProtocol {
        var videoSavedSuccessfullyInvoked = false
        var errorSavingVideoMessage = ""
        
        func videoSavedSuccessfully() {
            videoSavedSuccessfullyInvoked = true
        }
        
        func errorSavingVideo(error: Error) {
            errorSavingVideoMessage = error.localizedDescription
        }
    }
    
    class TestableGetDanceStylesUseCase: GetDanceStylesProtocol {
        func getDanceStyles() -> Observable<[Style]> {
            return Utils.myFrom(TestData.styles)
        }
    }
    
    class TestableSaveVideoUseCase: SaveNewVideoProtocol {
        var saveToVideoDBInvoked = false
        
        func saveVideoToDB(title: String, styleId: String, videoURL: URL) -> Observable<Void> {
            saveToVideoDBInvoked = true
            
            return Observable.create { observer in
                observer.on(.completed)
                return Disposables.create()
            }
        }
    }
    
}
