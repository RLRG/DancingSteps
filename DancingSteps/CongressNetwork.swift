//
//  CongressNetwork.swift
//  DancingSteps
//
//  Created by RLRG on 03/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

public final class CongressNetwork {
    private let network: Network<Congress>
    
    init(network: Network<Congress>) {
        self.network = network
    }
    
    public func fetchCongresses() -> Observable<[Congress]> {
        return network.getRequest("PATH_TODO_COMLETE!!") // TODO: COMPLETE THIS !!!
    }
}


extension Congress: ImmutableMappable {
    // TODO: SET THE MAPPING OF THE WEB SERVICE WITH THE OBJECT !
    // JSON -> Object
    public init(map: Map) throws {
        name = try map.value("XXXXXXXXX")
        organizer = try map.value("XXXXXXXXX")
        startDate = try map.value("XXXXXXXXX")
        endDate = try map.value("XXXXXXXXX")
    }
}
