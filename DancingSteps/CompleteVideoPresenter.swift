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
    
    let saveVideoUseCase: SaveNewVideoUseCase
    let getDanceStylesUseCase: GetDanceStylesUseCase
    var completeVideoVC : CompleteVideoProtocol!
    var styles: Variable<[Style]> = Variable([])
    let disposeBag = DisposeBag()
    
    init (saveVideoUseCase: SaveNewVideoUseCase, getDanceStylesUseCase: GetDanceStylesUseCase) {
        self.saveVideoUseCase = saveVideoUseCase
        self.getDanceStylesUseCase = getDanceStylesUseCase
    }
    
    func saveVideo(title: String = "NO_TITLE", styleId: String, videoURL: URL) {
        saveVideoUseCase.saveVideoToDB(title: title, styleId: styleId, videoURL: videoURL)
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

extension CompleteVideoPresenter : CompleteVideoPresentation {
    func present(finishVideoObservable: Observable<Void>) {
        finishVideoObservable
            .subscribe(
                onError: { (error) in
                    self.completeVideoVC.errorSavingVideo(error: error)
            },
                onCompleted: {
                    self.completeVideoVC.videoSavedSuccessfully()
        }).disposed(by: disposeBag)
    }
    
    func displayError(string: String) {
        self.completeVideoVC.errorSavingVideo(error: NSError(domain: string, code: 001, userInfo: nil))
    }
}
