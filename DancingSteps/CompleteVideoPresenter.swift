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
    var styles: Variable<[Style]> = Variable([])
    let disposeBag = DisposeBag()
    
    init (useCase: SaveNewVideoUseCase) {
        self.useCase = useCase
    }
    
    func saveVideo(title: String = "NO_TITLE", styleId: String, videoURL: URL) {
        useCase.saveVideoToDB(title: title, styleId: styleId, videoURL: videoURL)
    }
    
    // QUESTION: Do we create a new file with a new Use Case for this case ? Why ? How to proceed ? For the moment, I include the querying method in the same Use Case (SaveNewVideoUseCase)
    func getDanceStyles() {
        useCase.getDanceStyles()
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
    
    func loadDanceStyles(finishQueryStyles: Observable<[Style]>) {
        finishQueryStyles
            .asObservable()
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
