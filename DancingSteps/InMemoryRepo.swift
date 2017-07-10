//
//  InMemoryRepo.swift
//  DancingSteps
//
//  Created by RLRG on 10/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation

class InMemoryRepo {
    
    var styles:[Style]
    
    init() {
        styles = [Style(name: "Salsa", country: "Cuba"), Style(name: "Bachata", country: "Dominican Rep."), Style(name: "Kizomba", country: "Angola")]
    }
}

extension InMemoryRepo: EntityGateway {
    func fetchStyles() -> [Style] {
        return self.styles
    }
}

