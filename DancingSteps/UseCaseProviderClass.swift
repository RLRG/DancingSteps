//
//  UseCaseProviderClass.swift
//  DancingSteps
//
//  Created by RLRG on 07/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation

public final class UseCaseProviderClass: UseCaseProvider {

    func makeGetDanceStylesUseCase() -> GetDanceStylesProtocol {
        return GetDanceStylesUseCase()
    }
    
    func makeGetVideosUseCase() -> GetVideosProtocol {
        return GetVideosUseCase()
    }
    
    func makeSaveNewVideoUseCase() -> SaveNewVideoProtocol {
        return SaveNewVideoUseCase()
    }
    
    func makeGetCongressesUseCase() -> GetCongressesProtocol {
        return GetCongressesNetworkUseCase()
    }

}

