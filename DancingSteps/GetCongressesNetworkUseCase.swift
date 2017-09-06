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
    
    func congresses() -> Observable<[Congress]> {
        return Repository.shared.getCongresses()
    }
}
