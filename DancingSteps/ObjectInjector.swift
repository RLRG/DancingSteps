//
//  ObjectInjector.swift
//  DancingSteps
//
//  Created by Rodrigo López-Romero Guijarro on 01/09/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation

class ObjectInjector {
    
    class func createPresenterForCompleteVideoVC () -> CompleteVideoPresenter {
        let realmVideoRepo = RealmRepo<Video>()
        let realmStyleRepo = RealmRepo<Style>()
        let saveNewVideoUseCase = SaveNewVideoUseCase(repository: realmVideoRepo)
        let getDanceStylesUseCase = GetDanceStylesUseCase(repository: realmStyleRepo)
        let r_presenter = CompleteVideoPresenter(saveVideoUseCase: saveNewVideoUseCase, getDanceStylesUseCase: getDanceStylesUseCase)
        
        return r_presenter
    }
}
