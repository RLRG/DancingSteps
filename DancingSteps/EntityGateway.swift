//
//  EntityGateway.swift
//  DancingSteps
//
//  Created by RLRG on 10/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation

protocol EntityGateway {
    func fetchStyles() -> [Style]
}
