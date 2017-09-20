//
//  GetCongressesNetworkUseCase.swift
//  DancingSteps
//
//  Created by RLRG on 04/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import RxSwift

final class GetCongressesNetworkUseCase: GetCongressesProtocol {
    
    // MARK: - Properties & Initialization
    
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    // MARK: - Logic
    
    func congresses() -> Observable<[Congress]> {
        return repository.getCongresses()
    }
}
