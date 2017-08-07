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
    
    let useCase: SaveNewVideoUseCase
    var completeVideoVC : CompleteVideoProtocol!
    let disposeBag = DisposeBag()
    
    init (useCase: SaveNewVideoUseCase) {
        self.useCase = useCase
    }
    
    func saveVideo(title: String = "NO_TITLE", styleId: String, videoURL: URL) {
        useCase.saveVideoToDB(title: title, styleId: styleId, videoURL: videoURL)
    }
}

extension CompleteVideoPresenter : CompleteVideoPresentation {
    func present (finishVideoObservable: Observable<Void>) {
        finishVideoObservable
            .subscribe(
                onError: { (error) in
                    self.completeVideoVC.errorSavingVideo(error: error)
            },
                onCompleted: {
                    self.completeVideoVC.videoSavedSuccessfully()
        }).addDisposableTo(disposeBag)
    }
}
