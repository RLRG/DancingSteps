//
//  UseCaseProvider.swift
//  DancingSteps
//
//  Created by RLRG on 07/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation

protocol UseCaseProvider {
    func makeGetCongressesUseCase() -> GetCongressesNetworkUseCase
}
