//
//  CompleteVideoPresenter.swift
//  DancingSteps
//
//  Created by RLRG on 12/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation

class CompleteVideoPresenter {
    
    let useCase: SaveNewVideoUseCase
    
    init (useCase: SaveNewVideoUseCase) {
        self.useCase = useCase
    }
    
    func saveVideo(title: String = "NO_TITLE", videoURL: URL) {
        useCase.saveVideoToDB(title: title, videoURL: videoURL)
            .subscribe({_ in
                print("The saving of the video has FINISHED.")
                // TODO: Tell the view/user we have finished !
            })
    }
}
