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
    
    func getDanceStyles() -> Observable<[Style]> {
        return Repository.shared.getDanceStyles()
    }
}
