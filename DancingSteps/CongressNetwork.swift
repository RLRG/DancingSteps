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
    private let disposeBag = DisposeBag()
    
    init(network: Network<Congress>) {
        self.network = network
    }
    
    public func fetchCongresses() -> [Congress] {
        let congressesObservable = network.getRequest("\(Constants.eventsURL)/?\(Constants.AnonymousAccessTokenParameter)=\(Constants.AnonymousAccessToken)&\(Constants.categoryParameter)=\(Constants.categoryValue)&\(Constants.subcategoryParameter)=\(Constants.subcategoryValue)") // TODO: Improve this code with the corresponding Apple classes to create an URL.
        
        var congresses: [Congress] = []
        
        congressesObservable.asObservable()
            .subscribe(onNext: { (congressArray) in
                for congress in congressArray {
                    print("Congress: \(congress.name)")
                }
                congresses = congressArray
            },
                       onError: { error in
                        print("ERROR IN RESPONSE (CONGRESS): \(error)")
            },
                       onCompleted: {
                        print("onCompleted event !! (CONGRESS)")
            })
        .addDisposableTo(disposeBag)
        
        return congresses
    }
}


extension Congress: ImmutableMappable {
    // TODO: SET THE MAPPING OF THE WEB SERVICE WITH THE OBJECT !
    // JSON -> Object
    public init(map: Map) throws {
        name = try map.value("events -> name -> text")
        organizer = try map.value("events -> organizer_id") // Call the corresponding Web Service to get the name?
        startDate = try map.value("events -> start -> local")
        endDate = try map.value("events -> end -> local")
    }
}
