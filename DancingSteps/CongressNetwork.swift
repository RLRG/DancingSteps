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
        return network.getRequest("\(Constants.eventsURL)&location.address=London")
        // TODO: Remove the parameter "location.address=London" in order to have much less results. I have this configured like this for debugging purposes at the beginning of my developments.
    }
}


extension Congress: ImmutableMappable {
    // JSON -> Object
    public init(map: Map) throws {
        name = try map.value("name.text")
        organizer = try map.value("organizer_id") // Call the corresponding Web Service to get the name?
        let dateFormatter = DateFormatter() // TODO: Improve this by creating an auxiliary function with Utils.
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        startDate = dateFormatter.date(from: try map.value("start.local"))!
        endDate = dateFormatter.date(from: try map.value("end.local"))!
    }
}
