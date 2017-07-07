//
//  GetCongressesNetworkUseCase.swift
//  DancingSteps
//
//  Created by RLRG on 04/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import RxSwift

final class GetCongressesNetworkUseCase: GetCongressesUseCase {
    private let network: CongressNetwork
    var presenter: CongressesPresentation!
    
    init(network: CongressNetwork) {
        self.network = network
    }
    
    func congresses() {
        // 1. Fetching data.
        let congressesObservable = network.fetchCongresses()
        
        // 2. Process the data if needed (mapping).
        // Example: let programmerResponse = programmers.map { ProgrammerResponse(programmer: $0) }
        
        // 3. Provide the data to the presenter.
        presenter.present(congresses: congressesObservable)
    }
}
