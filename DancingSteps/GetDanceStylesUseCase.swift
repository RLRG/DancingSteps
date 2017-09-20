//
//  GetDanceStylesUseCase.swift
//  DancingSteps
//
//  Created by Rodrigo López-Romero Guijarro on 23/08/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import RxSwift

class GetDanceStylesUseCase: GetDanceStylesProtocol {
    
    // MARK: - Properties & Initialization
    
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    // MARK: - Logic
    
    func getDanceStyles() -> Observable<[Style]> {
        return repository.getDanceStyles()
    }
}
