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
        let congressesObservable = network.fetchCongresses()
        presenter.present(congressesObservable: congressesObservable)
    }
}
