//
//  NetworkProvider.swift
//  DancingSteps
//
//  Created by RLRG on 03/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

final class NetworkProvider {
    private let apiEndpoint: String
    
    public init() {
        apiEndpoint = "" // TODO: SET THIS !!!!
    }
    
    public func makeCongressNetwork() -> CongressNetwork {
        let network = Network<Congress>(apiEndpoint)
        return CongressNetwork(network: network)
    }
}
