//
//  GetDanceStylesUseCase.swift
//  DancingSteps
//
//  Created by Rodrigo López-Romero Guijarro on 23/08/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import RxSwift

class GetDanceStylesUseCase {
    
    // MARK: Properties & Initialization
    
    private let repository: AbstractRepository<Style>
    
    init(repository: AbstractRepository<Style>) {
        self.repository = repository
    }
    
    // MARK: Logic of the interactor.
    
    func getDanceStyles() -> Observable<[Style]> {
        let styleObservable = repository.queryAll()
        return styleObservable
    }
}
