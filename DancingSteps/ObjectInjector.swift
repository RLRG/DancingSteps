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
        
        let useCaseProvider = UseCaseProviderClass()
        
        let saveNewVideoUseCase = useCaseProvider.makeSaveNewVideoUseCase()
        let getDanceStylesUseCase = useCaseProvider.makeGetDanceStylesUseCase()
        let r_presenter = CompleteVideoPresenter(saveVideoUseCase: saveNewVideoUseCase, getDanceStylesUseCase: getDanceStylesUseCase)
        
        return r_presenter
    }
}
