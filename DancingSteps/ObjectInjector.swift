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
        let saveNewVideoUseCase = SaveNewVideoUseCase()
        let getDanceStylesUseCase = GetDanceStylesUseCase()
        let r_presenter = CompleteVideoPresenter(saveVideoUseCase: saveNewVideoUseCase, getDanceStylesUseCase: getDanceStylesUseCase)
        
        return r_presenter
    }
}
