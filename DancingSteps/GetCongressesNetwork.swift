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
    var presenter: CongressesPresentation!
    
    init(network: CongressNetwork) {
        self.network = network
    }
    
    func congresses() -> Observable<[Congress]> {
        // 1. Fetching data.
        let congresses = network.fetchCongresses()
        
        // 2. Process the data if needed (mapping).
        // TODO: MAPPING IF NEEDED.
        
        // 3. Provide the data to the presenter.
        presenter.present(congresses: congresses)
        
        return congresses // TODO: Do we really need this ? I don't think so....
    }
}
