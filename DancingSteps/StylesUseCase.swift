//
//  StylesUseCase.swift
//  DancingSteps
//
//  Created by RLRG on 10/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation

class StylesUseCase {
    
    // MARK: Properties & Initialization
    
    let entityGateway: EntityGateway
    var presenter: StylesPresentation!
    
    init(entityGateway: EntityGateway) {
        self.entityGateway = entityGateway
    }
    
    
    // MARK: Logic of the interactor.
    
    func showStyles() {
        
        // 1. Fetching the data. (dependency version principle)
        let styles = entityGateway.fetchStyles()
        
        // 2. Process the data: transformation in order to reduce the data we are going to show in the view.
        //let programmerResponse = programmers.map { ProgrammerResponse(programmer: $0) }
        
        // 3. Provide the data to the presenter.
        presenter.present(styles: styles)
    }
}
