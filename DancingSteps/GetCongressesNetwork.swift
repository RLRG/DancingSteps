//
//  getDanceEvents.swift
//  DancingSteps
//
//  Created by RLRG on 04/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import RxSwift

final class GetCongressesNetwork: GetCongressesUseCase {
    private let network: CongressNetwork
    
    init(network: CongressNetwork) {
        self.network = network
    }
    
    func congresses() -> Observable<[Congress]> {
        return network.fetchCongresses()
    }
}
