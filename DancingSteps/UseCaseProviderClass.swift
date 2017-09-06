//
//  UseCaseProviderClass.swift
//  DancingSteps
//
//  Created by RLRG on 07/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation

public final class UseCaseProviderClass: UseCaseProvider {

    // MARK: - Properties & Initialization
    
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    // MARK: - Logic
    
    func makeGetDanceStylesUseCase() -> GetDanceStylesProtocol {
        return GetDanceStylesUseCase(repository: repository)
    }
    
    func makeGetVideosUseCase() -> GetVideosProtocol {
        return GetVideosUseCase(repository: repository)
    }
    
    func makeSaveNewVideoUseCase() -> SaveNewVideoProtocol {
        return SaveNewVideoUseCase(repository: repository, fileManager: FileManager.default)
    }
    
    func makeGetCongressesUseCase() -> GetCongressesProtocol {
        return GetCongressesNetworkUseCase(repository: repository)
    }

}

