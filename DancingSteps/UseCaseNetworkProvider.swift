//
//  UseCaseNetworkProvider.swift
//  DancingSteps
//
//  Created by RLRG on 07/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation

public final class UseCaseNetworkProvider: UseCaseProvider {
    private let networkProvider: NetworkProvider
    
    public init() {
        networkProvider = NetworkProvider()
    }
    
    func makeGetCongressesUseCase() -> GetCongressesNetworkUseCase {
        return GetCongressesNetworkUseCase(network: networkProvider.makeCongressNetwork())
    }

}

