//
//  UseCaseProviderClass.swift
//  DancingSteps
//
//  Created by RLRG on 07/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation

public final class UseCaseProviderClass: UseCaseProvider {

    func makeGetDanceStylesUseCase() -> GetDanceStylesUseCase {
        return GetDanceStylesUseCase()
    }
    
    func makeGetVideosUseCase() -> GetVideosUseCase {
        return GetVideosUseCase()
    }
    
    func makeSaveNewVideoUseCase() -> SaveNewVideoUseCase {
        return SaveNewVideoUseCase()
    }
    
    func makeGetCongressesUseCase() -> GetCongressesNetworkUseCase {
        return GetCongressesNetworkUseCase()
    }

}

