//
//  CompleteVideoPresenter.swift
//  DancingSteps
//
//  Created by RLRG on 12/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import RxSwift

class CompleteVideoPresenter {
    
    let saveVideoUseCase: SaveNewVideoProtocol
    let getDanceStylesUseCase: GetDanceStylesProtocol
    var completeVideoVC : CompleteVideoProtocol!
    var styles: Variable<[Style]> = Variable([])
    let disposeBag = DisposeBag()
    
    init (saveVideoUseCase: SaveNewVideoProtocol, getDanceStylesUseCase: GetDanceStylesProtocol) {
        self.saveVideoUseCase = saveVideoUseCase
        self.getDanceStylesUseCase = getDanceStylesUseCase
    }
    
    func saveVideo(title: String = "NO_TITLE", styleId: String, videoURL: URL) {
        saveVideoUseCase.saveVideoToDB(title: title, styleId: styleId, videoURL: videoURL)
            .asObservable().subscribe(
                onError: { (error) in
                    self.completeVideoVC.errorSavingVideo(error: error)
            },
                onCompleted: {
                    self.completeVideoVC.videoSavedSuccessfully()
            }).disposed(by: disposeBag)
    }
    
    func getDanceStyles() {
        getDanceStylesUseCase.getDanceStyles().asObservable()
            .subscribe(
                onNext: { (returnedStyles) in
                    self.styles.value = returnedStyles
            },
                onError: { (error) in
                    #if DEBUG
                        print("Error querying dance styles.")
                    #endif
            },
                onCompleted: {
                    #if DEBUG
                        print("onCompleted querying dance styles.")
                    #endif
            }).disposed(by: disposeBag)
    }
}
