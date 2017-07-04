//
//  CongressesPresenter.swift
//  DancingSteps
//
//  Created by RLRG on 04/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation

class CongressesPresenter {
    
    var congresses: [Congress] = []
    let useCase: GetCongressesUseCase
    
    init (useCase: GetCongressesUseCase) {
        self.useCase = useCase
    }
    
    func viewIsReady() {
        useCase.congresses() // TODO: How to communicate this part of the app in Clean Architecture ? Pending to analize it !
    }
}
